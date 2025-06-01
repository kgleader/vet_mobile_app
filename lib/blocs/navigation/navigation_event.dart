import 'package:equatable/equatable.dart';

abstract class NavigationEvent extends Equatable {
  const NavigationEvent();

  @override
  List<Object> get props => [];
}

class NavigateToTab extends NavigationEvent {
  final int index;

  const NavigateToTab(this.index);

  @override
  List<Object> get props => [index];
}