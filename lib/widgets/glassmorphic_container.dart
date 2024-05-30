// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:ui';
import 'package:flutter/material.dart';

class GlassmorphicContainer extends StatelessWidget {
  final alignment;
  final padding;
  final color;
  final decoration;
  final foregroundDecoration;
  final double? width;
  final double? height;
  final BoxConstraints? constraints;
  final margin;
  final transform;
  final transformAlignment;
  final child;
  final clipBehavior;
  final double blur;

  const GlassmorphicContainer({
    super.key,
    this.alignment,
    this.padding,
    this.color = Colors.white,
    this.decoration,
    this.foregroundDecoration,
    this.width,
    this.height,
    this.constraints,
    this.margin,
    this.transform,
    this.transformAlignment,
    this.child,
    this.clipBehavior = Clip.none,
    this.blur = 1,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment,
      child: FractionallySizedBox(
        widthFactor: width,
        heightFactor: height,
        child: Container(
          padding: padding,
          foregroundDecoration: foregroundDecoration,
          constraints: constraints,
          margin: margin,
          transform: transform,
          transformAlignment: transformAlignment,
          clipBehavior: clipBehavior,
          child: ClipRRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomCenter,
                    colors: [color.withOpacity(0.6), color.withOpacity(0.1)],
                  ),
                  border: Border.all(width: 2, color: color.withOpacity(0.3)),
                ),
                child: child,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
