import 'package:comma/shared/components/Buttons/component.dart';
import 'package:flutter/material.dart';

class Final extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('النتيجة'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          textDirection: TextDirection.ltr,
          children: [
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: Container(
                width: double.infinity,
                child: Row(
                  textDirection: TextDirection.ltr,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 50.0),
                      child: Container(
                        width: 100,
                        child: defaultFormField(),
                      ),
                    ),
                    Text(
                      "كود الطالب:",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.blue,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Column(
              children: [
                defaultButton(function: () {}),
                Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: Row(
                    textDirection: TextDirection.ltr,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        ":اسم الطالب",
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.blue,
                        ),
                      ),
                      Column(
                        textDirection: TextDirection.ltr,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            ":كود الطالب",
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.blue,
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            ":مستحقات سابقة",
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.blue,
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            ":مستحقات حالية",
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.blue,
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            ":الاجمالي",
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.blue,
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            ":الطلوب سدادة(حدادني)",
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.blue,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
