import 'package:educational_institute/features/calender/presentation/view_models/year_month_picker_cubit/year_month_picker_cubit.dart';
import 'package:educational_institute/features/calender/presentation/views/schedule_view/schedule_view.dart';
import 'package:educational_institute/features/home/presentation/view_models/dots_cubit.dart';
import 'package:educational_institute/features/home/presentation/view_models/navigation_cubit/navigation_cubit.dart';
import 'package:educational_institute/features/home/presentation/views/course_details/course_details.dart';
import 'package:educational_institute/features/home/presentation/views/full_video/video_screen.dart';
import 'package:educational_institute/features/home/presentation/views/hottest_news/hottest_news_view.dart';
import 'package:educational_institute/features/home/presentation/views/teacher_details/teacher_details.dart';
import 'package:educational_institute/features/home/presentation/views/home_view/widgets/teacher_info_item.dart';
import 'package:educational_institute/features/login/presentation/views/login_view.dart';
import 'package:educational_institute/features/pleacment_test/presentation/view_models/subject_cubit.dart';
import 'package:educational_institute/features/pleacment_test/presentation/views/email_verification/email_verification_view.dart';
import 'package:educational_institute/features/pleacment_test/presentation/views/pleacment_test/pleacment_test.dart';
import 'package:educational_institute/navigation_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

abstract class AppRouter {
  static const kNavigationMenu = "/";
  static const kTeacherDetails = "/teacherDetails";
  static const kHottestNewsView = "/hottestNewsView";
  static const kCourseDetailsView = "/kCourseDetailsView";
  static const kPlacementTestView = "/kPlacementTestView";
  static const kEmailVerificationView = "/kEmailVerificationView";
  static const kFullScreenVideo = "/fullScreenVideo";
  static const kLoginView = "/kLoginView";
  static const kscheduleView = "/kScheduleView";

  static GoRouter router() {
    return GoRouter(
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => NavigationCubit(),
              ),
              BlocProvider(
                create: (context) => DotsCubit(),
              ),
              BlocProvider(
                create: (context) => SubjectCubit(),
              ),
              BlocProvider(
                create: (context) => YearMonthPickerCubit(
                    DateTime.now().year, DateTime.now().month),
              ),
              //BlocProvider(create: (context) => EventCubit()),
            ],
            child: const NavigationMenu(),
          ),
        ),
        GoRoute(
          path: kTeacherDetails,
          pageBuilder: (context, state) {
            final tranObject = state.extra as Tranobj;

            return CustomTransitionPage(
              key: state.pageKey,
              child: BlocProvider(
                create: (context) => DotsCubit(),
                child: TeacherDetails(
                  image: tranObject.image,
                  heroTag: tranObject.tag,
                ),
              ),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                return FadeTransition(
                  opacity: animation,
                  child: ScaleTransition(
                    scale: animation,
                    child: child,
                  ),
                );
              },
            );
          },
        ),
        GoRoute(
          path: kHottestNewsView,
          pageBuilder: (context, state) {
            final extra = state.extra as Map<String, String>;
            return CustomTransitionPage(
              key: state.pageKey,
              child: HottestNewsView(
                url: extra['url']!,
                tag: extra['tag']!,
                title: extra['title']!,
              ),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                return FadeTransition(
                  opacity: animation,
                  child: ScaleTransition(
                    scale: animation,
                    child: child,
                  ),
                );
              },
            );
          },
        ),
        GoRoute(
          path: kFullScreenVideo,
          pageBuilder: (context, state) {
            final videoUrl = state.extra as String;
            return CustomTransitionPage(
              key: state.pageKey,
              child: FullScreenVideoPlayerScreen(videoUrl: videoUrl),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                return FadeTransition(
                  opacity: animation,
                  child: ScaleTransition(
                    scale: animation,
                    child: child,
                  ),
                );
              },
            );
          },
        ),
        GoRoute(
          path: kCourseDetailsView,
          pageBuilder: (context, state) {
            final tranObject = state.extra as Tranobj;
            return CustomTransitionPage(
              key: state.pageKey,
              child: CourseDetailsView(
                  image: tranObject.image,
                  tag: tranObject.tag,
                  title: tranObject.text),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                return FadeTransition(
                  opacity: animation,
                  child: ScaleTransition(
                    scale: animation,
                    child: child,
                  ),
                );
              },
            );
          },
        ),
        GoRoute(
          path: kPlacementTestView,
          pageBuilder: (context, state) {
            return CustomTransitionPage(
              key: state.pageKey,
              child: BlocProvider(
                create: (context) => SubjectCubit(),
                child: const PlacementTest(),
              ),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                return FadeTransition(
                  opacity: animation,
                  child: ScaleTransition(
                    scale: animation,
                    child: child,
                  ),
                );
              },
            );
          },
        ),
        GoRoute(
          path: kEmailVerificationView,
          pageBuilder: (context, state) {
            return CustomTransitionPage(
              key: state.pageKey,
              child: const EmailVerificationView(),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                return FadeTransition(
                  opacity: animation,
                  child: ScaleTransition(
                    scale: animation,
                    child: child,
                  ),
                );
              },
            );
          },
        ),
        GoRoute(
          path: kLoginView,
          pageBuilder: (context, state) {
            return CustomTransitionPage(
              key: state.pageKey,
              child: const LoginView(),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                return FadeTransition(
                  opacity: animation,
                  child: ScaleTransition(
                    scale: animation,
                    child: child,
                  ),
                );
              },
            );
          },
        ),
        GoRoute(
          path: kscheduleView,
          pageBuilder: (context,state) {
            final selectedMonth = state.extra as DateTime;
            return CustomTransitionPage(
              key: state.pageKey,
              child:  ScheduleView(selectedMonth: selectedMonth,),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                return FadeTransition(
                  opacity: animation,
                  child: ScaleTransition(
                    scale: animation,
                    child: child,
                  ),
                );
              },
            );
          },
        ),
      ],
    );
  }
}
