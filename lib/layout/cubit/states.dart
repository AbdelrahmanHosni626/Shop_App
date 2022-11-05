import 'package:shop_app/models/categories/categories_model.dart';
import 'package:shop_app/models/home/home_model.dart';

abstract class ShopStates {}

class ShopInitialState extends ShopStates {}

class ShopChangeBottomNavBarState extends ShopStates {}

class ShopGetHomeLoadingState extends ShopStates {}

class ShopGetHomeSuccessState extends ShopStates
{
  final HomeModel homeModel;

  ShopGetHomeSuccessState(this.homeModel);
}

class ShopGetHomeErrorState extends ShopStates
{
  final String error;

  ShopGetHomeErrorState(this.error);
}


class ShopGetCategoriesLoadingState extends ShopStates {}

class ShopGetCategoriesSuccessState extends ShopStates
{
  final CategoriesModel categoriesModel;

  ShopGetCategoriesSuccessState(this.categoriesModel);
}

class ShopGetCategoriesErrorState extends ShopStates
{
  final String error;

  ShopGetCategoriesErrorState(this.error);
}