import 'package:carousel_slider/carousel_slider.dart';
import 'package:comma/modules/news/news_details.dart';
import 'package:comma/shared/components/Buttons/component.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class News extends StatelessWidget {
  const News({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Card(
              elevation: 20,
              child: CarouselSlider(
                  items: [
                    Image(
                      image: AssetImage("assets/images/3.png"),
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                    Image(
                      image: AssetImage("assets/images/4.png"),
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                    Image(
                      image: AssetImage("assets/images/5.png"),
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ],
                  options: CarouselOptions(
                    height: 200,
                    initialPage: 0,
                    enableInfiniteScroll: true,
                    reverse: false,
                    autoPlay: true,
                    autoPlayInterval: Duration(seconds: 3),
                    autoPlayAnimationDuration: Duration(seconds: 1),
                    autoPlayCurve: Curves.fastOutSlowIn,
                    scrollDirection: Axis.horizontal,
                    viewportFraction: 1.0,
                  )),
            ),
            SizedBox(
              height: 10,
            ),
            ListView.separated(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) => NewsList(),
                separatorBuilder: (context, index) => SizedBox(
                      height: 0,
                    ),
                itemCount: 10)
          ],
        ),
      ),
    );
  }

  Widget NewsList({context}) => InkWell(
    onTap: (){
      defaultNavigateTo(
        context: context,
        screen: NewsDetailsScreen()
      );
    },
    child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Card(
            elevation: 10,
            color: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadiusDirectional.circular(10)),
            child: Container(
              width: double.infinity,
              height: 130,
              child: Row(
                children: [
                  Container(
                    width: 100,
                    height: 130,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/images/3.png"),
                          fit: BoxFit.cover),
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(13),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(
                            " Luxor and the Sphinx Road Luxor and the Sphinx Road ",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        SizedBox(
                          height: 0,
                        ),
                        Expanded(
                          child: Text(
                            "SnapShots of the Participation SnapShots of the Participation ",
                            style: TextStyle(color: Color(0XFFA8BDF6)),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 5.0, right: 5),
                          child: Row(
                            children: [
                              Icon(
                                Icons.backpack_rounded,
                                color: Color(0XFFA8BDF6),
                              ),
                              Text(
                                "1/2/2022 ",
                                style: TextStyle(color: Color(0XFF265AE8)),
                              ),
                              Spacer(),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Color(0XFFA8BDF6),
                                ),
                                child: Text(
                                  "News ",
                                  style: TextStyle(color: Color(0XFF265AE8)),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
  );
}
