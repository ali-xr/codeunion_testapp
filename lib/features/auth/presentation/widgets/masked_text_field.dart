import 'package:codeunion_testapp/features/auth/presentation/widgets/formatters.dart';
import 'package:flutter/material.dart';

class WMaskedTextField extends StatefulWidget {
  final TextEditingController controller;
  final TextStyle? style;
  final String mask;
  final String escapeCharacter;
  final int maxLength;
  final TextInputType keyboardType;
  final TextInputAction? textInputAction;
  final InputDecoration decoration;
  final FocusNode? focusNode;
  final ValueChanged<String>? onChange;
  final VoidCallback? onEditingComplete;

  const WMaskedTextField({
    required this.controller,
    this.style,
    this.mask = 'xxxxxxxxxxxxxx',
    this.escapeCharacter = 'x',
    this.maxLength = 100,
    this.keyboardType = TextInputType.text,
    this.textInputAction,
    this.decoration = const InputDecoration(),
    this.focusNode,
    this.onChange,
    this.onEditingComplete,
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _WMaskedTextFieldState();
}

class _WMaskedTextFieldState extends State<WMaskedTextField> {
  int lastTextSize = 0;

  @override
  Widget build(BuildContext context) => TextField(
        controller: widget.controller,
        style: widget.style,
        inputFormatters: [Formatters.phoneFormatter],
        keyboardType: widget.keyboardType,
        textInputAction: widget.textInputAction,
        decoration: widget.decoration,
        focusNode: widget.focusNode,
        onEditingComplete: widget.onEditingComplete,
        onChanged: (text) {
          if (text.length < lastTextSize) {
            if (widget.mask[text.length] != widget.escapeCharacter) {
              widget.controller.selection = TextSelection.fromPosition(
                  TextPosition(offset: widget.controller.text.length));
            }
          } else {
            // its typing
            if (text.length >= lastTextSize) {
              final position = text.length;

              if ((widget.mask[position - 1] != widget.escapeCharacter) &&
                  (text[position - 1] != widget.mask[position - 1])) {
                widget.controller.text = _buildText(text);
              }

              if (widget.maxLength != position &&
                  widget.mask[position] != widget.escapeCharacter) {
                widget.controller.text =
                    '${widget.controller.text}${widget.mask[position]}';
              }
            }

            // Android on change resets cursor position(cursor goes to 0)
            // so you have to check if it reset, then put in the end(just on android)
            // as IOS bugs if you simply put it in the end
            if (widget.controller.selection.start <
                widget.controller.text.length) {
              widget.controller.selection = TextSelection.fromPosition(
                  TextPosition(offset: widget.controller.text.length));
            }
          }

          // update cursor position
          lastTextSize = widget.controller.text.length;

          if (widget.onChange != null) {
            widget.onChange!(widget.controller.text);
          }
        },
      );

  String _buildText(String text) {
    final buffer = StringBuffer();
    // var result = '';

    for (var i = 0; i < text.length - 1; i++) {
      buffer.write(text[i]);
      //  result += text[i];
    }
    buffer
      ..write(widget.mask[text.length - 1])
      ..write(text[text.length - 1]);
    // result += widget.mask[text.length - 1];
    // result += text[text.length - 1];

    return buffer.toString(); // result;
  }
}
