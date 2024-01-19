import 'package:flutter/material.dart';

const kSendBouttonTextStyle=TextStyle(
  color: Colors.black,
  fontWeight: FontWeight.bold,
  fontSize: 18,
);

const kMessageTextFieldDecoration=InputDecoration(
  contentPadding: EdgeInsets.symmetric(vertical: 10,horizontal: 20),
  hintText: 'Message...',
  border: InputBorder.none,
);

const kMessageContainerDecoration=BoxDecoration(
  border: Border(
    top: BorderSide(color: Colors.lightBlueAccent,width: 2)
  )
);

const kTextFieldDecoration=InputDecoration(
  hintText: 'Enter your email',
  hintStyle: TextStyle(color: Colors.blueGrey),
  contentPadding:
  EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide:
    BorderSide(color:kDarkBlueTwo, width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide:
    BorderSide(color:kDarkBlueTwo, width: 3.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
);

const kLightBlue= Color(0xff99D8FF);
const kDarkBlue=Color(0xff0F59B1);

const kDarkBlueTwo=Color(0xff23345f);
const kLightBlueTwo=Color(0xff394d7f);
const kHighLight=Color(0xff486fcb);
const kNotifacation=Color(0xff869dc0);