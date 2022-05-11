import 'dart:io';


import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projectapp/domain/Model/message_model.dart';
import 'package:projectapp/domain/bloc/Appstate/Appstate.dart';
import 'package:projectapp/domain/bloc/cubit/cubit.dart';
import 'package:projectapp/presentation/resources/color_manager.dart';
import 'package:intl/intl.dart';
import 'package:date_count_down/date_count_down.dart';
import 'package:auto_size_text/auto_size_text.dart';

import '../../../domain/Model/project_model.dart';
import '../../../domain/shared_preferences/shared_preferences.dart';
import '../../resources/style_manager.dart';
import '../uploadFileUser/UploadeUserFile.dart';
import 'package:path_provider/path_provider.dart';
import 'package:universal_html/html.dart' as html;

class ShowTasks extends StatefulWidget {
  const ShowTasks({Key? key}) : super(key: key);

  @override
  State<ShowTasks> createState() => _ShowTasksState();
}
class _ShowTasksState extends State<ShowTasks> {
  @override
  void showDownloadProgress(received, total) {
    if (total != -1) {
      print((received / total * 100).toStringAsFixed(0) + "%");
    }
  }
  var dio = Dio();

  Future download2(Dio dio, String url, String savePath) async {
    try {
      Response response = await dio.get(
        url,
        onReceiveProgress: showDownloadProgress,
        //Received data with List<int>
        options: Options(
            responseType: ResponseType.bytes,
            followRedirects: false,
            validateStatus: (status) {
              return status! < 500;
            }),
      );
      print(response.headers);
      File file = File(savePath);
      var raf = file.openSync(mode: FileMode.write);
      // response.data is List<int> type
      raf.writeFromSync(response.data);
      await raf.close();
    } catch (e) {
      print(e);
    }
  }
  String convertTimeStampToHumanDate(int timeStamp) {
    var dateToTimeStamp = DateTime.fromMillisecondsSinceEpoch(timeStamp * 1000);
    return DateFormat('dd/MM/yyyy').format(dateToTimeStamp);
  }
  String formatTimestamp(int timestamp) {
    var format = new DateFormat('d MMM, hh:mm a');
    var date = new DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    return format.format(date);
  }
  void downloadFile(String url) {
    html.AnchorElement anchorElement =  html.AnchorElement(href: url);
    anchorElement.download = url;
    anchorElement.click();
  }
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;
    return BlocConsumer<AppCubit,AppStates>(
        listener: (context, state) {
      
    }, builder: (context,states){
      var cubit = AppCubit.get(context);
      return Scaffold(

        appBar: AppBar(
          elevation: 0,
        ),
        backgroundColor:  ColorManager.primary,
        body:(states is GetProjectTaskDone)?Column(
          children: [
            Expanded(
              child: ListView.builder(itemBuilder: (context, index) {
                Timestamp t  = cubit.projectModel[index].dead_line;
                print(t.toDate().year);

                return GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)
                    => UploadUserFile(
                    )
                    ));
                  },

                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: ColorManager.darkGrey,
                        borderRadius: BorderRadius.circular(10),


                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              AutoSizeText("Task Name : " , style: getRegularStyle(
                      color: ColorManager.white,
                          fontSize: 30
                      ),),
                              AutoSizeText(cubit.projectModel[index].title.toString(),style: getRegularStyle(
                                  color: ColorManager.white,
                                  fontSize: 30
                              ),),
                            ],
                          ),
                          Row(
                            children: [
                              AutoSizeText("dead line : " , style: getRegularStyle(
                                  color: ColorManager.white,
                                  fontSize: 30
                              ),),
                              CountDownText(
                                due: t.toDate(),
                                finishedText: "Done",
                                showLabel: true,
                                style: TextStyle(color: Colors.white ,fontSize: 20),
                              )

                            ],
                          ),
                          Row(
                            children: [
                              AutoSizeText("status :  " , style: getRegularStyle(
                                  color: ColorManager.white,
                                  fontSize: 30
                              ),),
                              AutoSizeText(cubit.projectModel[index].status.toString(),style: getRegularStyle(
                                  color: ColorManager.white,
                                  fontSize: 30
                              ),),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AutoSizeText("descriptions  : " , style: getRegularStyle(
                                  color: ColorManager.white,
                                  fontSize: 30
                              ),),
                              AutoSizeText(cubit.projectModel[index].descriptions.toString(),style: getRegularStyle(
                                  color: ColorManager.white,
                                  fontSize: 30
                              ),),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              ElevatedButton(onPressed: (){
                                cubit.selectFile().then((value) {
                                  cubit.uploadFile().then((value) {
                                    FirebaseFirestore.instance
                                        .collection('user')
                                        .doc(CacheHelper.getDataString(key: 'currentUser'))
                                        .collection('project')
                                        .doc(cubit.projectModelID[index]).update({
                                      'status' : "upload",
                                      'file Upload': cubit.urlDownload,
                                    });
                                  });
                                }).then((value) async {

                                });
                              },
                                child:const AutoSizeText(
                                "Upload",
                              ),
                                style: ElevatedButton.styleFrom(
                                  primary:Colors.green
                                ),
                              ),
                              ElevatedButton(onPressed: ()async {

                                downloadFile(cubit.projectModel[index].link.toString());
                              }, child:const AutoSizeText(
                                "Download",
                              ),
                                style: ElevatedButton.styleFrom(
                                    primary:Colors.red
                                ),
                              ),
                            ],
                          )
                  ],
                      ),

                    ),
                  ),
                );
        } ,
      itemCount: cubit.projectModel.length,
      ),
            ),

          ],
        ) :Center(child: CircularProgressIndicator.adaptive())
        
        
      );
    });
  }
}
