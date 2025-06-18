import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vet_mobile_app/config/constants/sizes.dart';
import 'package:vet_mobile_app/config/router/route_names.dart';

class AppLogo extends StatelessWidget {
  final double? width;
  final double? height;
  final VoidCallback? onTap;

  const AppLogo({
    super.key,
    this.width,
    this.height,
    this.onTap,
  });

 @override
Widget build(BuildContext context) {
  return GestureDetector(
    onTap: onTap ?? () {
      context.go(RouteNames.profile);
    },
    child: Image.asset(
      'assets/icons/common/logo.png',
      width: width ?? Sizes.logoWidth,
    ),
  );
}
}