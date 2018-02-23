# flutter_colorpicker

[![pub package](https://img.shields.io/pub/v/flutter_colorpicker.svg)](https://pub.dartlang.org/packages/flutter_colorpicker)

A HSV color picker for your flutter app.

## Getting Started

### Installation

Add this to your pubspec.yaml (or create it):

```yaml
dependencies:
  flutter_colorpicker: any
```

Then run the flutter tooling:

```bash
flutter packages get
```

Or upgrade the packages with:

```bash
flutter packages upgrade
```

### Example

Use it in [showDialog] widget:

```dart
// create some value
Color pickerColor = new Color(0xff443a49);
Color currentColor = new Color(0xff443a49);
ValueChanged<Color> onColorChanged;

// bind some values with [ValueChanged<Color>] callback
changeColor(Color color) {
    setState(() => pickerColor = color);
}

// raise the [showDialog] widget
showDialog(
    context: context,
    child: new AlertDialog(
        title: const Text('Pick a color!'),
        content: new SingleChildScrollView(
            child: new ColorPicker(pickerColor: pickerColor, onColorChanged: changeColor),
        ),
        actions: <Widget>[
            new FlatButton(
                child: new Text('Got it'),
                onPressed: () {
                    setState(() => currentColor = pickerColor);
                    Navigator.of(context).pop();
                },
            ),
        ],
    ),
)
```

Details in [example/](https://github.com/mchome/flutter_colorpicker/tree/master/example) folder.

I have created the `ColorPicker` widget so you can use the color picker out of the box.
But you can create your own style with the `CustomPaint`.