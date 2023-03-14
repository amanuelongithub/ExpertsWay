import 'package:flutter/material.dart';

import 'package:learncoding/main.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:learncoding/api/google_signin_api.dart';
import 'package:learncoding/ui/widgets/header.dart';
import 'package:learncoding/utils/color.dart';
import 'package:shared_preferences/shared_preferences.dart';

String? title;

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  Widget _container(IconData leading, title, IconData trailing) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        // borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
              blurRadius: 10,
              offset: Offset(1, 1),
              color: Color.fromARGB(54, 104, 104, 104))
        ],
        borderRadius: BorderRadius.circular(radius),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () async {
            if (title == 'Logout') {
              SharedPreferences pre = await SharedPreferences.getInstance();
              await pre.remove('name');
              await pre.remove('image');
              pre.clear();
              GoogleSignInApi.logout();

              // ignore: use_build_context_synchronously
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => const RestartWidget(child: (MyApp()))));
            }
          },
          highlightColor: const Color.fromARGB(132, 135, 208, 245),
          splashColor: const Color.fromARGB(61, 231, 231, 231),
          borderRadius: BorderRadius.circular(radius),
          child: ListTile(
            leading: Container(
              width: 35,
              height: 35,
              decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 233, 233, 233),
                  borderRadius: BorderRadius.circular(radius)),
              child: Icon(
                leading,
                color: maincolor,
                size: 18,
              ),
            ),
            title: Text(
              title,
              style: const TextStyle(
                  color: Color.fromARGB(255, 137, 137, 137),
                  fontSize: 18,
                  fontWeight: FontWeight.w500),
            ),
            trailing: Icon(
              trailing,
              color: Colors.grey,
              size: 17,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 60.0),
        child: Column(
          children: [
            const Header(title: "Settings"),
            const SizedBox(
              height: 10,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 25),
              child: Column(
                children: [
                  _container(
                    Icons.cleaning_services,
                    'Clear data',
                    Icons.arrow_forward_ios,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  _container(
                    FontAwesomeIcons.rectangleAd,
                    'ad',
                    Icons.arrow_forward_ios,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  _container(
                    FontAwesomeIcons.coins,
                    'How do you earn coin',
                    Icons.arrow_forward_ios,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  _container(
                    Icons.logout,
                    'Logout',
                    Icons.arrow_forward_ios,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
