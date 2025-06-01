import 'package:equatable/equatable.dart';

class VetModel extends Equatable {
  final String id;
  final String name;
  final String specialty;
  final String phone;
  final String imagePath;
  final String experience;
  final double rating;
  final String about; // Add this property

  const VetModel({
    required this.id,
    required this.name,
    required this.specialty,
    required this.phone,
    required this.imagePath,
    required this.experience,
    required this.rating,
    required this.about, // Make it required
  });
  
  @override
  List<Object?> get props => [id, name, specialty, phone, imagePath, experience, rating, about];
}
