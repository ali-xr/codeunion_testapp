import 'package:codeunion_testapp/assets/constants/app_icons.dart';
import 'package:codeunion_testapp/features/common/presentation/widgets/w_scale_animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AuthHeader extends StatelessWidget {
  final String title;
  final String subTitle;
  final bool showBackButton;

  const AuthHeader({
    this.title = '',
    this.subTitle = '',
    this.showBackButton = false,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          left: 16, right: 16, top: MediaQuery.of(context).padding.top + 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (showBackButton) ...{
            WScaleAnimation(
              onTap: () => Navigator.of(context).pop(),
              child: Padding(
                padding: const EdgeInsets.only(right: 16, bottom: 16),
                child: SvgPicture.asset(AppIcons.chevronLeft),
              ),
            )
          },
          const SizedBox(height: 24),
          Text(title,
              style: Theme.of(context)
                  .textTheme
                  .displayMedium!
                  .copyWith(fontSize: 38, fontWeight: FontWeight.w700)),
          const SizedBox(height: 8),
          Text(
            subTitle,
            style: Theme.of(context)
                .textTheme
                .displayMedium!
                .copyWith(fontSize: 28, fontWeight: FontWeight.w400),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}
