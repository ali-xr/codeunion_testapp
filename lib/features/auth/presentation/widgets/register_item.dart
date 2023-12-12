import 'package:codeunion_testapp/assets/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class RegisterItem extends StatelessWidget {
  final String icon;
  final bool isCurrent;

  const RegisterItem({required this.icon, this.isCurrent = false, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      padding: const EdgeInsets.all(12),
      height: 56,
      width: 56,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(width: 1, color: white.withOpacity(0.4)),
        color: isCurrent ? white : darkGreen,
        boxShadow: isCurrent
            ? [
                BoxShadow(
                  blurRadius: 16,
                  offset: const Offset(0, 8),
                  color: black.withOpacity(0.16),
                ),
              ]
            : [],
      ),
      child: Center(
        child: SvgPicture.asset(
          icon,
          color: isCurrent ? primary : white,
        ),
      ),
    );
  }
}
