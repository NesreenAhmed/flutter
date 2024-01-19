import 'package:flutter/material.dart';


class RoundedButton extends StatelessWidget {
  RoundedButton({required this.color,required this.title,required this.onPress,required this.textColor,required this.font });
  final Color color;
  final String title;
  final VoidCallback onPress;
 final Color textColor;
 final String font;

  @override
  Widget build(BuildContext context) {
    return Padding(padding: EdgeInsets.symmetric(vertical: 16),
      child: Material(
        elevation: 12,
        color: color,
        //color: Colors.blueAccent,
        borderRadius: BorderRadius.circular(38),
        child: MaterialButton(
          onPressed: onPress,
          //go to login screen

          minWidth: 200,
          height: 42,
          child:  Text(
            title,
            style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color:textColor,
              fontFamily: font,
              letterSpacing: 3

            ),
          ),
        ),
      ),
    );
  }
}
