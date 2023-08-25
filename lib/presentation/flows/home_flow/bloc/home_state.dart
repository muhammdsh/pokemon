part of 'home_bloc.dart';

enum PageStatus { init, success, error, loading }

class HomeState extends Equatable {
  final PageStatus status;

  final String error;

  const HomeState({
    this.status = PageStatus.init,
    this.error = "",
  });

  HomeState copyWith(
      {PageStatus? status,
      String? error,
      List<CurrencyEntity>? currenciesList,
      List<CurrencyEntity>? displayList,
      String? lastUpdate}) {
    return HomeState(
        status: status ?? this.status,
        error: error ?? this.error,
      );
  }

  @override
  List<Object> get props => [status, error,];
}
