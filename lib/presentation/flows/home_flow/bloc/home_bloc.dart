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
  final GetCurrencyUseCase getCurrencyUseCase;

  HomeBloc(this.getCurrencyUseCase) : super(const HomeState()) {
    on<BaseEvent>(_onGetCurrencies);
  }

  @override
  void receive(String from, CommunicationType data) {
    // if (data is exchangeLocation) {
    //   setLocation(locationEntity: data.locationEntity, unit: state.unit);
    // }
  }
}

extension ExchangeBlocMappers on HomeBloc {
  void _onGetCurrencies(BaseEvent event, Emitter<HomeState> emit) async {
    emit(state.copyWith(
      status: PageStatus.loading,
    ));
  }
}




extension HomeActions on HomeBloc {
  void makeAction() {
    add(BaseEvent());
  }

}

class HomeConnection extends CommunicationType {
  final PageStatus exchangePageStatus;

  HomeConnection(this.exchangePageStatus);
}
