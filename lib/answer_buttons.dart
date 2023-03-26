import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'const.dart';

class AnswerButtons extends StatefulWidget {
  const AnswerButtons(
      {Key? key, required this.functionOnTap, required this.buttonText})
      : super(key: key);
  final String buttonText;
  final VoidCallback functionOnTap;
  @override
  _AnswerButtonsState createState() => _AnswerButtonsState();
}

class _AnswerButtonsState extends State<AnswerButtons> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(),
          left: BorderSide(),
          right: BorderSide(),
          bottom: BorderSide(),
        ),
      ),
      width: MediaQuery.of(context).size.width * buttonWidthMultiplier,
      height: MediaQuery.of(context).size.height * buttonHeightMultiplier,
      child: InkWell(
        onTap: widget.functionOnTap,
        child: Center(
          child: Text(widget.buttonText, style: answerButtonsStyle),
        ),
      ),
    );
  }
}
