import 'dart:async';
import 'dart:ffi';

import 'package:base_structure/app+injection/di.dart';
import 'package:base_structure/core/helper/interfaces/on_refresh_data.dart';
import 'package:base_structure/core/helper/screen_util/screen_helper.dart';
import 'package:base_structure/core/resources/colors.dart';
import 'package:base_structure/presentation/custom_widgets/infinite_list_view/bloc/infinite_list_bloc.dart';
import 'package:base_structure/presentation/custom_widgets/infinite_list_view/entity/pagination_params.dart';
import 'package:base_structure/presentation/custom_widgets/infinite_list_view/presentation/widgets/error_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../entity/usecase_wrapper.dart';
import 'widgets/bottom_loader.dart';

typedef PaginationType<T> = Widget Function(T data, int index);

class PaginationController<T> {
  late PostsListState<T> _state;

  void setData(PostsListState<T> state) {
    _state = state;
  }

  void getData(Map<String, dynamic> extraParams) {
    _state.callEvent(extraParams);
  }

  void paginate() {
    _state.paginate();
  }

  void changeListType({required ListType listType}) {
    _state.changeListType(listType: listType);
  }
}

class PaginationBuilder<T> extends StatefulWidget {
  const PaginationBuilder({
    super.key,
    required this.gridBuilder,
    required this.listBuilder,
    required this.useCase,
    this.withError = true,
    this.scrollDirection = Axis.vertical,
    this.extraParams = const {},
    this.controller,
    this.flex = 1,
    this.callEvent,
    this.sliverBuilder,
    this.scrollController,
    this.type = ListType.grid,
    this.customPagination = false,
  });

  final PaginationType<T> gridBuilder;
  final PaginationType<T> listBuilder;
  final PaginationType<T>? sliverBuilder;
  final ScrollController? scrollController;
  final UseCaseWrapper useCase;
  final Map<String, dynamic>? extraParams;
  final Axis scrollDirection;
  final bool withError;
  final bool customPagination;
  final ListType type;
  final int flex;
  final VoidCallback? callEvent;
  final PaginationController<T>? controller;

  @override
  State<PaginationBuilder<T>> createState() => PostsListState<T>();
}

class PostsListState<T> extends State<PaginationBuilder<T>>
    with TickerProviderStateMixin, OnRefreshDataMixin {
  final ScrollController _scrollController = ScrollController();
  late AnimationController listAnimationController;
  late AnimationController gridAnimationController;

  InfiniteListBloc bloc = InfiniteListBloc();

  @override
  void initState() {
    if (widget.controller != null) {
      widget.controller!.setData(this);
    }
    listAnimationController =
        AnimationController(duration: const Duration(milliseconds: 600), vsync: this);
    gridAnimationController =
        AnimationController(duration: const Duration(milliseconds: 600), vsync: this);
    bloc.buildObject(widget.useCase, PaginationParams());
    super.initState();
    // if (widget.scrollController != null) {
    //   widget.scrollController!.addListener(_onSliverScroll);
    // }
    if (!widget.customPagination) {
      _scrollController.addListener(_onScroll);
    }

    changeListType(listType: widget.type);
    bloc.add(DataFetched(extraParams: widget.extraParams));
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<InfiniteListBloc, InfiniteListState>(
      listener: (context, state) {
        if (state.isError && state.data.isNotEmpty) {
          // Scaffold.of(context).showSnackBar(SnackBar(
          //     content: Text(state.error.toString()),
          //     duration: const Duration(seconds: 2),
          //     backgroundColor: locator<AppThemeColors>().primaryColor));
        }
        if (state.status == ListStatus.success) {
          if (refreshSubCompleter != null && !refreshSubCompleter!.isCompleted) {
            refreshSubCompleter!.complete();
            refreshSubCompleter = null;
          }
        }
      },
      bloc: bloc,
      builder: (context, state) {
        if (state.isError && state.data.isEmpty) {
          return Visibility(
              visible: widget.withError,
              child: PaginationError(
                error: state.error != null
                    ? state.error!.toUpperCase().replaceAll('EXCEPTION:', '')
                    : 'Something Went Wrong',
                withRetry: true,
                onRetry: () {
                  callEvent(widget.extraParams ?? {});
                },
              ));
        }

        switch (state.status) {
          case ListStatus.success:
            if (state.data.isEmpty) {
              return Visibility(
                  visible: widget.withError,
                  child: const PaginationError(error: "We Haven’t Found Any Result"));
            }
            if (state.listType == ListType.list) {
              print(state);
              return RefreshIndicator(
                onRefresh: onRefresh,
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.all(0),
                  shrinkWrap: true,
                  scrollDirection: widget.scrollDirection,
                  itemBuilder: (BuildContext context, int index) {
                    final int count = state.data.length > 10 ? 10 : state.data.length;
                    final Animation<double> animation = Tween<double>(begin: 0.0, end: 1.0).animate(
                        CurvedAnimation(
                            parent: listAnimationController,
                            curve: Interval((1 / count) * index <= 1 ? (1 / count) * index : 1, 1.0,
                                curve: Curves.fastOutSlowIn)));
                    listAnimationController.forward();

                    return index >= state.data.length
                        ? const BottomLoader()
                        : AnimatedBuilder(
                        animation: listAnimationController,
                        builder: (BuildContext context, Widget? child) {
                          return FadeTransition(
                              opacity: animation,
                              child: Transform(
                                transform: Matrix4.translationValues(
                                    (1.0 - animation.value) <= 1
                                        ? 100 * (1.0 - animation.value)
                                        : 0,
                                    0.0,
                                    0.0),
                                child: widget.listBuilder((state.data[index]), index),
                              ));
                        });
                  },
                  itemCount: state.hasReachedMax ? state.data.length : state.data.length + 1,
                  controller: _scrollController,
                ),
              );
            }
            if (state.listType == ListType.grid) {
              return GridView.builder(
                padding: const EdgeInsets.all(0),
                itemCount: state.hasReachedMax ? state.data.length : state.data.length + 1,
                controller: _scrollController,
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.8,
                ),
                itemBuilder: (BuildContext context, int index) {
                  final int count = state.data.length > 10 ? 10 : state.data.length;
                  final Animation<double> animation = Tween<double>(begin: 0.0, end: 1.0).animate(
                      CurvedAnimation(
                          parent: gridAnimationController,
                          curve: Interval((1 / count) * index <= 1 ? (1 / count) * index : 1, 1.0,
                              curve: Curves.fastOutSlowIn)));
                  gridAnimationController?.forward();
                  return index == state.data.length
                      ? const BottomLoader()
                      : AnimatedBuilder(
                      animation: gridAnimationController,
                      builder: (BuildContext context, Widget? child) {
                        return FadeTransition(
                            opacity: animation,
                            child: Transform(
                              transform: Matrix4.translationValues(
                                  (1.0 - animation.value) <= 1
                                      ? 100 * (1.0 - animation.value)
                                      : 0,
                                  0.0,
                                  0.0),
                              child: widget.gridBuilder((state.data[index]), index),
                            ));
                      });
                },
              );
            } else {
              return SliverList.builder(
                itemCount: state.hasReachedMax ? state.data.length : state.data.length + 1,
                itemBuilder: (context, index) {
                  final int count = state.data.length > 10 ? 10 : state.data.length;
                  final Animation<double> animation = Tween<double>(begin: 0.0, end: 1.0).animate(
                      CurvedAnimation(
                          parent: listAnimationController,
                          curve: Interval((1 / count) * index <= 1 ? (1 / count) * index : 1, 1.0,
                              curve: Curves.fastOutSlowIn)));
                  listAnimationController.forward();
                  return index >= state.data.length
                      ? const BottomLoader()
                      : AnimatedBuilder(
                      animation: listAnimationController,
                      builder: (BuildContext context, Widget? child) {
                        return FadeTransition(
                            opacity: animation,
                            child: Transform(
                              transform: Matrix4.translationValues(
                                  (1.0 - animation.value) <= 1
                                      ? 100 * (1.0 - animation.value)
                                      : 0,
                                  0.0,
                                  0.0),
                              child: widget.listBuilder((state.data[index]), index),
                            ));
                      });
                },
              );
            }
          case ListStatus.initial:
            return Visibility(
                visible: widget.withError,
                child: const Center(
                  child: CircularProgressIndicator(),
                ));

                default:
                return Visibility(visible: false, child: Container());
        }
      },
    );
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();

    if (widget.scrollController != null) {
      widget.scrollController!.removeListener(_onSliverScroll);
    }
    gridAnimationController?.dispose();
    listAnimationController?.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) bloc.add(DataFetched(extraParams: widget.extraParams));
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;

    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }

  void _onSliverScroll() {
    if (_isSliverBottom) bloc.add(DataFetched(extraParams: widget.extraParams));
  }

  bool get _isSliverBottom {
    if (!widget.scrollController!.hasClients) return false;

    final maxScroll = widget.scrollController!.position.maxScrollExtent;
    final currentScroll = widget.scrollController!.offset;

    if (currentScroll >= (maxScroll * 0.99)) {}
    return currentScroll >= (maxScroll * 0.9);
  }

  void callEvent(Map<String, dynamic> extraParams) {
    bloc.add(ResetEvent());
    bloc.add(DataFetched(extraParams: extraParams));
  }

  void paginate() {
    bloc.add(DataFetched(
      extraParams: bloc.state.extra,
    ));
  }

  void changeListType({required ListType listType}) {
    gridAnimationController.reverse();
    listAnimationController.reverse();
    bloc.add(ChangeListType(listType));
  }

  @override
  Future<void> onRefresh() {
    refreshSubCompleter = Completer();
    // bloc.add(ResetEvent());
    bloc.add(DataFetched(extraParams: bloc.state.extra, isRefresh: true));

    return refreshSubCompleter!.future;
  }
}
