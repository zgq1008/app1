import 'package:flutter/material.dart';
class PersonView extends StatefulWidget {
  const PersonView({super.key});

  @override
  State<PersonView> createState() => _PersonViewState();
}
class _PersonViewState extends State<PersonView> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("我的"),
    );
  }
}