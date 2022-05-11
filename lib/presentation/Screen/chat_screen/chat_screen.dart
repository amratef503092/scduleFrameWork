import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projectapp/domain/bloc/Appstate/Appstate.dart';
import 'package:projectapp/domain/constant/constant.dart';
import 'package:projectapp/domain/shared_preferences/shared_preferences.dart';
import 'package:projectapp/presentation/Screen/chat_screen/chat.dart';
import 'package:projectapp/presentation/resources/assets_manager.dart';
import 'package:projectapp/presentation/resources/color_manager.dart';
import 'package:projectapp/presentation/resources/route_manager.dart';
import 'package:projectapp/presentation/resources/style_manager.dart';
import 'package:projectapp/presentation/resources/value_manager.dart';

import '../../../domain/bloc/cubit/cubit.dart';
class ChatScreen extends StatelessWidget {
   ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;
    return BlocConsumer<AppCubit,AppStates>(
      listener: (context, state) {

      },
      builder: (context , state){
        var cubit = AppCubit.get(context);

        return Scaffold(
          appBar: AppBar(
            elevation: 0,
            leading:   Padding(
              padding: EdgeInsets.all(4.0),
              child: CircleAvatar(
                backgroundColor: Color(0xff9A9FA4),
                radius: 4,
                child: IconButton(
                  onPressed: null,
                  icon: IconButton(

                    icon:const Icon(
                      Icons.arrow_back,
                      size: 25,
                      color: Colors.white,
                    ), onPressed: () {
                      Navigator.pushReplacementNamed(context, Routes.homeAdminScreen);
                  } ,
                  ),
                ),

              ),
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  color: ColorManager.primary,
                  height: height*.1,
                  child:Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children:  [
                        profileChat(image: ImageAssets.chatImage1 ,active: true),
                        Text("Messages" , style: getRegularStyle(color: ColorManager.white ,fontSize: 30),),
                        const CircleAvatar(
                          backgroundColor: Color(0xff9A9FA4),
                          radius: 30,
                          child: IconButton(
                            onPressed: null,
                            icon: Icon(
                              Icons.search,
                              size: 28,
                              color: Colors.white,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height *.8,
                  child: ListView.separated(
                      itemBuilder: (context , index){
                    return InkWell(
                      onTap: (){
                         if(cubit.listUser[index].username!=CacheHelper.getDataString(key: 'currentUser')){
                           CacheHelper.saveData(key: 'sender', value: cubit.listUser[index].username);
                           Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) =>
                               ChatScreenTwo(currenUser: cubit.listUser[index].username,sender: cubit.currentUser,)
                           ));
                           print(cubit.listUser[index].username);
                         }

                      },
                      child: ChatRow(
                          userName: cubit.listUser[index].username,

                          image: ImageAssets.chatImage1
                      ),
                    );

                  }, separatorBuilder: (context , index){
                    return Divider (
                      height: 2,
                    );
                  }, itemCount: cubit.listUser.length),
                )





              ],
            ),
          ),
        );
      },
    );
  }
}


