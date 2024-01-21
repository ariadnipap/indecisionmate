import 'package:flutter/material.dart';

@immutable
class AppTextTheme extends ThemeExtension<AppTextTheme> {
  final TextStyle? seeThroughText;
  final TextStyle? suggestions;
  final TextStyle? basicText;
  final TextStyle? title;
  final TextStyle? smallerTitle;
  final TextStyle? underlinedBasicText;
  final TextStyle? editOption;
  final TextStyle? continuebutton;
  final TextStyle? wheel;

   const AppTextTheme({
    this.seeThroughText,
    this.suggestions,
    this.basicText,
    this.title,
    this.smallerTitle,
    this.underlinedBasicText,
    this.editOption,
    this.continuebutton,
    this.wheel
  });

  AppTextTheme.fallback()
      : this(
        seeThroughText: const TextStyle(
          color: Colors.white,
          fontSize: 32,
          fontFamily: 'Fugaz One',
          fontWeight: FontWeight.w400,
        ),
        suggestions: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w400,
          fontFamily: "Fugaz One",
          fontStyle: FontStyle.normal,
          decoration: TextDecoration.none,
        ),
        basicText: const TextStyle(
          color: Colors.white,
          fontSize: 23,
          fontWeight: FontWeight.w400,
          fontFamily: "Fugaz One",
          fontStyle: FontStyle.normal,
          decoration: TextDecoration.none,
        ),
        title: const TextStyle(
          color: Colors.white,
          fontSize: 45,
          fontWeight: FontWeight.w400,
          fontFamily: "Fugaz One",
          fontStyle: FontStyle.normal,
          decoration: TextDecoration.none,
        ),
        smallerTitle: const TextStyle(
          color: Colors.white,
          fontSize: 30,
          fontWeight: FontWeight.w400,
          fontFamily: "Fugaz One",
          fontStyle: FontStyle.normal,
          decoration: TextDecoration.none,
        ),
        underlinedBasicText: const TextStyle(
          color: Colors.white,
          fontSize: 23,
          fontWeight: FontWeight.w400,
          fontFamily: "Fugaz One",
          fontStyle: FontStyle.normal,
          decoration: TextDecoration.underline,
        ),
        editOption: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w400,
          fontFamily: "Inter",
          fontStyle: FontStyle.normal,
          decoration: TextDecoration.none,
        ),
        continuebutton: TextStyle(
          color: Colors.white.withOpacity(0.7),
          fontSize: 23,
          fontWeight: FontWeight.w400,
          fontFamily: 'Fugaz One', 
          fontStyle: FontStyle.normal,
          decoration: TextDecoration.none,
        ),
        wheel: const TextStyle(
          color: Colors.black,
          fontSize: 18,
          fontFamily: 'Fugaz One',
          fontWeight: FontWeight.w400,
          fontStyle: FontStyle.normal,
          decoration: TextDecoration.none,
          ),
      );

  @override
  AppTextTheme copyWith({
    TextStyle? seeThroughText,
    TextStyle? suggestions,
    TextStyle? basicText,
    TextStyle? title,
    TextStyle? smallerTitle,
    TextStyle? underlinedBasicText,
    TextStyle? editOption,
    TextStyle? continuebutton,
    TextStyle? wheel,
  }) {
    return AppTextTheme(
      seeThroughText: seeThroughText ?? this.seeThroughText,
      suggestions: suggestions ?? this.suggestions,
      basicText: basicText ?? this.basicText,
      title: title ?? this.title,
      smallerTitle: smallerTitle ?? this.smallerTitle,
      underlinedBasicText: underlinedBasicText ?? this.underlinedBasicText,
      editOption: editOption ?? this.editOption,
      continuebutton: continuebutton ?? this.continuebutton,
      wheel: wheel ?? this.wheel,
    );
  }

  @override
  AppTextTheme lerp(AppTextTheme? other, double t) {
    if (other is! AppTextTheme) return this;
    return AppTextTheme(
      seeThroughText: TextStyle.lerp(seeThroughText, other.seeThroughText, t),
      suggestions: TextStyle.lerp(suggestions, other.suggestions, t),
      basicText: TextStyle.lerp(basicText, other.basicText, t),
      title: TextStyle.lerp(title, other.title, t),
      smallerTitle: TextStyle.lerp(smallerTitle, other.smallerTitle, t),
      underlinedBasicText: TextStyle.lerp(underlinedBasicText, other.underlinedBasicText, t),
      editOption: TextStyle.lerp(editOption, other.editOption, t),
      continuebutton: TextStyle.lerp(continuebutton, other.continuebutton, t),
      wheel: TextStyle.lerp(wheel, other.wheel, t)
    );
  }
}