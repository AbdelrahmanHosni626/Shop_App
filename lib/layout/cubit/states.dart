import 'package:shop_app/models/home/home_model.dart';

abstract class ShopStates {}

class ShopInitialState extends ShopStates {}

class ShopChangeBottomNavBarState extends ShopStates {}

class ShopGetLoadingState extends ShopStates {}

class ShopGetSuccessState extends ShopStates
{
  final HomeModel homeModel;

  ShopGetSuccessState(this.homeModel);
}

class ShopGetErrorState extends ShopStates
{
  final String error;

  ShopGetErrorState(this.error);
}