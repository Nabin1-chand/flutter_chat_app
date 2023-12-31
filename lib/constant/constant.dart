import 'package:flutter/material.dart';

const kSendButtonTextStyle =
    TextStyle(color: Colors.lightBlueAccent, fontSize: 18.0);
const kMessageTextFieldDecoration = InputDecoration(
    contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
    border: InputBorder.none);
const kMessageContainerDecoration = BoxDecoration(
    border: Border(top: BorderSide(color: Colors.lightBlueAccent, width: 2.0)));

const kTextFieldDecoration = InputDecoration(
    hintText: 'Enter a value',
    contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
    border: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(30.0))),
    enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.blueAccent, width: 1.0),
        borderRadius: BorderRadius.all(Radius.circular(30.0))),
    focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.blueAccent, width: 2.0),
        borderRadius: BorderRadius.all(Radius.circular(30.0))));
