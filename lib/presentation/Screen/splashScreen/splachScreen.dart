import 'dart:async';


import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projectapp/domain/shared_preferences/shared_preferences.dart';
import 'package:projectapp/domain/bloc/Appstate/Appstate.dart';
import 'package:projectapp/domain/shared_preferences/shared_preferences.dart';
import 'package:projectapp/presentation/resources/assets_manager.dart';
import 'package:projectapp/presentation/resources/route_manager.dart';

import '../../../domain/bloc/cubit/cubit.dart';
import '../../resources/color_manager.dart';
import '../../uploadTask/uploadTask.dart';
class SplashScreenApp extends StatefulWidget {

  const SplashScreenApp({Key? key}) : super(key: key);

  @override
  State<SplashScreenApp> createState() => _SplashScreenAppState();
}

class _SplashScreenAppState extends State<SplashScreenApp> {
  Timer?_timer;
  _startDelay(){
    _timer = Timer( const Duration(
        seconds: 2
    ),
        _goNext

    );
  }
  _goNext() {
    if (CacheHelper.getBoolean(key: "on_boarding") ?? false) {
      Navigator.pushReplacementNamed(context, Routes.loginRoute);
      }else{
        Navigator.pushReplacementNamed(context, Routes.onBoardingRoute);
      }
    }

  var connectivityResult ;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _startDelay();
  }
  @override
  void dispose() {
    _timer?.cancel();
    // TODO: implement dispose
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {

        return Scaffold(

          backgroundColor: ColorManager.primary,
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Image(

                image: AssetImage(ImageAssets.splashLogo),
              )
            ],
          ),
        );



  }
}







