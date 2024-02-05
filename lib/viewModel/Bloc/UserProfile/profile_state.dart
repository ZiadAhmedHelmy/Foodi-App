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



// ShippingState  Set
class LoadingSetShippingInfo extends ProfileState{}
class SuccessSetShippingInfo extends ProfileState{}


// ShippingState Get
class LoadingGetShippingInfo extends ProfileState{}
class SuccessGetShippingInfo extends ProfileState{}


// SelectedInfoState

class SuccessSelectedInfo extends ProfileState{}



// Selected Payment Method

class SelectedPaymentMethod extends ProfileState{}


