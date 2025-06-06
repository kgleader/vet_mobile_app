import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:vet_mobile_app/data/models/vet_model.dart'; // VetModel импорту

part 'vet_profile_event.dart';
part 'vet_profile_state.dart';

class VetProfileBloc extends Bloc<VetProfileEvent, VetProfileState> {
  // Figma моделине ылайык бир гана ветеринардын маалыматы (Dr. Asanов)
  // Аталышындагы кириллицалык 'о' латынча 'o' менен алмаштырылды
  final VetModel _drAsanov = const VetModel(
    id: 'vet_asanov', // Бул ID VeterinarScreen'ге берилген ID менен дал келиши керек
    name: 'Dr. Асанов Асан',
    specialty: 'Ветеринар',
    phone: '+996 500 112233',
    imagePath: 'assets/images/vet_profile.png', // Сиздин чыныгы сүрөт жолуңуз
    experience: '7 жыл',
    rating: 4.9,
    about: 'Dr. Асанов Асан көп жылдан бери мал доктур болуп эмгектенет. Анын негизги адистиги - ири жана майда мүйүздүү малдарды дарылоо. Оорулардын алдын алуу жана дарылоо боюнча тажрыйбасы мол.',
  );

  VetProfileBloc() : super(const VetProfileState()) {
    on<LoadVetProfileById>(_onLoadVetProfileById); // Ушул жерди текшериңиз
  }

  Future<void> _onLoadVetProfileById(
    LoadVetProfileById event,
    Emitter<VetProfileState> emit,
  ) async {
    emit(state.copyWith(status: VetProfileStatus.loading, clearVet: true, clearErrorMessage: true));
    try {
      await Future.delayed(const Duration(milliseconds: 300)); // Кичине кечигүү

      // Азырынча бир гана Dr. Asanov'дун ID'син текшеребиз
      // Бул жерде да _drAsanov туура (латынча 'o' менен) колдонулушу керек
      if (event.vetId == _drAsanov.id) {
        emit(state.copyWith(
          status: VetProfileStatus.success,
          vet: _drAsanov, // Бул жерде да
        ));
      } else {
        // Башка ID'лер азырынча колдоого алынбайт
        emit(state.copyWith(
          status: VetProfileStatus.failure,
          errorMessage: 'Ветеринар (ID: ${event.vetId}) табылган жок. Азыркы учурда бир гана "vet_asanov" ID\'си боюнча маалымат бар.',
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        status: VetProfileStatus.failure,
        errorMessage: 'Ветеринардын профилин жүктөөдө ката кетти: $e',
      ));
    }
  }
}
