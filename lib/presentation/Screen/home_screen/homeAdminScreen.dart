import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projectapp/domain/bloc/Appstate/Appstate.dart';
import 'package:projectapp/domain/bloc/cubit/cubit.dart';
import 'package:projectapp/domain/constant/constant.dart';
import 'package:projectapp/presentation/Screen/calendar/calendar_screen.dart';
import 'package:projectapp/presentation/resources/assets_manager.dart';
import 'package:projectapp/presentation/resources/color_manager.dart';
import 'package:projectapp/presentation/resources/route_manager.dart';
import 'package:projectapp/presentation/resources/string_manager.dart';
import 'package:projectapp/presentation/resources/style_manager.dart';
import 'package:projectapp/presentation/resources/value_manager.dart';
import 'package:sizer/sizer.dart';

import '../../show_task_admin.dart';

class HomeAdminScreen extends StatelessWidget {
  const HomeAdminScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;
    var cubit = AppCubit.get(context);
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(
                  Icons.logout
              ),
              onPressed: (){
                Navigator.maybePop(context);
                Navigator.of(context).pushReplacementNamed(Routes.loginRoute  );

              },
            ),
          ),
          backgroundColor: ColorManager.primary,
          body: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image(
                        image: AssetImage(ImageAssets.splashLogo),
                        width: width * 0.4),
                    Row(
                      children: [
                        SizedBox(
                          child: Image(
                            image: AssetImage(
                                (cubit.userModel?.username == "admin")
                                    ? ImageAssets.adminLogo
                                    : ImageAssets.createUserLogo),
                          ),
                        ),
                        Column(
                          children: [
                            Text(
                              (cubit.userModel?.username == "admin")
                                  ? AppString.admin
                                  : AppString.user,
                              style: getBoldStyle(
                                  color: ColorManager.white,
                                  fontSize: AppSize.s24),
                            )
                          ],
                        )
                      ],
                    ),
                    (SizerUtil.deviceType != DeviceType.mobile)?
                    (cubit.emailControllerLogin.text ==
                        "admin")?ElevatedButton(
                        onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)
                      => ShowTaskAdmin()
                      ));
                    }, child: const Text("Show tasks")) :const SizedBox() : SizedBox()
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: (SizerUtil.deviceType == DeviceType.mobile)
                      ? Column(

                          children: [
                            homeAndUserScreenMobile(
                                function: () {
                                  if (cubit.emailControllerLogin.text ==
                                      "admin") {

                                    Navigator.of(context).pushNamed(Routes.createUserRoute);

                                  } else {
                                     cubit.projectTask().then((value) {
                                       Navigator.of(context).pushNamed(Routes.showTasks);

                                     });
                                  }
                                },
                                right: true,
                                imagePath:
                                    (cubit.emailControllerLogin.text ==
                                            "admin")
                                        ? ImageAssets.adminPageImage1
                                        : ImageAssets.userLoginImage1,
                                text: (cubit.emailControllerLogin.text ==
                                        "admin")
                                    ? "create user"
                                    : "Show Task",
                                height: height),
                            SizedBox(
                              height: height * 0.02,
                            ),
                            homeAndUserScreenMobile(

                                function: () async{
                                  if (cubit.emailControllerLogin.text ==
                                      "admin") {

                                    Navigator.of(context).push( MaterialPageRoute(builder: (context)=>
                                        ShowTaskAdmin()
                                    ));

                                  } else {
                                    await cubit.projectTask().then((value) {

                                      Navigator.of(context).push( MaterialPageRoute(builder: (context)=>
                                          CalendarScreen()
                                      ));

                                    });

                                  }
                                },
                                right: false,
                                imagePath:
                                    (cubit.emailControllerLogin.text ==
                                            "admin")
                                        ? ImageAssets.adminPageImage2
                                        : ImageAssets.calender,
                                text: (cubit.emailControllerLogin.text ==
                                        "admin")
                                    ? "Show  Task"
                                    : "calender",
                                height: height),
                            SizedBox(
                              height: height * 0.03,
                            ),
                            GestureDetector(
                              onTap: () {
                                cubit.getAllUser().then((value) {
                                  Navigator.of(context).pushNamed(Routes.chatScreenRoute);

                                });


                              },
                              child: Card(
                                color: ColorManager.gery,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(58.0),
                                ),
                                clipBehavior: Clip.antiAlias,
                                elevation: 1,
                                child: Padding(
                                  padding: const EdgeInsets.all(4),
                                  child: Row(
                                    children: [

                                      const Image(
                                        image: AssetImage(ImageAssets
                                            .adminUserPageImage3),
                                      ),

                                      Text(
                                        "chat screen",
                                        style: getRegularStyle(
                                            color: ColorManager.white,
                                            fontSize: AppSize.s24),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),

                          ],
                        )
                      : Row(
                          children: [
                            Expanded(
                              child: homeAndUserScreenWeb(
                                  function: () async{
                                    if (cubit.emailControllerLogin.text ==
                                        "admin") {

                                      Navigator.of(context).pushNamed(Routes.createUserRoute);

                                    } else {
                                      await cubit.projectTask().then((value) {
                                        Navigator.of(context).pushNamed(Routes.showTasks);
                                      });


                                    }
                                  },
                                  imagePath:
                                      (cubit.emailControllerLogin.text ==
                                              "admin")
                                          ? ImageAssets.adminPageImage1
                                          : ImageAssets.userLoginImage1,
                                  text: (cubit.emailControllerLogin.text ==
                                          "admin")
                                      ? "create user"
                                      : "Show Task",
                                  ),
                            ),

                            Expanded(
                              child: homeAndUserScreenWeb(
                                  function: () async {
                                    if (cubit.emailControllerLogin.text ==
                                        "admin") {
                                      Navigator.of(context).pushNamed(Routes.uploadTaskScreenOneRoute);

                                    } else {
                                      await cubit.projectTask().then((value) {

                                        Navigator.of(context).push(
                                          MaterialPageRoute(builder: (context)=>CalendarScreen()
                                        ));

                                      });

                                    }
                                  },
                                  imagePath:
                                      (cubit.emailControllerLogin.text ==
                                              "admin")
                                          ? ImageAssets.adminPageImage2
                                          : ImageAssets.calender,
                                  text: (cubit.emailControllerLogin.text ==
                                          "admin")
                                      ? "Upload Task"
                                      : "calender",
                                 ),
                            ),

                            Expanded(
                              child: homeAndUserScreenWeb(
                                function: ()  {
                                  cubit.getAllUser().then((value) {

                                    Navigator.of(context).pushNamed(Routes.chatScreenRoute);
                                  });



                                },
                                imagePath:ImageAssets.adminUserPageImage3,
                                text: "chat screen",

                              ),
                            ),
                          ],
                        ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
