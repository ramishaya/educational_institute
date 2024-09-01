import 'package:educational_institute/core/utils/constants/app_colors.dart';
import 'package:educational_institute/core/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';

class EmailVerificationView extends StatefulWidget {
  const EmailVerificationView({super.key});

  @override
  State<EmailVerificationView> createState() => _EmailVerificationViewState();
}

class _EmailVerificationViewState extends State<EmailVerificationView> {
  int otbCode = 0;
  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = HelperFunctions.isDarkMode(context);
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        clipBehavior: Clip.antiAlias,
        surfaceTintColor: Colors.transparent,
        foregroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(
            Iconsax.arrow_left_24,
            size: HelperFunctions.screenHeight(context) * 0.03,
            color: isDarkMode ? AppColors.white : AppColors.black,
          ),
          onPressed: () {
            GoRouter.of(context).pop();
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(size.width * 0.07),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text(
                  "CO\nDE",
                  style: Theme.of(context)
                      .textTheme
                      .headlineLarge!
                      .copyWith(fontSize: 70),
                  textAlign: TextAlign.center,
                ),
                Text(
                  "Verification".toUpperCase(),
                  style: Theme.of(context).textTheme.headlineLarge,
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: size.height * 0.02,
                ),
                Text(
                  "Enter the Verification Code you recived in your email ",
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall!
                      .copyWith(fontWeight: FontWeight.normal),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: size.height * 0.06,
                ),
                OtpTextField(
                  onSubmit: (code) {
                    setState(() {
                      otbCode = int.parse(code);
                    });
                  },
                  numberOfFields: 6,
                  fillColor: AppColors.primaryColor.withOpacity(0.1),
                  filled: true,
                  keyboardType: TextInputType.number,
                ),
                SizedBox(
                  height: size.height * 0.06,
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: () {}, child: const Text("Send Code")),
                ),
                SizedBox(
                  height: size.height * 0.06,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
