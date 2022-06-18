import 'package:comma/layout/home/qrcode.dart';
import 'package:comma/modules/account/account.dart';
import 'package:comma/modules/chat/chat1.dart';
import 'package:comma/modules/cubit/cubit.dart';
import 'package:comma/modules/cubit/states.dart';
import 'package:comma/modules/home/home.dart';
import 'package:comma/modules/learn/learn.dart';
import 'package:comma/shared/components/Buttons/component.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class HomeScreen extends StatefulWidget {
  var role;
  HomeScreen({this.role});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  Barcode? result;

  QRViewController? controller;

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
      });
    });
  }

  final GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (context)=> AppCubit(),
     child: BlocConsumer<AppCubit, AppStates>(
       listener: (context, state){},
       builder: (context, state){
         return Scaffold(
           extendBody: true,
           // backgroundColor: AppCubit.get(context)
           //     .backgroundColor[AppCubit.get(context).CurrentIndex],
           appBar: AppBar(
             toolbarHeight: 0.0,
             elevation: 0.0,
           ),
           body: (AppCubit.get(context).CurrentIndex == 0) ? Home(role: widget.role,) : AppCubit.get(context).body[AppCubit.get(context).CurrentIndex],
           floatingActionButton: FloatingActionButton(
             onPressed: (){
               defaultNavigateTo(
                 context: context,
                 screen: ScanQrPage()
               );
             },
             backgroundColor: Theme.of(context).primaryColor.withAlpha(255),
             child: Icon(Icons.qr_code_scanner, color: Colors.white,),
           ),
           floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
           bottomNavigationBar:  BottomAppBar(
             shape: CircularNotchedRectangle(),
             notchMargin: 12,
             elevation: 0,
             color: Theme.of(context).primaryColor.withAlpha(255),
             child: BottomNavigationBar(
               unselectedLabelStyle: TextStyle(color: Colors.white, ),
               selectedLabelStyle: TextStyle(color: Colors.white),
               elevation: 0.0,
               backgroundColor: Theme.of(context).primaryColor.withAlpha(0),
               unselectedItemColor: Colors.white,
               selectedItemColor: Colors.white,
               currentIndex: AppCubit.get(context).CurrentIndex,
               onTap: (index) {
                 AppCubit.get(context).ChangeCurrentIndex(index) ;
               },
               items: [
                 BottomNavigationBarItem(
                   icon: (AppCubit.get(context).CurrentIndex == 0)?Icon(Icons.home, color: Colors.white,):
                   Icon(Icons.home_outlined, color: Colors.white,),
                   label: "Home",
                   backgroundColor: Colors.white
                 ),
                 BottomNavigationBarItem(
                     icon: (AppCubit.get(context).CurrentIndex == 1)?Icon(Icons.sms):Icon(Icons.sms_outlined),
                     label: "Chat "
                 ),
                 BottomNavigationBarItem(
                     icon: (AppCubit.get(context).CurrentIndex == 3)? Icon(Icons.computer) : Icon(Icons.computer_outlined)
                     , label: ""),
                 BottomNavigationBarItem(
                     icon: (AppCubit.get(context).CurrentIndex == 3)? Icon(Icons.computer) : Icon(Icons.computer_outlined)
                     , label: (widget.role == 'Student') ? "Learn" : 'Groups'),
                 BottomNavigationBarItem(
                     icon:(AppCubit.get(context).CurrentIndex == 4)? Icon(Icons.account_circle) : Icon(Icons.account_circle_outlined),
                     label: "Profile"),
               ],
             ),
           ),
               );
             },
           ),
    );
  }
}
