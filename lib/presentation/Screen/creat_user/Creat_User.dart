

import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:projectapp/domain/Model/user_model.dart';
import 'package:projectapp/domain/bloc/Appstate/Appstate.dart';
import 'package:projectapp/domain/constant/constant.dart';
import 'package:projectapp/presentation/resources/assets_manager.dart';
import 'package:projectapp/presentation/resources/color_manager.dart';
import 'package:projectapp/presentation/resources/route_manager.dart';
import 'package:projectapp/presentation/resources/string_manager.dart';
import 'package:projectapp/presentation/resources/style_manager.dart';
import 'package:projectapp/presentation/resources/value_manager.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import '../../../domain/bloc/cubit/cubit.dart';
class CreateUser extends StatelessWidget {
  CreateUser({Key? key}) : super(key: key);
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
        appBar: AppBar(
          leading: IconButton(
            onPressed: (){
              Navigator.pushReplacementNamed(
                  context, Routes.homeAdminScreen);
            },
            icon: Icon(
                Icons.arrow_back
            ),

          ),
          elevation: 0,
        ),
        body:  SingleChildScrollView(

          child: Column(
           children: [

             clipPathBuild(width: width,imageLogo1: ImageAssets.splashLogo ,height:height,imageTwo: ImageAssets.createUserLogo,txt: "login" ),


            SizedBox ( height: height*0.1,  child: Center(child: Text("Create User" , style: getBoldStyle(color: ColorManager.primary , fontSize: 24)))),
             ClipPath(
               clipper: OvalTopBorderClipper(),
               child: Container(
                 width: width,
                 height: height*.52,
                 color: ColorManager.primary,
                 child: Column(
                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   children: [
                     SizedBox(
                 width:  (width >=768 )? 400 :width,

                       child: Padding(
                         padding: const EdgeInsets.all(AppPadding.p35),
                         child: Form(
                             key: formKey,

                             child: Column(
                           children: [
                             textFormField(  labelTitle: "user name" , controller: cubit.emailControllerCreateUser , validateText: "Enter user name plz" ,pass: false),
                             const SizedBox(
                               height: 30,
                             ),
                             textFormField(  labelTitle: "password" , controller: cubit.passControllerLoginCreateUser , validateText: "Enter user password plz" ,pass: true),
                             const SizedBox(
                               height: 30,
                             ),
                            SizedBox(
                                height:50,
                                width:double.infinity,
                              child: (state is LoadingState)? const CircularProgressIndicator () :ElevatedButton(
                                onPressed: () {
                                  if(formKey.currentState!.validate()){
                                    cubit.addUser();                              }

                                },
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(Colors.white),

                                ), child: Text(
                                "sign in",style: getBoldStyle(color: ColorManager.primary),
                              ),)
                            ),
                           ],
                         ),

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
