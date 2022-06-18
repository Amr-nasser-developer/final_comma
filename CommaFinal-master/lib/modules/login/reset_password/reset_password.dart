import 'package:comma/shared/components/Buttons/component.dart';
import 'package:flutter/material.dart';

class ResetPassword extends StatelessWidget {
  var newPasswordController = TextEditingController();
  var confirmPasswordController = TextEditingController();
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
                'Reset your password',
                style: TextStyle(
                    fontSize: 18,
                    fontFamily: 'Plus Jakarta Sans'
                ),
              ),
              SizedBox(height: 30,),
              defaultTextFormField(
                controller: newPasswordController,
                onFieldSubmitted: (String value) {
                  print(value);
                },
                onChanged: (String value) {
                  print(value);
                },
                validator: (String? value){
                  if(value!.isEmpty){
                    return 'password must not be empty';
                  }else if(value.length < 8){
                    return 'Must contain 8 characters';
                  }
                },
                obscureText: false,
                labelText: 'Enter new password',
                prefixIcon: Icon(Icons.lock),
              ),
              SizedBox(height: 20,),
              defaultTextFormField(
                controller: confirmPasswordController,
                onFieldSubmitted: (String? value) {
                  print(value);
                },
                onChanged: (String? value) {
                  print(value);
                },
                validator: (String? value){
                  if(value!.isEmpty){
                    return 'password must not be empty';
                  } else if(newPasswordController.text != confirmPasswordController.text){
                    return 'Must match both password';
                  }
                },
                obscureText: false,
                labelText: 'Confirm Password',
                prefixIcon: Icon(Icons.lock),
              ),
              SizedBox(height: 30,),
              defaultAccessButton(
                  function: (){
                    if (formKey.currentState!.validate()) {
                      print(newPasswordController.text);
                      print(confirmPasswordController.text);
                    }
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
