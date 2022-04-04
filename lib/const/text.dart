import 'package:flutter/material.dart';
import 'package:price_app/const/color.dart';

class defaultText extends StatelessWidget {
  final String text;
  final bool italic;
  final bool bold;
  final double size;
  final bool isItBlack;
  defaultText(this.text, this.size, this.italic, this.bold, this.isItBlack);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: size,
        fontStyle: italic == true ? FontStyle.italic : FontStyle.normal,
        fontWeight: bold == true ? FontWeight.bold : FontWeight.normal,
        color: isItBlack == true ? black : white,
      ),
    );
  }
}
