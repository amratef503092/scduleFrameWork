import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path/path.dart';
import 'package:projectapp/domain/Model/chatModel.dart';
import 'package:projectapp/domain/Model/message_model.dart';
import 'package:projectapp/domain/Model/model.dart';
import 'package:projectapp/domain/Model/user_model.dart';
import 'package:projectapp/domain/bloc/Appstate/Appstate.dart';
import 'package:projectapp/domain/shared_preferences/shared_preferences.dart';
import 'package:projectapp/presentation/resources/assets_manager.dart';
import 'package:projectapp/presentation/resources/route_manager.dart';
import 'package:projectapp/presentation/resources/string_manager.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import '../../Model/project_model.dart';
import '../../constant/FirebaseApi.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(InitialState());

  static AppCubit get(context) => BlocProvider.of(context);
  List<SliderViewObject> list = [
    SliderViewObject(
      title: AppString.onBoardingScreenHeadLine1,
      image2: ImageAssets.onBoardingLogo1,
      image1: ImageAssets.onBoardingLogo2,
      iconData: Icons.arrow_forward,
    ),
    SliderViewObject(
      title: AppString.onBoardingScreenHeadLine2,
      image2: ImageAssets.onBoardingLogo3,
      image1: ImageAssets.onBoardingLogo4,
      iconData: Icons.arrow_forward,

    ),
    SliderViewObject(
      title: AppString.onBoardingScreenHeadLine3,
      image2: ImageAssets.onBoardingLogo5,
      image1: ImageAssets.onBoardingLogo6,
      iconData: Icons.power_settings_new,
    ),
  ];
  String ? userName;

  bool inBoardingScreen = false;

  int currentIndex = 0;
  int count1 = 0;
  int count2 = 0;
  var emailControllerLogin = TextEditingController();
  var passControllerLogin = TextEditingController();
  var emailControllerCreateUser = TextEditingController();
  var passControllerLoginCreateUser = TextEditingController();
  var messageController = TextEditingController();
  PageController pageController = PageController(initialPage: 0);

  String ?currentUser;
  Uint8List? fileBytes;
  String ?fileName;
  File ?file;
  var urlDownload;

  Future<void>selectFile() async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: false);
    print(result!.names);
    if (result != null) {
      fileBytes = result.files.first.bytes;
     fileName = result.files.first.name;
      // Upload file
    }

  }

  Future<void>uploadFile() async {
   var snapshot =  await FirebaseStorage.instance.ref('uploads/$fileName').putData(fileBytes!);

    urlDownload = await snapshot.ref.getDownloadURL();

    print('Download-Link: $urlDownload');

  }



  nextPage(int index, context) {
    if (index < 2) {
      pageController.nextPage(
          duration: const Duration(
              milliseconds: 750),
          curve: Curves
              .fastLinearToSlowEaseIn);
    } else {
      Navigator
          .pushReplacementNamed(
          context,
          Routes.loginRoute);
      inBoardingScreen = true;
      CacheHelper.saveData(
          key: "on_boarding",
          value: inBoardingScreen);
    }
    emit(NextPage());
  }

  UserModel ?userModel;

  void readUser(String username, context) async {
    final docUser = FirebaseFirestore.instance
        .collection('user').doc(username);
    final snapShot = await docUser.get();
    emit(LoadingState());
    if (snapShot.exists) {
      userModel = UserModel.fromJson(snapShot.data()!);
      if (userModel?.username == emailControllerLogin.text &&
          userModel?.password == passControllerLogin.text) {
        CacheHelper.saveData(
            key: 'currentUser', value: emailControllerLogin.text);

        Navigator.pushReplacementNamed(context, Routes.homeAdminScreen);


      } else if (userModel?.username == emailControllerLogin.text &&
          userModel?.password == passControllerLogin.text) {
        CacheHelper.saveData(
            key: 'currentUser', value: emailControllerLogin.text);
        Navigator.pushReplacementNamed(context, Routes.homeAdminScreen);
      } else {
        Fluttertoast.showToast(
            msg: "password or username is wrong",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 5,
            webBgColor: "#e61f34",
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0
        );
      }
      emit(DataIsDone());
    } else {
      Fluttertoast.showToast(
          msg: "password or username is wrong",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 5,
          webBgColor: "#e61f34",
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
      emit(GetDataError());
    }
  }


  Future<Future<bool?>> addUser() async {
    CollectionReference users = FirebaseFirestore.instance.collection('user');
    final docUser = FirebaseFirestore.instance
        .collection('user').doc(emailControllerCreateUser.text);
    final snapShot = await docUser.get();
    if (snapShot.exists) {
      emit(CreateUserNameError());
      return Fluttertoast.showToast(
          msg: "username is exist",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 5,
          webBgColor: "#e61f34",
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
    } else {
      return users.doc(emailControllerCreateUser.text)
          .set({
        'username': emailControllerCreateUser.text, // John Doe
        'password': passControllerLoginCreateUser.text, // Stokes and Sons

      })
          .then((value) {
        Fluttertoast.showToast(
            msg: "Done",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 5,
            webBgColor: "#e61f34",
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0
        );
        emit(CreateUserNameDone());
      }
      )
          .catchError((error) {
        Fluttertoast.showToast(
            msg: "password or username is wrong",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 5,
            webBgColor: "#e61f34",
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0
        );
        emit(CreateUserNameError());
      });
    }
  }

  List<ChatUserModel> listUser = [];

  Future<void> getAllUser() async {
    listUser = [];
     FirebaseFirestore.instance.collection('user').get().then((
        value) {
      value.docs.forEach((element) {
        if (CacheHelper.getDataString(key: 'currentUser') !=
            element.data()['username']) {
          listUser.add(ChatUserModel.fromJson(element.data()));
        }
      });
      emit(GetAllUsersDone());
    }).catchError((e) {
      emit(GetAllUsersError());
    });
  }


  List<ProjectModel> projectModel = [];
  List<String> projectModelID = [];


  Future<void> projectTask() async {
     projectModel = [];
     projectModelID = [];
     FirebaseFirestore.instance.
    collection('user').
    doc('${CacheHelper.getDataString(key: 'currentUser')}').
    collection('project').get().then((value)  {

      for (var element in value.docs) {
        element.id;
        projectModelID.add(element.id);
        projectModel.add(ProjectModel.fromJson(element.data()));
      }
      emit(GetProjectTaskDone());
    }).catchError((e){
      print(e.toString());

     });
  }
  Future<void> projectTaskAdmin(String x) async {
    projectModel = [];
    projectModelID = [];
    FirebaseFirestore.instance.
    collection('user').
    doc(x).
    collection('project').get().then((value)  {

      for (var element in value.docs) {
        element.id;
        projectModelID.add(element.id);
        projectModel.add(ProjectModel.fromJson(element.data()));
      }
      print(projectModel[1].status);
      emit(GetProjectTaskDone());
    }).catchError((e){
      print(e.toString());

    });
  }

  void sendMessage({
    required String text,
    required var time,
    String ?receiver,
  }) async
  {
    MessageModel messageModel =
    MessageModel(
        senderId: CacheHelper.getDataString(key: 'currentUser'),
        text: text,
        dateTime: time,
        receiverId: CacheHelper.getDataString(key: 'sender')
    );
    FirebaseFirestore.instance.collection('user').doc(CacheHelper.getDataString(key: 'currentUser')).
    collection('chats').doc(CacheHelper.getDataString(key: 'sender')).collection('messages').add(messageModel.toMap()).then((value) {
      emit(SendMessageDone());
    }).catchError((e){
      emit(SendMessageError());
    });
    FirebaseFirestore.instance.collection('user').doc(CacheHelper.getDataString(key: 'sender')).
    collection('chats').doc(CacheHelper.getDataString(key: 'currentUser')).collection('messages').add(messageModel.toMap()).then((value) {
      emit(SendMessageDone());
    }).catchError((e){
      emit(SendMessageError());
    });
    
  }
}


