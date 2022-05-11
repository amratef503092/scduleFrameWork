import 'package:flutter/material.dart';
import 'package:projectapp/presentation/Screen/chat_screen/chat.dart';
import 'package:projectapp/presentation/Screen/connect%20to%20internet/conect_to_internet%20plz.dart';
import 'package:projectapp/presentation/uploadTask/uploadTask.dart';
import 'package:projectapp/presentation/resources/string_manager.dart';

import '../Screen/LooginScreen/LoginScreen.dart';
import '../Screen/OnBarding_Screen/OnBoardingScereen.dart';
import '../Screen/Setting/setting.dart';
import '../Screen/chat_screen/chat_screen.dart';
import '../Screen/creat_user/Creat_User.dart';
import '../Screen/home_screen/homeAdminScreen.dart';
import '../Screen/show_tasks/show_task.dart';
import '../Screen/splashScreen/splachScreen.dart';


class Routes{

  static const String splashRoute = "/"; //initial route
  static const String onBoardingRoute = "/onBoarding";
  static const String loginRoute = "/login";
  static const String homeAdminScreen = "/HomeAdminScreen";
  static const String homeUserScreen = "/HomeUserScreen";
  static const String chatScreenRoute = "/ChatScreen";
  static const String connectInternet= "/connectInternet";
  static const String createUserRoute= "/createUser";
  static const String chatScreenTwoRoute= "/chatScreenTwoRoute";
  static const String uploadTaskScreenOneRoute= "/UploadTask";
  static const String setting = "/Setting";
  static const String showTasks = "/showTasks";


}
class RouteGenerator{
  static Route<dynamic> getRoute(RouteSettings routeSettings){
   switch(routeSettings.name){
     case Routes.splashRoute:
       return MaterialPageRoute(
         builder: (context) => SplashScreenApp(),);
     case Routes.connectInternet:
       return MaterialPageRoute(
         builder: (context) => ConnectToInternet(),);
     case Routes.onBoardingRoute:
       return MaterialPageRoute(
         builder: (context) => OnBoardingScreen(),);
     case Routes.loginRoute:
       return MaterialPageRoute(
         builder: (context) => LoginScreen(),);
     case Routes.setting:
       return MaterialPageRoute(
         builder: (context) => Setting(),);
     case Routes.homeAdminScreen:
       return MaterialPageRoute(
         builder: (context) => HomeAdminScreen(),);
     case Routes.createUserRoute:
       return MaterialPageRoute(
         builder: (context) => CreateUser(),);
     case Routes.homeUserScreen:

     case Routes.chatScreenRoute:
       return MaterialPageRoute(
         builder: (context) => ChatScreen(),);
     case Routes.chatScreenTwoRoute:
       return MaterialPageRoute(
         builder: (context) => ChatScreenTwo(),);
     case Routes.uploadTaskScreenOneRoute:
       return MaterialPageRoute(
         builder: (context) => UploadTaskScreenOne(),);
     case Routes.showTasks:
       return MaterialPageRoute(
         builder: (context) => ShowTasks(),);
       default:
         return unDefinedRoute();

   }
  }

  static Route unDefinedRoute() =>MaterialPageRoute(
    builder: (context) => Scaffold(
      appBar: AppBar(
        title: Text(AppString.undefinedRoute),
      ),
      body: Center(
        child:Text(AppString.undefinedRoute),
      ),
    )) ;
}
