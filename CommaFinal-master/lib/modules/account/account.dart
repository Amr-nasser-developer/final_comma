import 'package:comma/modules/cubit/cubit.dart';
import 'package:comma/modules/cubit/states.dart';
import 'package:comma/modules/login/Login_student/login.dart';
import 'package:comma/modules/profile/ask_doubt/ask_doubt.dart';
import 'package:comma/modules/profile/change_pass/change_pass.dart';
import 'package:comma/modules/profile/courses_screen/courses_screen.dart';
import 'package:comma/modules/profile/cv_screen/cv_screen.dart';
import 'package:comma/modules/profile/groups_screen/groups_screen.dart';
import 'package:comma/modules/profile/many/many.dart';
import 'package:comma/modules/profile/material_screen/material_screen.dart';
import 'package:comma/modules/profile/order_screen/order_screen.dart';
import 'package:comma/modules/profile/research_screen/research_screen.dart';
import 'package:comma/shared/components/Buttons/component.dart';
import 'package:comma/shared/local/shared.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return BlocProvider(
      create: (context) => AppCubit()..getStudentProfile(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var role = CashHelper.getData(key: 'role');
          var appCubit = AppCubit.get(context);
          return Scaffold(
            backgroundColor: HexColor('#265AE8'),
            appBar: AppBar(
              elevation: 0.0,
              toolbarHeight: 0.0,
            ),
            body: SingleChildScrollView(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          height: height * 0.35,
                          child: Stack(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: Color(0XFF265AE8),
                                ),
                                width: double.infinity,
                                height: 200,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 40.0, top: 15),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: 70,
                                      height: 70,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: AssetImage(
                                              "assets/images/2.png",
                                            ),
                                            fit: BoxFit.cover),
                                        borderRadius: BorderRadius.circular(15),
                                        color: Color(0XFF265AE8),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 7,
                                    ),
                                    Text(
                                      (appCubit.studentName != null)
                                          ? "${appCubit.studentName}"
                                          : '...',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 20.0),
                                    ),
                                    if(CashHelper.getData(key: 'role') == 'Student') SizedBox(
                                      height: 7,
                                    ),
                                    if(CashHelper.getData(key: 'role') == 'Student')Text("Faculty of Computer Science",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 18)),
                                    SizedBox(
                                      height: 7,
                                    ),
                                    Text(
                                        (appCubit.studentCode != null)
                                            ? "ID:${appCubit.studentCode}"
                                            : '...',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 18)),
                                    SizedBox(height: 20),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          height: height * 0.6,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(25),
                                topLeft: Radius.circular(25)),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: 20,
                              ),
                              if(CashHelper.getData(key: 'role') == 'Student') Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 22),
                                    child: Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                       ContainerProfile(
                                            function: () {
                                              defaultNavigateTo(
                                                  context: context,
                                                  screen: CourseResultScreen());
                                            },
                                            text: "Result",
                                            icon: Icon(Icons.outbox),
                                          ),
                                          SizedBox(height: 10),
                                       ContainerProfile(
                                            function: () {
                                              defaultNavigateTo(
                                                  context: context,
                                                  screen: OrderScreen());
                                            },
                                            text: "Orders",
                                            icon: Icon(Icons.outbox),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      children: [
                                        ContainerProfile(
                                          function: () {
                                            defaultNavigateTo(
                                                context: context,
                                                screen: AskDoubtScreen());
                                          },
                                          text: "Ask doubt",
                                          icon: Icon(Icons.outbox),
                                        ),
                                        SizedBox(height: 10),
                                        ContainerProfile(
                                          function: () {
                                            CashHelper.deleteData(key: 'token');
                                            CashHelper.deleteData(key: 'role');
                                            defaultFinishNavigate(
                                                context: context,
                                                widget: Login_Student());
                                          },
                                          text: 'Logout',
                                          icon: Icon(Icons.logout),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              if(CashHelper.getData(key: 'role') != 'Student')Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding:
                                    EdgeInsets.symmetric(horizontal: 22),
                                    child: Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                        children: [
                                     ContainerProfile(
                                            function: () {
                                              defaultNavigateTo(
                                                  context: context,
                                                  screen: ResearchScreen());
                                            },
                                            text: "Researches",
                                            icon: Icon(Icons.outbox),
                                          ),
                                          SizedBox(height: 10),
                                        ContainerProfile(
                                            function: () {
                                              defaultNavigateTo(
                                                  context: context,
                                                  screen: MaterialScreen());
                                            },
                                            text: "Material",
                                            icon: Icon(Icons.outbox),
                                          ),
                                          SizedBox(height: 10),
                                          ContainerProfile(
                                            function: () {
                                              defaultNavigateTo(
                                                  context: context,
                                                  screen: AskDoubtScreen());
                                            },
                                            text: "Ask doubt",
                                            icon: Icon(Icons.outbox),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      children: [
                                        ContainerProfile(
                                          function: () {
                                            defaultNavigateTo(
                                                context: context,
                                                screen: CvScreen());
                                          },
                                          text: "CV",
                                          icon: Icon(Icons.outbox),
                                        ),
                                        SizedBox(height: 10),
                                       ContainerProfile(
                                          function: () {
                                            defaultNavigateTo(
                                                context: context,
                                                screen: GroupsScreen());
                                          },
                                          text: "Groups",
                                          icon: Icon(Icons.outbox),
                                        ),
                                        SizedBox(height: 10),
                                        ContainerProfile(
                                          function: () {
                                            CashHelper.deleteData(key: 'token');
                                            CashHelper.deleteData(key: 'role');
                                            defaultFinishNavigate(
                                                context: context,
                                                widget: Login_Student());
                                          },
                                          text: 'Logout',
                                          icon: Icon(Icons.logout),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        )
                      ]),
                  if(CashHelper.getData(key: 'role') == 'Student')Padding(
                    padding: EdgeInsets.only(
                      bottom: 200,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        defaultGPA(
                            image: 'assets/images/4.png',
                            t1: '89.50 %',
                            t2: 'Attendance'),
                        SizedBox(
                          width: 40,
                        ),
                        defaultGPA(
                            image: 'assets/images/1.png',
                            t1: (appCubit.gpa != null)
                                ? '${appCubit.gpa}'
                                : '...',
                            t2: 'GPA'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

Widget defaultGPA({image, t1, t2}) => Container(
      width: 120,
      height: 150,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(width: 2, color: Color(0XFF265AE8)),
        color: Colors.white,
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              backgroundImage: AssetImage(image),
              radius: 40,
            ),
          ),
          defaultText(size: 20.0, text: t1, bold: true, color: '#202020'),
          defaultText(size: 16.0, text: t2, bold: false, color: '#777777')
        ],
      ),
    );
