import 'package:comma/modules/cubit/cubit.dart';
import 'package:comma/modules/cubit/states.dart';
import 'package:comma/shared/components/Buttons/component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AssignScreen extends StatelessWidget {
  var groupId;
  AssignScreen({this.groupId});
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return BlocProvider(
      create: (context) => AppCubit()..getMaterialAndCvAndResearch(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {
          if(state is AddGroupsSuccess){
            Fluttertoast.showToast(
                msg: "Removed Successfully",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.green,
                textColor: Colors.white,
                fontSize: 16.0
            );
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
                  bold: true, size: 26.0, text: 'Add', color: '#265AE8'),
            ),
            body: Padding(
              padding: EdgeInsets.symmetric(vertical: 25.0, horizontal: 25.0),
              child: Column(
                children: [
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
                    height: 20,
                  ),
                  Expanded(
                    child: ListView.separated(
                        reverse: false,
                        shrinkWrap: true,
                        physics: BouncingScrollPhysics(),
                        itemBuilder: (context, index) => defaultAdd(
                            context: context,
                            width: width,
                            groubId: groupId.toString(),
                            media: appCubit.media[index],
                          state: state
                        ),
                        separatorBuilder: (context, state) =>
                            SizedBox(height: 10),
                        itemCount: 5),
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

Widget defaultAdd({media, width, context, groubId, state}) => (media['collection_name'] ==
        'user_matrial')
    ? Container(
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                alignment: Alignment.center,
                width: width * 0.45,
                child: Text(
                  '${media['file_name']}',
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
            if(state is AddGroupsLoading)Expanded(child: CircularProgressIndicator()),
              if(state is! AddGroupsLoading) Expanded(
              child: InkWell(
                onTap: () {
                  AppCubit.get(context).addGroups(media_id: '${media['id']}', group_id: groubId);
                },
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(15.0)),
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  width: width * 0.45,
                  child: Text(
                    'Add',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      )
    : Container(
        height: 0.1,
      );
