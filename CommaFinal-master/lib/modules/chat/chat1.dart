import 'package:comma/modules/chat/chat2.dart';
import 'package:comma/modules/cubit/cubit.dart';
import 'package:comma/modules/cubit/states.dart';
import 'package:comma/shared/components/Buttons/component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ModelChat {
  final String title1;
  final String title2;
  final IconData icon;
  ModelChat({
    required this.title1,
    required this.title2,
    required this.icon,
  });
}

class ChatScreen extends StatelessWidget {
  List<ModelChat> ListModelChat = [
    ModelChat(
        title1: "Database",
        title2: 'Completed 90 of 135',
        icon: Icons.account_balance_outlined),
    ModelChat(
        title1: "DataStructure",
        title2: 'Completed 90 of 185',
        icon: Icons.accessibility),
    ModelChat(
        title1: "Security", title2: 'Completed 70 of 105', icon: Icons.outbox),
    ModelChat(
        title1: "Expert System",
        title2: 'Completed 40 of 235',
        icon: Icons.account_circle_outlined),
    ModelChat(
        title1: "DataStructure",
        title2: 'Completed 90 of 185',
        icon: Icons.accessibility),
    ModelChat(
        title1: "Security", title2: 'Completed 70 of 105', icon: Icons.outbox),
    ModelChat(
        title1: "Expert System",
        title2: 'Completed 40 of 235',
        icon: Icons.account_circle_outlined),
  ];
  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (context)=> AppCubit()..getChats(),
    child: BlocConsumer<AppCubit, AppStates>(
      listener: (context, state){},
      builder: (context, state){
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0.0,
            title: defaultText(
                bold: true,
                size: 26.0,
                text: 'Group Chats',
                color: '#265AE8'
            ),
          ),
          body: Padding(
              padding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 15.0),
              child: ListView.separated(
                  shrinkWrap: true,
                  physics: BouncingScrollPhysics(),
                  reverse: false,
                  itemBuilder: (context, index) => ListChat(AppCubit.get(context).chats[index], context),
                  separatorBuilder: (context, index) => SizedBox(height: 10),
                  itemCount: AppCubit.get(context).chats.length
              )),
        );
      },
    ),
    );
  }

  Widget ListChat(courses, context) => InkWell(
    onTap: (){
      defaultNavigateTo(
          context: context,
          screen: ChatViewScreen(
            name: (courses['matrial']['name_en'] != null) ? '${courses['matrial']['name_en']}' : '${courses['matrial']['name_ar']}',
            id: '${courses['id']}'.toString(),
            image: null,
            fromId: null,
          )
      );
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
          Icon(Icons.account_balance_outlined, size: 40),
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
                  text:  (courses['matrial']['name_en'] != null) ? '${courses['matrial']['name_en']}' : '${courses['matrial']['name_ar']}'
              ),
              SizedBox(height: 5,),
              defaultText(
                  color: '#9DA8C3',
                  size: 11.0,
                  maxLines: 1,
                  bold: true,
                  textAlign: TextAlign.start,
                  text: (courses['matrial']['units'] != null) ? '${courses['matrial']['units']}' : '0'
              )
            ],
          ),
          Spacer(),
          Icon(Icons.chat)
        ],
      ),
    ),
  );
}
