class RegisterModel {
  final String fullName;
  final String phone;
  final String password;
  final String confirmPassword;

  const RegisterModel({
    required this.fullName,
    required this.phone,
    required this.password,
    required this.confirmPassword,
  });

  // Можно добавить методы для валидации
  bool isValid() {
    return fullName.isNotEmpty && 
           phone.isNotEmpty && 
           password.isNotEmpty && 
           password == confirmPassword;
  }

  // Для преобразования в JSON при работе с API
  Map<String, dynamic> toJson() {
    return {
      'fullName': fullName,
      'phone': phone,
      'password': password,
    };
  }
}