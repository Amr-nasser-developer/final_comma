import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class NewsDetailsScreen extends StatefulWidget {
  var title;
  var image;
  var body;
  var date;
  NewsDetailsScreen({this.title, this.image, this.body, this.date});

  @override
  State<NewsDetailsScreen> createState() => _NewsDetailsScreenState();
}

class _NewsDetailsScreenState extends State<NewsDetailsScreen> {
  bool maxText = false;
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              Container(
                height: height * 0.4,
                child:  ClipRRect(
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(80.0),
                      bottomLeft: Radius.circular(80.0)),
                  child: (widget.image != 'assets/images/home.png') ? Image.network('${widget.image}', fit: BoxFit.fill):Image.asset('${widget.image}', fit: BoxFit.fill),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 50.0, horizontal: 15.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                            height: 40,
                            width: 45,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15.0)),
                            child: IconButton(
                                icon: Icon(
                                  Icons.arrow_back_ios_sharp,
                                  size: 16,
                                  color: HexColor('#23b2ff'),
                                ),
                                onPressed: (){Navigator.pop(context);}
                            )),
                        Spacer(),
                        Text(
                          'News',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold),
                        ),
                        Spacer(),
                        Container(
                            height: 40,
                            width: 45,
                            color: Colors.transparent,
                            child: IconButton(
                              icon: Icon(
                                Icons.share,
                                color: Colors.transparent,
                              ),
                              onPressed: (){},
                            ))
                      ],
                    ),
                    SizedBox(height: height * 0.23,),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
                      decoration: BoxDecoration(boxShadow: [
                        BoxShadow(
                          color: Color.fromRGBO(0, 0, 0, 0.0784313725490196),
                          spreadRadius: 1,
                          blurRadius: 2,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ], color: Colors.white, borderRadius: BorderRadius.circular(15.0)),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${widget.title}',
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(color: HexColor('#262c3d'), fontSize: 20.0, fontWeight: FontWeight.bold) ,
                                ),
                                SizedBox(height: 30,),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.calendar_today_sharp,
                                      color: HexColor('#23b2ff'),
                                      size: 14,
                                    ),
                                    Text('${widget.date}',
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                            color: HexColor('#b0b3c7'))),
                                  ],
                                ),
                                SizedBox(height: 15,),
                                Padding(
                                  padding:  EdgeInsets.symmetric(horizontal: 10),
                                  child: Text(
                                    '${widget.body}',
                                    maxLines: (maxText == false) ? 7 : 100,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(color: HexColor('#747f9e'), fontSize: 14.0, fontWeight: FontWeight.bold) ,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          if(maxText == false)TextButton(onPressed: (){
                            setState(() {
                              maxText = !maxText;
                            });
                          }, child: Text(
                            'more',
                            style: TextStyle(color: HexColor('#23b2ff'), fontSize: 14),
                          ))
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        )
    );
  }
}
