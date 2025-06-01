part of 'vet_profile_bloc.dart';

abstract class VetProfileEvent extends Equatable {
  const VetProfileEvent();

  @override
  List<Object> get props => [];
}

// Бир конкреттүү ветеринардын профилин ID боюнча жүктөө үчүн окуя
class LoadVetProfileById extends VetProfileEvent {
  final String vetId;

  const LoadVetProfileById(this.vetId);

  @override
  List<Object> get props => [vetId];
}
