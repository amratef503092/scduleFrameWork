import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projectapp/domain/bloc/Appstate/Appstate.dart';
import 'package:projectapp/domain/shared_preferences/shared_preferences.dart';
import 'package:projectapp/presentation/resources/assets_manager.dart';
import 'package:projectapp/presentation/resources/color_manager.dart';
import 'package:projectapp/presentation/resources/route_manager.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:projectapp/presentation/resources/value_manager.dart';
import 'package:sizer/sizer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../domain/bloc/cubit/cubit.dart';
import '../../../domain/constant/constant.dart';

class OnBoardingScreen extends StatelessWidget {
  OnBoardingScreen({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;
    return BlocProvider(
      create: (context) => AppCubit(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = AppCubit.get(context);

          return Sizer(
            builder: (context, orientation, deviceType) {
              return  Scaffold(
                body: Column(
                  children: [
                    clipPathBuild(
                      imageLogo1:     ImageAssets.splashLogo ,
                        height: height,
                        width: width,

                        txt: "on"),
                    midDesign(height: height, txt: "on"),
                    Expanded(
                      child: ClipPath(
                        clipper: OvalTopBorderClipper(),
                        child: Container(
                          color: ColorManager.primary,
                          child: Row(
                            children: [

                              Expanded(

                                child: PageView.builder(
                                    itemBuilder: (context, index) {
                                      return  downDesign(list: cubit.list , index: index , width: width ,height: height,function: (){
                                        cubit.nextPage(index, context);
                                      });
                                    },
                                    itemCount: cubit.list.length,
                                    controller: cubit.pageController,
                                    onPageChanged: (index) {
                                      cubit.currentIndex = index;
                                    }),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                  ],
                ),
                bottomSheet: Container(
                  height: AppSize.s100,
                  color: ColorManager.white,
                  child: Container(
                    color: ColorManager.primary,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          children: [
                            SmoothPageIndicator(
                              controller: cubit.pageController, // PageController
                              count: cubit.list.length,
                              effect: const SlideEffect(
                                  spacing: 8.0,
                                  radius: 10.0,
                                  dotWidth: 16.0,
                                  dotHeight: 16.0,
                                  paintStyle: PaintingStyle.stroke,
                                  strokeWidth: 2,
                                  dotColor: Colors.grey,
                                  activeDotColor: Colors.white),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                )
              );
            },
          );
        },
      ),
    );
  }
}
