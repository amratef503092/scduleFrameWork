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
import '../ProfileUser.dart';
import '../domain/Model/chatModel.dart';
class ShowTaskAdmin extends StatelessWidget {
  ShowTaskAdmin({Key? key}) : super(key: key);

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
          body: Column(
            children: [

              FutureBuilder<QuerySnapshot>(future: FirebaseFirestore.instance.collection('user').get(),
                builder: (context, snapshot) {

                  if(snapshot.hasData){

                   return Expanded(
                     child: ListView.builder(itemBuilder: (context, index) {
                      return (snapshot.data!.docs[index]['username'] == CacheHelper.getDataString(key:'currentUser'))?SizedBox():
                      GestureDetector(
                        onTap: () {
                          cubit.count1 =0;
                          cubit.count2 =0;
                          FirebaseFirestore.instance.collection('user').doc(snapshot.data!.docs[index].id).collection('project').get().then((value) {
                            value.docs.forEach((element) {

                              if(element.data()['status']=='upload'){
                                cubit.count1++;
                              }else{
                                cubit.count2++;

                              }
                            });
                          });
                          Navigator.push(context, MaterialPageRoute(builder:
                              (context)=>ProfileUser(
                            userId:snapshot.data!.docs[index].id,
                          )));

                        },
                        child: Row(
                          children: [
                            const Image(image: AssetImage(
                                ImageAssets.chatImage1
                            )),
                            Text(
                                snapshot.data!.docs[index]['username']
                            )
                          ],
                        ),
                      );
                  },itemCount: snapshot.data!.docs.length,),
                   );

                }else if(snapshot.hasError){
                  return Text("Error");
                }else if(snapshot.connectionState ==ConnectionState.waiting){
                  return Center(child: CircularProgressIndicator.adaptive());
                }
                return Text("Error");

              },)





            ],
          ),
        );
      },
    );
  }
}


