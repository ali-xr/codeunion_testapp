import 'package:codeunion_testapp/assets/colors/colors.dart';
import 'package:codeunion_testapp/features/auth/presentation/pages/password.dart';
import 'package:codeunion_testapp/features/common/presentation/widgets/custom_screen.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen>
    with TickerProviderStateMixin {
  late PageController pageController;
  late TabController tabController;
  int currentPage = 0;

  @override
  initState() {
    pageController = PageController();
    tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  dispose() {
    pageController.dispose();
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScreen(
      child: Scaffold(
        // resizeToAvoidBottomInset: false,
        backgroundColor: darkGreen,

        body: Column(
          children: [
            Spacer(),
            Text('Register',
                style: Theme.of(context)
                    .textTheme
                    .displayMedium!
                    .copyWith(fontSize: 28, fontWeight: FontWeight.w700)),
            const SizedBox(height: 8),
            Text(
              'Register Your Account',
              style: Theme.of(context)
                  .textTheme
                  .displayMedium!
                  .copyWith(fontSize: 14, fontWeight: FontWeight.w400),
            ),
            Spacer(),
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
            Container(
              height: MediaQuery.of(context).size.height -
                  (180 + MediaQuery.of(context).padding.top) -
                  94,
              color: primary,
              child: Container(
                  decoration: const BoxDecoration(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(16)),
                    color: white,
                  ),
                  padding: const EdgeInsets.only(top: 16),
                  child: const PasswordScreen()),
            ),
          ],
        ),
        // body: CustomScrollView(
        //   physics: const ClampingScrollPhysics(),
        //   slivers: [
        //     SliverAppBar(
        //       stretch: true,
        //       expandedHeight: 180 + MediaQuery.of(context).padding.top,
        //       titleSpacing: 0,
        //       leadingWidth: 0,
        //       elevation: 0,
        //       pinned: false,
        //       floating: true,
        //       centerTitle: false,
        //       collapsedHeight: 80 + MediaQuery.of(context).padding.top,
        //       toolbarHeight: 80 + MediaQuery.of(context).padding.top,
        //       automaticallyImplyLeading: false,
        //       backgroundColor: darkGreen,
        //       title: Padding(
        //         padding:
        //             EdgeInsets.only(top: MediaQuery.of(context).viewInsets.top),
        //         child: Column(
        //           mainAxisSize: MainAxisSize.min,
        //           children: [
        //             WScaleAnimation(
        //               onTap: () => Navigator.of(context).pop(),
        //               child: Padding(
        //                 padding: const EdgeInsets.only(
        //                     right: 16, bottom: 16, left: 16),
        //                 child: SvgPicture.asset(AppIcons.chevronLeft),
        //               ),
        //             ),
        //             Padding(
        //               padding: const EdgeInsets.only(left: 16),
        //               child: Container(
        //                 height: 50,
        //                 width: 50,
        //                 color: Colors.blue,
        //               ),
        //             ),
        //           ],
        //         ),
        //       ),
        //       flexibleSpace: FlexibleSpaceBar(
        //         collapseMode: CollapseMode.parallax,
        //         background: Padding(
        //           padding: const EdgeInsets.symmetric(horizontal: 16),
        //           child: Column(
        //             crossAxisAlignment: CrossAxisAlignment.start,
        //             mainAxisAlignment: MainAxisAlignment.end,
        //             children: [
        //               Text('Register',
        //                   style: Theme.of(context)
        //                       .textTheme
        //                       .displayMedium!
        //                       .copyWith(
        //                           fontSize: 28, fontWeight: FontWeight.w700)),
        //               const SizedBox(height: 8),
        //               Text(
        //                 'Register Your Account',
        //                 style: Theme.of(context)
        //                     .textTheme
        //                     .displayMedium!
        //                     .copyWith(
        //                         fontSize: 14, fontWeight: FontWeight.w400),
        //               ),
        //             ],
        //           ),
        //         ),
        //       ),
        //     ),
        //     SliverPersistentHeader(
        //       pinned: true,
        //       delegate: RegistrationHeader(currentPage: currentPage),
        //     ),
        //
        //   ],
        // ),
      ),
      //
    );
  }
}
