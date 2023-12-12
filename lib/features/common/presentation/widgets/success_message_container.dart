import 'package:codeunion_testapp/assets/colors/colors.dart';
import 'package:codeunion_testapp/assets/constants/app_icons.dart';
import 'package:codeunion_testapp/features/common/presentation/bloc/show_pop_up/show_pop_up_bloc.dart';
import 'package:codeunion_testapp/features/common/presentation/widgets/w_scale_animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SuccessMessageContainer extends StatelessWidget {
  final String message;

  const SuccessMessageContainer({
    required this.message,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        border: Border.all(
          color: successBorder,
          width: 2,
        ),
        color: successBackground,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
              color: successIcon,
              borderRadius: BorderRadius.circular(12),
            ),
            alignment: Alignment.center,
            child: SvgPicture.asset(
              AppIcons.circleCheck,
              // color: white,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              message,
              maxLines: 5,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context)
                  .textTheme
                  .displaySmall!
                  .copyWith(color: errorTextColor),
            ),
          ),
          WScaleAnimation(
              onTap: () {
                context.read<ShowPopUpBloc>().add(HidePopUp());
              },
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: SvgPicture.asset(
                  AppIcons.errorClose,
                  colorFilter:
                      const ColorFilter.mode(successCloseIcon, BlendMode.srcIn),
                ),
              ))
        ],
      ),
    );
  }
}
