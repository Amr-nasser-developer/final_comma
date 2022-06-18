import 'package:flutter/material.dart';

class ItemGPA extends StatelessWidget {
  int CurrentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GPA'),
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
                        child: TextFormField(
                          keyboardType: TextInputType.visiblePassword,
                          decoration: InputDecoration(
                            hintText: "C1801418",
                            border: InputBorder.none,
                          ),
                        ),
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
                Container(
                  width: 120,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadiusDirectional.circular(15),
                    color: Colors.indigoAccent,
                  ),
                  child: MaterialButton(
                    onPressed: () {},
                    child: Text(
                      "بحث",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: Row(
                    textDirection: TextDirection.ltr,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        ":اسم الطالب                ",
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.blue,
                        ),
                      ),
                      Column(
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
                            height: 30,
                          ),
                          Text(
                            ":التقدير العام",
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
