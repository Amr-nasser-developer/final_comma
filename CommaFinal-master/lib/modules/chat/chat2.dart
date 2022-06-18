import 'dart:async';

import 'package:comma/modules/cubit/cubit.dart';
import 'package:comma/modules/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';




class ChatViewScreen extends StatefulWidget {
  var id;
  var fromId;
  var image;
  var name;
  ChatViewScreen({this.id,this.fromId, this.name, this.image});

  @override
  State<ChatViewScreen> createState() => _ChatViewScreenState();
}

class _ChatViewScreenState extends State<ChatViewScreen> {

  var messageController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
      AppCubit()..getMessages(groub_id: widget.id),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {
          if (state is SendMessageSuccess) {
            messageController.clear();
            AppCubit.get(context).getMessages(groub_id: widget.id);
          }
        },
        builder: (context, state) {
          Stream<dynamic> generateNumbers = (() async* {
            await Future<void>.delayed(Duration(seconds: 2));

            for (int i = 1; i <= 10; i++) {
              await Future<void>.delayed(Duration(seconds: 20));
              yield AppCubit.get(context).getMessages(groub_id: widget.id);
            }
          })();
          return Scaffold(
              appBar: AppBar(
                title: Row(
                  children: [
                    if (widget.image != null)
                      CircleAvatar(
                        radius: 25,
                        backgroundImage: NetworkImage("${widget.image}"),
                      ),
                    if (widget.image == null)
                      CircleAvatar(
                        radius: 25,
                        backgroundImage: AssetImage("assets/images/user.jpeg"),
                      ),
                    SizedBox(
                      width: 15,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${widget.name}",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              "Active Now",
                              style: TextStyle(
                                  color: Color(0XFFA8BDF6), fontSize: 14),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            CircleAvatar(
                              radius: 5,
                              backgroundColor: Colors.green,
                            )
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ),
              body: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                child: Column(
                  children: [
                    StreamBuilder<dynamic>(
                      stream: generateNumbers,
                      initialData: '1',
                      builder: (
                          BuildContext context,
                          AsyncSnapshot<dynamic> snapshot,
                          ) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return  Expanded(
                            child: ListView.separated(
                              itemBuilder: (context, index) => defaultTextMessage(
                                  fromId: widget.fromId,
                                  message: AppCubit.get(context)
                                      .allMessages[index]),
                              separatorBuilder: (context, index) =>
                                  SizedBox(height: 10),
                              itemCount: AppCubit.get(context)
                                  .allMessages
                                  .length,
                              shrinkWrap: true,
                              reverse: false,
                            ),
                          );
                        } else if (snapshot.connectionState ==
                            ConnectionState.active ||
                            snapshot.connectionState == ConnectionState.done) {
                          if (snapshot.hasError) {
                            return const Text('Error');
                          } else if (snapshot.hasData) {
                            return Text(snapshot.data.toString(),
                                style: const TextStyle(
                                    color: Colors.red, fontSize: 40));
                          } else {
                            return const Text('Empty data');
                          }
                        } else {
                          return Text('State: ${snapshot.connectionState}');
                        }
                      },
                    ),
                    SizedBox(height: 5,),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: Colors.white,
                          border: Border.all(color: HexColor('#b0b3c7'))),
                      child: Row(
                        children: [
                          Expanded(
                            child: Form(
                              key: formKey,
                              child: TextFormField(
                                autofocus: false,
                                controller: messageController,
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Enter your Message',
                                  hintStyle:
                                  TextStyle(color: HexColor('#b0b3c7')),
                                ),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              if (formKey.currentState!.validate()) {
                                AppCubit.get(context).sendMessages(
                                    message: messageController.text,
                                  id: widget.id.toString()
                                );
                              }
                            },
                            child: CircleAvatar(
                              backgroundColor: HexColor('#23b2ff'),
                              child: Icon(
                                Icons.send,
                                color: Colors.white,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ));
        },
      ),
    );
  }
}

Widget defaultTextMessage({message, fromId}) => Column(
  crossAxisAlignment: CrossAxisAlignment.end,
  children: [
    Padding(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Text(
        (message['sender']['name_en'] != null) ? '${message['sender']['name_en']}' : '${message['sender']['name_ar']}',
        style: TextStyle(
            fontSize: 16, fontWeight: FontWeight.bold, color: Colors.grey),
      ),
    ),
    Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25),
                  bottomLeft: Radius.circular(25),
                  topRight: Radius.circular(25))),
          padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '${message['message']}',
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
      ],
    ),
  ],
);
