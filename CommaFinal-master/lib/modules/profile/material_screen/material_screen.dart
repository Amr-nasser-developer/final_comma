import 'dart:io';
import 'package:comma/modules/cubit/cubit.dart';
import 'package:comma/modules/cubit/states.dart';
import 'package:comma/shared/components/Buttons/component.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';

class MaterialScreen extends StatelessWidget {
  File? file;
  _getfile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      file = File(result.files.single.path.toString());
    }
    //  print(File(result!.files.single.path.toString()));
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return BlocProvider(
      create: (context) => AppCubit()..getMaterialAndCvAndResearch(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {
          if(state is UploadMaterialSuccess){
            Fluttertoast.showToast(
                msg: "The File Uploaded Successfully",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.green,
                textColor: Colors.white,
                fontSize: 16.0
            );
            AppCubit.get(context).getMaterialAndCvAndResearch();
          }
        },
        builder: (context, state) {
          var appCubit = AppCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0.0,
              leading: IconButton(
                icon: Icon(
                  Icons.arrow_back_ios_sharp,
                  color: Colors.black,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              title: defaultText(
                  bold: true, size: 26.0, text: 'Material', color: '#265AE8'),
            ),
            body: Padding(
              padding: EdgeInsets.symmetric(vertical: 25.0, horizontal: 25.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          _getfile();
                        },
                        child: Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                          color: Colors.grey[600],
                          child: Text(
                            'Choose File',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'No File Chosen',
                        style: TextStyle(color: Colors.black),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  if (state is UploadMaterialLoading)
                    CircularProgressIndicator(),
                  if (state is! UploadMaterialLoading)
                    defaultAccessButton(
                        function: () {
                          appCubit.uploadMaterial(file: file);
                        },
                        text: 'Upload New Material'),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: Container(
                        alignment: Alignment.center,
                        width: width * 0.45,
                        child: Text(
                          'File Name',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      )),
                      SizedBox(
                        width: 30,
                      ),
                      Expanded(
                          child: Container(
                        alignment: Alignment.center,
                        width: width * 0.45,
                        child: Text(
                          'Attachment',
                          style: TextStyle(fontSize: 16, color: Colors.black),
                        ),
                      )),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                 if(state is GetMaterialLoading ) CircularProgressIndicator(),
                 if(state is! GetMaterialLoading) Expanded(
                    child: ListView.separated(
                        reverse: false,
                        shrinkWrap: true,
                        physics: BouncingScrollPhysics(),
                        itemBuilder: (context, index) => defaultListMaterial(
                            width: width, material: appCubit.media[index]),
                        separatorBuilder: (context, state) =>
                            SizedBox(height: 10),
                        itemCount: appCubit.media.length),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

Widget defaultListMaterial({width, material}) => (material['collection_name'] == 'user_matrial') ?Container(
      alignment: Alignment.topLeft,
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          color: Color.fromRGBO(0, 0, 0, 0.0784313725490196),
          spreadRadius: 1,
          blurRadius: 2,
          offset: Offset(0, 3), // changes position of shadow
        ),
      ], color: Colors.white, borderRadius: BorderRadius.circular(15.0)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Container(
              alignment: Alignment.center,
              width: width * 0.45,
              child: Text(
                '${material['file_name']}',
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
            ),
          ),
          SizedBox(
            width: 30,
          ),
          Expanded(
            child: InkWell(
              onTap: () async {
                final url = '${material['url']}';
                if (await canLaunch(url)) {
                  await launch(url);
                } else {
                  throw 'Could not launch $url';
                }
              },
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(15.0)),
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                width: width * 0.45,
                child: Text(
                  'DownLoad',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    ) : Container(height: 0.1,);
