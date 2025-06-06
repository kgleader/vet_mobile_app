import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:vet_mobile_app/blocs/vet_profile/vet_profile_bloc.dart';
import 'package:vet_mobile_app/data/models/vet_model.dart';

void main() {
  late VetProfileBloc vetProfileBloc; 
  
  const vetAsanovForTest = VetModel(
    id: 'vet_asanov',
    name: 'Dr. Асанов Асан',
    specialty: 'Ветеринар',
    phone: '+996 500 112233',
    imagePath: 'assets/images/vet_profile.png',
    experience: '7 жыл',
    rating: 4.9,
    about: 'Dr. Асанов Асан көп жылдан бери мал доктур болуп эмгектенет. Анын негизги адистиги - ири жана майда мүйүздүү малдарды дарылоо. Оорулардын алдын алуу жана дарылоо боюнча тажрыйбасы мол.',
  );

  setUp(() {
    vetProfileBloc = VetProfileBloc(); 
  });
  
  tearDown(() {
    vetProfileBloc.close();
  });

  group('VetProfileBloc (tested in vet_list_bloc_test.dart file)', () { 
    test('initial state is correct', () {
      expect(vetProfileBloc.state, const VetProfileState()); 
    });
    
    blocTest<VetProfileBloc, VetProfileState>(
      'emits [loading, success] when LoadVetProfileById is added and vet is found',
      build: () => vetProfileBloc,
      act: (bloc) => bloc.add(const LoadVetProfileById('vet_asanov')),
      expect: () => <VetProfileState>[
        const VetProfileState(status: VetProfileStatus.loading, vet: null, errorMessage: null),
        const VetProfileState(status: VetProfileStatus.success, vet: vetAsanovForTest, errorMessage: null),
      ],
    );

    blocTest<VetProfileBloc, VetProfileState>(
      'emits [loading, failure] when LoadVetProfileById is added and vet is NOT found',
      build: () => vetProfileBloc,
      act: (bloc) => bloc.add(const LoadVetProfileById('non_existent_id')),
      expect: () => <VetProfileState>[
        const VetProfileState(status: VetProfileStatus.loading, vet: null, errorMessage: null),
        const VetProfileState(
          status: VetProfileStatus.failure, 
          vet: null, 
          errorMessage: 'Ветеринар (ID: non_existent_id) табылган жок. Азыркы учурда бир гана "vet_асанова" ID\'си боюнча маалымат бар.',
        ),
      ],
    );
  });
}
