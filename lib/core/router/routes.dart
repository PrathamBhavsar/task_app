import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../domain/entities/task.dart';
import '../../domain/entities/user.dart';
import '../../presentation/screens/agency/agency_detail_page.dart';
import '../../presentation/screens/agency/new_agency_screen.dart';
import '../../presentation/screens/auth/auth_screen.dart';
import '../../presentation/screens/bill/review_bill_screen.dart';
import '../../presentation/screens/customer/new_client_screen.dart';
import '../../presentation/screens/home/home_screen.dart';
import '../../presentation/screens/measurement/measurement_screen.dart';
import '../../presentation/screens/quote/edit_quote_screen.dart';
import '../../presentation/screens/splash/splash_screen.dart';
import '../../presentation/screens/task/edit_task_page.dart';
import '../../presentation/screens/task/task_detail_page.dart';
import '../../utils/constants/app_constants.dart';
import 'args.dart';

final List<GoRoute> appRoutes = [
  GoRoute(
    path: AppRoutes.splash,
    pageBuilder: (context, state) => _slideTransition(SplashScreen(), state),
  ),
  GoRoute(
    path: AppRoutes.auth,
    pageBuilder: (context, state) => _slideTransition(AuthScreen(), state),
  ),
  GoRoute(
    path: AppRoutes.home,
    pageBuilder: (context, state) => _slideTransition(HomeScreen(), state),
  ),
  GoRoute(
    path: AppRoutes.agencyDetails,
    pageBuilder: (context, state) {
      final agency = state.extra as User;
      return _slideTransition(AgencyDetailPage(agency: agency), state);
    },
  ),
  GoRoute(
    path: AppRoutes.taskDetails,
    pageBuilder: (context, state) {
      // final Task? task = state.extra as Task?;
      final Task task = state.extra as Task;
      return _slideTransition(TaskDetailPage(task: task), state);
    },
  ),
  GoRoute(
    path: AppRoutes.editTask,
    pageBuilder: (context, state) {
      final data = state.extra as Map<String, dynamic>;
      return _slideTransition(
        EditTaskPage(task: data['task'], isNew: data['isNew']),
        state,
      );
    },
  ),
  GoRoute(
    path: AppRoutes.measurement,
    pageBuilder: (context, state) {
      final data = state.extra as MeasurementArgs;

      return _slideTransition(MeasurementScreen(task: data.task), state);
    },
  ),
  GoRoute(
    path: AppRoutes.newCustomer,
    pageBuilder: (context, state) => _slideTransition(NewClientScreen(), state),
  ),
  GoRoute(
    path: AppRoutes.editAgency,
    pageBuilder: (context, state) {
      final User? agent = state.extra as User?;
      return _slideTransition(NewAgencyScreen(agent: agent), state);
    },
  ),
  GoRoute(
    path: AppRoutes.reviewBill,
    pageBuilder:
        (context, state) => _slideTransition(ReviewBillScreen(), state),
  ),
  // GoRoute(
  //   path: AppRoutes.quoteDetails,
  //   pageBuilder: (context, state) {
  //     // final quote = state.extra as Quote;
  //     final quote = Quote.sampleQuotes.first;
  //     return _slideTransition(QuoteDetailsScreen(quote: quote), state);
  //   },
  // ),
  GoRoute(
    path: AppRoutes.editQuote,
    pageBuilder: (context, state) {
      final Task task = state.extra as Task;

      return _slideTransition(EditQuoteScreen(task: task), state);
    },
  ),
];

Page<dynamic> _slideTransition(Widget screen, GoRouterState state) =>
    CustomTransitionPage(
      key: state.pageKey,
      child: screen,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.easeInOut;

        var tween = Tween(
          begin: begin,
          end: end,
        ).chain(CurveTween(curve: curve));
        var offsetAnimation = animation.drive(tween);

        return SlideTransition(position: offsetAnimation, child: child);
      },
    );
