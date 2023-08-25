part of 'infinite_list_bloc.dart';

enum ListStatus { initial, success, failure, errorWithData }

enum ListType { grid, list, sliver }

class InfiniteListState<T> extends Equatable {
  const InfiniteListState(
      {this.status = ListStatus.initial,
      this.data = const [],
      this.hasReachedMax = false,
      this.currentPage = 0,
      this.limit,
      this.extra,
      this.listType = ListType.grid,
      this.isError = false,
      this.error});

  final ListStatus status;
  final List<T> data;
  final bool hasReachedMax;
  final int currentPage;
  final int? limit;
  final String? error;
  final bool isError;
  final ListType? listType;
  final Map<String, dynamic>? extra;

  InfiniteListState<T> copyWith(
      {ListStatus? status,
      List<T>? data,
      bool? hasReachedMax,
      int? currentPage,
      int? limit,
      Map<String, dynamic>? extra,
      ListType? listType,
      bool? isError,
      Map<String, dynamic>? currentParams,
      String? error}) {
    return InfiniteListState<T>(
        status: status ?? this.status,
        data: data ?? this.data,
        extra: extra ?? this.extra,
        hasReachedMax: hasReachedMax ?? this.hasReachedMax,
        currentPage: currentPage ?? this.currentPage,
        limit: limit ?? this.limit,
        isError: isError ?? this.isError,
        listType: listType ?? this.listType,
        error: error ?? this.error);
  }

  @override
  List<Object?> get props =>
      [status, data, hasReachedMax, currentPage, limit, error, isError, listType, extra];
}
