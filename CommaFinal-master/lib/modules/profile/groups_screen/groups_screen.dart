import 'package:comma/modules/cubit/cubit.dart';
import 'package:comma/modules/cubit/states.dart';
import 'package:comma/modules/profile/assign_screen/assign_screen.dart';
import 'package:comma/modules/profile/available_screen/available_screen.dart';
import 'package:comma/shared/components/Buttons/component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GroupsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubit()..getGroups(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var appCubit = AppCubit.get(context);
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0.0,
              title: defaultText(
                  bold: true, size: 26.0, text: 'Groups', color: '#265AE8'),
            ),
            body: SingleChildScrollView(
              child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 25.0, vertical: 15.0),
                  child: Column(
                    children: [
                      if (state is GetGroupsLoading)
                        Center(
                          child: CircularProgressIndicator(),
                        ),
                      if (state is! GetGroupsLoading)
                        ListView.separated(
                            shrinkWrap: true,
                            physics: BouncingScrollPhysics(),
                            reverse: false,
                            itemBuilder: (context, index) => ListGroups(
                                appCubit.matrialGroups[index], context),
                            separatorBuilder: (context, index) =>
                                SizedBox(height: 10),
                            itemCount: appCubit.matrialGroups.length),
                    ],
                  )),
            ),
          );
        },
      ),
    );
  }

  Widget ListGroups(group, context) => Container(
        padding: EdgeInsets.symmetric(vertical: 30.0, horizontal: 15.0),
        width: double.infinity,
        decoration: BoxDecoration(
            color: Color(0XFF265AE8).withOpacity(0.1),
            borderRadius: BorderRadius.circular(25)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: defaultText(
                  color: '#1A1C24',
                  size: 12.0,
                  maxLines: 4,
                  bold: true,
                  textAlign: TextAlign.start,
                  text: '${group['matrial']['name_en']}'),
            ),
            SizedBox(
              width: 5,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  defaultText(
                      color: '#1A1C24',
                      size: 12.0,
                      maxLines: 4,
                      bold: true,
                      textAlign: TextAlign.start,
                      text: '${group['day']}'),
                ],
              ),
            ),
            Expanded(
              child: defaultAccessButton(
                  text: 'Add',
                  function: () {
                    defaultNavigateTo(
                        context: context,
                        screen: AssignScreen(
                          groupId: '${group['id']}',
                        ));
                  }),
            ),
          ],
        ),
      );
}
