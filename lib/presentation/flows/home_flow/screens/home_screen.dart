import 'package:base_structure/app+injection/di.dart';
import 'package:base_structure/presentation/flows/home_flow/bloc/home_bloc.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  final bloc = locator<HomeBloc>();

  @override
  void dispose() {
    bloc.close();
    super.dispose();
  }

  @override
  initState() {
    super.initState();
    bloc.makeAction();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}
