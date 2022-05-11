import 'dart:io';

abstract class AppStates{}
class InitialState extends AppStates{
}
class SplashScreenDone extends AppStates{
}
class getProperCircleEmpty extends AppStates{
}
class NextPage extends AppStates{
}
class LoadingState extends AppStates{}
class DataIsDone extends AppStates{
}
class GetDataError extends AppStates{
}
class CreateUserNameDone extends AppStates{
}
class CreateUserNameError extends AppStates{
}
class GetAllUsersDone extends AppStates{
}
class GetAllUsersError extends AppStates{
}
class GetMessageDone extends AppStates{
}
class SendMessageDone extends AppStates{
}
class SendMessageError extends AppStates{
}
class GetRoomError extends AppStates{
}
class SelectFileDone extends AppStates{
  final File ?file;
  SelectFileDone(this.file);
}
class UploadDone extends AppStates{
  final File ?file;
  UploadDone(this.file);
}
class changeText extends AppStates{
}
class GetProjectTaskDone extends AppStates{
}






