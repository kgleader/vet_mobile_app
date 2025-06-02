part of 'navigation_bloc.dart'; // Негизги BLoC файлына шилтеме

// import 'package:equatable/equatable.dart'; // Бул сап негизги bloc файлында болушу керек

class NavigationState extends Equatable {
  final int currentIndex;

  const NavigationState({required this.currentIndex});

  @override
  List<Object> get props => [currentIndex];
}