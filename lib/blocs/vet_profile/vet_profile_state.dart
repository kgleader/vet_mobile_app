part of 'vet_profile_bloc.dart';

enum VetProfileStatus { initial, loading, success, failure }

class VetProfileState extends Equatable {
  const VetProfileState({
    this.status = VetProfileStatus.initial,
    this.vet, // Тандалган ветеринардын модели
    this.errorMessage,
  });

  final VetProfileStatus status;
  final VetModel? vet;
  final String? errorMessage;

  VetProfileState copyWith({
    VetProfileStatus? status,
    VetModel? vet,
    String? errorMessage,
    bool clearVet = false,
    bool clearErrorMessage = false,
  }) {
    return VetProfileState(
      status: status ?? this.status,
      vet: clearVet ? null : (vet ?? this.vet),
      errorMessage: clearErrorMessage ? null : (errorMessage ?? this.errorMessage),
    );
  }

  @override
  List<Object?> get props => [status, vet, errorMessage];
}
