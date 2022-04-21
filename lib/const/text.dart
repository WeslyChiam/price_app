import 'package:flutter/material.dart';
import 'package:price_app/const/color.dart';

Widget mainTitle(data) {
  return Text(
    data,
    style: const TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
  );
}

Widget subTitle(data) {
  return Text(
    data,
    style: const TextStyle(fontSize: 20.0, fontStyle: FontStyle.italic),
  );
}

Widget content(data) {
  return Text(
    data,
    style: const TextStyle(fontSize: 15.0),
  );
}

Widget bulletList(boldText, text) {
  return ListTile(
    leading: const Icon(Icons.arrow_right),
    title: RichText(
      text: TextSpan(children: <TextSpan>[
        TextSpan(
            text: boldText,
            style: const TextStyle(fontWeight: FontWeight.bold, color: black)),
        TextSpan(text: text, style: const TextStyle(color: black))
      ], style: const TextStyle(fontSize: 15.0)),
    ),
  );
}

Widget boldFirstLetter(boldText, text) {
  return ListTile(
    title: RichText(
        text: TextSpan(children: <TextSpan>[
      TextSpan(
          text: boldText,
          style: const TextStyle(fontWeight: FontWeight.bold, color: black)),
      TextSpan(text: text, style: const TextStyle(color: black)),
    ], style: const TextStyle(fontSize: 15.0))),
  );
}

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
