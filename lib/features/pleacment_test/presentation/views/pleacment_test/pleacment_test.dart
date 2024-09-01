import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:educational_institute/core/utils/constants/app_colors.dart';
import 'package:educational_institute/core/utils/constants/sizes.dart';
import 'package:educational_institute/core/utils/helpers/helper_functions.dart';
import 'package:educational_institute/core/utils/validator/validator.dart';
import 'package:educational_institute/features/pleacment_test/presentation/view_models/subject_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:iconsax/iconsax.dart';
import 'package:flutter/services.dart';

class PlacementTest extends StatefulWidget {
  const PlacementTest({super.key});

  @override
  State<PlacementTest> createState() => _PlacementTestState();
}

class _PlacementTestState extends State<PlacementTest> {
  int otbCode = 0;

  Future openDialog() {
    return AwesomeDialog(
      context: context,
      dialogType: DialogType.noHeader,
      animType: AnimType.rightSlide,
      headerAnimationLoop: false,
      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
      width: MediaQuery.of(context).size.width,
      dismissOnTouchOutside: true,
      dismissOnBackKeyPress: false,
      title: 'CODE Verification',
      body: Padding(
        padding: EdgeInsets.all(HelperFunctions.screenWidth(context) *
            AppSizes.horizintalMarginPercent),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "Verification CODE ",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            const Text(
              "Enter the Verification Code you received in your email",
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            OtpTextField(
              onSubmit: (code) {
                setState(() {
                  otbCode = int.parse(code);
                });
              },
              numberOfFields: 6,
              fieldWidth: HelperFunctions.screenWidth(context) * 0.095,
              fillColor: Colors.grey.withOpacity(0.1),
              filled: true,
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                child: const Text("Send Code"),
              ),
            ),
          ],
        ),
      ),
    ).show();
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = HelperFunctions.isDarkMode(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.primaryColor,
        title: Text(
          "Placement Test",
          style: Theme.of(context)
              .textTheme
              .headlineMedium!
              .copyWith(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: HelperFunctions.screenWidth(context) *
                  AppSizes.horizintalMarginPercent),
          child: Form(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: HelperFunctions.screenHeight(context) * 0.04),
                BlocBuilder<SubjectCubit, SubjectState>(
                  builder: (context, state) {
                    var cubit = SubjectCubit.get(context);
                    return DropdownButtonFormField<String>(
                      dropdownColor:
                          isDarkMode ? AppColors.dark : AppColors.light,
                      value: cubit.selectedSubject,
                      decoration: InputDecoration(
                        prefixIconColor: isDarkMode
                            ? AppColors.white
                            : AppColors.primaryColor,
                        label: const Text('Select Subject'),
                        prefixIcon: const Icon(Icons.book),
                      ),
                      items: cubit.subjects.map((String subject) {
                        return DropdownMenuItem<String>(
                          value: subject,
                          child: Text(
                            subject,
                            style: isDarkMode
                                ? const TextStyle(color: AppColors.white)
                                : const TextStyle(color: AppColors.black),
                            textDirection: TextDirection.rtl,
                          ),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        if (newValue != null) {
                          cubit.updateSubject(newValue);
                        }
                      },
                      validator: (value) =>
                          value == null ? 'Please select a subject' : null,
                    );
                  },
                ),
                SizedBox(height: HelperFunctions.screenHeight(context) * 0.03),
                TextFormField(
                  cursorColor: AppColors.primaryColor,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(
                        RegExp(r'^[\u0621-\u064A ]+$')),
                  ],
                  decoration: InputDecoration(
                    label: const Text("First Name"),
                    prefixIcon: Icon(
                      Iconsax.user,
                      color:
                          isDarkMode ? AppColors.white : AppColors.primaryColor,
                    ),
                  ),
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  validator: (value) =>
                      AValidator.validateArabicText("First Name", value),
                ),
                SizedBox(height: HelperFunctions.screenHeight(context) * 0.03),
                TextFormField(
                  cursorColor: AppColors.primaryColor,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(
                        RegExp(r'^[\u0621-\u064A ]+$')),
                  ],
                  decoration: InputDecoration(
                    label: const Text("Last Name"),
                    prefixIcon: Icon(
                      Iconsax.user,
                      color:
                          isDarkMode ? AppColors.white : AppColors.primaryColor,
                    ),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  validator: (value) =>
                      AValidator.validateArabicText("Last Name", value),
                ),
                SizedBox(height: HelperFunctions.screenHeight(context) * 0.03),
                TextFormField(
                  cursorColor: AppColors.primaryColor,
                  decoration: InputDecoration(
                    label: const Text("Email"),
                    prefixIcon: Icon(
                      Icons.email,
                      color:
                          isDarkMode ? AppColors.white : AppColors.primaryColor,
                    ),
                  ),
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  validator: (value) =>
                      AValidator.validateArabicText("Last Name", value),
                ),
                SizedBox(height: HelperFunctions.screenHeight(context) * 0.03),
                TextFormField(
                  cursorColor: AppColors.primaryColor,
                  decoration: InputDecoration(
                    label: const Text("Phone Number"),
                    prefixIcon: Icon(
                      Iconsax.call,
                      color:
                          isDarkMode ? AppColors.white : AppColors.primaryColor,
                    ),
                  ),
                  keyboardType: TextInputType.phone,
                  textInputAction: TextInputAction.next,
                  validator: (value) => EValidator.validatePhoneNumber(value),
                ),
                SizedBox(height: HelperFunctions.screenHeight(context) * 0.03),
                TextFormField(
                  cursorColor: AppColors.primaryColor,
                  decoration: InputDecoration(
                    label: const Text("Home Number"),
                    prefixIcon: Icon(
                      Iconsax.call_calling,
                      color:
                          isDarkMode ? AppColors.white : AppColors.primaryColor,
                    ),
                  ),
                  keyboardType: TextInputType.phone,
                  textInputAction: TextInputAction.done,
                  validator: (value) => EValidator.validatePhoneNumber(value),
                ),
                SizedBox(height: HelperFunctions.screenHeight(context) * 0.06),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      openDialog();
                    },
                    child: const Text("Submit"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class AValidator {
  static String? validateEmptyText(String? fieldName, String? value) {
    if (value == null || value.isEmpty) {
      return "$fieldName is required";
    }
    return null;
  }

  static String? validateArabicText(String? fieldName, String? value) {
    if (value == null || value.isEmpty) {
      return "$fieldName is required";
    } else if (!RegExp(r'^[\u0621-\u064A ]+$').hasMatch(value)) {
      return "$fieldName must contain Arabic letters only";
    }
    return null;
  }

  static String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Name is required';
    } else if (value.length < 2) {
      return 'Name must be at least 2 characters long';
    }
    return null;
  }

  static String? validateUserName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Username is required';
    } else if (value.length < 3) {
      return 'Username must be at least 3 characters long';
    } else if (!RegExp(r'^[a-zA-Z0-9_]+$').hasMatch(value)) {
      return 'Username can only contain letters, numbers, and underscores';
    }
    return null;
  }

  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    } else if (!RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(value)) {
      return 'Enter a valid email address';
    }
    return null;
  }

  static String? validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Phone number is required';
    } else if (!RegExp(r'^\+?[0-9]{10,15}$').hasMatch(value)) {
      return 'Enter a valid phone number';
    }
    return null;
  }

  static String? validatePassword(String? value) {
    if (value!.isEmpty) {
      return 'Password is required';
    }
    return null;
  }
}
