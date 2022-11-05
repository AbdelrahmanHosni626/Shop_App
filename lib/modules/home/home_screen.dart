import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/layout/cubit/states.dart';
import 'package:shop_app/models/home/home_model.dart';
import 'package:shop_app/shared/styles/colors.dart';

import '../../models/categories/categories_model.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (BuildContext context, state) {},
      builder: (BuildContext context, Object? state) {
        var cubit = ShopCubit.get(context);

        return ConditionalBuilder(
          condition: cubit.homeModel != null && cubit.categoriesModel != null,
          builder: (context) => homeBuilder(cubit.homeModel!, cubit.categoriesModel!),
          fallback: (context) => const Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }

  Widget homeBuilder(HomeModel model, CategoriesModel categoriesModel) => SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            CarouselSlider(
              items: model.data!.banners!
                  .map(
                    (e) => Image(
                      image: NetworkImage(
                        e.image!,
                      ),
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  )
                  .toList(),
              options: CarouselOptions(
                autoPlay: true,
                enableInfiniteScroll: true,
                initialPage: 0,
                height: 250.0,
                reverse: false,
                autoPlayInterval: const Duration(seconds: 3),
                autoPlayAnimationDuration: const Duration(seconds: 1),
                scrollDirection: Axis.horizontal,
                autoPlayCurve: Curves.fastOutSlowIn,
                viewportFraction: 1.0,
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 10.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Categories',
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  SizedBox(
                    height: 100.0,
                    child: ListView.separated(
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) => buildCategoryItem(categoriesModel.data!.data![index]),
                      separatorBuilder: (context, index) => const SizedBox(width: 20.0,),
                      itemCount: categoriesModel.data!.data!.length,
                    ),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  const Text(
                    'New Products',
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  Container(
                    color: Colors.grey[300],
                    child: GridView.count(
                      shrinkWrap: true,
                      crossAxisCount: 2,
                      mainAxisSpacing: 1,
                      crossAxisSpacing: 1,
                      childAspectRatio: 1 / 1.83,
                      physics: const NeverScrollableScrollPhysics(),
                      children: List.generate(
                        model.data!.products!.length,
                        (index) => buildGridItem(model.data!.products![index]),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );

  Widget buildGridItem(ProductsModel model) => Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                Image(
                  image: NetworkImage(
                    model.image!,
                  ),
                  height: 200,
                  width: double.infinity,
                ),
                if (model.discount != 0)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 5,
                    ),
                    color: defaultColor,
                    child: const Text(
                      'DISCOUNT',
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.white,
                      ),
                    ),
                  ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(13.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    model.name!,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 14.0,
                      height: 1.1,
                    ),
                  ),
                  const SizedBox(
                    height: 5.0,
                  ),
                  Row(
                    children: [
                      Text(
                        '${model.price!.round()}',
                        style: const TextStyle(
                          fontSize: 12.0,
                          color: defaultColor,
                        ),
                      ),
                      const SizedBox(
                        width: 20.0,
                      ),
                      if (model.discount != 0)
                        Text(
                          '${model.oldPrice!.round()}',
                          style: const TextStyle(
                            fontSize: 10.0,
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                      const Spacer(),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.favorite_outline,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      );

  Widget buildCategoryItem(DataModel model) => Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: [
          Image(
            image: NetworkImage(
              model.image!,
            ),
            width: 100.0,
            height: 100.0,
            fit: BoxFit.cover,
          ),
          Container(
            width: 100.0,
            color: Colors.black.withOpacity(0.6),
            child: Text(
              model.name!,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 15.0,
              ),
            ),
          ),
        ],
      );
}
