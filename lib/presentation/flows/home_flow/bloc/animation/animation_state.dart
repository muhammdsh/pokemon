part of 'animation_cubit.dart';

class AnimationState extends Equatable {
  const AnimationState({this.type = ShapeType.sharpSquare});

  final ShapeType type;

  AnimationState copyWith({ShapeType? type}) {
    return AnimationState(type: type ?? this.type);
  }

  @override
  List<Object?> get props => [type];
}
