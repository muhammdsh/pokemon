part of 'home_bloc.dart';

enum PageStatus { init, success, error, loading }

class HomeState extends Equatable {
  final PageStatus status;
  final String text;

  final String error;

  const HomeState({
    this.status = PageStatus.init,
    this.text = '',
    this.error = "",
  });

  HomeState copyWith({
    PageStatus? status,
    String? text,
    String? error,
  }) {
    return HomeState(
      status: status ?? this.status,
      text: text ?? this.text,
      error: error ?? this.error,
    );
  }

  @override
  List<Object> get props => [status, error, text];
}
