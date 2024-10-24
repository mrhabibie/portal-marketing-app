import 'package:flutter/material.dart';

import '../theme/theme.dart';

class RoundedButtonWidget extends StatelessWidget {
  final String label;
  final double? paddingTop;
  final Color? backgroundColor, textColor;
  final Color? outlineColor;
  final Widget? child;
  final void Function()? onPressed;
  final double? height;
  final double? borderRadius;
  final BorderSide? borderSide;

  const RoundedButtonWidget({
    super.key,
    required this.label,
    this.paddingTop,
    this.backgroundColor,
    this.textColor,
    this.outlineColor,
    this.child,
    required this.onPressed,
    this.height,
    this.borderRadius,
    this.borderSide,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: paddingTop ?? 0),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          fixedSize: WidgetStateProperty.all(
            Size(MediaQuery.of(context).size.width, height ?? 54),
          ),
          backgroundColor:
              WidgetStateProperty.all(backgroundColor ?? Pallet.purple),
          elevation: WidgetStateProperty.all(0),
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius ?? 10),
              side: borderSide != null
                  ? borderSide!
                  : outlineColor != null
                      ? BorderSide(color: outlineColor!)
                      : BorderSide.none,
            ),
          ),
        ),
        child: child ??
            Text(
              label,
              style: TextStyles.regularNormalRegular
                  .copyWith(color: textColor ?? Pallet.neutralWhite),
            ),
      ),
    );
  }
}
