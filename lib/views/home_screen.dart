import 'package:achat/data_source/firebase_services.dart';
import 'package:achat/views/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../controllers/firebase_auth_controller.dart';
import '../resources/constants.dart';
import '../resources/widgets/home/body_home.dart';
import '../resources/widgets/home/header_home.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>{
  FirebaseService firebaseServices = FirebaseService();

  @override
  Widget build(BuildContext context) {
    final user = context
        .watch<FirebaseAuthController>()
        .appUser;
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: primaryColor,
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (_) => SearchScreen()));
          },
          child: SvgPicture.asset(searchIcon,
              height: 24, width: 24, color: Colors.white),
        ),
        body: SafeArea(
          child: Column(
            children: [
              Padding(
                  padding:
                  const EdgeInsets.symmetric (horizontal: 26, vertical: 16),
                  child: HeaderHome(user: user!)),
              Expanded(
                  child: BodyHome(firebaseServices: firebaseServices, user:
                  user)),
            ],
          ),
        ));
  }
}
