import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/states.dart';
import 'package:shop_app/models/categories/categories_model.dart';
import 'package:shop_app/models/home/home_model.dart';
import 'package:shop_app/modules/categories/categories_screen.dart';
import 'package:shop_app/modules/favorites/favorites_screen.dart';
import 'package:shop_app/modules/home/home_screen.dart';
import 'package:shop_app/modules/settings/settings_screen.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/network/end_points.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopInitialState());

  static ShopCubit get(context) => BlocProvider.of(context);

  List<Widget> screens = [
    HomeScreen(),
    CategoriesScreen(),
    FavoritesScreen(),
    SettingsScreen(),
  ];

  int currentIndex = 0;

  void changeBottomNavBar(int index) {
    currentIndex = index;
    emit(ShopChangeBottomNavBarState());
  }

  HomeModel? homeModel;

  void getHomeData() {
    emit(ShopGetHomeLoadingState());

    DioHelper.getData(
      url: HOME,
      token: token,
    ).then((value) {
      homeModel = HomeModel.fromJson(value.data);
      emit(ShopGetHomeSuccessState(homeModel!));
    }).catchError((error) {
      print(error.toString());
      emit(ShopGetHomeErrorState(error.toString()));
    });
  }


  CategoriesModel? categoriesModel;

  void getCategoriesData() {
    emit(ShopGetCategoriesLoadingState());

    DioHelper.getData(
      url: GET_GATEGORIES,
      token: token,
    ).then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);
      emit(ShopGetCategoriesSuccessState(categoriesModel!));
    }).catchError((error) {
      print(error.toString());
      emit(ShopGetCategoriesErrorState(error.toString()));
    });
  }
}
