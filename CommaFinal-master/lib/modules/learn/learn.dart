import 'package:comma/modules/chat/chat2.dart';
import 'package:comma/modules/cubit/cubit.dart';
import 'package:comma/modules/cubit/states.dart';
import 'package:comma/shared/components/Buttons/component.dart';
import 'package:comma/shared/local/shared.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'learn_view.dart';

class ModelCourse {
  final String title1;
  final String title2;
  final IconData icon;
  ModelCourse({
    required this.title1,
    required this.title2,
    required this.icon,
  });
}

class Learn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubit()..getCourses(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var homeCourse = AppCubit.get(context);
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0.0,
              title: defaultText(
                  bold: true, size: 26.0, text: 'Learn', color: '#265AE8'),
            ),
            body: Padding(
                padding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 15.0),
                child: ListView.separated(
                    shrinkWrap: true,
                    physics: BouncingScrollPhysics(),
                    reverse: false,
                    itemBuilder: (context, index) =>
                        ListCourse(homeCourse.materialCourses[index], context),
                    separatorBuilder: (context, index) => SizedBox(height: 10),
                    itemCount: homeCourse.materialCourses.length)),
          );
        },
      ),
    );
  }

  Widget ListCourse(user, context) => (user['grade'] == null)
      ? InkWell(
          onTap: () {
            print(CashHelper.getData(key: 'token'));
            defaultNavigateTo(
                context: context,
                screen: Learn_View(
                  id: user['group_id'],
                ));
          },
          child: Container(
              padding: EdgeInsets.symmetric(vertical: 30.0, horizontal: 15.0),
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Color(0XFF265AE8).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(25)),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 20,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      defaultText(
                          color: '#1A1C24',
                          size: 15.0,
                          maxLines: 1,
                          bold: true,
                          textAlign: TextAlign.start,
                          text: 'Subject: ${user['matrial']['name_en']}'),
                      SizedBox(
                        height: 5,
                      ),
                      defaultText(
                          color: '#9DA8C3',
                          size: 11.0,
                          maxLines: 1,
                          bold: true,
                          textAlign: TextAlign.start,
                          text: 'Total Units: ${user['matrial']['units']}')
                    ],
                  ),
                  Spacer(),
                  CircleAvatar(
                    backgroundColor: Colors.blue,
                    child: Icon(Icons.pending),
                  ),
                ],
              )))
      : Container(
          height: 1,
          width: double.infinity,
          color: Colors.transparent,
        );
}
