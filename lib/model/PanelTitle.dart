import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PanelTitle extends StatelessWidget {
  final String title;
  final bool isRequired;
  PanelTitle({
    Key key,
    @required this.title,
    @required this.isRequired,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 12, bottom: 4),
      child: Text.rich(
        TextSpan(children: <TextSpan>[
          TextSpan(
            text: title,
            style: TextStyle(
                fontSize: 20,
                color: Color(0xFF93959E),
                fontWeight: FontWeight.w500),
          ),
          // TextSpan(
          //   text: isRequired ? " *" : "",
          //   style: TextStyle(fontSize: 14, color: Color(0xFF3EB16F)),
          // ),
        ]),
      ),
    );
  }
}
