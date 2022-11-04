import 'package:flutter/material.dart';
import 'package:shop_app/modules/login/login_screen.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';

class ShopLayoutScreen extends StatelessWidget {
  const ShopLayoutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Salla',
        ),
        actions: [
          IconButton(
            onPressed: ()
            {
              CacheHelper.removeData(key: 'token').then((value) {
                if(value)
                  {
                    navigateAndFinish(context, LoginScreen());
                  }
              });
            },
            icon: const Icon(
              Icons.logout_outlined,
            ),
          ),
        ],
      ),
      body: const Center(
        child: Text(
          'Salla',
        ),
      ),
    );
  }
}
