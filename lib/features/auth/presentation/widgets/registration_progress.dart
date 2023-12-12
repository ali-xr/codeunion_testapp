import 'package:codeunion_testapp/assets/colors/colors.dart';
import 'package:flutter/material.dart';

class RegistrationProgress extends StatelessWidget {
  final int currentPosition;
  const RegistrationProgress({
    this.currentPosition = 0,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Positioned(
          left: 0,
          right: 0,
          child: Container(
            height: 2,
            color: white.withOpacity(0.4),
          ),
        ),
        AnimatedPositioned(
          left: 0,
          right: (MediaQuery.of(context).size.width - 56) -
              ((MediaQuery.of(context).size.width - 56) * (1 / 3) * currentPosition),
          duration: const Duration(milliseconds: 100),
          child: Container(
            height: 2,
            color: white,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // RegisterItem(icon: AppIcons.cliboardList, isCurrent: currentPosition >= 0),
            // RegisterItem(icon: AppIcons.deviceMobile, isCurrent: currentPosition >= 1),
            // RegisterItem(icon: AppIcons.shield, isCurrent: currentPosition >= 2),
            // RegisterItem(icon: AppIcons.bigKey, isCurrent: currentPosition >= 3),
          ],
        ),
      ],
    );
  }
}
