import 'package:comma/modules/login/reset_password/reset_password.dart';
import 'package:comma/shared/components/Buttons/component.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class CheckEmail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 25, vertical: 25),
        child: Column(
          children: [
            Text(
              'Check your email',
              style: TextStyle(
                  fontSize: 26,
                  fontFamily: 'Plus Jakarta Sans'
              ),
            ),
            SizedBox(height: 15,),
            Text(
              'We’ve sent a password recover instruction to your email',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'Plus Jakarta Sans'
              ),
            ),
            SizedBox(height: 20,),
            Image.asset('assets/images/check_email.png'),
            SizedBox(height: 15,),
            defaultAccessButton(
              function: (){
                defaultNavigateTo(context: context, screen: ResetPassword());
              },
              text: 'Open email app',
            ),
            SizedBox(height: 5,),
            MaterialButton(
          onPressed: (){

          },
          child: Container(
            height: 50.0,
            alignment: Alignment.center,
            width: double.infinity,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5.0)),
            child: Text(
              'Will do it later',
              style: TextStyle(color: HexColor('#265AE8')),
            ),
          ),
        ),
            SizedBox(height: 30,),
            Text(
              'Didn’t get any email? Check your spam folder or try again with a valid email.',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 14,
                  color: HexColor('#9FA3A9')),
            ),
          ],
        ),
      ),
    );
  }
}
