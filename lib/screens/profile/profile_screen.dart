import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:go_router/go_router.dart';
import 'package:vet_mobile_app/core/app_colors.dart';
import 'package:vet_mobile_app/config/router/route_names.dart'; // Бул импорт бар экенин текшериңиз
import 'package:intl/intl.dart'; // For date formatting and age calculation

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  User? _currentUser;
  Map<String, dynamic>? _userData;
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    _currentUser = _auth.currentUser;

    if (_currentUser == null) {
      if (mounted) {
        setState(() {
          _isLoading = false;
          _errorMessage = "Колдонуучу табылган жок. Сураныч, кайра кириңиз.";
        });
      }
      return;
    }

    try {
      DocumentSnapshot<Map<String, dynamic>> userDoc =
          await _firestore.collection('users').doc(_currentUser!.uid).get();

      if (userDoc.exists) {
        setState(() {
          _userData = userDoc.data();
          _isLoading = false;
        });
      } else {
        setState(() {
          _errorMessage = "Колдонуучунун маалыматтары табылган жок.";
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = "Маалыматтарды жүктөөдө ката кетти: $e";
        _isLoading = false;
      });
    }
  }

  String? _calculateAge(Timestamp? dobTimestamp) {
    if (dobTimestamp == null) return null;
    final dob = dobTimestamp.toDate();
    final today = DateTime.now();
    int age = today.year - dob.year;
    if (today.month < dob.month || (today.month == dob.month && today.day < dob.day)) {
      age--;
    }
    return age > 0 ? "$age жаш" : null;
  }

  @override
  Widget build(BuildContext context) {
    final String? avatarUrl = _userData?['avatarUrl'] as String?;
    final String? ageString = _calculateAge(_userData?['dateOfBirth'] as Timestamp?);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Колдонуучу'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            context.go(RouteNames.menu);
          },
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Image.asset(
              'assets/icons/common/logo.png',
              height: 50,
              width: 90,
            ),
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator(color: AppColors.primary))
          : _errorMessage != null
              ? Center(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(_errorMessage!, textAlign: TextAlign.center, style: const TextStyle(color: Colors.red, fontSize: 16)),
                  ),
                )
              : _currentUser == null || _userData == null
                  ? Center(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          _errorMessage ?? "Колдонуучунун маалыматтарын жүктөө мүмкүн болбоду.",
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontSize: 16, color: AppColors.textSecondary),
                        ),
                      ),
                    )
                  : RefreshIndicator(
                      onRefresh: _loadUserData,
                      color: AppColors.primary,
                      child: ListView(
                        padding: const EdgeInsets.all(0), // Removed default ListView padding
                        children: [
                          const SizedBox(height: 24), // Space from AppBar
                          CircleAvatar(
                            radius: 50,
                            backgroundColor: Colors.grey.shade200, // Placeholder background
                            backgroundImage: avatarUrl != null && avatarUrl.isNotEmpty
                                ? NetworkImage(avatarUrl)
                                : null,
                            child: avatarUrl == null || avatarUrl.isEmpty
                                ? const Icon(Icons.person, size: 60, color: AppColors.primary) // Placeholder icon
                                : null,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            _userData!['fullName'] ?? 'Аты-жөнү жок',
                            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
                            textAlign: TextAlign.center,
                          ),
                          if (ageString != null) ...[
                            const SizedBox(height: 4),
                            Text(
                              ageString,
                              style: TextStyle(fontSize: 15, color: AppColors.textSecondary.withOpacity(0.8)),
                              textAlign: TextAlign.center,
                            ),
                          ],
                          const SizedBox(height: 24), // Space before the info box
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 20.0), // Adjusted margin
                            padding: const EdgeInsets.symmetric(vertical: 8.0), // Added vertical padding
                            decoration: BoxDecoration(
                              color: Colors.white, // Figma's background for this box
                              borderRadius: BorderRadius.circular(16), // Figma's border radius
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.15), // Softer shadow like Figma
                                  spreadRadius: 2,
                                  blurRadius: 10,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Column(
                              children: [
                                _buildInfoListTile(
                                  icon: Icons.email_outlined,
                                  text: _currentUser!.email ?? 'Email жок',
                                  // iconColor is removed, will use AppColors.primary directly
                                  textColor: AppColors.textSecondary,
                                ),
                                // Divider removed to match Figma
                                _buildInfoListTile(
                                  icon: Icons.phone_outlined,
                                  text: _userData!['phoneNumber'] ?? 'Телефон номери жок',
                                  textColor: AppColors.textSecondary,
                                ),
                                // Divider removed
                                _buildInfoListTile(
                                  icon: Icons.settings_outlined,
                                  text: 'Жөндөөлөр',
                                  textColor: AppColors.textSecondary,
                                  trailing: const Icon(Icons.arrow_forward_ios, size: 18, color: AppColors.primary),
                                  onTap: () async { // Make the onTap async
                                    // Navigate to EditProfileScreen and wait for it to pop
                                    await context.pushNamed(RouteNames.editProfileScreen);
                                    // After returning from EditProfileScreen, reload user data
                                    if (mounted) { // Check if the widget is still in the tree
                                      _loadUserData();
                                    }
                                  },
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 32),
                        ],
                      ),
                    ),
    );
  }

  Widget _buildInfoListTile({
    required IconData icon,
    required String text,
    Color? textColor,
    Widget? trailing,
    VoidCallback? onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: AppColors.primary, size: 24), // Icon color set to AppColors.primary
      title: Text(
        text,
        style: TextStyle(fontSize: 16, color: textColor ?? AppColors.textPrimary),
      ),
      trailing: trailing,
      onTap: onTap,
      dense: true, // Keeps it compact
      contentPadding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0), // Adjusted padding
    );
  }
}