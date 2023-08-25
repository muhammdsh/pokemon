part of 'app_bloc.dart';

abstract class AppEvent {}

class LaunchAppEvent extends AppEvent {}

class AppLanguageEvent extends AppEvent {
  final AppLanguages languages;

  AppLanguageEvent(this.languages);
}

class AppThemeModeEvent extends AppEvent {
  final AppThemeMode? appThemeMode;

  AppThemeModeEvent({this.appThemeMode});
}

class CheckUserEvent extends AppEvent{

}

class ChangeCheckUserEvent extends AppEvent{
  final bool? data;
  ChangeCheckUserEvent({this.data});

}



class SetAppStatusEvent extends AppEvent {
  final AppStatus appStatus;
  final bool? isFirstTime;

  SetAppStatusEvent(this.appStatus, {this.isFirstTime});
}

