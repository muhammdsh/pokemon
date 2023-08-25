import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:base_structure/core/error/http/forbidden_error.dart';
import 'package:base_structure/core/param/base_param.dart';
import 'package:base_structure/core/services/memoization_store.dart';
import 'package:base_structure/presentation/custom_widgets/infinite_list_view/entity/pagination_params.dart';
import 'package:base_structure/presentation/custom_widgets/infinite_list_view/entity/usecase_wrapper.dart';
import 'package:equatable/equatable.dart';
import 'package:rxdart/rxdart.dart';
import 'package:stream_transform/stream_transform.dart';

part 'infinite_list_event.dart';

part 'infinite_list_state.dart';

typedef AsyncCallbackWithParams<T, P extends BaseParams> = Future<T> Function(P b);

const throttleDuration = Duration(milliseconds: 200);

enum ComparingStatus { equal, larger, smaller }

class InfiniteListBloc<T> extends Bloc<PostEvent, InfiniteListState<T>> {
  late UseCaseWrapper useCaseWrapper;
  late WrapperParams wrapperParams;

  InfiniteListBloc() : super(InfiniteListState<T>()) {
    on<DataFetched>(
      _onDataFetched,
      transformer: throttleDroppable(throttleDuration),
    );
    on<ResetEvent>(
      _onReset,
      transformer: throttleDroppable(throttleDuration),
    );
    on<ChangeListType>(_onChangeListType);
  }

  void buildObject(UseCaseWrapper useCaseWrapper, WrapperParams wrapperParams) {
    setUseCaseWrapper = useCaseWrapper;
    setWrapperParams = wrapperParams;
  }

  set setUseCaseWrapper(UseCaseWrapper useCaseWrapper) {
    this.useCaseWrapper = useCaseWrapper;
  }

  set setWrapperParams(WrapperParams wrapperParams) {
    this.wrapperParams = wrapperParams;
  }

  EventTransformer<E> throttleDroppable<E>(Duration duration) {
    return (events, mapper) {
      return droppable<E>().call(events.debounceTime(duration), mapper);
    };
  }

  void _onReset(ResetEvent event, Emitter<InfiniteListState<T>> emit) {
    emit(InfiniteListState<T>(listType: state.listType));
  }

  void _onChangeListType(ChangeListType event, Emitter<InfiniteListState<T>> emit) {
    if (event.listType == null) {
      emit(state.copyWith(
          listType: state.listType == ListType.list ? ListType.grid : ListType.list));
    }
    emit(state.copyWith(listType: event.listType));
  }

  Future<void> _onDataFetched(DataFetched event, Emitter<InfiniteListState<T>> emit) async {
    emit(state.copyWith(extra: event.extraParams));

    final WrapperParams params = wrapperParams.copyWith(
        startIndex: event.isRefresh ? 0 : state.currentPage, extraParams: event.extraParams);
    if (state.hasReachedMax && !event.isRefresh) return;
    try {
      final data = await useCaseWrapper.caller(params);
      if (compare(data ?? []) == ComparingStatus.equal) {
        List<T> result = [];
        if (event.isRefresh) {
          result = List.of([])..addAll(data as List<T>);
        } else {
          result = List.of(state.data)..addAll(data as List<T>);
        }
        emit(state.copyWith(
          status: ListStatus.success,
          isError: false,
          currentPage: event.isRefresh ? 1 : state.currentPage + 1,
          data: result,
          hasReachedMax: false,
        ));
        print('state222222222222: success $state');

        return;
      }

      List<T> result2 = [];
      if (event.isRefresh) {
        result2 = List.of([])..addAll(data as List<T>);
      } else {
        result2 = List.of(state.data)..addAll(data as List<T>);
      }

      emit(state.copyWith(
          hasReachedMax: true,
          status: compare(data!) == ComparingStatus.smaller ? ListStatus.success : state.status,
          isError: compare(data!) == ComparingStatus.smaller ? false : state.isError,
          currentPage: event.isRefresh ? 1 : null,
          data: compare(data!) == ComparingStatus.smaller ? result2 : state.data));
      print('state333333333333: $state');
    } on ForbiddenError catch (e) {
      throw ForbiddenError();
    } catch (e, stacktrace) {
      print('ee: $e $stacktrace');
      emit(state.copyWith(isError: true, error: e.toString()));
    }
  }

  ComparingStatus compare(List<dynamic> data) {
    final length = data.length;
    final limit = (wrapperParams as PaginationParams).limit;
    if (length == limit) return ComparingStatus.equal;
    if (length < limit) return ComparingStatus.smaller;
    if (length > limit) return ComparingStatus.larger;
    return ComparingStatus.smaller;
  }
}
