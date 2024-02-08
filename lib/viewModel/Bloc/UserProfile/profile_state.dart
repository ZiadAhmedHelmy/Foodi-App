part of 'profile_cubit.dart';

@immutable
abstract class ProfileState {}

class ProfileInitial extends ProfileState {}


// UploadImage State
class UploadImageSuccessState extends ProfileState{}
class UploadImageLoadingState extends ProfileState{}
class UploadImageErrorState extends ProfileState{}




// user Infoooo

class LoadingUserInfoState extends ProfileState{}
class SuccessUserInfoState extends ProfileState{}



// update userPhoto
class UpadteImageSuccess extends ProfileState{}




