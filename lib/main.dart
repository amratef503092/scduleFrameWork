import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:projectapp/domain/bloc/BlocObserver.dart';
import 'package:projectapp/domain/bloc/cubit/cubit.dart';
import 'package:projectapp/domain/shared_preferences/shared_preferences.dart';
import 'package:projectapp/presentation/resources/route_manager.dart';
import 'package:projectapp/presentation/resources/theme_manager.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();

    await CacheHelper.init();
    WidgetsFlutterBinding.ensureInitialized();

    await Firebase.initializeApp();

    BlocOverrides.runZoned(
          () {
        runApp( const MyApp());
      },
      blocObserver: MyBlocObserver(),
    );
  }







class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return  MultiBlocProvider(

      providers: [
        BlocProvider(create: (_)=>AppCubit())

      ],
      child: Sizer(
        builder: (context, orientation, deviceType){
          return  MaterialApp(
            title: 'Flutter Demo',
            onGenerateRoute: RouteGenerator.getRoute,
            theme: getApplicationTheme(),
            initialRoute:Routes.splashRoute,
          );
        }
      ),
    );
  }
}



