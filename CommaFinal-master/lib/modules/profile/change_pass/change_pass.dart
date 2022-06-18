import 'package:comma/layout/home/home.dart';
import 'package:comma/modules/cubit/cubit.dart';
import 'package:comma/modules/cubit/states.dart';
import 'package:comma/shared/components/Buttons/component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChangePass extends StatelessWidget {
  var passwordController = TextEditingController();
  var confirmPasswordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (context)=>AppCubit(),
    child: BlocConsumer<AppCubit,AppStates>(
      listener: (context, state){
        if(state is ChangePassSuccess){
          defaultFinishNavigate(
            context: context,
            widget: HomeScreen()
          );
        }
      },
      builder: (context, state){
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0.0,
            centerTitle: true,
            title: defaultText(
              color: '#265AE8',
              text: 'Change Password',
              bold: true,
              size: 20.0,
            ),
            leading: IconButton(
                onPressed: (){
                  Navigator.pop(context);
                },
                icon: Icon(Icons.arrow_back_ios_sharp, color: Colors.black,)
            ),
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 25),
            child: Column(
              children: [
                defaultTextFormField(
                    labelText: 'Password',
                    controller: passwordController,
                    validator: (String? value){
                      if(value!.isEmpty){
                        return 'Please Insert The New Password';
                      };
                    }
                ),
                SizedBox(height: 15,),
                defaultTextFormField(
                    labelText: 'Confirm Password',
                    controller: confirmPasswordController,
                    validator:(String? value){
                      if(value!.isEmpty){
                        return 'Please Insert The New Password';
                      };
                      if(confirmPasswordController.text != passwordController.text){
                        return 'The Confirm Password Must Match The Password';
                      }
                    }
                ),
                SizedBox(height: 30,),
                if(state is ChangePassLoading)CircularProgressIndicator(),
                if(state is! ChangePassLoading)defaultAccessButton(
                    text: 'SAVE',
                    function: (){
                      AppCubit.get(context).postChangePass(
                        password: passwordController.text,
                        password_confirmation: confirmPasswordController.text
                      );
                    }
                )
              ],
            ),
          ),
        );
      },
    ),
    );
  }
}
