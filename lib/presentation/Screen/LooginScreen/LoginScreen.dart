

import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:projectapp/domain/Model/user_model.dart';
import 'package:projectapp/domain/bloc/Appstate/Appstate.dart';
import 'package:projectapp/domain/constant/constant.dart';
import 'package:projectapp/domain/shared_preferences/shared_preferences.dart';
import 'package:projectapp/presentation/resources/assets_manager.dart';
import 'package:projectapp/presentation/resources/color_manager.dart';
import 'package:projectapp/presentation/resources/string_manager.dart';
import 'package:projectapp/presentation/resources/style_manager.dart';
import 'package:projectapp/presentation/resources/value_manager.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import '../../../domain/bloc/cubit/cubit.dart';
class LoginScreen extends StatelessWidget {
   LoginScreen({Key? key}) : super(key: key);
   var formKey = GlobalKey<FormState>();
  late FirebaseFirestore fireStore;


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
   listener: (context, state) {

   },builder: (context, state)
    {

      var size = MediaQuery.of(context).size;
      var height = size.height;
      var width = size.width;

      var cubit = AppCubit.get(context);


      return Scaffold(
       body:  SingleChildScrollView(
         child: Column(
           children: [
             clipPathBuild(width:  width,imageLogo1: ImageAssets.splashLogo ,height:height,imageTwo: ImageAssets.userLogin,txt: "login" ),

             midDesign( width:  width, height: height,txt: "login",taskImage: ImageAssets.taskList,text:AppString.getYourTasksDone ) ,

             ClipPath(
               clipper: OvalTopBorderClipper(),
               child: Container(
                 height: height*.53,
                 width: width,
                 color: ColorManager.primary,
                 child: Column(
                   children: [
                     SizedBox(
                       width:  (width >=768 )? 400 :width,
                       child: Padding(
                         padding: const EdgeInsets.all(AppPadding.p35),
                         child: Form(child: Column(
                           children: [
                             textFormField(  labelTitle: "user name" , controller: cubit.emailControllerLogin , validateText: "Enter user name plz" ,pass: false),
                             const SizedBox(
                               height: 30,
                             ),
                             textFormField(  labelTitle: "password" , controller: cubit.passControllerLogin , validateText: "Enter user password plz" ,pass: true),
                             const SizedBox(
                               height: 30,
                             ),
                            SizedBox(
                                height:50,
                                width:double.infinity,
                              child: (state is LoadingState)? const CircularProgressIndicator () :ElevatedButton(
                                onPressed: () {
                                  if(formKey.currentState!.validate()){
                                    cubit.readUser(cubit.emailControllerLogin.text ,context);
                                  }

                                },
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(Colors.white),

                                ), child: Text(
                                "sign in",style: getBoldStyle(color: ColorManager.primary),
                              ),)
                            ),
                           ],
                         ),
                           key: formKey,

                         ),
                       ),
                     ),
                   ],
                 ),
               ),
             ),
           ],
         ),
       ),
      );
    },
    );
  }
}
