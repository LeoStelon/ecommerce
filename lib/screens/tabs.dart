import 'package:ecommerce/constant/colors.dart';
import 'package:ecommerce/screens/cart.dart';
import 'package:ecommerce/screens/home.dart';
import 'package:ecommerce/screens/profile.dart';
import 'package:flutter/material.dart';

class Tabs extends StatefulWidget {
  final int index;
  Tabs({@required this.index});
  @override
  _TabsState createState() => _TabsState();
}

class _TabsState extends State<Tabs> {
  int _selectedIndex = 0;

  final List<Widget> _list = [
    Home(),
    Cart(),
    Profile(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _list[widget.index],
    );
  }
}
