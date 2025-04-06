import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../data/models/employee.dart';
import '../../data/models/salon.dart';
import '../../presentation/screens/appointment/appointment_screen.dart';
import '../../presentation/screens/appointment/new_appointment_screen.dart';
import '../../presentation/screens/auth/otp_screen.dart';
import '../../presentation/screens/employee/employee_screen.dart';
import '../../presentation/screens/employee/new_employee_screen.dart';
import '../../presentation/screens/home/home_screen.dart';
import '../../presentation/screens/managers/manager_screen.dart';
import '../../presentation/screens/products/new_product_screen.dart';
import '../../presentation/screens/products/product_screen.dart';
import '../../presentation/screens/reports/report_page.dart';
import '../../presentation/screens/salons/new_salon_screen.dart';
import '../../presentation/screens/salons/salon_screen.dart';
import '../../presentation/screens/services/new_service_screen.dart';
import '../../presentation/screens/services/service_screen.dart';
import '../../presentation/screens/supervisors/supervisor_screen.dart';
import '../../presentation/screens/transactions/new_transaction_screen.dart';
import '../../presentation/screens/transactions/transactions_screen.dart';

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

abstract class AppRouter {
  static GoRouter router() => GoRouter(
    initialLocation: '/home',
    routes: [
      GoRoute(
        path: '/otp',
        name: 'otp',
        pageBuilder: (context, state) => _slideTransition(OtpScreen(), state),
      ),
      GoRoute(
        path: '/home',
        name: 'home',
        pageBuilder: (context, state) => _slideTransition(HomeScreen(), state),
      ),
      GoRoute(
        path: '/appointment',
        name: 'appointment',
        pageBuilder:
            (context, state) => _slideTransition(AppointmentScreen(), state),
      ),
      GoRoute(
        path: '/newAppointment',
        name: 'newAppointment',
        pageBuilder:
            (context, state) => _slideTransition(NewAppointmentScreen(), state),
      ),
      GoRoute(
        path: '/employee',
        name: 'employee',
        pageBuilder:
            (context, state) => _slideTransition(EmployeeScreen(), state),
      ),
      GoRoute(
        path: '/newEmployee',
        name: 'newEmployee',
        pageBuilder: (context, state) {
          final employee = state.extra as Employee?;
          return _slideTransition(NewEmployeeScreen(employee: employee), state);
        },
      ),
      GoRoute(
        path: '/salon',
        name: 'salon',
        pageBuilder: (context, state) => _slideTransition(SalonScreen(), state),
      ),
      GoRoute(
        path: '/newSalon',
        name: 'newSalon',
        pageBuilder: (context, state) {
          final salon = state.extra as Salon?;
          return _slideTransition(NewSalonScreen(salon: salon), state);
        },
      ),
      GoRoute(
        path: '/transaction',
        name: 'transaction',
        pageBuilder:
            (context, state) => _slideTransition(TransactionsScreen(), state),
      ),
      GoRoute(
        path: '/newTransaction',
        name: 'newTransaction',
        pageBuilder:
            (context, state) => _slideTransition(NewTransactionScreen(), state),
      ),
      GoRoute(
        path: '/service',
        name: 'service',
        pageBuilder:
            (context, state) => _slideTransition(ServiceScreen(), state),
      ),
      GoRoute(
        path: '/newService',
        name: 'newService',
        pageBuilder:
            (context, state) => _slideTransition(NewServiceScreen(), state),
      ),
      GoRoute(
        path: '/report',
        name: 'report',
        pageBuilder: (context, state) => _slideTransition(ReportPage(), state),
      ),
      GoRoute(
        path: '/product',
        name: 'product',
        pageBuilder:
            (context, state) => _slideTransition(ProductScreen(), state),
      ),
      GoRoute(
        path: '/newProduct',
        name: 'newProduct',
        pageBuilder:
            (context, state) => _slideTransition(NewProductScreen(), state),
      ),
      GoRoute(
        path: '/supervisor',
        name: 'supervisor',
        pageBuilder:
            (context, state) => _slideTransition(SupervisorScreen(), state),
      ),
      GoRoute(
        path: '/manager',
        name: 'manager',
        pageBuilder:
            (context, state) => _slideTransition(ManagerScreen(), state),
      ),
    ],
  );
}
