import 'package:comma/modules/cubit/cubit.dart';
import 'package:comma/modules/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:url_launcher/url_launcher.dart';

class Learn_View extends StatefulWidget {
 var id;
 Learn_View({this.id});

  @override
  State<Learn_View> createState() => _Learn_ViewState();
}

class _Learn_ViewState extends State<Learn_View> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (context)=> AppCubit()..getFileDownLoad(id: widget.id),
    child: BlocConsumer<AppCubit, AppStates>(
      listener: (context, state){},
      builder: (context, state){
        return Scaffold(
            appBar: AppBar(
              title: Text('Files', style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold)),
              leading: IconButton(
                onPressed: (){
                  Navigator.pop(context);
                },
                icon: Icon(Icons.arrow_back_ios_sharp, color: Colors.black,),
              ),
            ),
            body: Padding(
              padding: EdgeInsets.symmetric(horizontal: 25, vertical: 25),
              child: ListView.separated(
                  itemBuilder: (context, index)=> defaultLearnView(
                    file: AppCubit.get(context).attachment[index]
                  ),
                  separatorBuilder: (context, index)=> SizedBox(height: 10),
                  itemCount: AppCubit.get(context).attachment.length
              ),
            )
        );
      },
    ),
    );
  }
  _launchUrl({String? urlMedia}) async {
    final url =  urlMedia!;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}

Widget defaultLearnView({file}) => InkWell(
  onTap: (){
  //  defaultNavigateTo(context: context, screen: DoctorInformationScreen(doctorName: 'Dr.${doc['username']}', doctorId: '${doc['user']}',doctorImage: '${doc['image']}',));
  },
  child: Container(
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
      children: [
        Container(
            decoration: BoxDecoration(boxShadow: [
              BoxShadow(
                  color: Color.fromRGBO(0, 0, 0, 0.0784313725490196),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 3))
            ]),
            child: Icon(Icons.file_copy)
        ),
        SizedBox(
          width: 20,
        ),
        Expanded(
          child: Text(
            '${file['title']}',
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: HexColor('#262c3d')),
          ),
        ),
        IconButton(
          icon: Icon(Icons.download_sharp, color: Colors.black,),
          onPressed: ()async{
            final url =  file['attachment']!;
            if (await canLaunch(url)) {
              await launch(url);
            } else {
              throw 'Could not launch $url';
            }
          },
        )
      ],
    ),
  ),
);
