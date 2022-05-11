import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path/path.dart';
import 'package:projectapp/domain/bloc/cubit/cubit.dart';
import 'package:projectapp/presentation/resources/assets_manager.dart';
import 'package:projectapp/presentation/resources/color_manager.dart';
import 'package:projectapp/presentation/resources/route_manager.dart';
import 'package:projectapp/presentation/resources/style_manager.dart';
import 'package:projectapp/presentation/resources/value_manager.dart';

import '../../domain/bloc/Appstate/Appstate.dart';
import '../../domain/constant/constant.dart';
import '../selectUser/SelectUser.dart';

class UploadTaskScreenOne extends StatelessWidget {
   UploadTaskScreenOne({Key? key}) : super(key: key);
  TextEditingController titleController = TextEditingController();
   TextEditingController de = TextEditingController();
  var formKey = GlobalKey<FormState>();

   @override
  Widget build(BuildContext context) {

    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;
    var cubit = AppCubit.get(context);


        return BlocConsumer<AppCubit,AppStates>(listener: (context, state) {

        },
          builder: (context ,state){

            return Scaffold(
            backgroundColor: Color(0xff3D4752),
            body: SingleChildScrollView(
              child: Column(
                  children:
                  [
                    SizedBox(
                      height: height * .2,
                      width: double.infinity,
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Positioned(
                            right: -130,
                            top: -40,
                            child: Container(
                              width: 500,
                              height: height * .4,
                              decoration: const BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage(ImageAssets.splashLogo),
                                  )),
                            ),
                          ),

                        ],
                      ),
                    ),
                    const SizedBox(height: 24,),
                    const Image(image: AssetImage(
                        ImageAssets.uploadImageOne
                    )),
                    Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Form(key: formKey,child: Column(
                        children:  [
                          TextFormField(
                            controller: titleController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'please Enter Title';
                              }
                              return null;
                            },style:getMediumStyle(color: ColorManager.white ,fontSize: AppSize.s20),
                            decoration:  InputDecoration(
                                labelText: 'Title',
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
                            obscureText:false,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Container(
                            width: double.infinity,
                            child: Text(
                              "Description",
                              style: getBoldStyle(color: ColorManager.white, fontSize: 24),
                              textAlign: TextAlign.start,
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.all(12),
                            height: 8 * 24.0,

                            child: TextFormField(
                              controller: de,
                              style: getSemiBoldStyle(color: ColorManager.white, fontSize: 24),
                              maxLines: 20,
                              decoration: InputDecoration(
                                hintText: "Type Something....",
                                hintStyle: const TextStyle(
                                    color: Color(0xffA3A3A3)
                                ),
                                fillColor: Colors.grey[300],
                                focusedBorder: const OutlineInputBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(21.0)),
                                    borderSide: BorderSide(color: Colors.white)),
                                enabledBorder: const OutlineInputBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(21.0)),
                                    borderSide: BorderSide(color: Colors.white)),

                              ),

                            ),
                          ),

                          MaterialButton(
                            onPressed: () async{
                              await  cubit.selectFile();
                              if(cubit.fileName !=null){
                                showDialog<String>(
                                    context: context,
                                    builder: (BuildContext context) => AlertDialog(
                                      title: const Text('select File Successful'),
                                      actions: <Widget>[
                                        TextButton(
                                          onPressed: () => Navigator.pop(context, 'Back'),
                                          child: const Text('OK'),
                                        ),
                                      ],
                                    ));
                              }


                            } , child: Container(
                            width: 297,
                            height: 65,
                            decoration: BoxDecoration(
                              color: ColorManager.gery,
                              borderRadius: BorderRadius.circular(36),
                              border: Border.all(
                                  color: ColorManager.white
                              ),


                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const Image(
                                    image: AssetImage(
                                        ImageAssets.adminPageImage2
                                    ),

                                  ),
                                  Text(
                                    "Upload your file" ,
                                    style: getRegularStyle(color: ColorManager.white,fontSize: 24),
                                  )
                                ],
                              ),
                            ),
                          ),),
                          SizedBox(
                            height: 10,
                          ),
                          MaterialButton(onPressed: (){
                            if(cubit.fileName == null){
                              showDialog<String>(
                                  context: context,
                                  builder: (BuildContext context) => AlertDialog(
                                    title: const Text('Please select File'),
                                    actions: <Widget>[
                                      TextButton(
                                        onPressed: () => Navigator.pop(context, 'Back'),
                                        child: const Text('OK'),
                                      ),
                                    ],
                                  ));
                            }
                            if(formKey.currentState!.validate() && cubit.fileName!.isNotEmpty){
                              cubit.getAllUser().then((value) {

                                Navigator.of(context).push(MaterialPageRoute(builder: (context)=> SelectUser(title: titleController.text,
                                  description: de.text,)));
                              });


                            }




                          } , child: Container(
                            width: 137,
                            height: 58,
                            decoration: BoxDecoration(
                              color: ColorManager.gery,
                              borderRadius: BorderRadius.circular(36),
                              border: Border.all(
                                  color: ColorManager.white
                              ),


                            ),
                            child: Center(
                              child: Text(
                                "Next" ,
                                style: getRegularStyle(color: ColorManager.white,fontSize: 24),
                              ),
                            ),
                          ),),
                          // cubit.task != null ?  StreamBuilder<TaskSnapshot>(
                          //   stream: cubit.task?.snapshotEvents,
                          //   builder: (context, snapshot) {
                          //     if (snapshot.hasData) {
                          //       final snap = snapshot.data!;
                          //       final progress = snap.bytesTransferred / snap.totalBytes;
                          //       final percentage = (progress * 100).toStringAsFixed(2);
                          //
                          //       return
                          //         Text(
                          //           '$percentage %',
                          //           style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color: ColorManager.white),
                          //         );
                          //     } else {
                          //       return Container();
                          //     }
                          //   },
                          // )
                          //     : Container(),


                        ],

                      )),
                    )
                  ]
              ),
            ),);
          },
        );



  }
}
