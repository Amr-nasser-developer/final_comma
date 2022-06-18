import 'package:flutter/material.dart';

class Login extends StatelessWidget {
  var EmailController = TextEditingController();
  var PasswordController = TextEditingController();
  var FormKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Form(
            key: FormKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    Image.asset("assets/images/2.png"),
                  ],
                ),
                Text(
                  "Welcome Doctor",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                    color: Colors.blueAccent,
                  ),
                ),
                Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: EmailController,
                      onFieldSubmitted: (String value) {
                        print(value);
                      },
                      onChanged: (String value) {
                        print(value);
                      },
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return "Code must not be empty";
                        }
                        return null;
                      },
                      obscureText: true,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.lock),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black12),
                        ),
                        suffixIcon: Icon(Icons.remove_red_eye),
                        labelText: "Code",
                        labelStyle: TextStyle(color: Colors.black38),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: EmailController,
                      onFieldSubmitted: (String value) {
                        print(value);
                      },
                      onChanged: (String value) {
                        print(value);
                      },
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return "password must not be empty";
                        }
                        return null;
                      },
                      obscureText: true,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.lock),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black12),
                        ),
                        suffixIcon: Icon(Icons.remove_red_eye),
                        labelText: "Password",
                        labelStyle: TextStyle(color: Colors.black38),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Don't have an account?"),
                        TextButton(
                            onPressed: () {}, child: Text("Forgot Password?")),
                      ],
                    ),
                    SizedBox(height: 20),
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.blueAccent),
                      child: MaterialButton(
                        child: Text(
                          "login",
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () {
                          if (FormKey.currentState!.validate()) {
                            print(PasswordController);
                            print(EmailController);
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
