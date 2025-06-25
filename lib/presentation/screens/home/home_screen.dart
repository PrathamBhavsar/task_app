import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../utils/constants/app_constants.dart';
import '../../../utils/enums/user_role.dart';
import '../../../utils/extensions/padding.dart';
import '../../blocs/home/home_bloc.dart';
import '../../blocs/home/home_event.dart';
import '../../blocs/home/home_state.dart';
import '../../widgets/selection_drawer.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.white,
          drawer: const SelectionDrawer(),
          appBar:
              state.barIndex == 0
                  ? AppBar(title: Text(state.currentTitle))
                  : null,
          bottomNavigationBar: BottomNavigationBar(
            backgroundColor: Colors.white,
            elevation: 0,
            showUnselectedLabels: true,
            selectedItemColor: Colors.black,
            unselectedItemColor: AppColors.accent,
            selectedLabelStyle: TextStyle(color: Colors.black),
            unselectedLabelStyle: TextStyle(color: AppColors.secondary),
            currentIndex: state.barIndex,
            onTap: (i) => context.read<HomeBloc>().add(SetBarIndexEvent(i)),
            items: [
              BottomNavigationBarItem(
                backgroundColor: Colors.white,
                icon: Icon(Icons.dashboard),
                label: "Dashboard",
              ),
              BottomNavigationBarItem(
                backgroundColor: Colors.white,
                icon: Icon(Icons.task),
                label: "Tasks",
              ),
              BottomNavigationBarItem(
                backgroundColor: Colors.white,
                icon: Icon(Icons.person),
                label: "Customers",
              ),
              if (state.userRole == UserRole.admin)
                BottomNavigationBarItem(
                  backgroundColor: Colors.white,
                  icon: Icon(Icons.business),
                  label: "Agencies",
                ),
              BottomNavigationBarItem(
                backgroundColor: Colors.white,
                icon: Icon(Icons.receipt),
                label: "Bills",
              ),
            ],
          ),
          body: SafeArea(
            child: state.currentPage.padAll(AppPaddings.appPaddingInt),
          ),
        );
      },
    );
  }
}
