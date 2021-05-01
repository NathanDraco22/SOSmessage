import 'package:flutter/material.dart';
import 'package:sos_message/src/pages/config_page.dart';
import 'package:sos_message/src/pages/home_page.dart';

import 'package:provider/provider.dart';
import 'package:sos_message/src/pages/intro_page.dart';
import 'package:sos_message/src/providers/contact_provider.dart';
import 'package:sos_message/src/providers/preferences.dart';


main(List<String> args) async{

  WidgetsFlutterBinding.ensureInitialized();

  final pref = new Preferences();

  await pref.initPreferences();

  runApp(new SOSapp());

}


class SOSapp extends StatelessWidget{

  @override
  Widget build(BuildContext context) {

    final pref = new Preferences();

    final bool intro = pref.firstInApp;

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ContactProvider() )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: (intro) ?"intro":"/",
        routes: {
          "/"        : (_) => HomePage(),
          "settings" : (_) => SetPage(),
          "intro"    : (_) => Intro()
        },
        theme: ThemeData.dark(),
      ),
    );
  }
}