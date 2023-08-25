import 'package:base_structure/presentation/flows/home_flow/components/row_shape_types.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'animation_state.dart';

class AnimationCubit extends Cubit<AnimationState> {
  AnimationCubit() : super(const AnimationState());

  void changeShapeType(ShapeType type) {
    emit(state.copyWith(type: type));
  }
}
