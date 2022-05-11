import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:projectapp/domain/Model/model.dart';
import 'package:projectapp/presentation/Screen/chat_screen/chat.dart';
import 'package:projectapp/presentation/resources/assets_manager.dart';
import 'package:projectapp/presentation/resources/color_manager.dart';
import 'package:projectapp/presentation/resources/route_manager.dart';
import 'package:projectapp/presentation/resources/style_manager.dart';
import 'package:projectapp/presentation/resources/value_manager.dart';
Widget clipPathBuild({ var width, var height , required String imageLogo1 , String ?imageTwo , required String txt}){
  return  ClipPath(
    clipper: OvalBottomBorderClipper(),

    child: Column(
      children: [
        Container(
          color: ColorManager.primary,
          height: height * .3,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: width*.5,
                decoration:  BoxDecoration(
                    image: DecorationImage(
                      image:     AssetImage(imageLogo1),
                    )

                ),
              ),

              (imageTwo==null)? const SizedBox():SizedBox(
                width: width*.3,
                child: Image(
                  image: AssetImage(
                      imageTwo
                  ),
                ),
              ),
            ],
          ),
        ),


      ],
    ),
  );
}
Widget midDesign({var height,  String ?taskImage,String ?text,required String ?txt , var width }){
  return   Container(
    width: width,
    color: ColorManager.white,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children:  [
        (taskImage == null)? const SizedBox():Image(
          image: AssetImage(
            taskImage,
          ),
        ),
        (text== null)?const SizedBox():Text(
            text,style: getBoldStyle(color: ColorManager.primary,fontSize: AppSize.s20),
        )
      ],
    ),
  );
}
Widget downDesign({var width, var height, List<SliderViewObject> ?list, index ,Function? function}){
  return Padding(
    padding: const EdgeInsets.all(20.0),
    child: Column(
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: Container(
            width: width * 0.3,
            height: height * .2,
            decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                      list![index].image1.toString()),
                )),
          ),
        ),
        Align(
          alignment: Alignment.topRight,
          child: SizedBox(
            height: height * 0.13,
            width: width / 2,
            child: Row(
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [
                Text(
                  list[index].title![0],
                  style: const TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                Column(
                  children: [
                    SizedBox(
                      height: height * 0.018,
                    ),
                    SizedBox(
                      height: height * 0.1,
                      width: width * 0.42,
                      child: Text(
                        list[index].title!
                            .substring(1),
                        style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                            color: Colors.white),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
        Row(
          mainAxisAlignment:
          MainAxisAlignment.spaceBetween,
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Container(
                width: width * 0.3,
                height: height * .2,
                decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(list[index].image2
                          .toString()),
                    )),
              ),
            ),
            Column(
              children: [
                const SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsets.all(9.0),
                  child: Align(
                    child: SizedBox(
                        child: GestureDetector(
                          onTap: (){
                            function!();
                          },


                          child: CircleAvatar(
                            backgroundColor:
                            ColorManager.white,
                            radius: 30,
                            child: Icon(
                              list[index].iconData,
                              size: 40,
                              color: ColorManager.primary,
                            ),
                          ),
                        )),
                  ),
                ),
              ],
            )
          ],
        )
      ],
    ),
  );
}
Widget textFormField({required TextEditingController controller,  String ?labelTitle ,  String? validateText ,bool ?pass}){
  return TextFormField(
    controller: controller,
    validator: (value) {
      if (value == null || value.isEmpty) {
        return validateText;
      }
      return null;
    },style:getMediumStyle(color: ColorManager.white ,fontSize: AppSize.s20),
    decoration:  InputDecoration(
        labelText: labelTitle,
        labelStyle: getBoldStyle(color: ColorManager.white,fontSize: AppSize.s20),

        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color:  ColorManager.white),
          //  when the TextFormField in unfocused
        ) ,
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color:  ColorManager.white),
          //  when the TextFormField in focused
        ) ,
        border: const UnderlineInputBorder(
          borderSide: BorderSide(color: ColorManager.white),
        ),
        errorBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color:  ColorManager.error),
        )
    ),
    keyboardType: TextInputType.emailAddress,
    obscureText: pass!,
  );
}
Widget homeAndUserScreenMobile(
    {var height,
    required String text,
      required String imagePath,
       int? flex,
      required bool right,
      required Function? function}){
  return     GestureDetector(
    onTap: (){
      function!();

    },
    child: Container(
      decoration: BoxDecoration(
        color:         ColorManager.gery,
        borderRadius: BorderRadius.circular(58.0),

      ),
      clipBehavior:Clip.antiAlias,
      child: Padding(
        padding: const EdgeInsets.all(AppPadding.p14),
        child: (right) ? Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [


                Text( text,style: getRegularStyle(color: ColorManager.white , fontSize: AppSize.s24),
                ),
              ],
            ),
            Expanded(
              child: Image(
                image: AssetImage(
                    imagePath
                ),
              ),
            ),


          ],
        ): Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image(
              image: AssetImage(
                  imagePath
              ),
            ),
            Column(
              children: [

                Text( text,style: getRegularStyle(color: ColorManager.white , fontSize: AppSize.s24),
                ),
              ],
            ),


          ],
        )
      ),
    ),
  );
}
Widget homeAndUserScreenWeb(
    {
      required String text,
      required String imagePath,
      required Function? function}){
  return     GestureDetector(
    onTap: (){
      function!();

    },
    child: Container(
      decoration: BoxDecoration(
        color:         ColorManager.gery,
        borderRadius: BorderRadius.circular(58.0),

      ),
      clipBehavior:Clip.antiAlias,
      child: Padding(
          padding: const EdgeInsets.all(AppPadding.p14),
          child:  Column(
            children: [
              Image(
                image: AssetImage(
                    imagePath
                ),
              ),
              Text( text,style: getRegularStyle(color: ColorManager.white , fontSize: AppSize.s24),
              ),
            ],
          )
      ),
    ),
  );
}
Widget profileChat({ required String  image, bool active = true}){
  return   Stack(
    clipBehavior: Clip.none,
    children:  [
      CircleAvatar(
      backgroundColor : const Color(0xff39424C) ,
        radius: 35,
        child: CircleAvatar(
          backgroundColor: const Color(0xff9A9FA4),
          radius: 30,
          backgroundImage: AssetImage(
            image,
          ),

        ),
      ),
      Positioned(
        bottom: 6,
        right: 12,
        child: CircleAvatar(
          backgroundColor: (active)? Colors.green :Colors.grey,
          radius: 7,


        ),
      ),
    ],
  );
}


 Widget ChatRow({required String userName  , String ?image}) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image(
              image:  AssetImage(
                image!,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  userName , style: getMediumStyle(color: ColorManager.primary , fontSize: AppSize.s18),
                ),

              ],
            ),


          ],
        );


}

