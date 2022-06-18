import 'package:comma/modules/cubit/cubit.dart';
import 'package:comma/modules/cubit/states.dart';
import 'package:comma/shared/components/Buttons/component.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';

class AskDoubtScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (context)=> AppCubit()..getAsks(),
    child: BlocConsumer<AppCubit, AppStates>(
      listener: (context, state){},
      builder: (context, state){
        var appCubit = AppCubit.get(context);
        return Scaffold(
          appBar:  AppBar(
            backgroundColor: Colors.white,
            elevation: 0.0,
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios_sharp, color: Colors.black,),
              onPressed: (){
                Navigator.pop(context);
              },
            ),
            title: defaultText(
                bold: true,
                size: 26.0,
                text: 'Ask Doubt',
                color: '#265AE8'
            ),
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(vertical: 25, horizontal: 25),
            child: Expanded(
              child: Column(
                children: [
                  if(state is GetAsksLoading) CircularProgressIndicator(),
                 if(state is! GetAsksLoading) ListView.separated(
                      reverse: false,
                      shrinkWrap: true,
                      physics: BouncingScrollPhysics(),
                      itemBuilder: (context, index)=> defaultAsked(appCubit.asks[index]),
                      separatorBuilder: (context, state)=> SizedBox(height: 10),
                      itemCount: appCubit.asks.length
                  ),
                ],
              ),
            ),
          ),
        );
      },
    ),
    );
  }
}
Widget defaultAsked(ask)=> Container(
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
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        '${ask['title_en']}',
        style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black),
      ),
      SizedBox(height: 10,),
      Text(
        '${ask['answer_en']}',
        style: TextStyle(
            fontSize: 14,
            color: Colors.blue),
      ),
    ],
  ),
);
