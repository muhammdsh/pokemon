import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:base_structure/core/mediators/bloc_hub/bloc_member.dart';
import 'package:base_structure/core/mediators/bloc_hub/members_key.dart';
import 'package:base_structure/core/mediators/communication_types/base_communication.dart';
import 'package:base_structure/core/param/no_param.dart';
import 'package:base_structure/domain/entities/currency_entity.dart';
import 'package:base_structure/domain/usecases/get_currencies_usecases.dart';
import 'package:meta/meta.dart';

part 'home_event.dart';

part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> with BlocMember {
  HomeBloc() : super(const HomeState()) {
    on<OnTextChangedEvent>(_onTextChanged);
    on<OnClearTextEvent>(_onTextCleared);
  }

  @override
  void receive(String from, CommunicationType data) {
    // if (data is exchangeLocation) {
    //   setLocation(locationEntity: data.locationEntity, unit: state.unit);
    // }
  }
}

extension ExchangeBlocMappers on HomeBloc {
  void _onTextChanged(OnTextChangedEvent event, Emitter<HomeState> emit) async {
    emit(state.copyWith(text: event.text));
  }

  void _onTextCleared(OnClearTextEvent event, Emitter<HomeState> emit) async {
    emit(state.copyWith(text: ''));
  }
}

extension HomeActions on HomeBloc {
  void onTextChangedAction(String text) {
    add(OnTextChangedEvent(text));
  }

  void onClearAction() {
    add(OnClearTextEvent());
  }
}

class HomeConnection extends CommunicationType {
  final PageStatus exchangePageStatus;

  HomeConnection(this.exchangePageStatus);
}
