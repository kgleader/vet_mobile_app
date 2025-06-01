import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vet_mobile_app/blocs/navigation/navigation_event.dart';
import 'package:vet_mobile_app/blocs/navigation/navigation_state.dart';

class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
  NavigationBloc() : super(const NavigationState(currentIndex: 0)) {
    on<NavigateToTab>((event, emit) {
      emit(NavigationState(currentIndex: event.index));
    });
  }
}