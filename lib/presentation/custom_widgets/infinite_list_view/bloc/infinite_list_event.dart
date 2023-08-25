part of 'infinite_list_bloc.dart';

abstract class PostEvent  {

}

class DataFetched extends PostEvent {
  final Map<String, dynamic>? extraParams;
  final bool isRefresh;

  DataFetched({ this.extraParams, this.isRefresh = false});
}

class ResetEvent extends PostEvent {}

class ChangeListType extends PostEvent {
  final ListType? listType;

  ChangeListType(this.listType);
}
