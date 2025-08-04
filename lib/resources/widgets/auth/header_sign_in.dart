
import 'package:flutter/material.dart';

import '../../constants.dart';

class HeaderSignIn extends StatelessWidget {
  const HeaderSignIn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(32, 32, 32, 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Welcome to", style: txtSemiBold(18)),
              Text("Amazin Chat", style: txtSemiBold(32, primaryColor)),
            ],
          ),
          const Spacer(),
          Hero(
            tag: amzChatIcon,
            child: Image.asset(
              amzChatIcon,
              height: 60,
              width: 60,
            ),
          ),
        ],
      ),
    );
  }
}


