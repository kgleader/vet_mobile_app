import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:vet_mobile_app/blocs/vet_profile/vet_profile_bloc.dart';
import 'package:vet_mobile_app/core/app_colors.dart';
import 'package:vet_mobile_app/core/app_text_styles.dart';
import 'package:vet_mobile_app/screens/vet/vet_message.dart';
import 'package:vet_mobile_app/config/router/route_names.dart';
import 'package:vet_mobile_app/core/app_logo.dart'; // Чыныгы AppLogo импорту

class VeterinarScreen extends StatefulWidget {
  final String vetId;

  const VeterinarScreen({super.key, required this.vetId});

  @override
  State<VeterinarScreen> createState() => _VeterinarScreenState();
}

class _VeterinarScreenState extends State<VeterinarScreen> {
  @override
  void initState() {
    super.initState();
    // Окуянын аталышын LoadVetProfileById деп тууралоо
    context.read<VetProfileBloc>().add(LoadVetProfileById(widget.vetId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: AppColors.primary),
          onPressed: () {
            // Меню экранына кайтуу
            // Эгер меню экраны ShellRoute'тун негизги жолу болсо (мис., RouteNames.menu)
            // жана ал BottomNavigationBar'дын биринчи элементине туура келсе,
            // анда context.go(RouteNames.menu) же context.go('/') колдонсо болот.
            // Эгер башкача болсо, так жолду көрсөтүңүз.
            // Азырынча, мурунку экранга кайтабыз, бул көбүнчө меню болот.
            if (GoRouter.of(context).canPop()) {
              GoRouter.of(context).pop();
            } else {
              // Эгер артка кайтуу мүмкүн болбосо (мис., бул биринчи экран), менюга өтүү
              GoRouter.of(context).go(RouteNames.menu); 
            }
          },
        ),
        title: Text(
          'Ветеринар',
          style: AppTextStyles.heading2.copyWith(color: AppColors.textPrimary),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: GestureDetector(
              onTap: () {
                GoRouter.of(context).go(RouteNames.profile);
              },
              child: const AppLogo(), // size параметри алынып салынды
            ),
          ),
        ],
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
      ),
      body: BlocBuilder<VetProfileBloc, VetProfileState>( // VetListBloc ордуна VetProfileBloc
        builder: (context, state) {
          if (state.status == VetProfileStatus.loading) { // VetListStatus ордуна VetProfileStatus
            return const Center(child: CircularProgressIndicator());
          } else if (state.status == VetProfileStatus.failure) { // VetListStatus ордуна VetProfileStatus
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  state.errorMessage ?? 'Маалыматтарды жүктөөдө ката кетти.',
                  style: AppTextStyles.body.copyWith(color: Colors.red),
                  textAlign: TextAlign.center,
                ),
              ),
            );
          } else if (state.status == VetProfileStatus.success && state.vet != null) { // selectedVet ордуна vet
            final vet = state.vet!;
            
            // Негизги сүрөттүн жолун аныктоо
            String primaryImagePath;
            if (vet.imagePath.isNotEmpty && vet.imagePath.startsWith('assets/')) {
              primaryImagePath = vet.imagePath;
            } else {
              // Эгер vet.imagePath туура эмес болсо же бош болсо, демейки жолду колдонуу
              primaryImagePath = 'assets/images/vet_profile.png';
            }
            // Дебаг үчүн:
            // print("Attempting to load primary image for ${vet.name}: $primaryImagePath");
            // print("VetModel.imagePath was: ${vet.imagePath}");

            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12.0),
                      child: Container(
                        height: 220,
                        width: double.infinity,
                        color: Colors.grey[200], // Фондук түс
                        child: Image.asset( // DecorationImage ордуна Image.asset колдонуу
                          primaryImagePath, // Аныкталган негизги сүрөт жолу
                          fit: BoxFit.cover,
                          errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
                            // Бул errorBuilder primaryImagePath жүктөлбөсө чакырылат.
                            print('Error loading image "$primaryImagePath": $error');
                            
                            // Эгер негизги аракет демейки сүрөт ЭМЕС болсо,
                            // анда демейки сүрөттү жүктөөгө аракет кылуу
                            if (primaryImagePath != 'assets/images/vet_profile.png') {
                              // print('Falling back to default image: assets/images/vet_profile.png');
                              return Image.asset(
                                'assets/images/vet_profile.png', // Демейки сүрөт
                                fit: BoxFit.cover,
                                errorBuilder: (BuildContext context, Object errorDefault, StackTrace? stackTraceDefault) {
                                  // Эгер демейки сүрөт да жүктөлбөсө
                                  print('Error loading default image "assets/images/vet_profile.png": $errorDefault');
                                  return const Center(child: Icon(Icons.broken_image, size: 100, color: Colors.grey));
                                },
                              );
                            } else {
                              // Эгер негизги аракет демейки сүрөт БОЛСО жана ал да жүктөлбөсө
                              return const Center(child: Icon(Icons.broken_image, size: 100, color: Colors.grey));
                            }
                          },
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                vet.name,
                                style: AppTextStyles.heading2.copyWith(fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                vet.specialty,
                                style: AppTextStyles.body.copyWith(color: AppColors.textSecondary),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 16),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: AppColors.primary.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'Тажрыйба',
                                style: AppTextStyles.caption.copyWith(color: AppColors.primary, fontSize: 10),
                              ),
                              Text(
                                vet.experience.replaceAll(' тажрыйба', ''),
                                style: AppTextStyles.body.copyWith(color: AppColors.primary, fontWeight: FontWeight.bold, fontSize: 12),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24), 
                  
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      'Автобиография', 
                      style: AppTextStyles.heading3.copyWith(color: AppColors.primary), 
                    ),
                  ),
                  const SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      vet.about,
                      style: AppTextStyles.body.copyWith(color: AppColors.textSecondary),
                    ),
                  ),
                  const SizedBox(height: 32), 
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: ElevatedButton(
                      onPressed: () {
                         Navigator.push(
                           context,
                           MaterialPageRoute(
                             builder: (context) => VetMessage(vet: vet), 
                           ),
                         );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: Colors.white,
                        minimumSize: const Size(double.infinity, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        textStyle: AppTextStyles.buttonText, // Туура стиль: buttonText
                      ),
                      child: const Text('Билдирүү таштоо'),
                    ),
                  ),
                   const SizedBox(height: 16),
                ],
              ),
            );
          } else if (state.status == VetProfileStatus.success && state.vet == null) { // selectedVet ордуна vet
             return Center(
              child: Text(
                'Ветеринар (ID: ${widget.vetId}) табылган жок.',
                style: AppTextStyles.body,
              ),
            );
          }
           else {
            return const Center(child: Text("Белгисиз абал же маалыматтар жок."));
          }
        },
      ),
    );
  }
}
