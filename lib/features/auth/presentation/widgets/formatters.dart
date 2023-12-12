import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

// ignore: avoid_classes_with_only_static_members
class Formatters {
  static final phoneFormatter = MaskTextInputFormatter(
      mask: '## ### ## ##',
      filter: {'#': RegExp(r'[\+0-9]')},
      type: MaskAutoCompletionType.lazy);
}
