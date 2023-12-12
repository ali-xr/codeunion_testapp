import 'package:codeunion_testapp/assets/colors/colors.dart';
import 'package:codeunion_testapp/assets/constants/app_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class InfoContainer extends StatelessWidget {
  const InfoContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: primary.withOpacity(0.1),
      ),
      child: Row(
        children: [
          SvgPicture.asset(AppIcons.infoCircle),
          const SizedBox(width: 8),
          Expanded(
            child: RichText(
              text: TextSpan(children: [
                TextSpan(
                  text: 'Login Info',
                  style: Theme.of(context).textTheme.displayLarge!.copyWith(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                ),
                TextSpan(
                    text: ' (A-z, '
                        '0-9, ., _)',
                    style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ))
              ]),
            ),
          )
        ],
      ),
    );
  }
}
