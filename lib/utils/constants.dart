import 'package:flutter/material.dart';

const COLOR_BLACK = Color.fromRGBO(3, 0, 28, 1.0);
const COLOR_1 = Color.fromRGBO(134, 200, 188, 1.0);
const COLOR_GREY = Color.fromRGBO(134, 134, 163, 184);
const COLOR_WHITE = Color.fromRGBO(255, 255, 255, 1.0);
const COLOR_DARKBLUE = Color.fromRGBO(0, 0, 255, 1.0);
const LIGHT_GREY = Color.fromRGBO(253, 235, 237, 1.0);

const TextTheme TEXT_THEME_DEFAULT = TextTheme(
    headline2: TextStyle(
        color: COLOR_BLACK, fontWeight: FontWeight.w700, fontSize: 22),
    headline3: TextStyle(
        color: Colors.white, fontWeight: FontWeight.w700, fontSize: 20),
    headline4: TextStyle(
        color: COLOR_BLACK, fontWeight: FontWeight.w700, fontSize: 16),
    headline5: TextStyle(
        color: Colors.white70, fontWeight: FontWeight.w700, fontSize: 14),
    headline6: TextStyle(
        color: COLOR_BLACK, fontWeight: FontWeight.w700, fontSize: 12),
    headline1: TextStyle(
        color: Colors.white70, fontWeight: FontWeight.w700, fontSize: 50),
    bodyText1: TextStyle(
        color: Colors.white70,
        fontWeight: FontWeight.w500,
        fontSize: 14,
        height: 1.5),
    bodyText2: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w500,
        fontSize: 14,
        height: 1.5),
    subtitle1: TextStyle(
        color: COLOR_BLACK, fontSize: 12, fontWeight: FontWeight.w500),
    subtitle2: TextStyle(
        color: COLOR_GREY, fontSize: 12, fontWeight: FontWeight.w500));

const TextTheme TEXT_THEME_SMALL = TextTheme(
    headline2: TextStyle(
        color: COLOR_BLACK, fontWeight: FontWeight.w700, fontSize: 20),
    headline3: TextStyle(
        color: COLOR_BLACK, fontWeight: FontWeight.w700, fontSize: 18),
    headline4: TextStyle(
        color: COLOR_BLACK, fontWeight: FontWeight.w700, fontSize: 14),
    headline5: TextStyle(
        color: COLOR_BLACK, fontWeight: FontWeight.w700, fontSize: 12),
    headline6: TextStyle(
        color: Colors.cyan, fontWeight: FontWeight.w700, fontSize: 14),
    headline1: TextStyle(
        color: COLOR_BLACK, fontWeight: FontWeight.w700, fontSize: 22),
    bodyText1: TextStyle(
        color: COLOR_1, fontWeight: FontWeight.w500, fontSize: 15, height: 1.5),
    bodyText2: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w500,
        fontSize: 15,
        height: 1.5),
    subtitle1: TextStyle(
        color: COLOR_BLACK, fontSize: 12, fontWeight: FontWeight.w500),
    subtitle2: TextStyle(
        color: COLOR_GREY, fontSize: 12, fontWeight: FontWeight.w500));
