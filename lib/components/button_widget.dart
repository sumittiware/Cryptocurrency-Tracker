import 'package:crypto_app/style/colors.dart';
import 'package:flutter/material.dart';

class ButtonWidget extends StatefulWidget {
  final String label;
  final Color bgColor;
  final Color textColor;
  final Function() onTap;
  final EdgeInsets padding;
  final bool showborder;

  const ButtonWidget({
    super.key,
    required this.label,
    required this.bgColor,
    required this.textColor,
    required this.onTap,
    this.padding = const EdgeInsets.all(16),
    this.showborder = true,
  });

  @override
  State<ButtonWidget> createState() => _ButtonWidgetState();
}

class _ButtonWidgetState extends State<ButtonWidget> {
  final _colorUtils = ColorUtils();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          (!widget.showborder) ? EdgeInsets.zero : const EdgeInsets.all(8.0),
      child: ElevatedButton(
        onPressed: widget.onTap,
        style: ElevatedButton.styleFrom(
          elevation: 0.5,
          textStyle: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 14,
            color: widget.textColor,
          ),
          backgroundColor: widget.bgColor,
          foregroundColor: widget.textColor,
          shape: (!widget.showborder)
              ? RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                  side: BorderSide(
                    color: _colorUtils.primary,
                    width: 1,
                  ),
                )
              : RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
          padding: widget.padding,
        ),
        child: Text(widget.label),
      ),
    );
  }
}
