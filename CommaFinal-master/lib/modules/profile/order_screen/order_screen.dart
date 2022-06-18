import 'package:comma/modules/cubit/cubit.dart';
import 'package:comma/modules/cubit/states.dart';
import 'package:comma/shared/components/Buttons/component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';

class OrderScreen extends StatefulWidget {
  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  String? selectRequest;
  var copyController = TextEditingController();
  var noteController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return BlocProvider(create: (context)=> AppCubit()..getRequestOrder()..getOrder(),
    child: BlocConsumer<AppCubit, AppStates>(
      listener: (context, state){
        if(state is MakeOrderSuccess){
          Fluttertoast.showToast(
              msg: "Make Order Successfully",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 16.0
          );
          AppCubit.get(context).getOrder();
        }
      },
      builder: (context, state){
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
                text: 'Orders',
                color: '#265AE8'
            ),
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      border: Border.all(
                        color: HexColor('#b0b3c7'),
                      )
                  ),
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 2),
                    child: DropdownButton<String>(
                      underline: Divider(
                        color: Colors.white,
                      ),
                      isExpanded: true,
                      value: selectRequest,
                      hint: Text('Request', style: TextStyle(color: HexColor('#b0b3c7')),),
                      items: AppCubit.get(context).requestOrder.map((value) {
                        return DropdownMenuItem<String>(
                          value: value['id'].toString(),
                          child: Text(value['name_en']),
                        );
                      }).toList(),
                      onChanged: (value){
                        setState(() {
                          selectRequest = value;
                          print(selectRequest);
                        });
                      },
                    ),
                  ),
                ),
                SizedBox(height: 15,),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      border: Border.all(
                        color: HexColor('#b0b3c7'),
                      )
                  ),
                  width: double.infinity,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15.0 ),
                    child: TextFormField(
                      controller: copyController,
                      decoration: InputDecoration(
                        hintText: 'Copy',
                        border: InputBorder.none,
                        labelStyle: TextStyle(color: Colors.black38),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 15,),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      border: Border.all(
                        color: HexColor('#b0b3c7'),
                      )
                  ),
                  width: double.infinity,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15.0 ),
                    child: TextFormField(
                      controller: noteController,
                      decoration: InputDecoration(
                        hintText: 'Note',
                        border: InputBorder.none,
                        labelStyle: TextStyle(color: Colors.black38),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20,),
              if(state is MakeOrderLoading) CircularProgressIndicator(),
              if(state is! MakeOrderLoading) defaultAccessButton(text: 'Make Request',
                    function: (){
                  AppCubit.get(context).makeOrder(
                    id: selectRequest.toString(),
                    notes: noteController.text,
                    paperQty: copyController.text
                  );
                  noteController..clear();
                  copyController.clear();
                    }
                ),
                SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                        child: Container(
                          alignment: Alignment.center,
                          width:  width *0.45,
                          child:  Text(
                            'Request',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                        )
                    ),
                    Expanded(
                        child: Container(
                          alignment: Alignment.center,
                          width:  width *0.2,
                          child:  Text(
                            'Copy',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                        )
                    ),
                    Expanded(
                        child: Container(
                          alignment: Alignment.center,
                          width:  width *0.2,
                          child: Text(
                            'Status',
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.black),
                          ),
                        )
                    ),
                  ],
                ),
                SizedBox(height: 10,),
               if(state is GetOrderLoading)CircularProgressIndicator(),
               if(state is! GetOrderLoading) Expanded(
                  child: ListView.separated(
                      reverse: false,
                      shrinkWrap: true,
                      physics: BouncingScrollPhysics(),
                      itemBuilder: (context, index)=>defaultOrder(width: width, order: AppCubit.get(context).order[index]),
                      separatorBuilder: (context, state)=> SizedBox(height: 10),
                      itemCount: AppCubit.get(context).order.length
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
Widget defaultOrder({width, order})=> Container(
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
            '${order['request']['name_en']}',
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.black),
          ),
        ),
      ),
      Expanded(
        child: Container(
          alignment: Alignment.center,
          width: width * 0.2,
          child: Text(
            '${order['paper_count']}',
            style: TextStyle(
                fontSize: 14,
                color: Colors.blue),
          ),
        ),
      ),
      Expanded(
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(15.0)
          ),
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          width: width * 0.2,
          child: Text(
            (order['status'] == '1')?'Pending' : 'In prograss',
            style: TextStyle(
                fontSize: 14,
                color: Colors.white),
          ),
        ),
      ),
    ],
  ),
);
