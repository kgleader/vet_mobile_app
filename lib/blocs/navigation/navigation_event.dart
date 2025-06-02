part of 'navigation_bloc.dart'; // Негизги BLoC файлына шилтеме

// import 'package:equatable/equatable.dart'; // Бул сап негизги bloc файлында болушу керек

abstract class NavigationEvent extends Equatable {
  const NavigationEvent();

  @override
  List<Object> get props => [];
}

class NavigateTo extends NavigationEvent {
  final int index;

  const NavigateTo(this.index);

  @override
  List<Object> get props => [index];
}