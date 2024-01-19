import 'package:flutter/material.dart';

class MyTextBox extends StatelessWidget {
  final String text;
  final String sectionName;
  final VoidCallback onpressed;
  const MyTextBox({super.key,required this.text,required this.sectionName,required this.onpressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.only(left: 15,bottom: 15),
      margin: EdgeInsets.only(left: 20,right: 20,top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(sectionName,style: TextStyle(
                color: Colors.grey.shade500
              ),
              ),
              IconButton(
                  onPressed:onpressed,
                  icon: Icon(
                Icons.settings
              ))
            ],
          ),
          Text(text),
        ],
      ),
    );
  }
}
