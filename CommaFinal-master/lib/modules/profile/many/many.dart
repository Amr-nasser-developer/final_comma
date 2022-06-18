import 'package:comma/shared/components/Buttons/component.dart';
import 'package:flutter/material.dart';

class Money extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('سداد المصروفات'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(25.0),
            child: Container(
              width: double.infinity,
              child: Row(
                textDirection: TextDirection.ltr,
                mainAxisAlignment: MainAxisAlignment.start,
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
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  "اسم الطالب:",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.blue,
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
              Container(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    textDirection: TextDirection.ltr,
                    children: [
                      Expanded(
                        child: Text(
                          "التقدير",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          "اسم المادة",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          "كود المادة",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
