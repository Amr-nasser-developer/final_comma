import 'package:comma/modules/chat/chat2.dart';
import 'package:comma/modules/cubit/cubit.dart';
import 'package:comma/modules/cubit/states.dart';
import 'package:comma/shared/components/Buttons/component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
//
// class ModelCourse {
//   final String title1;
//   final String title2;
//   final IconData icon;
//   ModelCourse({
//     required this.title1,
//     required this.title2,
//     required this.icon,
//   });
// }

class CourseResultScreen extends StatelessWidget {
  // List<ModelCourse> ListModelCourse = [
  //   ModelCourse(
  //       title1: "Database",
  //       title2: 'Completed 90 of 135',
  //       icon: Icons.account_balance_outlined),
  //   ModelCourse(
  //       title1: "DataStructure",
  //       title2: 'Completed 90 of 185',
  //       icon: Icons.accessibility),
  //   ModelCourse(
  //       title1: "Security", title2: 'Completed 70 of 105', icon: Icons.outbox),
  //   ModelCourse(
  //       title1: "Expert System",
  //       title2: 'Completed 40 of 235',
  //       icon: Icons.account_circle_outlined),
  //   ModelCourse(
  //       title1: "DataStructure",
  //       title2: 'Completed 90 of 185',
  //       icon: Icons.accessibility),
  //   ModelCourse(
  //       title1: "Security", title2: 'Completed 70 of 105', icon: Icons.outbox),
  //   ModelCourse(
  //       title1: "Expert System",
  //       title2: 'Completed 40 of 235',
  //       icon: Icons.account_circle_outlined),
  // ];
  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (context)=> AppCubit()..getCourses(),
    child: BlocConsumer<AppCubit, AppStates>(
    listener: (context, state){},
      builder: (context, state){
      var appCubit = AppCubit.get(context);
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.0,
          title: defaultText(
              bold: true,
              size: 26.0,
              text: 'Result',
              color: '#265AE8'
          ),
        ),
        body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 15.0),
            child: Column(
              children: [
                if(state is GetCoursesLoading) CircularProgressIndicator(),
                  if(state is! GetCoursesLoading) ListView.separated(
                    shrinkWrap: true,
                    physics: BouncingScrollPhysics(),
                    reverse: false,
                    itemBuilder: (context, index) => ListCourse(appCubit.materialCourses[index], context),
                    separatorBuilder: (context, index) => SizedBox(height: 10),
                    itemCount: appCubit.materialCourses.length
                ),
              ],
            )),
      );
      },
    ),
    );
  }

  Widget ListCourse(user, context) =>(user['grade'] != null) ?Container(
    padding: EdgeInsets.symmetric(vertical: 30.0, horizontal: 15.0),
    width: double.infinity,
    decoration: BoxDecoration(
        color: Color(0XFF265AE8).withOpacity(0.1),
        borderRadius: BorderRadius.circular(25)),
    child:  Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
       // if(user['matrial']['image'] != null) Container(
       //     width: 30,
       //     height: 30,
       //     child: Image.network('${user['matrial']['image']}', height: 30 , width: 30)),
       //  if(user['matrial']['image'] == null) Image.asset('assets/images/learn.png'),
       //    SizedBox(
       //    width: 20,
       //  ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            defaultText(
                color: '#1A1C24',
                size: 15.0,
                maxLines: 1,
                bold: true,
                textAlign: TextAlign.start,
                text: '${user['matrial']['name_en']}'
            ),
            SizedBox(height: 5,),
            defaultText(
                color: '#9DA8C3',
                size: 11.0,
                maxLines: 1,
                bold: true,
                textAlign: TextAlign.start,
                text: '${user['matrial']['units']}'
            )
          ],
        ),
        Spacer(),
        CircleAvatar(
          backgroundColor: Colors.blue,
            child: Text('A', style: TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold),))
      ],
    )
  ): Container(
    height: 1,
    width: double.infinity,
    color: Colors.transparent,
  );

}
