// ignore_for_file: use_build_context_synchronously

import 'package:educational_institute/core/utils/constants/app_colors.dart';
import 'package:educational_institute/core/utils/constants/sizes.dart';
import 'package:educational_institute/core/utils/helpers/helper_functions.dart';
import 'package:educational_institute/core/utils/local_storage/local_storage.dart';
import 'package:educational_institute/core/utils/router/app_router.dart';
import 'package:educational_institute/features/pleacment_test/presentation/views/pleacment_test/pleacment_test.dart';
import 'package:educational_institute/navigation_menu.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = HelperFunctions.isDarkMode(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.primaryColor,
        title: Text(
          "Login",
          style: Theme.of(context)
              .textTheme
              .headlineMedium!
              .copyWith(color: Colors.white),
        ),
      ),
      body: Form(
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: HelperFunctions.screenWidth(context) *
                  AppSizes.horizintalMarginPercent),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                cursorColor: AppColors.primaryColor,
                decoration: InputDecoration(
                  label: const Text("Email"),
                  prefixIcon: Icon(Icons.email,
                      color: isDarkMode
                          ? AppColors.white
                          : AppColors.primaryColor),
                ),
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                validator: (value) =>
                    AValidator.validateArabicText("Email", value),
              ),
              SizedBox(height: HelperFunctions.screenHeight(context) * 0.03),
              TextFormField(
                cursorColor: AppColors.primaryColor,
                decoration: InputDecoration(
                  label: const Text("Password"),
                  prefixIcon: Icon(Icons.lock,
                      color: isDarkMode
                          ? AppColors.white
                          : AppColors.primaryColor),
                ),
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                validator: (value) =>
                    AValidator.validateArabicText("Password", value),
              ),
              SizedBox(height: HelperFunctions.screenHeight(context) * 0.06),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    // Perform login validation and authentication here
                    await LocalStorage.saveData(key: 'isGuest', value: false);
                    await LocalStorage.saveData(key: 'isTeacher', value: true);
                    print(" we are navigating");
                    GoRouter.of(context)
                        .pushReplacement(AppRouter.kNavigationMenu);
                    // Navigator.of(context).popUntil((route) => route.isFirst);
                  },
                  child: const Text("Login"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
