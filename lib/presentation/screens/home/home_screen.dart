import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../utils/constants/app_constants.dart';
import '../../../utils/extensions/padding.dart';

import '../../providers/home_provider.dart';
import '../../widgets/selection_drawer.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final homeProvider = Provider.of<HomeProvider>(context);

    return Scaffold(
      drawer: const SelectionDrawer(),
      appBar: AppBar(
        title: Text("Dashboard", style: AppTexts.titleTextStyle),
        forceMaterialTransparency: true,
      ),
      body: SingleChildScrollView(
        child: homeProvider.firstPage.padAll(AppPaddings.appPaddingInt),
      ),
    );
  }
}
