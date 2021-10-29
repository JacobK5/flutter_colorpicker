/// The components of HSV Color Picker
///
/// Try to create a Color Picker with other layout on your own :)

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/src/utils.dart';

enum PaletteType {
  hsvWithHue,
  hsvWithValue,
  hsvWithSaturation,
  hslWithHue,
  hslWithLightness,
  hslWithSaturation,
  rgbWithBlue,
  rgbWithGreen,
  rgbWithRed,
}
enum TrackType {
  hue,
  saturation,
  saturationForHSL,
  value,
  lightness,
  red,
  green,
  blue,
  alpha,
}
enum ColorLabelType { hex, rgb, hsv, hsl }
enum ColorModel { rgb, hsv, hsl }
// enum ColorModel { rgb, hsv, hsl, hsp, okhsv, okhsl, lab, lch, cmyk }

class HSVWithHueColorPainter extends CustomPainter {
  const HSVWithHueColorPainter(this.hsvColor, {this.pointerColor});

  final HSVColor hsvColor;
  final Color? pointerColor;

  @override
  void paint(Canvas canvas, Size size) {
    final Rect rect = Offset.zero & size;
    const Gradient gradientV = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [Colors.white, Colors.black],
    );
    final Gradient gradientH = LinearGradient(
      colors: [
        Colors.white,
        HSVColor.fromAHSV(1.0, hsvColor.hue, 1.0, 1.0).toColor(),
      ],
    );
    canvas.drawRect(rect, Paint()..shader = gradientV.createShader(rect));
    canvas.drawRect(
      rect,
      Paint()
        ..blendMode = BlendMode.multiply
        ..shader = gradientH.createShader(rect),
    );

    canvas.drawCircle(
      Offset(size.width * hsvColor.saturation, size.height * (1 - hsvColor.value)),
      size.height * 0.04,
      Paint()
        ..color = pointerColor ?? (useWhiteForeground(hsvColor.toColor()) ? Colors.white : Colors.black)
        ..strokeWidth = 1.5
        ..style = PaintingStyle.stroke,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class HSVWithSaturationColorPainter extends CustomPainter {
  const HSVWithSaturationColorPainter(this.hsvColor, {this.pointerColor});

  final HSVColor hsvColor;
  final Color? pointerColor;

  @override
  void paint(Canvas canvas, Size size) {
    final Rect rect = Offset.zero & size;
    const Gradient gradientV = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [Colors.transparent, Colors.black],
    );
    final List<Color> colors = [
      HSVColor.fromAHSV(1.0, 0.0, hsvColor.saturation, 1.0).toColor(),
      HSVColor.fromAHSV(1.0, 60.0, hsvColor.saturation, 1.0).toColor(),
      HSVColor.fromAHSV(1.0, 120.0, hsvColor.saturation, 1.0).toColor(),
      HSVColor.fromAHSV(1.0, 180.0, hsvColor.saturation, 1.0).toColor(),
      HSVColor.fromAHSV(1.0, 240.0, hsvColor.saturation, 1.0).toColor(),
      HSVColor.fromAHSV(1.0, 300.0, hsvColor.saturation, 1.0).toColor(),
      HSVColor.fromAHSV(1.0, 360.0, hsvColor.saturation, 1.0).toColor(),
    ];
    final Gradient gradientH = LinearGradient(colors: colors);
    canvas.drawRect(rect, Paint()..shader = gradientH.createShader(rect));
    canvas.drawRect(rect, Paint()..shader = gradientV.createShader(rect));

    canvas.drawCircle(
      Offset(
        size.width * hsvColor.hue / 360,
        size.height * (1 - hsvColor.value),
      ),
      size.height * 0.04,
      Paint()
        ..color = pointerColor ?? (useWhiteForeground(hsvColor.toColor()) ? Colors.white : Colors.black)
        ..strokeWidth = 1.5
        ..style = PaintingStyle.stroke,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class HSVWithValueColorPainter extends CustomPainter {
  const HSVWithValueColorPainter(this.hsvColor, {this.pointerColor});

  final HSVColor hsvColor;
  final Color? pointerColor;

  @override
  void paint(Canvas canvas, Size size) {
    final Rect rect = Offset.zero & size;
    const Gradient gradientV = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [Colors.transparent, Colors.white],
    );
    final List<Color> colors = [
      const HSVColor.fromAHSV(1.0, 0.0, 1.0, 1.0).toColor(),
      const HSVColor.fromAHSV(1.0, 60.0, 1.0, 1.0).toColor(),
      const HSVColor.fromAHSV(1.0, 120.0, 1.0, 1.0).toColor(),
      const HSVColor.fromAHSV(1.0, 180.0, 1.0, 1.0).toColor(),
      const HSVColor.fromAHSV(1.0, 240.0, 1.0, 1.0).toColor(),
      const HSVColor.fromAHSV(1.0, 300.0, 1.0, 1.0).toColor(),
      const HSVColor.fromAHSV(1.0, 360.0, 1.0, 1.0).toColor(),
    ];
    final Gradient gradientH = LinearGradient(colors: colors);
    canvas.drawRect(rect, Paint()..shader = gradientH.createShader(rect));
    canvas.drawRect(rect, Paint()..shader = gradientV.createShader(rect));
    canvas.drawRect(
      rect,
      Paint()..color = Colors.black.withOpacity(1 - hsvColor.value),
    );

    canvas.drawCircle(
      Offset(
        size.width * hsvColor.hue / 360,
        size.height * (1 - hsvColor.saturation),
      ),
      size.height * 0.04,
      Paint()
        ..color = pointerColor ?? (useWhiteForeground(hsvColor.toColor()) ? Colors.white : Colors.black)
        ..strokeWidth = 1.5
        ..style = PaintingStyle.stroke,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class HSLWithHueColorPainter extends CustomPainter {
  const HSLWithHueColorPainter(this.hslColor, {this.pointerColor});

  final HSLColor hslColor;
  final Color? pointerColor;

  @override
  void paint(Canvas canvas, Size size) {
    final Rect rect = Offset.zero & size;
    final Gradient gradientH = LinearGradient(
      colors: [
        const Color(0xff808080),
        HSLColor.fromAHSL(1.0, hslColor.hue, 1.0, 0.5).toColor(),
      ],
    );
    const Gradient gradientV = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      stops: [0.0, 0.5, 0.5, 1],
      colors: [
        Colors.white,
        Color(0x00ffffff),
        Colors.transparent,
        Colors.black,
      ],
    );
    canvas.drawRect(rect, Paint()..shader = gradientH.createShader(rect));
    canvas.drawRect(rect, Paint()..shader = gradientV.createShader(rect));

    canvas.drawCircle(
      Offset(size.width * hslColor.saturation, size.height * (1 - hslColor.lightness)),
      size.height * 0.04,
      Paint()
        ..color = pointerColor ?? (useWhiteForeground(hslColor.toColor()) ? Colors.white : Colors.black)
        ..strokeWidth = 1.5
        ..style = PaintingStyle.stroke,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class HSLWithSaturationColorPainter extends CustomPainter {
  const HSLWithSaturationColorPainter(this.hslColor, {this.pointerColor});

  final HSLColor hslColor;
  final Color? pointerColor;

  @override
  void paint(Canvas canvas, Size size) {
    final Rect rect = Offset.zero & size;
    final List<Color> colors = [
      HSLColor.fromAHSL(1.0, 0.0, hslColor.saturation, 0.5).toColor(),
      HSLColor.fromAHSL(1.0, 60.0, hslColor.saturation, 0.5).toColor(),
      HSLColor.fromAHSL(1.0, 120.0, hslColor.saturation, 0.5).toColor(),
      HSLColor.fromAHSL(1.0, 180.0, hslColor.saturation, 0.5).toColor(),
      HSLColor.fromAHSL(1.0, 240.0, hslColor.saturation, 0.5).toColor(),
      HSLColor.fromAHSL(1.0, 300.0, hslColor.saturation, 0.5).toColor(),
      HSLColor.fromAHSL(1.0, 360.0, hslColor.saturation, 0.5).toColor(),
    ];
    final Gradient gradientH = LinearGradient(colors: colors);
    const Gradient gradientV = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      stops: [0.0, 0.5, 0.5, 1],
      colors: [
        Colors.white,
        Color(0x00ffffff),
        Colors.transparent,
        Colors.black,
      ],
    );
    canvas.drawRect(rect, Paint()..shader = gradientH.createShader(rect));
    canvas.drawRect(rect, Paint()..shader = gradientV.createShader(rect));

    canvas.drawCircle(
      Offset(size.width * hslColor.hue / 360, size.height * (1 - hslColor.lightness)),
      size.height * 0.04,
      Paint()
        ..color = pointerColor ?? (useWhiteForeground(hslColor.toColor()) ? Colors.white : Colors.black)
        ..strokeWidth = 1.5
        ..style = PaintingStyle.stroke,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class HSLWithLightnessColorPainter extends CustomPainter {
  const HSLWithLightnessColorPainter(this.hslColor, {this.pointerColor});

  final HSLColor hslColor;
  final Color? pointerColor;

  @override
  void paint(Canvas canvas, Size size) {
    final Rect rect = Offset.zero & size;
    final List<Color> colors = [
      const HSLColor.fromAHSL(1.0, 0.0, 1.0, 0.5).toColor(),
      const HSLColor.fromAHSL(1.0, 60.0, 1.0, 0.5).toColor(),
      const HSLColor.fromAHSL(1.0, 120.0, 1.0, 0.5).toColor(),
      const HSLColor.fromAHSL(1.0, 180.0, 1.0, 0.5).toColor(),
      const HSLColor.fromAHSL(1.0, 240.0, 1.0, 0.5).toColor(),
      const HSLColor.fromAHSL(1.0, 300.0, 1.0, 0.5).toColor(),
      const HSLColor.fromAHSL(1.0, 360.0, 1.0, 0.5).toColor(),
    ];
    final Gradient gradientH = LinearGradient(colors: colors);
    const Gradient gradientV = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        Colors.transparent,
        Color(0xFF808080),
      ],
    );
    canvas.drawRect(rect, Paint()..shader = gradientH.createShader(rect));
    canvas.drawRect(rect, Paint()..shader = gradientV.createShader(rect));
    canvas.drawRect(
      rect,
      Paint()..color = Colors.black.withOpacity((1 - hslColor.lightness * 2).clamp(0, 1)),
    );
    canvas.drawRect(
      rect,
      Paint()..color = Colors.white.withOpacity(((hslColor.lightness - 0.5) * 2).clamp(0, 1)),
    );

    canvas.drawCircle(
      Offset(size.width * hslColor.hue / 360, size.height * (1 - hslColor.saturation)),
      size.height * 0.04,
      Paint()
        ..color = pointerColor ?? (useWhiteForeground(hslColor.toColor()) ? Colors.white : Colors.black)
        ..strokeWidth = 1.5
        ..style = PaintingStyle.stroke,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class RGBWithRedColorPainter extends CustomPainter {
  const RGBWithRedColorPainter(this.color, {this.pointerColor});

  final Color color;
  final Color? pointerColor;

  @override
  void paint(Canvas canvas, Size size) {
    final Rect rect = Offset.zero & size;
    final Gradient gradientH = LinearGradient(
      colors: [
        Color.fromRGBO(color.red, 255, 0, 1.0),
        Color.fromRGBO(color.red, 255, 255, 1.0),
      ],
    );
    final Gradient gradientV = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        Color.fromRGBO(color.red, 255, 255, 1.0),
        Color.fromRGBO(color.red, 0, 255, 1.0),
      ],
    );
    canvas.drawRect(rect, Paint()..shader = gradientH.createShader(rect));
    canvas.drawRect(
      rect,
      Paint()
        ..shader = gradientV.createShader(rect)
        ..blendMode = BlendMode.multiply,
    );

    canvas.drawCircle(
      Offset(size.width * color.blue / 255, size.height * (1 - color.green / 255)),
      size.height * 0.04,
      Paint()
        ..color = pointerColor ?? (useWhiteForeground(color) ? Colors.white : Colors.black)
        ..strokeWidth = 1.5
        ..style = PaintingStyle.stroke,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class RGBWithGreenColorPainter extends CustomPainter {
  const RGBWithGreenColorPainter(this.color, {this.pointerColor});

  final Color color;
  final Color? pointerColor;

  @override
  void paint(Canvas canvas, Size size) {
    final Rect rect = Offset.zero & size;
    final Gradient gradientH = LinearGradient(
      colors: [
        Color.fromRGBO(255, color.green, 0, 1.0),
        Color.fromRGBO(255, color.green, 255, 1.0),
      ],
    );
    final Gradient gradientV = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        Color.fromRGBO(255, color.green, 255, 1.0),
        Color.fromRGBO(0, color.green, 255, 1.0),
      ],
    );
    canvas.drawRect(rect, Paint()..shader = gradientH.createShader(rect));
    canvas.drawRect(
      rect,
      Paint()
        ..shader = gradientV.createShader(rect)
        ..blendMode = BlendMode.multiply,
    );

    canvas.drawCircle(
      Offset(size.width * color.blue / 255, size.height * (1 - color.red / 255)),
      size.height * 0.04,
      Paint()
        ..color = pointerColor ?? (useWhiteForeground(color) ? Colors.white : Colors.black)
        ..strokeWidth = 1.5
        ..style = PaintingStyle.stroke,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class RGBWithBlueColorPainter extends CustomPainter {
  const RGBWithBlueColorPainter(this.color, {this.pointerColor});

  final Color color;
  final Color? pointerColor;

  @override
  void paint(Canvas canvas, Size size) {
    final Rect rect = Offset.zero & size;
    final Gradient gradientH = LinearGradient(
      colors: [
        Color.fromRGBO(0, 255, color.blue, 1.0),
        Color.fromRGBO(255, 255, color.blue, 1.0),
      ],
    );
    final Gradient gradientV = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        Color.fromRGBO(255, 255, color.blue, 1.0),
        Color.fromRGBO(255, 0, color.blue, 1.0),
      ],
    );
    canvas.drawRect(rect, Paint()..shader = gradientH.createShader(rect));
    canvas.drawRect(
      rect,
      Paint()
        ..shader = gradientV.createShader(rect)
        ..blendMode = BlendMode.multiply,
    );

    canvas.drawCircle(
      Offset(size.width * color.red / 255, size.height * (1 - color.green / 255)),
      size.height * 0.04,
      Paint()
        ..color = pointerColor ?? (useWhiteForeground(color) ? Colors.white : Colors.black)
        ..strokeWidth = 1.5
        ..style = PaintingStyle.stroke,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class HSVWithSaturationColorWheelPainter extends CustomPainter {
  const HSVWithSaturationColorWheelPainter(this.hsvColor, {this.pointerColor});

  final HSVColor hsvColor;
  final Color? pointerColor;

  @override
  void paint(Canvas canvas, Size size) {
    final Rect rect = Offset.zero & size;
    final List<Color> colors = [
      HSVColor.fromAHSV(1.0, 0.0, hsvColor.saturation, 1.0).toColor(),
      HSVColor.fromAHSV(1.0, 60.0, hsvColor.saturation, 1.0).toColor(),
      HSVColor.fromAHSV(1.0, 120.0, hsvColor.saturation, 1.0).toColor(),
      HSVColor.fromAHSV(1.0, 180.0, hsvColor.saturation, 1.0).toColor(),
      HSVColor.fromAHSV(1.0, 240.0, hsvColor.saturation, 1.0).toColor(),
      HSVColor.fromAHSV(1.0, 300.0, hsvColor.saturation, 1.0).toColor(),
      HSVColor.fromAHSV(1.0, 360.0, hsvColor.saturation, 1.0).toColor(),
    ];
    final Gradient gradientS = SweepGradient(colors: colors);
    final Gradient gradientR = RadialGradient(
      colors: [
        Colors.white,
        HSVColor.fromAHSV(1.0, hsvColor.hue, 1.0, 1.0).toColor(),
      ],
    );
    canvas.drawRect(rect, Paint()..shader = gradientS.createShader(rect));
    // canvas.drawRect(
    //   rect,
    //   Paint()
    //     ..blendMode = BlendMode.multiply
    //     ..shader = gradientR.createShader(rect),
    // );

    canvas.drawCircle(
      Offset(size.width * hsvColor.saturation, size.height * (1 - hsvColor.value)),
      size.height * 0.04,
      Paint()
        ..color = pointerColor ?? (useWhiteForeground(hsvColor.toColor()) ? Colors.white : Colors.black)
        ..strokeWidth = 1.5
        ..style = PaintingStyle.stroke,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class _SliderLayout extends MultiChildLayoutDelegate {
  static const String track = 'track';
  static const String thumb = 'thumb';
  static const String gestureContainer = 'gesturecontainer';

  @override
  void performLayout(Size size) {
    layoutChild(
      track,
      BoxConstraints.tightFor(
        width: size.width - 30.0,
        height: size.height / 5,
      ),
    );
    positionChild(track, Offset(15.0, size.height * 0.4));
    layoutChild(
      thumb,
      BoxConstraints.tightFor(width: 5.0, height: size.height / 4),
    );
    positionChild(thumb, Offset(0.0, size.height * 0.4));
    layoutChild(
      gestureContainer,
      BoxConstraints.tightFor(width: size.width, height: size.height),
    );
    positionChild(gestureContainer, Offset.zero);
  }

  @override
  bool shouldRelayout(_SliderLayout oldDelegate) => false;
}

class TrackPainter extends CustomPainter {
  const TrackPainter(this.trackType, this.hsvColor);

  final TrackType trackType;
  final HSVColor hsvColor;

  @override
  void paint(Canvas canvas, Size size) {
    final Rect rect = Offset.zero & size;
    if (trackType == TrackType.alpha) {
      final Size chessSize = Size(size.height / 2, size.height / 2);
      Paint chessPaintB = Paint()..color = const Color(0xffcccccc);
      Paint chessPaintW = Paint()..color = Colors.white;
      List.generate((size.height / chessSize.height).round(), (int y) {
        List.generate((size.width / chessSize.width).round(), (int x) {
          canvas.drawRect(
            Offset(chessSize.width * x, chessSize.width * y) & chessSize,
            (x + y) % 2 != 0 ? chessPaintW : chessPaintB,
          );
        });
      });
    }

    switch (trackType) {
      case TrackType.hue:
        final List<Color> colors = [
          const HSVColor.fromAHSV(1.0, 0.0, 1.0, 1.0).toColor(),
          const HSVColor.fromAHSV(1.0, 60.0, 1.0, 1.0).toColor(),
          const HSVColor.fromAHSV(1.0, 120.0, 1.0, 1.0).toColor(),
          const HSVColor.fromAHSV(1.0, 180.0, 1.0, 1.0).toColor(),
          const HSVColor.fromAHSV(1.0, 240.0, 1.0, 1.0).toColor(),
          const HSVColor.fromAHSV(1.0, 300.0, 1.0, 1.0).toColor(),
          const HSVColor.fromAHSV(1.0, 360.0, 1.0, 1.0).toColor(),
        ];
        Gradient gradient = LinearGradient(colors: colors);
        canvas.drawRect(rect, Paint()..shader = gradient.createShader(rect));
        break;
      case TrackType.saturation:
        final List<Color> colors = [
          HSVColor.fromAHSV(1.0, hsvColor.hue, 0.0, 1.0).toColor(),
          HSVColor.fromAHSV(1.0, hsvColor.hue, 1.0, 1.0).toColor(),
        ];
        Gradient gradient = LinearGradient(colors: colors);
        canvas.drawRect(rect, Paint()..shader = gradient.createShader(rect));
        break;
      case TrackType.saturationForHSL:
        final List<Color> colors = [
          HSLColor.fromAHSL(1.0, hsvColor.hue, 0.0, 0.5).toColor(),
          HSLColor.fromAHSL(1.0, hsvColor.hue, 1.0, 0.5).toColor(),
        ];
        Gradient gradient = LinearGradient(colors: colors);
        canvas.drawRect(rect, Paint()..shader = gradient.createShader(rect));
        break;
      case TrackType.value:
        final List<Color> colors = [
          HSVColor.fromAHSV(1.0, hsvColor.hue, 1.0, 0.0).toColor(),
          HSVColor.fromAHSV(1.0, hsvColor.hue, 1.0, 1.0).toColor(),
        ];
        Gradient gradient = LinearGradient(colors: colors);
        canvas.drawRect(rect, Paint()..shader = gradient.createShader(rect));
        break;
      case TrackType.lightness:
        final List<Color> colors = [
          HSLColor.fromAHSL(1.0, hsvColor.hue, 1.0, 0.0).toColor(),
          HSLColor.fromAHSL(1.0, hsvColor.hue, 1.0, 0.5).toColor(),
          HSLColor.fromAHSL(1.0, hsvColor.hue, 1.0, 1.0).toColor(),
        ];
        Gradient gradient = LinearGradient(colors: colors);
        canvas.drawRect(rect, Paint()..shader = gradient.createShader(rect));
        break;
      case TrackType.red:
        final List<Color> colors = [
          hsvColor.toColor().withRed(0).withOpacity(1.0),
          hsvColor.toColor().withRed(255).withOpacity(1.0),
        ];
        Gradient gradient = LinearGradient(colors: colors);
        canvas.drawRect(rect, Paint()..shader = gradient.createShader(rect));
        break;
      case TrackType.green:
        final List<Color> colors = [
          hsvColor.toColor().withGreen(0).withOpacity(1.0),
          hsvColor.toColor().withGreen(255).withOpacity(1.0),
        ];
        Gradient gradient = LinearGradient(colors: colors);
        canvas.drawRect(rect, Paint()..shader = gradient.createShader(rect));
        break;
      case TrackType.blue:
        final List<Color> colors = [
          hsvColor.toColor().withBlue(0).withOpacity(1.0),
          hsvColor.toColor().withBlue(255).withOpacity(1.0),
        ];
        Gradient gradient = LinearGradient(colors: colors);
        canvas.drawRect(rect, Paint()..shader = gradient.createShader(rect));
        break;
      case TrackType.alpha:
        final List<Color> colors = [
          Colors.black.withOpacity(0.0),
          Colors.black.withOpacity(1.0),
        ];
        Gradient gradient = LinearGradient(colors: colors);
        canvas.drawRect(rect, Paint()..shader = gradient.createShader(rect));
        break;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class ThumbPainter extends CustomPainter {
  const ThumbPainter({this.thumbColor, this.fullThumbColor = false});

  final Color? thumbColor;
  final bool fullThumbColor;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawShadow(
      Path()
        ..addOval(
          Rect.fromCircle(center: const Offset(0.5, 2.0), radius: size.width * 1.8),
        ),
      Colors.black,
      3.0,
      true,
    );
    canvas.drawCircle(
        Offset(0.0, size.height * 0.4),
        size.height,
        Paint()
          ..color = Colors.white
          ..style = PaintingStyle.fill);
    if (thumbColor != null) {
      canvas.drawCircle(
          Offset(0.0, size.height * 0.4),
          size.height * (fullThumbColor ? 1.0 : 0.65),
          Paint()
            ..color = thumbColor!
            ..style = PaintingStyle.fill);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class IndicatorPainter extends CustomPainter {
  const IndicatorPainter(this.color);

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final Size chessSize = Size(size.width / 10, size.height / 10);
    final Paint chessPaintB = Paint()..color = const Color(0xFFCCCCCC);
    final Paint chessPaintW = Paint()..color = Colors.white;
    List.generate((size.height / chessSize.height).round(), (int y) {
      List.generate((size.width / chessSize.width).round(), (int x) {
        canvas.drawRect(
          Offset(chessSize.width * x, chessSize.height * y) & chessSize,
          (x + y) % 2 != 0 ? chessPaintW : chessPaintB,
        );
      });
    });

    canvas.drawCircle(
        Offset(size.width / 2, size.height / 2),
        size.height / 2,
        Paint()
          ..color = color
          ..style = PaintingStyle.fill);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class CheckerPainter extends CustomPainter {
  const CheckerPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final Size chessSize = Size(size.height / 6, size.height / 6);
    Paint chessPaintB = Paint()..color = const Color(0xffcccccc);
    Paint chessPaintW = Paint()..color = Colors.white;
    List.generate((size.height / chessSize.height).round(), (int y) {
      List.generate((size.width / chessSize.width).round(), (int x) {
        canvas.drawRect(
          Offset(chessSize.width * x, chessSize.width * y) & chessSize,
          (x + y) % 2 != 0 ? chessPaintW : chessPaintB,
        );
      });
    });
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class ColorPickerLabel extends StatefulWidget {
  const ColorPickerLabel(
    this.hsvColor, {
    Key? key,
    this.enableAlpha = true,
    this.textStyle,
    this.editable = false, // TODO: TBD
    this.onColorChanged, // TODO: TBD
  }) : super(key: key);

  final HSVColor hsvColor;
  final bool enableAlpha;
  final TextStyle? textStyle;
  final bool editable;
  final ValueChanged<HSVColor>? onColorChanged;

  @override
  _ColorPickerLabelState createState() => _ColorPickerLabelState();
}

class _ColorPickerLabelState extends State<ColorPickerLabel> {
  final Map<ColorLabelType, List<String>> _colorTypes = {
    ColorLabelType.hex: ['R', 'G', 'B', 'A'],
    ColorLabelType.rgb: ['R', 'G', 'B', 'A'],
    ColorLabelType.hsv: ['H', 'S', 'V', 'A'],
    ColorLabelType.hsl: ['H', 'S', 'L', 'A'],
  };

  ColorLabelType _colorType = ColorLabelType.hex;

  List<String> colorValue(HSVColor hsvColor, ColorLabelType colorLabelType) {
    final Color color = hsvColor.toColor();
    if (colorLabelType == ColorLabelType.hex) {
      return [
        color.red.toRadixString(16).toUpperCase().padLeft(2, '0'),
        color.green.toRadixString(16).toUpperCase().padLeft(2, '0'),
        color.blue.toRadixString(16).toUpperCase().padLeft(2, '0'),
        '${(color.opacity * 100).round()}%',
      ];
    } else if (colorLabelType == ColorLabelType.rgb) {
      return [
        color.red.toString(),
        color.green.toString(),
        color.blue.toString(),
        '${(color.opacity * 100).round()}%',
      ];
    } else if (colorLabelType == ColorLabelType.hsv) {
      return [
        '${hsvColor.hue.round()}°',
        '${(hsvColor.saturation * 100).round()}%',
        '${(hsvColor.value * 100).round()}%',
        '${(hsvColor.alpha * 100).round()}%',
      ];
    } else if (colorLabelType == ColorLabelType.hsl) {
      HSLColor hslColor = hsvToHsl(hsvColor);
      return [
        '${hslColor.hue.round()}°',
        '${(hslColor.saturation * 100).round()}%',
        '${(hslColor.lightness * 100).round()}%',
        '${(hsvColor.alpha * 100).round()}%',
      ];
    } else {
      return ['??', '??', '??', '??'];
    }
  }

  List<Widget> colorValueLabels() {
    return [
      for (String item in _colorTypes[_colorType] ?? [])
        if (widget.enableAlpha || item != 'A')
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 7.0),
            child: IntrinsicHeight(
              child: Column(
                children: <Widget>[
                  Text(
                    item,
                    style: widget.textStyle ??
                        Theme.of(context).textTheme.bodyText2?.copyWith(fontWeight: FontWeight.bold, fontSize: 16.0),
                  ),
                  const SizedBox(height: 10.0),
                  Expanded(
                    child: Text(
                      colorValue(widget.hsvColor, _colorType)[_colorTypes[_colorType]!.indexOf(item)],
                      overflow: TextOverflow.ellipsis,
                      style: widget.textStyle ?? Theme.of(context).textTheme.bodyText2,
                    ),
                  ),
                ],
              ),
            ),
          )
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
      DropdownButton(
        value: _colorType,
        onChanged: (ColorLabelType? type) {
          if (type != null) {
            setState(() => _colorType = type);
          }
        },
        items: [
          for (ColorLabelType type in _colorTypes.keys)
            DropdownMenuItem(
              value: type,
              child: Text(type.toString().split('.').last.toUpperCase()),
            )
        ],
      ),
      const SizedBox(width: 10.0),
      ...colorValueLabels(),
    ]);
  }
}

class ColorPickerSlider extends StatelessWidget {
  const ColorPickerSlider(
    this.trackType,
    this.hsvColor,
    this.onColorChanged, {
    Key? key,
    this.displayThumbColor = false,
    this.fullThumbColor = false,
  }) : super(key: key);

  final TrackType trackType;
  final HSVColor hsvColor;
  final ValueChanged<HSVColor> onColorChanged;
  final bool displayThumbColor;
  final bool fullThumbColor;

  void slideEvent(RenderBox getBox, BoxConstraints box, Offset globalPosition) {
    double localDx = getBox.globalToLocal(globalPosition).dx - 15.0;
    double progress = localDx.clamp(0.0, box.maxWidth - 30.0) / (box.maxWidth - 30.0);
    switch (trackType) {
      case TrackType.hue:
        // 360 is the same as zero
        // if set to 360, sliding to end goes to zero
        onColorChanged(hsvColor.withHue(progress * 359));
        break;
      case TrackType.saturation:
        onColorChanged(hsvColor.withSaturation(progress));
        break;
      case TrackType.saturationForHSL:
        onColorChanged(hslToHsv(hsvToHsl(hsvColor).withSaturation(progress)));
        break;
      case TrackType.value:
        onColorChanged(hsvColor.withValue(progress));
        break;
      case TrackType.lightness:
        onColorChanged(hslToHsv(hsvToHsl(hsvColor).withLightness(progress)));
        break;
      case TrackType.red:
        onColorChanged(HSVColor.fromColor(hsvColor.toColor().withRed((progress * 0xff).round())));
        break;
      case TrackType.green:
        onColorChanged(HSVColor.fromColor(hsvColor.toColor().withGreen((progress * 0xff).round())));
        break;
      case TrackType.blue:
        onColorChanged(HSVColor.fromColor(hsvColor.toColor().withBlue((progress * 0xff).round())));
        break;
      case TrackType.alpha:
        onColorChanged(hsvColor.withAlpha(localDx.clamp(0.0, box.maxWidth - 30.0) / (box.maxWidth - 30.0)));
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (BuildContext context, BoxConstraints box) {
      double thumbOffset = 15.0;
      Color thumbColor;
      switch (trackType) {
        case TrackType.hue:
          thumbOffset += (box.maxWidth - 30.0) * hsvColor.hue / 360;
          thumbColor = HSVColor.fromAHSV(1.0, hsvColor.hue, 1.0, 1.0).toColor();
          break;
        case TrackType.saturation:
          thumbOffset += (box.maxWidth - 30.0) * hsvColor.saturation;
          thumbColor = HSVColor.fromAHSV(1.0, hsvColor.hue, hsvColor.saturation, 1.0).toColor();
          break;
        case TrackType.saturationForHSL:
          thumbOffset += (box.maxWidth - 30.0) * hsvToHsl(hsvColor).saturation;
          thumbColor = HSLColor.fromAHSL(1.0, hsvColor.hue, hsvToHsl(hsvColor).saturation, 0.5).toColor();
          break;
        case TrackType.value:
          thumbOffset += (box.maxWidth - 30.0) * hsvColor.value;
          thumbColor = HSVColor.fromAHSV(1.0, hsvColor.hue, 1.0, hsvColor.value).toColor();
          break;
        case TrackType.lightness:
          thumbOffset += (box.maxWidth - 30.0) * hsvToHsl(hsvColor).lightness;
          thumbColor = HSLColor.fromAHSL(1.0, hsvColor.hue, 1.0, hsvToHsl(hsvColor).lightness).toColor();
          break;
        case TrackType.red:
          thumbOffset += (box.maxWidth - 30.0) * hsvColor.toColor().red / 0xff;
          thumbColor = hsvColor.toColor().withOpacity(1.0);
          break;
        case TrackType.green:
          thumbOffset += (box.maxWidth - 30.0) * hsvColor.toColor().green / 0xff;
          thumbColor = hsvColor.toColor().withOpacity(1.0);
          break;
        case TrackType.blue:
          thumbOffset += (box.maxWidth - 30.0) * hsvColor.toColor().blue / 0xff;
          thumbColor = hsvColor.toColor().withOpacity(1.0);
          break;
        case TrackType.alpha:
          thumbOffset += (box.maxWidth - 30.0) * hsvColor.toColor().opacity;
          thumbColor = Colors.black.withOpacity(hsvColor.alpha);
          break;
      }

      return CustomMultiChildLayout(
        delegate: _SliderLayout(),
        children: <Widget>[
          LayoutId(
            id: _SliderLayout.track,
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(50.0)),
              child: CustomPaint(
                  painter: TrackPainter(
                trackType,
                hsvColor,
              )),
            ),
          ),
          LayoutId(
            id: _SliderLayout.thumb,
            child: Transform.translate(
              offset: Offset(thumbOffset, 0.0),
              child: CustomPaint(
                painter: ThumbPainter(
                  thumbColor: displayThumbColor ? thumbColor : null,
                  fullThumbColor: fullThumbColor,
                ),
              ),
            ),
          ),
          LayoutId(
            id: _SliderLayout.gestureContainer,
            child: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints box) {
                RenderBox? getBox = context.findRenderObject() as RenderBox?;
                return GestureDetector(
                  onPanDown: (DragDownDetails details) =>
                      getBox != null ? slideEvent(getBox, box, details.globalPosition) : null,
                  onPanUpdate: (DragUpdateDetails details) =>
                      getBox != null ? slideEvent(getBox, box, details.globalPosition) : null,
                );
              },
            ),
          ),
        ],
      );
    });
  }
}

class ColorIndicator extends StatelessWidget {
  const ColorIndicator(
    this.hsvColor, {
    Key? key,
    this.width = 50.0,
    this.height = 50.0,
  }) : super(key: key);

  final HSVColor hsvColor;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(1000.0)),
        border: Border.all(color: const Color(0xffdddddd)),
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(1000.0)),
        child: CustomPaint(painter: IndicatorPainter(hsvColor.toColor())),
      ),
    );
  }
}

class ColorPickerRect extends StatelessWidget {
  const ColorPickerRect(
    this.hsvColor,
    this.onColorChanged,
    this.paletteType, {
    Key? key,
  }) : super(key: key);

  final HSVColor hsvColor;
  final ValueChanged<HSVColor> onColorChanged;
  final PaletteType paletteType;

  void _handleColorChange(double horizontal, double vertical) {
    switch (paletteType) {
      case PaletteType.hsvWithHue:
        onColorChanged(hsvColor.withSaturation(horizontal).withValue(vertical));
        break;
      case PaletteType.hsvWithSaturation:
        onColorChanged(hsvColor.withHue(horizontal * 360).withValue(vertical));
        break;
      case PaletteType.hsvWithValue:
        onColorChanged(hsvColor.withHue(horizontal * 360).withSaturation(vertical));
        break;
      case PaletteType.hslWithHue:
        onColorChanged(hslToHsv(
          hsvToHsl(hsvColor).withSaturation(horizontal).withLightness(vertical),
        ));
        break;
      case PaletteType.hslWithSaturation:
        onColorChanged(hslToHsv(
          hsvToHsl(hsvColor).withHue(horizontal * 360).withLightness(vertical),
        ));
        break;
      case PaletteType.hslWithLightness:
        onColorChanged(hslToHsv(
          hsvToHsl(hsvColor).withHue(horizontal * 360).withSaturation(vertical),
        ));
        break;
      case PaletteType.rgbWithRed:
        onColorChanged(HSVColor.fromColor(
          hsvColor.toColor().withBlue((horizontal * 255).round()).withGreen((vertical * 255).round()),
        ));
        break;
      case PaletteType.rgbWithGreen:
        onColorChanged(HSVColor.fromColor(
          hsvColor.toColor().withBlue((horizontal * 255).round()).withRed((vertical * 255).round()),
        ));
        break;
      case PaletteType.rgbWithBlue:
        onColorChanged(HSVColor.fromColor(
          hsvColor.toColor().withRed((horizontal * 255).round()).withGreen((vertical * 255).round()),
        ));
        break;
      default:
        break;
    }
  }

  void _handleGesture(Offset position, BuildContext context, double height, double width) {
    RenderBox? getBox = context.findRenderObject() as RenderBox?;
    if (getBox == null) {
      return;
    }
    Offset localOffset = getBox.globalToLocal(position);
    double horizontal = localOffset.dx.clamp(0.0, width) / width;
    double vertical = 1 - localOffset.dy.clamp(0.0, height) / height;
    _handleColorChange(horizontal, vertical);
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        double width = constraints.maxWidth;
        double height = constraints.maxHeight;

        return RawGestureDetector(
          gestures: {
            AlwaysWinPanGestureRecognizer: GestureRecognizerFactoryWithHandlers<AlwaysWinPanGestureRecognizer>(
              () => AlwaysWinPanGestureRecognizer(),
              (AlwaysWinPanGestureRecognizer instance) {
                instance
                  ..onDown = ((details) => _handleGesture(details.globalPosition, context, height, width))
                  ..onUpdate = ((details) => _handleGesture(details.globalPosition, context, height, width));
              },
            ),
          },
          child: Builder(
            builder: (BuildContext _) {
              switch (paletteType) {
                case PaletteType.hsvWithHue:
                  return CustomPaint(painter: HSVWithHueColorPainter(hsvColor));
                case PaletteType.hsvWithSaturation:
                  return CustomPaint(painter: HSVWithSaturationColorPainter(hsvColor));
                case PaletteType.hsvWithValue:
                  return CustomPaint(painter: HSVWithValueColorPainter(hsvColor));
                case PaletteType.hslWithHue:
                  return CustomPaint(painter: HSLWithHueColorPainter(hsvToHsl(hsvColor)));
                case PaletteType.hslWithSaturation:
                  return CustomPaint(painter: HSLWithSaturationColorPainter(hsvToHsl(hsvColor)));
                case PaletteType.hslWithLightness:
                  return CustomPaint(painter: HSLWithLightnessColorPainter(hsvToHsl(hsvColor)));
                case PaletteType.rgbWithRed:
                  return CustomPaint(painter: RGBWithRedColorPainter(hsvColor.toColor()));
                case PaletteType.rgbWithGreen:
                  return CustomPaint(painter: RGBWithGreenColorPainter(hsvColor.toColor()));
                case PaletteType.rgbWithBlue:
                  return CustomPaint(painter: RGBWithBlueColorPainter(hsvColor.toColor()));
                default:
                  return const CustomPaint();
              }
            },
          ),
        );
      },
    );
  }
}

class ColorPickerCircle extends StatelessWidget {
  const ColorPickerCircle(
    this.hsvColor,
    this.onColorChanged,
    this.paletteType, {
    Key? key,
  }) : super(key: key);

  final HSVColor hsvColor;
  final ValueChanged<HSVColor> onColorChanged;
  final PaletteType paletteType;

  void _handleColorChange(double horizontal, double vertical) {
    switch (paletteType) {
      case PaletteType.hsvWithHue:
        onColorChanged(hsvColor.withSaturation(horizontal).withValue(vertical));
        break;
      case PaletteType.hsvWithSaturation:
        onColorChanged(hsvColor.withHue(horizontal * 360).withValue(vertical));
        break;
      case PaletteType.hsvWithValue:
        onColorChanged(hsvColor.withHue(horizontal * 360).withSaturation(vertical));
        break;
      case PaletteType.hslWithHue:
        onColorChanged(hslToHsv(
          hsvToHsl(hsvColor).withSaturation(horizontal).withLightness(vertical),
        ));
        break;
      case PaletteType.hslWithSaturation:
        onColorChanged(hslToHsv(
          hsvToHsl(hsvColor).withHue(horizontal * 360).withLightness(vertical),
        ));
        break;
      case PaletteType.hslWithLightness:
        onColorChanged(hslToHsv(
          hsvToHsl(hsvColor).withHue(horizontal * 360).withSaturation(vertical),
        ));
        break;
      case PaletteType.rgbWithRed:
        onColorChanged(HSVColor.fromColor(
          hsvColor.toColor().withBlue((horizontal * 255).round()).withGreen((vertical * 255).round()),
        ));
        break;
      case PaletteType.rgbWithGreen:
        onColorChanged(HSVColor.fromColor(
          hsvColor.toColor().withBlue((horizontal * 255).round()).withRed((vertical * 255).round()),
        ));
        break;
      case PaletteType.rgbWithBlue:
        onColorChanged(HSVColor.fromColor(
          hsvColor.toColor().withRed((horizontal * 255).round()).withGreen((vertical * 255).round()),
        ));
        break;
      default:
        break;
    }
  }

  void _handleGesture(Offset position, BuildContext context, double height, double width) {
    RenderBox? getBox = context.findRenderObject() as RenderBox?;
    if (getBox == null) {
      return;
    }
    Offset localOffset = getBox.globalToLocal(position);
    double horizontal = localOffset.dx.clamp(0.0, width) / width;
    double vertical = 1 - localOffset.dy.clamp(0.0, height) / height;
    _handleColorChange(horizontal, vertical);
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        double width = constraints.maxWidth;
        double height = constraints.maxHeight;

        return RawGestureDetector(
          gestures: {
            AlwaysWinPanGestureRecognizer: GestureRecognizerFactoryWithHandlers<AlwaysWinPanGestureRecognizer>(
              () => AlwaysWinPanGestureRecognizer(),
              (AlwaysWinPanGestureRecognizer instance) {
                instance
                  ..onDown = ((details) => _handleGesture(details.globalPosition, context, height, width))
                  ..onUpdate = ((details) => _handleGesture(details.globalPosition, context, height, width));
              },
            ),
          },
          child: Builder(
            builder: (BuildContext _) {
              switch (paletteType) {
                case PaletteType.hsvWithHue:
                  return CustomPaint(painter: HSVWithHueColorPainter(hsvColor));
                case PaletteType.hsvWithSaturation:
                  return CustomPaint(painter: HSVWithSaturationColorPainter(hsvColor));
                case PaletteType.hsvWithValue:
                  return CustomPaint(painter: HSVWithValueColorPainter(hsvColor));
                case PaletteType.hslWithHue:
                  return CustomPaint(painter: HSLWithHueColorPainter(hsvToHsl(hsvColor)));
                case PaletteType.hslWithSaturation:
                  return CustomPaint(painter: HSLWithSaturationColorPainter(hsvToHsl(hsvColor)));
                case PaletteType.hslWithLightness:
                  return CustomPaint(painter: HSLWithLightnessColorPainter(hsvToHsl(hsvColor)));
                case PaletteType.rgbWithRed:
                  return CustomPaint(painter: RGBWithRedColorPainter(hsvColor.toColor()));
                case PaletteType.rgbWithGreen:
                  return CustomPaint(painter: RGBWithGreenColorPainter(hsvColor.toColor()));
                case PaletteType.rgbWithBlue:
                  return CustomPaint(painter: RGBWithBlueColorPainter(hsvColor.toColor()));
                default:
                  return const CustomPaint();
              }
            },
          ),
        );
      },
    );
  }
}

class AlwaysWinPanGestureRecognizer extends PanGestureRecognizer {
  @override
  void addAllowedPointer(event) {
    super.addAllowedPointer(event);
    resolve(GestureDisposition.accepted);
  }

  @override
  String get debugDescription => 'alwaysWin';
}