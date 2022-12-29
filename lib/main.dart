import 'package:learncoding/ui/pages/help.dart';
import 'package:learncoding/ui/pages/navmenu/dashboard.dart';
import 'package:learncoding/ui/pages/onboarding1.dart';
import 'package:learncoding/ui/pages/profile.dart';
import 'package:learncoding/ui/pages/setting.dart';
import 'package:learncoding/ui/pages/undefinedScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:learncoding/global/globals.dart' as globals;
import 'package:learncoding/routes/router.dart' as router;
import 'package:shared_preferences/shared_preferences.dart';

late SharedPreferences prefs;
Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SharedPreferences.getInstance().then((prefs) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
        .then((value) => runApp(
              RestartWidget(
                child: MyApp(),
              ),
            ));
  });
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  void getLoginStatus() async {
    prefs = await SharedPreferences.getInstance();
    globals.gAuth.googleSignIn.isSignedIn().then((value) {
      prefs.setBool("isLoggedin", value);
    });
  }

  @override
  void initState() {
    getLoginStatus();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      onGenerateRoute: router.generateRoute,
      onUnknownRoute: (settings) => CupertinoPageRoute(
          builder: (context) => UndefinedScreen(
                name: settings.name,
              )),
      // theme: Provider.of<ThemeModel>(context).currentTheme,
      debugShowCheckedModeBanner: false,
      // home: Settings(),
      home: Profile(),
    );
  }
}

class RestartWidget extends StatefulWidget {
  RestartWidget({this.child});

  final Widget? child;

  static void restartApp(BuildContext context) {
    context.findAncestorStateOfType<_RestartWidgetState>()!.restartApp();
  }

  @override
  _RestartWidgetState createState() => _RestartWidgetState();
}

class _RestartWidgetState extends State<RestartWidget> {
  Key key = UniqueKey();

  void restartApp() {
    setState(() {
      key = UniqueKey();
    });
  }

  @override
  Widget build(BuildContext context) {
    return KeyedSubtree(
      key: key,
      child: widget.child!,
    );
  }
}
