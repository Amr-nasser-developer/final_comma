import 'package:comma/modules/login/check_email/check_email.dart';
import 'package:comma/modules/login/reset_password/reset_password.dart';
import 'package:comma/shared/components/Buttons/component.dart';
import 'package:flutter/material.dart';

class ForgetPassword extends StatelessWidget {
  var forgetPasswordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_sharp, color: Colors.black,),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
      ),
      body: Form(
        key: formKey,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 25, horizontal: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
                Text(
                    'Email Address',
                  style: TextStyle(
                    fontSize: 18,
                    fontFamily: 'Plus Jakarta Sans'
                  ),
                ),
              SizedBox(height: 30,),
              defaultTextFormField(
                controller: forgetPasswordController,
                onFieldSubmitted: (String value) {
                  print(value);
                },
                onChanged: (String value) {
                  print(value);
                },
                validator: (String? value){
                  if(value!.isEmpty){
                    return 'The email address you provided is not associated with your account';
                  }
                },
                obscureText: false,
                labelText: 'email adress',
                prefixIcon: Icon(Icons.account_circle_outlined),
              ),
              SizedBox(height: 30,),
              defaultAccessButton(
                  function: (){
                    defaultNavigateTo(context: context, screen: CheckEmail());
                  },
                  text: 'Sent Email'
                  )
            ],
          ),
        ),
      ),
    );
  }
}
