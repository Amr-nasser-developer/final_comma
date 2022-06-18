abstract class AppStates {}

class AppInitialState extends AppStates {}
class ChangeBottomState extends AppStates {}
class ChangeAppModeState extends AppStates {}

class LoginLoading extends AppStates{}
class LoginSuccess extends AppStates{}
class LoginError extends AppStates{
  final error;
  LoginError(this.error);
}
class ChangePassLoading extends AppStates{}
class ChangePassSuccess extends AppStates{}
class ChangePassError extends AppStates{
  final error;
  ChangePassError(this.error);
}
class GetStudentProfileLoading extends AppStates{}
class GetStudentProfileSuccess extends AppStates{}
class GetStudentProfileError extends AppStates{
  final error;
  GetStudentProfileError(this.error);
}
class GetPostsLoading extends AppStates{}
class GetPostsSuccess extends AppStates{}
class GetPostsError extends AppStates{
  final error;
  GetPostsError(this.error);
}
class GetCoursesLoading extends AppStates{}
class GetCoursesSuccess extends AppStates{}
class GetCoursesError extends AppStates{
  final error;
  GetCoursesError(this.error);
}
class GetChatsLoading extends AppStates{}
class GetChatsSuccess extends AppStates{}
class GetChatsError extends AppStates{
  final error;
  GetChatsError(this.error);
}
class GetAsksLoading extends AppStates{}
class GetAsksSuccess extends AppStates{}
class GetAsksError extends AppStates{
  final error;
  GetAsksError(this.error);
}
class MakeRequestLoading extends AppStates{}
class MakeRequestSuccess extends AppStates{}
class MakeRequestError extends AppStates{
  final error;
  MakeRequestError(this.error);
}
class MakeOrderLoading extends AppStates{}
class MakeOrderSuccess extends AppStates{}
class MakeOrderError extends AppStates{
  final error;
  MakeOrderError(this.error);
}
class GetOrderLoading extends AppStates{}
class GetOrderSuccess extends AppStates{}
class GetOrderError extends AppStates{
  final error;
  GetOrderError(this.error);
}
class GetMessageLoading extends AppStates{}
class GetMessageSuccess extends AppStates{}
class GetMessageError extends AppStates{
  final error;
  GetMessageError(this.error);
}
class SendMessageLoading extends AppStates{}
class SendMessageSuccess extends AppStates{}
class SendMessageError extends AppStates{
  final error;
  SendMessageError(this.error);
}
class SendAttendLoading extends AppStates{}
class SendAttendSuccess extends AppStates{}
class SendAttendError extends AppStates{
  final error;
  SendAttendError(this.error);
}
class UploadMaterialLoading extends AppStates{}
class UploadMaterialSuccess extends AppStates{}
class UploadMaterialError extends AppStates{
  final error;
  UploadMaterialError(this.error);
}
class UploadResearchLoading extends AppStates{}
class UploadResearchSuccess extends AppStates{}
class UploadResearchError extends AppStates{
  final error;
  UploadResearchError(this.error);
}
class UploadCvLoading extends AppStates{}
class UploadCvSuccess extends AppStates{}
class UploadCvError extends AppStates{
  final error;
  UploadCvError(this.error);
}
class GetMaterialLoading extends AppStates{}
class GetMaterialSuccess extends AppStates{}
class GetMaterialError extends AppStates{
  final error;
  GetMaterialError(this.error);
}
class GetGroupsLoading extends AppStates{}
class GetGroupsSuccess extends AppStates{}
class GetGroupsError extends AppStates{
  final error;
  GetGroupsError(this.error);
}
class ExistGroupsLoading extends AppStates{}
class ExistGroupsSuccess extends AppStates{}
class ExistGroupsError extends AppStates{
  final error;
  ExistGroupsError(this.error);
}
class AddGroupsLoading extends AppStates{}
class AddGroupsSuccess extends AppStates{}
class AddGroupsError extends AppStates{
  final error;
  AddGroupsError(this.error);
}
class GetFileDownloadLoading extends AppStates{}
class GetFileDownloadSuccess extends AppStates{}
class GetFileDownloadError extends AppStates{
  final error;
  GetFileDownloadError(this.error);
}
class GetRequestOrderLoading extends AppStates{}
class GetRequestOrderSuccess extends AppStates{}
class GetRequestOrderError extends AppStates{
  final error;
  GetRequestOrderError(this.error);
}

