import 'package:codeunion_testapp/features/common/presentation/bloc/show_pop_up/show_pop_up_bloc.dart';
import 'package:codeunion_testapp/features/common/presentation/widgets/error_message_container.dart';
import 'package:codeunion_testapp/features/common/presentation/widgets/success_message_container.dart';
import 'package:codeunion_testapp/features/common/presentation/widgets/w_keyboard_dismisser.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomScreen extends StatelessWidget {
  final Widget child;
  final Color? color;
  const CustomScreen({required this.child, this.color, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShowPopUpBloc, ShowPopUpState>(
      builder: (context, state) => Material(
        color: color,
        child: Stack(
          children: [
            Positioned.fill(child: WKeyboardDismisser(child: child)),
            AnimatedPositioned(
              top: state.showPopUp
                  ? MediaQuery.of(context).padding.top + 12
                  : -(MediaQuery.of(context).padding.top + 12 + 56),
              left: 16,
              right: 16,
              duration: const Duration(milliseconds: 150),
              child: state.isSuccess
                  ? SuccessMessageContainer(
                      message: state.message,
                    )
                  : ErrorMessageContainer(message: state.message),
            )
          ],
        ),
      ),
    );
  }
}
