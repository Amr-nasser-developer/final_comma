import 'package:comma/layout/home/home.dart';
import 'package:comma/modules/cubit/cubit.dart';
import 'package:comma/modules/cubit/states.dart';
import 'package:comma/modules/login/forget_password/forget_password.dart';
import 'package:comma/shared/components/Buttons/component.dart';
import 'package:comma/shared/local/shared.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';

class Login_Student extends StatefulWidget {
  @override
  State<Login_Student> createState() => _Login_StudentState();
}

class _Login_StudentState extends State<Login_Student> {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  bool obscure = false;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubit(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {
          if (state is LoginError) {
            Fluttertoast.showToast(
                msg: "The username or password is incorrect",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0);
          }
          if (state is LoginSuccess) {
            CashHelper.setData(key: 'email', value: emailController.text);
            CashHelper.setData(key: 'password', value: passwordController.text);
            CashHelper.setData(
                key: 'role', value: AppCubit.get(context).role);
            CashHelper.setData(
                    key: 'token', value: AppCubit.get(context).loginToken)
                .then((value) {
              defaultFinishNavigate(
                  context: context,
                  widget: HomeScreen(
                    role: AppCubit.get(context).role,
                  ));
            });
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              flexibleSpace: Center(
                child: Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/images/splash1.png"),
                      ),
                    )),
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(1000),
                      bottomRight: Radius.circular(1000))),
              bottom: PreferredSize(
                preferredSize: Size.fromHeight(120),
                child: SizedBox(),
              ),
              elevation: 0,
              backgroundColor: HexColor('#265AE8'),
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Text(
                          "Welcome back! \n Sign in to Continue! ",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: "Plus Jakarta Sans",
                            fontSize: 26,
                            color: HexColor('#0B121F'),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Column(
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          defaultTextFormField(
                            controller: emailController,
                            validator: (String? value) {
                              if (value!.isEmpty) {
                                return 'Code must not be empty';
                              }
                            },
                            labelText: 'user name',
                            prefixIcon: Icon(Icons.account_circle_outlined),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          defaultTextFormField(
                            controller: passwordController,
                            validator: (String? value) {
                              if (value!.isEmpty) {
                                return 'password must not be empty';
                              }
                            },
                            obscureText: (obscure == false) ? true : false,
                            labelText: 'Password',
                            prefixIcon: Icon(Icons.lock),
                            suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    obscure = !obscure;
                                  });
                                },
                                icon: (obscure == false)
                                    ? Icon(Icons.remove_red_eye)
                                    : Icon(Icons.visibility_off)),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          SizedBox(height: 20),
                          if (state is LoginLoading)
                            CircularProgressIndicator(),
                          if (state is! LoginLoading)
                            defaultAccessButton(
                                function: () {
                                  if (formKey.currentState!.validate()) {
                                    AppCubit.get(context).postLogin(
                                        user_code: emailController.text,
                                        password: passwordController.text);
                                  }
                                },
                                text: 'Login'),
                          SizedBox(
                            height: 20,
                          ),
                          TextButton(
                              onPressed: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return ForgetPassword();
                                }));
                              },
                              child: Text(
                                "Forgot Password?",
                                style: TextStyle(
                                  fontFamily: "Mulish",
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0XFFA8BDF6),
                                ),
                              )),
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
}
