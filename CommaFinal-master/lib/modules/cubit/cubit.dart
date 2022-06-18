import 'package:comma/layout/home/qrcode.dart';
import 'package:comma/modules/account/account.dart';
import 'package:comma/modules/chat/chat1.dart';
import 'package:comma/modules/cubit/states.dart';
import 'package:comma/modules/learn/learn.dart';
import 'package:comma/modules/home/home.dart';
import 'package:comma/modules/profile/groups_screen/groups_screen.dart';
import 'package:comma/shared/local/shared.dart';
import 'package:comma/shared/remote/dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());
  static AppCubit get(context) => BlocProvider.of(context);
  int CurrentIndex = 0;
  List<Widget> body = [
    Home(),
    ChatScreen(),
    ScanQrPage(),
    (CashHelper.getData(key: 'role') == 'Student') ? Learn() : GroupsScreen(),
    Profile(),
  ];
  List<dynamic> backgroundColor = [
    Colors.white,
    Colors.white,
    Colors.white,
    Colors.white,
    Color(0XFF265AE8),
  ];
  List<dynamic> AppBarColors = [
    Colors.white,
    Colors.white,
    Colors.white,
    Colors.white,
    Color(0XFF265AE8),
  ];
  List<String> Titles = [
    "Home",
    "Chat",
    "Learn",
    "Profile",
    "",
  ];
  void ChangeCurrentIndex(int index) {
    CurrentIndex = index;
    emit(ChangeBottomState());
  }

  bool isDark = false;
  void ChangeAppsMode() {
    isDark = !isDark;
    emit(ChangeAppModeState());
  }

  var loginToken;
  var role;
  postLogin({user_code, password}) {
    emit(LoginLoading());
    DioHelper.postData(
        url: 'signin',
        data: {'user_code': user_code, 'password': password}).then((value) {
      emit(LoginSuccess());
      loginToken = value.data['data']['token'];
      role = value.data['data']['user']['roles'][0]['name'];
      print('Rolee => ${role}');
      print('Login Token => ${loginToken}');
    }).catchError((e) {
      emit(LoginError(e.toString()));
      print(e.toString());
    });
  }

  postChangePass({password, password_confirmation}) {
    emit(ChangePassLoading());
    DioHelper.postData(
        url: 'student/changePass',
        token: CashHelper.getData(key: 'token'),
        data: {
          'password': password,
          'password_confirmation': password_confirmation
        }).then((value) {
      emit(ChangePassSuccess());
    }).catchError((e) {
      emit(ChangePassError(e.toString()));
      print(e.toString());
    });
  }

  var studentData;
  var studentName;
  var studentCode;
  var gpa;

  getStudentProfile() {
    emit(GetStudentProfileLoading());
    DioHelper.getData(url: 'student', token: CashHelper.getData(key: 'token'))
        .then((value) {
      emit(GetStudentProfileSuccess());
      studentData = value.data['data']['student'];
      studentName = value.data['data']['student']['name_en'];
      studentCode = value.data['data']['student']['user_code'];
      gpa = value.data['data']['student']['student']['gpa'];
    }).catchError((e) {
      emit(GetStudentProfileError(e.toString()));
      print(e.toString());
    });
  }

  List posts = [];
  List attach = [];
  var imageAttach;

  getPosts({subCategory, category, q}) {
    emit(GetPostsLoading());
    DioHelper.getData(
            url: 'blog/posts',
            query: {
              'subCategory': subCategory,
              'category': category,
              'q': (q != '') ? q : 'test'
            },
            token: CashHelper.getData(key: 'token'))
        .then((value) {
      emit(GetPostsSuccess());
      posts = value.data['data']['posts'];
      imageAttach = value.data['data']['posts']['attachment'][0]['Attachment'];
    }).catchError((e) {
      emit(GetPostsError(e.toString()));
      print(e.toString());
    });
  }
  List chats = [];
  getChats() {
    emit(GetChatsLoading());
    DioHelper.getData(
        url: 'chat/list',
        token: CashHelper.getData(key: 'token')
    ).then((value) {
      emit(GetChatsSuccess());
      chats =
      value.data['data']['chats'];
    }).catchError((e) {
      emit(GetChatsError(e.toString()));
      print(e.toString());
    });
  }
  List materialCourses = [];
  getCourses() {
    emit(GetCoursesLoading());
    DioHelper.getData(
            url: 'student/courses', token: CashHelper.getData(key: 'token'))
        .then((value) {
      emit(GetCoursesSuccess());
      materialCourses =
          value.data['data']['result']['student']['studentmatrial'];
    }).catchError((e) {
      emit(GetCoursesError(e.toString()));
      print(e.toString());
    });
  }

  List asks = [];
  getAsks() {
    emit(GetAsksLoading());
    DioHelper.getData(url: 'faq', token: CashHelper.getData(key: 'token'))
        .then((value) {
      emit(GetAsksSuccess());
      asks = value.data['data']['faq'];
    }).catchError((e) {
      emit(GetAsksError(e.toString()));
      print(e.toString());
    });
  }

  List attachment = [];
  getFileDownLoad({id}) {
    emit(GetFileDownloadLoading());
    DioHelper.getData(
            url: 'student/courses/$id', token: CashHelper.getData(key: 'token'))
        .then((value) {
      emit(GetFileDownloadSuccess());
      attachment = value.data['data']['course']['attachments'];
    }).catchError((e) {
      emit(GetFileDownloadError(e.toString()));
      print(e.toString());
    });
  }

  makeRequest({id}) {
    emit(MakeRequestLoading());
    DioHelper.getData(
            url: 'student/courses/$id', token: CashHelper.getData(key: 'token'))
        .then((value) {
      emit(MakeRequestSuccess());
      attachment = value.data['data']['course']['attachments'];
    }).catchError((e) {
      emit(MakeRequestError(e.toString()));
      print(e.toString());
    });
  }

  List media = [];
  getMaterialAndCvAndResearch() {
    emit(GetMaterialLoading());
    DioHelper.getData(
            url: 'doctor/profile/me',
        token: CashHelper.getData(key: 'token'))
        .then((value) {
      emit(GetMaterialSuccess());
      media = value.data['data']['user']['media'];
    }).catchError((e) {
      emit(GetMaterialError(e.toString()));
      print(e.toString());
    });
  }

  List requestOrder = [];
  getRequestOrder() {
    emit(GetRequestOrderLoading());
    DioHelper.getData(
            url: 'student/order/requests',
            token: CashHelper.getData(key: 'token'))
        .then((value) {
      emit(GetRequestOrderSuccess());
      requestOrder = value.data['data']['requests'];
    }).catchError((e) {
      emit(GetRequestOrderError(e.toString()));
      print(e.toString());
    });
  }

  List matrialGroups = [];
  getGroups() {
    emit(GetGroupsLoading());
    DioHelper.getData(url: 'doctor', token: CashHelper.getData(key: 'token'))
        .then((value) {
      emit(GetGroupsSuccess());
      matrialGroups = value.data['data']['groups'];
      print(value.data);
    }).catchError((e) {
      emit(GetGroupsError(e.toString()));
      print(e.toString());
    });
  }

  existGroups({media_id, group_id}) {
    emit(ExistGroupsLoading());
    DioHelper.postData(
            url: 'doctor/removeFromGroup',
            data: {'media_id': media_id, 'group_id': group_id},
            token: CashHelper.getData(key: 'token'))
        .then((value) {
      emit(ExistGroupsSuccess());
      print(value.data);
    }).catchError((e) {
      emit(ExistGroupsError(e.toString()));
      print(e.toString());
    });
  }

  addGroups({media_id, group_id}) {
    emit(AddGroupsLoading());
    DioHelper.postData(
            url: 'doctor/addToGroup',
            data: {'media_id': media_id, 'group_id': group_id},
            token: CashHelper.getData(key: 'token'))
        .then((value) {
      emit(AddGroupsSuccess());
      print(value.data);
    }).catchError((e) {
      emit(AddGroupsError(e.toString()));
      print(e.toString());
    });
  }

  makeOrder({id, notes, paperQty}) {
    emit(MakeOrderLoading());
    DioHelper.postData(
            url: 'student/order/$id',
            data: {'notes': notes, 'paperQty': paperQty},
            token: CashHelper.getData(key: 'token'))
        .then((value) {
      emit(MakeOrderSuccess());
      print(value.data);
    }).catchError((e) {
      emit(MakeOrderError(e.toString()));
      print(e.toString());
    });
  }

  List order = [];
  getOrder() {
    emit(GetOrderLoading());
    DioHelper.getData(
            url: 'student/order', token: CashHelper.getData(key: 'token'))
        .then((value) {
      emit(GetOrderSuccess());
      order = value.data['data']['orders'];
    }).catchError((e) {
      emit(GetOrderError(e.toString()));
      print(e.toString());
    });
  }

  uploadMaterial({file}) {
    emit(UploadMaterialLoading());
    DioHelper.uploadFile(
            url: 'doctor/upload',
            token: CashHelper.getData(key: 'token'),
            file: file)
        .then((value) {
      emit(UploadMaterialSuccess());
      print(value['data']['data']['user_code']);
    }).catchError((e) {
      emit(UploadMaterialError(e.toString()));
      print(e.toString());
      print(e.message());
    });
  }

  uploadResearch({file}) {
    emit(UploadResearchLoading());
    DioHelper.uploadResearch(
            url: 'doctor/profile/upload/research',
            token: CashHelper.getData(key: 'token'),
            file: file
    )
        .then((value) {
      emit(UploadResearchSuccess());
      print(value['data']['data']['user_code']);
    }).catchError((e) {
      emit(UploadResearchError(e.toString()));
      print(e.toString());
      print(e.message());
    });
  }

  uploadCv({file}) {
    emit(UploadCvLoading());
    DioHelper.uploadCv(
            url: 'doctor/profile/upload/cv',
            token: CashHelper.getData(key: 'token'),
            file: file)
        .then((value) {
      emit(UploadCvSuccess());
      print(value['data']['data']['user_code']);
    }).catchError((e) {
      emit(UploadCvError(e.toString()));
      print(e.toString());
      print(e.message());
    });
  }

  sendQrCodeData({id}) {
    emit(SendAttendLoading());
    DioHelper.postData(
            url: 'student/attend/$id', token: CashHelper.getData(key: 'token'))
        .then((value) {
      emit(SendAttendSuccess());
      print(value.data);
    }).catchError((e) {
      emit(SendAttendError(e.toString()));
      print(e.toString());
    });
  }

  List allMessages = [];
  getMessages({groub_id}) {
    emit(GetMessageLoading());
    DioHelper.getData(
            url: 'chat/messages/$groub_id',
            token: CashHelper.getData(key: 'token'))
        .then((value) {
      emit(GetMessageSuccess());
      allMessages = value.data['data']['chat']['messages'];
      print(value.data);
    }).catchError((e) {
      emit(GetMessageError(e.toString()));
      print(e.toString());
    });
  }

  sendMessages({id, message}) {
    emit(SendMessageLoading());
    DioHelper.postData(
            url: 'chat/sendMessage/$id',
            data: {'message': message},
            token: CashHelper.getData(key: 'token'))
        .then((value) {
      emit(SendMessageSuccess());
      print(value.data);
    }).catchError((e) {
      emit(SendMessageError(e.toString()));
      print(e.toString());
    });
  }
}
