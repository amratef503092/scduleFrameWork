import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projectapp/domain/bloc/cubit/cubit.dart';
import '../../domain/bloc/Appstate/Appstate.dart';
import '../../domain/shared_preferences/shared_preferences.dart';
import '../resources/assets_manager.dart';
import '../resources/color_manager.dart';
import '../resources/style_manager.dart';
import '../resources/value_manager.dart';
import '../uploadTask/uploadTask.dart';

class SelectUser extends StatefulWidget {
   final String ?  description;
   final String ? title;

   SelectUser({this.description, this.title});

  @override
  _SelectUserState createState() => _SelectUserState();
}

class _SelectUserState extends State<SelectUser> {
  List<ContactModel> contacts = [];

  List<ContactModel> selectedContacts = [];

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = AppCubit.get(context);
          if (contacts.isEmpty) {
            for (int i = 0; i < cubit.listUser.length; i++) {
              if (cubit.listUser[i].username != 'admin') {
                contacts.add(
                  ContactModel(
                      cubit.listUser[i].username, false),
                );
              }
            }
          }

          return Scaffold(
            body: SafeArea(
              child: Container(
                width: double.infinity,
                child: Column(

                  children: [


                    Container(
                      color: const Color(0xff39424C),
                      child: Column(
                        children: [
                          Container(
                              width: double.infinity,
                              color: ColorManager.primary,
                              child: Column(
                                children: [
                                  Align(
                                    alignment: Alignment.topLeft,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: CircleAvatar(
                                        backgroundColor: ColorManager.gery,
                                        radius: 20.0,
                                        child: IconButton(

                                            icon: const Icon(
                                                Icons.arrow_back_ios
                                            ),
                                          color: ColorManager.white, onPressed: () {
                                              Navigator.push(context, MaterialPageRoute(builder: (context)=> UploadTaskScreenOne()));
                                        },
                                        ),
                                      ),
                                    ),
                                  ),
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
                               'admin',
                                    style: getMediumStyle(
                                        color: ColorManager.white,
                                        fontSize: AppSize.s18),
                                  )
                                ],
                              )),
                        ],
                      ),
                    ),
                    Expanded(
                      child: ListView.separated(
                          itemCount: contacts.length,
                          itemBuilder: (BuildContext context, int index) {
                            // return item
                            return ContactItem(
                              contacts[index].name,
                              contacts[index].isSelected,
                              index,

                            );


                          },separatorBuilder: (context , index){
                            return const SizedBox(
                              height: 20,
                              child: Divider(
                                height: 20,
                              ),
                            );
                      }),
                    ),
                    selectedContacts.isNotEmpty
                        ? Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 25,
                              vertical: 10,
                            ),
                            child: SizedBox(
                              width: double.infinity,
                              child: RaisedButton(
                                color: ColorManager.primary,
                                child: Text(
                                  "Send Task (${selectedContacts.length})",
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                  ),
                                ),
                                onPressed: () {
                                  showDatePicker(
                                    context: context,
                                    firstDate: DateTime.now(),
                                    initialDate: DateTime.now(),
                                    lastDate: DateTime(
                                      2030
                                    ),
                                  ).then((value) {

                                    cubit.uploadFile().whenComplete(() =>  selectedContacts.forEach((element) {
                                      FirebaseFirestore.instance
                                          .collection('user')
                                          .doc(element.name)
                                          .collection('project')
                                          .add({
                                        'title': widget.title,
                                        'descriptions':widget.description,
                                        'time upload': DateTime.now(),
                                        'dead line' : value,
                                        'file': '${cubit.urlDownload}',
                                        'status':'not'
                                      });
                                    }));
                                  }).then((value) {
                                    showDialog<String>(
                                        context: context,
                                        builder: (BuildContext context) => AlertDialog(
                                          title: const Text('Upload Successful File'),
                                          actions: <Widget>[

                                            TextButton(
                                              onPressed: () => Navigator.pop(context, 'Back'),
                                              child: const Text('OK'),
                                            ),
                                          ],
                                        ));
                                  });


                                },
                              ),
                            ),
                          )
                        : Container(),
                  ],
                ),
              ),
            ),
          );
        });
  }

  Widget ContactItem(
      String name, bool isSelected, int index) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        width: double.infinity,
        height: 60,
        child: ListTile(
          leading: const CircleAvatar(
            backgroundColor: Colors.black,
            radius: 35.0,
            child: CircleAvatar(

              radius: 25,
              backgroundColor: ColorManager.primary,
              backgroundImage: AssetImage(
                ImageAssets.chatImage1
              )

            ),
          ),
          title: Text(
            name,
            style: TextStyle(
              fontSize: 25,
              color: ColorManager.primary,
              fontWeight: FontWeight.bold,
            ),
          ),

          trailing: isSelected
              ? Icon(
                  Icons.check_circle,
                  color: Colors.green[700],
                )
              : Icon(
                  Icons.check_circle_outline,
                  color: Colors.grey,
                ),
          onTap: () {
            setState(() {
              contacts[index].isSelected = !contacts[index].isSelected;
              if (contacts[index].isSelected == true) {
                selectedContacts.add(ContactModel(name,  true));
              } else if (contacts[index].isSelected == false) {
                selectedContacts
                    .removeWhere((element) => element.name == contacts[index].name);
              }
            });
          },
        ),
      ),
    );
  }
}

class ContactModel {
  String name;
  bool isSelected;

  ContactModel(this.name,  this.isSelected);
}
