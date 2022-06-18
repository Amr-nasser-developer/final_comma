import 'package:carousel_slider/carousel_slider.dart';
import 'package:comma/modules/cubit/cubit.dart';
import 'package:comma/modules/cubit/states.dart';
import 'package:comma/modules/news/news_details.dart';
import 'package:comma/shared/components/Buttons/component.dart';
import 'package:comma/shared/local/shared.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';

class Home extends StatefulWidget {
  var role ;
  Home({this.role});
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin{

  late TabController tabController;
  var searchController = TextEditingController();
  bool title = false;
  bool search = false;
  int tapIndex =0;
  int id =  0;
  void initState() {
    tabController = TabController(length: 4, vsync: this, initialIndex: 0);
    super.initState();
  }
  List<dynamic> homeList = [
    {
      'image' : 'assets/images/News.png',
    },
    {
      'image' : 'assets/images/News.png',
    },
    {
      'image' : 'assets/images/News.png',
    },
  ];
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
        return BlocProvider(create: (context)=> AppCubit()..getPosts(category: 2, subCategory: 0, q: 'test')..postLogin(
          password: CashHelper.getData(key: 'password'),
          user_code: CashHelper.getData(key: 'email'),
        ),
        child: BlocConsumer<AppCubit, AppStates>(
          listener: (context, state){},
          builder: (context, state){
            return DefaultTabController(
              length: 5,
              initialIndex: tabController.index,
              child: Scaffold(
                appBar: AppBar(
                  title: Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: InkWell(
                      onTap: (){
                        setState(() {
                          title = !title;
                          if(title == false){
                            id = 2;
                          }else{
                            id = 3;
                          }
                          print(id);
                          AppCubit.get(context).getPosts(category: id,subCategory: (tapIndex != null) ? tapIndex : 0 );
                        });

                      },
                      child: Container(
                          alignment: Alignment.center,
                          height: 40,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.0),
                              border: Border.all(
                                color: HexColor('#265AE8'),
                              )
                          ),
                          width: double.infinity,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text((title == false) ? 'News' : 'Event', style: TextStyle(color: HexColor('#265AE8'), fontSize: 18),),
                              SizedBox(width: 30,),
                              Icon(Icons.swap_horiz_sharp)
                            ],
                          )
                      ),
                    ),
                  ),
                  actions:  [
                    Padding(
                        padding: const EdgeInsets.only(top: 10, right: 10),
                        child: Container(
                            height: 40,
                            width: 45,
                            decoration: BoxDecoration(
                                color: Colors.lightBlue,
                                borderRadius: BorderRadius.circular(15.0)),
                            child: IconButton(
                              icon: Icon(
                                Icons.search,
                                color: HexColor('#265AE8'),
                              ),
                              onPressed: (){
                                setState(() {
                                  search = !search;
                                });
                              },
                            ))
                    )
                  ] ,
                  bottom: TabBar(
                    isScrollable: true,
                    onTap: (void index) {
                      setState(() {
                        tapIndex = tabController.index;
                        AppCubit.get(context).getPosts(category: id, subCategory: tabController.index, q: '');
                      });
                    },
                    controller: tabController,
                    tabs: <Widget>[
                      Tab(
                        child: Text(
                          'Academy',
                          style: TextStyle(
                              color: (tabController.index == 0)
                                  ? HexColor('#265AE8')
                                  : HexColor('#B0B3C7')),
                        ),
                      ),
                      Tab(
                        child: Text(
                          'National',
                          style: TextStyle(
                              color: (tabController.index == 1)
                                  ? HexColor('#265AE8')
                                  : HexColor('#B0B3C7')),
                        ),
                      ),
                      Tab(
                        child: Text(
                          'International',
                          style: TextStyle(
                              color: (tabController.index == 2)
                                  ? HexColor('#265AE8')
                                  : HexColor('#B0B3C7')),
                        ),
                      ),
                      Tab(
                        child: Text(
                          'Live',
                          style: TextStyle(
                              color: (tabController.index == 3)
                                  ? HexColor('#265AE8')
                                  : HexColor('#B0B3C7')),
                        ),
                      ),
                    ],
                  ),
                ),
                body: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                       if(search == true) defaultTextFormField(
                          controller: searchController,
                          labelText: 'Search',
                          onChanged: (String? value){
                            AppCubit.get(context).getPosts(
                              q: value,
                              category: id,
                              subCategory: tabController.index
                            );
                          },
                          suffixIcon: Icon(Icons.search)
                        ),
                        SizedBox(height: 20,),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(15.0),
                          child: CarouselSlider(
                            items: AppCubit.get(context).posts.map((e) => Builder(builder: (context) {
                              return Container(
                                  decoration: BoxDecoration(
                                    borderRadius:
                                    BorderRadius.circular(15.0),
                                    boxShadow: [
                                      BoxShadow(
                                          color: HexColor('#00AEAC'),
                                          spreadRadius: 0,
                                          blurRadius: 0),
                                    ],
                                  ),
                                  child: (e['attachment'].isNotEmpty)?Image.network('${e['attachment'][0]['Attachment']}',fit: BoxFit.fill, width: double.infinity,) : Image.asset('assets/images/splash1.png', fit: BoxFit.fill, width: double.infinity,),
                              );
                            }),
                            )
                                .toList(),
                            options: CarouselOptions(
                              // autoPlayCurve: Curves.easeInCirc,
                              autoPlayInterval: Duration(seconds: 3),
                              autoPlayAnimationDuration:
                              Duration(milliseconds: 1200),
                              reverse: false,
                              viewportFraction: 1,
                              aspectRatio: 2,
                              enlargeCenterPage: true,
                              scrollDirection: Axis.horizontal,
                              autoPlay: true,
                            ),
                          ),
                        ),
                        SizedBox(height: 20,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            defaultText(
                                text: 'News',
                                color: '#262C3D',
                                bold: true,
                                size: 18.0
                            ),
                            SizedBox(height: 10,),
                            if(state is GetPostsLoading)CircularProgressIndicator(),
                            if(state is! GetPostsLoading)ListView.separated(
                                shrinkWrap: true,
                                reverse: false,
                                physics: BouncingScrollPhysics(),
                                itemBuilder: (context, index) => defaultHomeContainer(AppCubit.get(context).posts[index], width,
                                  context,
                                ),
                                separatorBuilder: (context, index) => SizedBox(height: 5,),
                                itemCount: AppCubit.get(context).posts.length),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
        );
  }

  Widget defaultHomeContainer(data, width, contexts) => InkWell(
    onTap: (){
      defaultNavigateTo(context: contexts, screen: NewsDetailsScreen(
        body: (data['description_en']!= null) ? '${data['description_en']}' : '${data['description_ar']}' ,
        title: '${data['title_en']}',
        date: '${data['created_at']}',
        image: (data['attachment'].isNotEmpty)? '${data['attachment'][0]['Attachment']}': 'assets/images/splash1.png',
      ));
    },
    child: Container(
      padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
      width: double.infinity,
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.0784313725490196),
              spreadRadius: 1,
              blurRadius: 2,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
          color: Colors.white,
          borderRadius: BorderRadius.circular(25)),
      child: Center(
        child: Row(
          children: [
            Container(
              height: 100,
              width: 100,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15.0),
                  child: (data['attachment'].isNotEmpty)? Image.network('${data['attachment'][0]['Attachment']}'):Image.asset('assets/images/home.png')),
            ),
            SizedBox(
              width: 20,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: width * 0.52,
                  child: defaultText(
                    color: '#262C3D',
                    text: (data['title_en'] != null) ? '${data['title_en']}' : '${data['title_ar']}' ,
                    maxLines: 3,
                    size: 14.0,
                    bold: true,
                    textAlign: TextAlign.start
                  ),
                ),
                SizedBox(height: 5,),
                Container(
                  width: width * 0.52,
                  child: defaultText(
                      color: '#747F9E',
                      text: (data['description_en'] != null) ? '${data['description_en']}' : '${data['description_ar']}',
                      size: 14.0,
                      maxLines: 3,
                      bold: false,
                      textAlign: TextAlign.start
                  ),
                ),
                SizedBox(height: 10,),
                Row(
                  children: [
                    Row(
                      children: [
                        Icon(Icons.calendar_today_sharp,color: HexColor('#265AE8'),),
                        SizedBox(width: 3,),
                        Container(
                          width: 100,
                          child: defaultText(
                              color: '#265AE8',
                              text: (data['created_at'] != null) ? '${data['created_at']}' : '...',
                              size: 11.0,
                              bold: false,
                              textAlign: TextAlign.start
                          ),
                        ),
                      ],
                    ),
                    SizedBox(width: width * 0.05,),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        color: HexColor('#A8BDF6'),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Text((title == false) ? 'News' : 'Event',
                        style: TextStyle(color: HexColor('#3666EA'), fontSize: 12),
                      ),
                    )
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    ),
  );
}
