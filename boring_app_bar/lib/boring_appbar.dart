import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'dart:ui' as ui;

class BoringAppBar extends StatefulWidget implements PreferredSizeWidget {
  final AppBar contentAppBar;

  BoringAppBar({Key key, @required this.contentAppBar}) : super(key: key);

  @override
  _BoringAppBarState createState() => _BoringAppBarState();

  // default is 56.0
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class _BoringAppBarState extends State<BoringAppBar> {
  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    final double statusBarWidth = MediaQuery.of(context).size.width;
    return Stack(
      children: <Widget>[
        widget.contentAppBar,
        Container(
          margin: EdgeInsets.fromLTRB(0, statusBarHeight, 0, 0),
          //height: widget.preferredSize.height,
          child: CustomPaint(
            painter: BackgroundTextPainter(
                statusBarWidth, widget.preferredSize.height),
          ),
        )
      ],
    );
  }
}

class BackgroundTextPainter extends CustomPainter {
  static const number_text_paragraph = 20;
  static const _list_string = ['🎅', '🎄'];
  static const _font_size_min = 8;
  static const _font_size_max = 30;
  static const _space_offset_width = 5;
  static const _space_offset_height = 5;

  final double width;
  final double height;

  final Random random = new Random();
  final _paragraphStyle = ui.ParagraphStyle(
    textDirection: TextDirection.ltr,
  );

  final _constraints = ui.ParagraphConstraints(width: kToolbarHeight);

  double randomMinMax(int min, int max) =>
      (min + random.nextInt(max - min + 1)).toDouble();

  double _fontSize() => randomMinMax(_font_size_min, _font_size_max);

  Offset _offset() => Offset(
      randomMinMax(_space_offset_width, width.toInt() - _space_offset_width),
      randomMinMax(
          _space_offset_height, height.toInt() - _space_offset_height));

  String _text() => _list_string[random.nextInt(_list_string.length)];

  Paragraph _makeParagraph() {
    final textStyle = ui.TextStyle(
      color: Colors.white,
      fontSize: _fontSize(),
    );

    final paragraphBuilder = ui.ParagraphBuilder(_paragraphStyle)
      ..pushStyle(textStyle)
      ..addText(_text());

    final paragraph = paragraphBuilder.build();
    paragraph.layout(_constraints);
    return paragraph;
  }

  BackgroundTextPainter(this.width, this.height);

  @override
  void paint(Canvas canvas, Size size) {
    for (int i = 0; i < number_text_paragraph; i++) {
      canvas.drawParagraph(_makeParagraph(), _offset());
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
