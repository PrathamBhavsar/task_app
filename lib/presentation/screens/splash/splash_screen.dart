import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../providers/home_provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() async {
      await Provider.of<HomeProvider>(context, listen: false).fetchAllData();
      if (mounted) context.goNamed('home');
    });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
}
