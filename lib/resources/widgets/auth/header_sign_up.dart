import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../constants.dart';

class HeaderSignUp extends StatelessWidget {
  const HeaderSignUp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Row(
        children: [
          InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                color: primaryColor, // Nền cam
                borderRadius: BorderRadius.circular(8), // Hình vuông bo nhẹ
              ),
              padding: EdgeInsets.all(6),
              child: SvgPicture.asset(
                backIcon,
                width: 20,
                height: 20,
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(width: 32),
          Text("Create your account", style: txtSemiBold(18)),
        ],
      ),
    );
  }
}
