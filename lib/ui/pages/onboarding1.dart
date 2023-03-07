import 'package:learncoding/api/shared_preference/shared_preference.dart';
import 'package:learncoding/theme/box_icons_icons.dart';
import 'package:learncoding/ui/pages/navmenu/menu_dashboard_layout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:learncoding/api/google_signin_api.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Onboarding extends StatefulWidget {
  @override
  _OnboardingState createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  final PageController controller = PageController(initialPage: 0);

  int counter = 0;
  List<Widget> pictures = [];
  List<Widget> messages = [];
  List<Widget> buttons = [];
  late Widget displayedPicture;
  late Widget displayedMessage;
  late Widget displayedButton;

  @override
  void initState() {
    super.initState();
    // signin();
  }

  void createWidgets() {
    pictures.addAll([
      buildSvgPicture('assets/images/freelancer.svg'),
      buildSvgPicture('assets/images/recess.svg'),
      buildSvgPicture('assets/images/knowledge.svg'),
    ]);

    Widget button;
    button = buildButton("Next", () {
      counter++;
      setState(() {
        displayedPicture = pictures[counter];
        displayedMessage = messages[counter];
        displayedButton = buttons[counter];
      });
    });
    buttons.add(button);
    button = buildButton("Next", () {
      counter++;
      setState(() {
        displayedPicture = pictures[counter];
        displayedMessage = messages[counter];
        displayedButton = buttons[counter];
      });
    });
    buttons.add(button);
    buttons.add(
      buildButton("Get started", signin),
    );

    messages.addAll([
      buildMessage(
        "Learn anytime, and anywhere",
        "Lorem ipsum dolor sit amet consectetur"
            " adipiscing elit Ut et massa mi. Aliquam in hendrerit.",
      ),
      buildMessage(
        "Unleash Your Creativity and Compete with Style",
        "Lorem ipsum dolor sit amet consectetur"
            " adipiscing elit Ut et massa mi. Aliquam in hendrerit.",
      ),
      buildMessage(
          "High quality lectures and unlimited questions",
          "Lorem ipsum dolor sit amet consectetur"
              " adipiscing elit Ut et massa mi. Aliquam in hendrerit.")
    ]);

    displayedPicture = pictures[counter];
    displayedMessage = messages[counter];
    displayedButton = buttons[counter];
  }

  Widget buildMessage(String mainMessage, String subMessage) {
    return SizedBox(
      key: UniqueKey(),
      height: 150,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40.0),
        child: Column(
          children: <Widget>[
            Text(
              mainMessage,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
            const Spacer(),
            Text(
              subMessage,
              overflow: TextOverflow.fade,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 13,
              ),
            ),
          ],
        ),
      ),
    );
  }

  SizedBox buildButton(String label, VoidCallback onTap) {
    return SizedBox(
      key: UniqueKey(),
      width: 200,
      height: 50,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF0396FF), Color.fromARGB(255, 133, 204, 255)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Center(
            child: Text(
              label,
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildSvgPicture(String assetName) {
    return SizedBox(
      key: UniqueKey(),
      height: MediaQuery.of(context).size.height * 0.4,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: SvgPicture.asset(assetName),
      ),
    );
  }

  Widget buildPageControlDots(int currentPageNumber) {
    return Row(
      key: UniqueKey(),
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        for (var index = 0; index < 3; index++)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: CircleAvatar(
              radius: 4,
              backgroundColor: index == currentPageNumber ? Colors.blue : Colors.blue[100],
            ),
          )
      ],
    );
  }

  Future signin() async {
    try {
      final user = await GoogleSignInApi.login();
      String? name = user!.displayName;
      String? image = user.photoUrl;

      // SharedPreferences pref = await SharedPreferences.getInstance();
      UserPreferences.setuser(image!, name!);
    } catch (error) {
      // console.error("Error during login: ", error);
      UserPreferences.setuser(
          "https://www.gravatar.com/avatar/205e460b479e2e5b48aec07710c08d50",
          "testDisplayName");
    }

    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => (MenuDashboardLayout())));
  }

  @override
  Widget build(BuildContext context) {
    createWidgets();
    return CupertinoPageScaffold(
      child: Column(
        children: <Widget>[
          const Spacer(),
          AnimatedSwitcher(
            duration: const Duration(seconds: 1),
            child: displayedPicture,
          ),
          const Spacer(),
          AnimatedSwitcher(
            duration: const Duration(seconds: 1),
            child: displayedMessage,
          ),
          const Spacer(),
          AnimatedSwitcher(
            duration: const Duration(seconds: 1),
            child: buildPageControlDots(counter),
          ),
          const Spacer(),
          AnimatedSwitcher(
            duration: const Duration(seconds: 1),
            child: displayedButton,
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
