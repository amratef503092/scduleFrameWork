
import 'package:flutter/material.dart';
import 'package:projectapp/presentation/resources/style_manager.dart';
import 'package:projectapp/presentation/resources/value_manager.dart';


import 'color_manager.dart';
import 'fonts_manager.dart';

ThemeData getApplicationTheme(){
  return ThemeData(
    // main colors of the app
    primaryColor: ColorManager.primary,
    primaryColorLight: ColorManager.primaryOpacity70,
    primaryColorDark: ColorManager.darkGrey,
    disabledColor: ColorManager.gery1,
      colorScheme: ColorScheme.fromSwatch().copyWith(secondary: ColorManager.gery),
    // card theme
    cardTheme: const CardTheme(
      elevation: AppSize.s4,
      shadowColor: ColorManager.gery,
      color: ColorManager.white,
    ),
    // app bar theme
    appBarTheme: AppBarTheme(
      shadowColor: ColorManager.primaryOpacity70,
      color: ColorManager.primary,
      centerTitle: true,
      elevation: AppSize.s4,
      titleTextStyle: getRegularStyle(color: ColorManager.white,fontSize: FontSize.s12)
    ),
    // button theme
    buttonTheme: const ButtonThemeData(
      shape:  StadiumBorder(),
      disabledColor:  ColorManager.gery1,
      buttonColor: ColorManager.primary,
      splashColor: ColorManager.primaryOpacity70,
    ),
    // elevatedButtonTheme
    elevatedButtonTheme :  ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        textStyle: getRegularStyle(color: ColorManager.white),
        primary: ColorManager.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSize.s12)
        )
      )
    ),
    // text theme
    textTheme: TextTheme(
      headline1: getSemiBoldStyle(color: ColorManager.darkGrey ,fontSize: AppSize.s16 ),
      subtitle1: getLightStyle(color: ColorManager.lightGrey,fontSize: FontSize.s14),
      caption: getRegularStyle(color: ColorManager.gery1),
      bodyText1: getRegularStyle(color: ColorManager.gery),
    ),
    // input decoration theme
    // inputDecorationTheme: InputDecorationTheme(
    //   contentPadding: const EdgeInsets.all(AppPadding.p8),
    //   // hit style
    //   hintStyle: getRegularStyle(color: ColorManager.gery1),
    //   // label style
    //   labelStyle: getMediumStyle(color: ColorManager.darkGrey),
    //   // error style
    //   errorStyle: getRegularStyle(color: ColorManager.error),
    //   //enable border
    //   enabledBorder: const OutlineInputBorder(
    //     borderSide: BorderSide(color: ColorManager.gery , width: AppSize.s1_5),
    //     borderRadius: BorderRadius.all(Radius.circular(AppSize.s8)),
    //   ),
    //   //Focused border
    //   focusedBorder: const OutlineInputBorder(
    //     borderSide: BorderSide(color: ColorManager.primary , width: AppSize.s1_5),
    //     borderRadius: BorderRadius.all(Radius.circular(AppSize.s8)),
    //   ),
    //   // error Border
    //   errorBorder: const OutlineInputBorder(
    //     borderSide: BorderSide(color: ColorManager.error , width: AppSize.s1_5),
    //     borderRadius: BorderRadius.all(Radius.circular(AppSize.s8)),
    //   ),
    //   // focused error
    // focusedErrorBorder: const OutlineInputBorder(
    //     borderSide: BorderSide(color: ColorManager.primary , width: AppSize.s1_5),
    //     borderRadius: BorderRadius.all(Radius.circular(AppSize.s8)),
    //   ),
    //
    // )
  );
}