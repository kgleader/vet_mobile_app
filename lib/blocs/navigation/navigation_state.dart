import 'package:equatable/equatable.dart';

class NavigationState extends Equatable {
  final int currentIndex;

  const NavigationState({required this.currentIndex});
  
  @override
  List<Object> get props => [currentIndex];
}