import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:projectapp/presentation/resources/color_manager.dart';
import 'package:d_chart/d_chart.dart';
import 'package:universal_html/html.dart' as html;

import 'ProfileUser.dart';
import 'ProfileUser.dart';
import 'domain/bloc/cubit/cubit.dart';

class ProfileUser extends StatefulWidget {
  final String userId;
    ProfileUser({
    required this.userId
});

  @override
  State<ProfileUser> createState() => _ProfileUserState();
}
int count =0 ;
int count2 =0 ;

void downloadFile(String url) {
  html.AnchorElement anchorElement =  new html.AnchorElement(href: url);
  anchorElement.download = url;
  anchorElement.click();
}
List <String> upload = [];
List <String> notUpload = [];

class _ProfileUserState extends State<ProfileUser> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.primary,
      body: Column(
        children: [

          FutureBuilder<QuerySnapshot>( future:FirebaseFirestore.instance.collection('user').doc(widget.userId).collection('project').get()
              ,builder: (context, snapshot) {
                if(snapshot.hasData){

                  return Expanded(
                    child: Container(

                      child: Column(
                        children: [
                          ListView.builder(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              if(snapshot.data!.docs[index]['status']== 'upload'){
                                count++;
                                print(count);
                              }else{
                                count2++;
                                print(count2);
                              }
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [

                                    Container(
                                      decoration: BoxDecoration(
                                        color: ColorManager.gery
                                      ),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                        children: [

                                      Column(
                                        children: [
                                          Text(snapshot.data!.docs[index]['title']),

                                        ],
                                      ),
                                          (snapshot.data!.docs[index]['status']=='upload')?ElevatedButton(onPressed: ()async {

                                            downloadFile(snapshot.data!.docs[index]['file Upload']);
                                          }, child:const AutoSizeText(
                                            "Download",
                                          ),
                                            style: ElevatedButton.styleFrom(
                                                primary:Colors.red
                                            ),
                                          ) : ElevatedButton(onPressed: ()async {
                                          }, child:const AutoSizeText(
                                            "Not upload File",
                                          ),
                                            style: ElevatedButton.styleFrom(
                                                primary:Colors.red
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                            itemCount: snapshot.data!.docs.length,

                          ),

                        SizedBox(width:500,
                          height: 400,
                          child: Padding(
                              padding: EdgeInsets.all(16),
                              child: AspectRatio(
                                aspectRatio: 16 / 9,
                                child: DChartBar(
                                  data: [
                                    {
                                      'id': 'Bar',
                                      'data': [
                                        {'domain': 'Finished Task', 'measure': AppCubit.get(context).count1},
                                        {'domain': 'Not Finished Task', 'measure': AppCubit.get(context).count2},

                                      ],
                                    },
                                  ],
                                  domainLabelPaddingToAxisLine: 16,
                                  axisLinePointTick: 1,
                                  axisLinePointWidth: 10,
                                  axisLineColor: Colors.white,
                                  xAxisTitleColor: Colors.white,
                                  barValueColor: Colors.white,
                                  domainLabelColor: ColorManager.white,
                                  borderColor: Colors.white,
                                  measureLabelColor: ColorManager.white,
                                  measureLabelPaddingToAxisLine: 16,
                                  barColor: (barData, index, id) => Colors.white,
                                  showBarValue: true,
                                ),
                              ),
                            ),
                        ) ,
                        ],
                      ),
                    ),
                  );
                }else if(snapshot.hasError){
                  return Text("Error") ;
                }else {
                  return Center(child: CircularProgressIndicator());
                }
              }
          ),
        ],
      ),
    );
  }
}
