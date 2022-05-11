import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projectapp/domain/bloc/Appstate/Appstate.dart';
import 'package:projectapp/domain/shared_preferences/shared_preferences.dart';
import 'package:projectapp/presentation/resources/assets_manager.dart';
import 'package:projectapp/presentation/resources/color_manager.dart';
import 'package:projectapp/presentation/resources/route_manager.dart';
import 'package:projectapp/presentation/resources/style_manager.dart';
import 'package:projectapp/presentation/resources/value_manager.dart';

import '../../../domain/bloc/cubit/cubit.dart';

class ChatScreenTwo extends StatelessWidget {
  String ? currenUser;
  String ? sender;
  ChatScreenTwo({this.currenUser , this.sender});
  final fireStore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = AppCubit.get(context);
        return Scaffold(
            appBar: AppBar(
              elevation: 0,
              leading: Padding(
                padding: EdgeInsets.all(4.0),
                child: CircleAvatar(
                  backgroundColor: Color(0xff9A9FA4),
                  radius: 4,
                  child: IconButton(
                    onPressed: () {
                      if(  (CacheHelper.getDataString(key: 'currentUser') =='admin' )){
                        Navigator.pushReplacementNamed(context, Routes.chatScreenRoute);
                      }else{
                        Navigator.pushReplacementNamed(context, Routes.homeAdminScreen);

                      }


                    },
                    icon: Icon(
                      Icons.arrow_back,
                      size: 25,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            body: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                        width: double.infinity,
                        color: ColorManager.primary,
                        child: Column(
                          children: [
                            const CircleAvatar(
                              backgroundColor: Color(0xff39424C),
                              radius: 70,
                              child: CircleAvatar(
                                backgroundColor: Color(0xff9A9FA4),
                                radius: 100,
                                backgroundImage: AssetImage(
                                  ImageAssets.chatImage1,
                                ),
                              ),
                            ),
                            Text(
                              CacheHelper.getDataString(key: 'sender').toString(),
                              style: getMediumStyle(
                                  color: ColorManager.white,
                                  fontSize: AppSize.s18),
                            )
                          ],
                        )),
                    StreamBuilder<QuerySnapshot>(
                      stream:
                      FirebaseFirestore.instance.
                      collection('user').
                      doc('${CacheHelper.getDataString(key: 'currentUser')}').
                      collection('chats').doc(CacheHelper.getDataString(key: 'sender')).
                      collection('messages').orderBy('time').snapshots(),
                      builder: (context , snapshot)
                      {
                        if(!snapshot.hasData){
                          return Text(
                              "no message"
                          ) ;
                        }else{
                          final messages = snapshot.data!.docs.reversed;
                          List<MessageLine> messageWidgets = [];

                          for(var message in messages){

                            final messageText = message.get('text');
                            final sender = message.get('sender');
                            messageWidgets.add(MessageLine(sender:sender , messageText: messageText,isMe: CacheHelper.getDataString(key: 'currentUser') == sender));
                          }
                          return Expanded(
                            child: ListView(
                              reverse: true,
                              children:  messageWidgets,
                            ),
                          ) ;
                        }

                      },

                    ),
                    // (cubit.messageList.length>0)? Expanded(
                    //   child: ListView.separated(itemBuilder: (context , index){
                    //     var message  = cubit.messageList[index];
                    //
                    //    return MessageLine(sender: message.senderId,messageText: message.text,isMe:message.senderId == CacheHelper.getDataString(key: 'currentUser') );
                    //
                    //
                    //   } ,itemCount: cubit.messageList.length,separatorBuilder: (context , index){
                    //     return SizedBox(
                    //       height: 15,
                    //     );
                    //   }, ),
                    // ): Center(
                    //   child: CircularProgressIndicator(),
                    // ),
                    Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              controller: cubit.messageController,
                              decoration: InputDecoration(
                                labelText: "Enter Email",
                                fillColor: Colors.white,
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25.0),
                                  borderSide: BorderSide(
                                    color: Colors.blue,
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25.0),
                                  borderSide: BorderSide(
                                    color: ColorManager.primary,
                                    width: 2.0,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        CircleAvatar(
                            backgroundColor: const Color(0xff39424C),
                            radius: 25,
                            child: IconButton(
                              icon: const Icon(
                                Icons.send,
                                color: ColorManager.white,
                              ),
                              onPressed: () {

                                cubit.sendMessage(text: cubit.messageController.text , time:DateTime.now().toString() );

                                cubit.messageController.clear();
                              },
                            ))
                      ],
                    ),
                  ]),
            );
      },
    );
  }
}

class MessageLine extends StatelessWidget {
  MessageLine({
    this.messageText,
    this.sender,
    this.isMe,
  });
  String? messageText;
  String? sender;
  bool? isMe;
  @override
  Widget build(BuildContext context) {
    return (isMe!)
        ? Padding(
            padding: const EdgeInsets.all(AppPadding.p12),
            child: Container(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text('$sender'),
                  Material(
                    elevation: 2,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                      topLeft: Radius.circular(30),
                    ),
                    color: ColorManager.primary,
                    child: Padding(
                      padding: const EdgeInsets.all(14.0),
                      child: Text(
                        '$messageText',
                        style: getBoldStyle(
                          color: ColorManager.white,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        : Padding(
            padding: const EdgeInsets.all(AppPadding.p12),
            child: Container(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('$sender'),
                  Material(
                    elevation: 2,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30),
                        topRight: Radius.circular(30)),
                    color: Color(0xffAAACAE),
                    child: Padding(
                      padding: const EdgeInsets.all(14.0),
                      child: Text(
                        '$messageText',
                        style: getBoldStyle(
                          color: Color(0xff1A1D21),
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}
// (CacheHelper.getDataString(key: 'currentUser') !='admin' ) ?
//
// fireStore.collection('chats').doc('admin_${CacheHelper.getDataString(key: 'currentUser')}').collection('message').orderBy('time').snapshots()
//     :fireStore.collection('chats').doc('admin_${CacheHelper.getDataString(key: 'sender')}').collection('message').orderBy('time').snapshots(),