// import 'package:educational_institute/core/common/widgets/buttons/circular_back_button.dart';
// import 'package:educational_institute/core/utils/constants/app_colors.dart';
// import 'package:educational_institute/core/utils/constants/sizes.dart';
// import 'package:educational_institute/core/utils/device/device_utility.dart';
// import 'package:educational_institute/core/utils/helpers/helper_functions.dart';
// import 'package:flutter/material.dart';

// class HottestNewsHeader extends StatefulWidget {
//   const HottestNewsHeader({
//     super.key,
//     required this.tag,
//     required this.image,
//     required this.title,
//   });

//   final String tag;
//   final String image;
//   final String title;

//   @override
//   State<HottestNewsHeader> createState() => _HottestNewsHeaderState();
// }

// class _HottestNewsHeaderState extends State<HottestNewsHeader>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//   late Animation<Offset> _offsetAnimation;

//   @override
//   void initState() {
//     super.initState();
//     _controller = AnimationController(
//       duration: const Duration(seconds: 1),
//       vsync: this,
//     );

//     _offsetAnimation = Tween<Offset>(
//       begin: const Offset(1.0, 0.0), // Start off-screen to the right
//       end: const Offset(0.0, 0.0), // End at original position
//     ).animate(CurvedAnimation(
//       parent: _controller,
//       curve: Curves.easeInOut,
//     ));

//     _controller.forward();
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: double.infinity,
//       height: HelperFunctions.screenHeight(context) * 0.55,
//       color: Colors.transparent,
//       child: Stack(
//         children: [
//           Hero(
//             tag: widget.tag,
//             child: Image.asset(
//               widget.image,
//               fit: BoxFit.cover,
//               width: double.infinity,
//               height: HelperFunctions.screenHeight(context) * 0.55,
//             ),
//           ),
//           Positioned(
//               top: DeviceUtils.getAppBarBarHeight(),
//               left: HelperFunctions.screenWidth(context) *
//                   AppSizes.horizintalMarginPercent,
//               child: const CircularBackButton()),
//           Positioned(
//             left: HelperFunctions.screenWidth(context) *
//                 AppSizes.horizintalMarginPercent,
//             bottom: DeviceUtils.getAppBarBarHeight(),
//             right: HelperFunctions.screenWidth(context) *
//                 AppSizes.horizintalMarginPercent *
//                 2,
//             child: SlideTransition(
//               position: _offsetAnimation,
//               child: Text(
//                 widget.title,
//                 style: Theme.of(context).textTheme.headlineLarge!.copyWith(
//                     color: AppColors.white, fontWeight: FontWeight.w500),
//                 maxLines: 3,
//                 overflow: TextOverflow.ellipsis,
//                 softWrap: true,
//                 textAlign: TextAlign.start,
//               ),
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
