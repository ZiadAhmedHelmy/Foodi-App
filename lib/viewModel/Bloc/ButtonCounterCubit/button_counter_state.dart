part of 'button_counter_cubit.dart';

@immutable
abstract class ButtonCounterState {}

class ButtonCounterInitial extends ButtonCounterState {}

class AddFoodCountState extends ButtonCounterState {}
class RemoveFoodCountState extends ButtonCounterState {}



class ShowPassWordOrNot extends ButtonCounterState{}
