import 'package:codeunion_testapp/assets/colors/colors.dart';
import 'package:codeunion_testapp/features/auth/presentation/widgets/registration_progress.dart';
import 'package:flutter/material.dart';

class RegistrationHeader extends SliverPersistentHeaderDelegate {
  final int currentPage;
  const RegistrationHeader({required this.currentPage});
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: darkGreen,
      alignment: Alignment.bottomCenter,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Container(
                height: 53,
                decoration: const BoxDecoration(
                  color: primary,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                ),
              ),
              // Container(
              //   height: 16,
              //   decoration: BoxDecoration(
              //     color: white,
              //     boxShadow: [
              //       BoxShadow(
              //         offset: const Offset(0, -4),
              //         blurRadius: 20,
              //         color: woodSmoke.withOpacity(0.06),
              //       )
              //     ],
              //     borderRadius: const BorderRadius.only(
              //       topLeft: Radius.circular(16),
              //       topRight: Radius.circular(16),
              //     ),
              //   ),
              // )
            ],
          ),
          Positioned(
            top: -28,
            left: 27,
            right: 27,
            child: RegistrationProgress(
              currentPosition: currentPage,
            ),
          ),
        ],
      ),
    );
  }

  @override
  double get maxExtent => 94;

  @override
  double get minExtent => 94;

  @override
  bool shouldRebuild(covariant RegistrationHeader oldDelegate) {
    return currentPage != oldDelegate.currentPage;
  }
}
