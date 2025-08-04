import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../models/app_user.dart';
import '../../Utils/utils.dart';
import '../../constants.dart';

class HeaderConversation extends StatelessWidget {
  const HeaderConversation({Key? key, required this.receiver})
    : super(key: key);

  final AppUser receiver;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
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
          SizedBox(width: 16),
          CircleAvatar(
            radius: 25,
            backgroundColor: Colors.grey.withOpacity(0.6),
            backgroundImage: receiver.photoUrl != null
                ? NetworkImage(receiver.photoUrl!)
                : null,
            child: receiver.photoUrl != null
                ? null
                : Text(
                    Utils.nameInit(receiver.displayName ?? ""),
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
          ),
          SizedBox(width: 16),
          Text(receiver.displayName ?? "", style: txtSemiBold(18)),
        ],
      ),
    );
  }
}
