import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'button_counter_state.dart';

class ButtonCounterCubit extends Cubit<ButtonCounterState> {
  ButtonCounterCubit() : super(ButtonCounterInitial());
  static ButtonCounterCubit get(context) => BlocProvider.of(context);
  int productCount = 0 ;
  bool isShowenPassLogin = true;
  bool isShowenPassRegister = true;
  void productCountAdd(){
    if(productCount== 30){
      //Fluttertoast.showToast(msg: "That is Maximum You get from this Product");
    }
    else{
      productCount++;
      emit(AddFoodCountState());
    }

  }

  void productCountRemove(){
    if(productCount>0){
      productCount--;
      emit(RemoveFoodCountState());
    }
  }

  void showPassWord(){
     isShowenPassLogin=!isShowenPassLogin;
     emit(ShowPassWordOrNot());
  }

  void showPassWordRegister(){
    isShowenPassRegister=!isShowenPassRegister;
    emit(ShowPassWordOrNot());
  }



}
