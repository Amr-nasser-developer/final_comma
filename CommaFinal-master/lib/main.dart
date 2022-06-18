import 'package:comma/modules/cubit/cubit.dart';
import 'package:comma/modules/cubit/states.dart';
import 'package:comma/modules/login/Login_student/login.dart';
import 'package:comma/modules/on_Boarding/onBoarding.dart';
import 'package:comma/modules/spalsh_screen/splash_screen.dart';
import 'package:comma/shared/local/shared.dart';
import 'package:comma/shared/remote/dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'layout/home/home.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  late String? token = CashHelper.getData(key: 'token');
  late String? role = CashHelper.getData(key: 'role');
  await CashHelper.init();
  runApp(MyApp(token, role));
}

class MyApp extends StatelessWidget {
  String? token;
  String? role;
  MyApp(this.token, this.role);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        drawerTheme: DrawerThemeData(backgroundColor: Colors.white),
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: AppBarTheme(
          systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: Colors.white,
              statusBarIconBrightness: Brightness.dark),
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(
            color: Colors.blueAccent,
          ),
          titleTextStyle: TextStyle(
            color: Colors.blueAccent,
          ),
          elevation: 0,
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.blueAccent,
          backgroundColor: Colors.white,
          elevation: 5,
          unselectedItemColor: Colors.black,
        ),
        textTheme: TextTheme(
          bodyText2: TextStyle(
            fontFamily: "Mulish",
            fontWeight: FontWeight.w600,
            color: Colors.black,
            fontSize: 18,
          ),
        ),
      ),
      darkTheme: ThemeData(
        drawerTheme: DrawerThemeData(backgroundColor: Color(0XFF0a1929)),
        appBarTheme: AppBarTheme(
          systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: Color(0XFF0a1929),
              statusBarIconBrightness: Brightness.light),
          backgroundColor: Color(0XFF0a1929),
          iconTheme: IconThemeData(color: Colors.blueAccent),
          titleTextStyle: TextStyle(
            color: Colors.blueAccent,
          ),
          elevation: 0,
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.blueAccent,
          backgroundColor: Color(0XFF0a1929),
          unselectedItemColor: Colors.white,
          elevation: 0,
        ),
        scaffoldBackgroundColor: Color(0XFF0a1929),
        textTheme: TextTheme(
          bodyText2: TextStyle(
            color: Colors.white,
            fontSize: 18,
          ),
        ),
      ),
      themeMode: ThemeMode.light,
      debugShowCheckedModeBanner: false,
      home: (token == null) ? Login_Student() :  HomeScreen(role: role,) ,
    );
  }
}
