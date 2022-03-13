import 'package:dealflow_coding_assignment/controllers/sign_up_controller.dart';
import 'package:dealflow_coding_assignment/views/sign_up_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'controllers/home_controller.dart';
import 'controllers/login_controller.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (_) => LoginController(),
    ),
    ChangeNotifierProvider(
      create: (_) => SignUpController(),
    ),
    ChangeNotifierProvider(
      create: (_) => HomeController(),
    ),
  ], child: MyApp()));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
        inputDecorationTheme: const InputDecorationTheme(
          labelStyle: TextStyle(color: Colors.black, fontFamily: "Poppins", fontSize: 14),
          filled: true,
          fillColor: Color(0xfff0f5fe),
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: Color(0xfff0f5fe),
            ),
            borderRadius: BorderRadius.all(Radius.circular(15)),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xfff0f5fe)),
            borderRadius: BorderRadius.all(Radius.circular(15)),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xfff0f5fe)),
            borderRadius: BorderRadius.all(Radius.circular(15)),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xfff0f5fe)),
            borderRadius: BorderRadius.all(Radius.circular(15)),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xfff0f5fe)),
            borderRadius: BorderRadius.all(Radius.circular(15)),
          ),
        ),
      ),
      home: SignUpView(),
    );
  }
}
