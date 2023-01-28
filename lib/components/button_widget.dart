import 'package:crypto_app/style/colors.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatefulWidget {
  final String label;
  final Function() onTap;
  final Color textColor;
  final Color bgColor;

  const CustomButton({
    super.key,
    required this.label,
    required this.onTap,
    required this.textColor,
    required this.bgColor,
  });

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  final _colorUtils = ColorUtils();

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: widget.onTap,
      style: ElevatedButton.styleFrom(
        elevation: 2,
        backgroundColor: widget.bgColor,
        foregroundColor: widget.textColor,
        padding: const EdgeInsets.all(8),
      ),
      child: Text(widget.label),
    );
  }
}

class ButtonWidget extends StatefulWidget {
  final String label;
  final Color bgColor;
  final Color textColor;
  final Function() onTap;

  const ButtonWidget({
    super.key,
    required this.label,
    required this.bgColor,
    required this.textColor,
    required this.onTap,
  });

  @override
  State<ButtonWidget> createState() => _ButtonWidgetState();
}

class _ButtonWidgetState extends State<ButtonWidget> {
  final _colorUtils = ColorUtils();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: widget.onTap,
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: widget.bgColor,
            borderRadius: BorderRadius.circular(4),
            border: Border.all(
              color: _colorUtils.primary,
              width: 1,
            ),
            boxShadow: [
              BoxShadow(
                offset: const Offset(0, 2),
                blurRadius: 4,
                spreadRadius: 0,
                color: _colorUtils.white.withOpacity(0.075),
              )
            ],
          ),
          alignment: Alignment.center,
          child: Text(
            widget.label,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 14,
              color: widget.textColor,
            ),
          ),
        ),
      ),
    );
  }
}
