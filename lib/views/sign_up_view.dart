import 'package:provider/provider.dart';
import 'package:dealflow_coding_assignment/controllers/sign_up_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'login_view.dart';

class SignUpView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SignUpViewState();
  }
}

class SignUpViewState extends State<SignUpView> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  FocusNode usernameNode = FocusNode();
  FocusNode emailNode = FocusNode();
  FocusNode passwordNode = FocusNode();
  FocusNode confirmPasswordNode = FocusNode();
  bool rememberMe = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: Scaffold(
            key: _scaffoldKey,
            body: Padding(
              padding: EdgeInsets.only(left: 16.0, right: 16.0),
              child: ListView(
                physics: BouncingScrollPhysics(),
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/10, left: 16),
                        child: const Text(
                          "Create",
                          style: TextStyle(
                              fontSize: 28.0, fontFamily: "Poppins", fontWeight: FontWeight.bold),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 16.0),
                        child: Text(
                          "Account",
                          style: TextStyle(
                              fontSize: 28.0, fontFamily: "Poppins", fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding:
                    const EdgeInsets.only(left: 16.0, right: 16.0, top: 30.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        TextFormField(
                            autocorrect: false,
                            controller: usernameController,
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.next,
                            style: const TextStyle(fontSize: 16.0),
                            focusNode: usernameNode,
                            onFieldSubmitted: (value) {
                              usernameNode.unfocus();
                              FocusScope.of(context).requestFocus(emailNode);
                            },
                            decoration: const InputDecoration(
                              labelText: "Username",
                              hintText:
                              "john97",),
                          ),
                        Padding(
                          padding: EdgeInsets.only(top: 12.0),
                          child: TextFormField(
                              autocorrect: false,
                              controller: emailController,
                              keyboardType: TextInputType.text,
                              textInputAction: TextInputAction.next,
                              style: TextStyle(fontSize: 16.0),
                              focusNode: emailNode,
                              onFieldSubmitted: (value) {
                                emailNode.unfocus();
                                FocusScope.of(context).requestFocus(passwordNode);
                              },
                            decoration: const InputDecoration(
                              labelText: "Email",
                              labelStyle: TextStyle(color: Colors.black),
                              hintText:
                              "john.doe@connexease.com",),
                              ),
                        ),
                    Padding(
                      padding: const EdgeInsets.only(top: 12.0),
                      child: TextFormField(
                                autocorrect: false,
                                controller: passwordController,
                                keyboardType: TextInputType.text,
                                textInputAction: TextInputAction.done,
                                style: TextStyle(fontSize: 16.0),
                                obscureText: context.watch<SignUpController>().showPassword,
                                focusNode: passwordNode,
                                onFieldSubmitted: (value) async {
                                  passwordNode.unfocus();
                                  FocusScope.of(context).requestFocus(confirmPasswordNode);
                                },
                                decoration: InputDecoration(
                                  labelText: 'Password',
                                  suffix: context.watch<SignUpController>().showPassword
                                      ? InkWell(
                                        child: const Icon(
                                    Icons.visibility_off,),
                                    onTap: () {
                                      context.read<SignUpController>().updateShowPassword(value: false);
                                    },
                                      )
                                      : InkWell(
                                        child: const Icon(Icons.visibility,),
                                    onTap: ()=> context.read<SignUpController>().updateShowPassword(value: true),
                                      ),
                                ),
                              ),
                    ),
                        Padding(
                          padding: const EdgeInsets.only(top: 12.0),
                          child: TextFormField(
                                autocorrect: false,
                                controller: confirmPasswordController,
                                keyboardType: TextInputType.text,
                                textInputAction: TextInputAction.next,
                                style: const TextStyle(fontSize: 16.0),
                                obscureText: context.watch<SignUpController>().showPassword,
                                focusNode: confirmPasswordNode,
                                onFieldSubmitted: (value) async {
                                  confirmPasswordNode.unfocus();
                                },
                                decoration: InputDecoration(
                                  labelText: 'Confirm Password',
                                  suffix: context.watch<SignUpController>().showPassword
                                      ? InkWell(
                                    child: const Icon(
                                      Icons.visibility_off,),
                                    onTap: () {
                                      context.read<SignUpController>().updateShowPassword(value: false);
                                    },
                                  )
                                      : InkWell(
                                    child: const Icon(Icons.visibility,),
                                    onTap: ()=> context.read<SignUpController>().updateShowPassword(value: true),
                                  ),
                                ),
                              ),
                        ),
                      Padding(
                            padding: EdgeInsets.only(top: 15.0, bottom: 16.0),
                            child: InkWell(
                              child: Container(
                                width: MediaQuery.of(context).size.width - (30),
                                height: 50.0,
                                decoration:
                                BoxDecoration(borderRadius: BorderRadius.circular(15.0), color: Color(0xff710193)),
                                child: const Center(
                                  child: Text(
                                    "Sign Up",
                                    style: TextStyle(
                                        fontSize: 20.0,
                                        fontFamily: "Poppins",
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white),
                                  ),
                                ),
                              ),
                              onTap: () {
                                if (passwordController.text != confirmPasswordController.text) {
                                  showSnackBar();
                                } else {
                                  context.read<SignUpController>().addNewCreator(usernameController.text, passwordController.text, emailController.text).then(
                                          (value) =>  Navigator.push(
                                            context,
                                            MaterialPageRoute(builder: (context) => LoginView()),
                                          ));
                                }
                              },
                            ),
                        ),
                        Row(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
                          const Padding(
                            padding: EdgeInsets.only(left: 8.0, right: 10.0),
                            child: Text(
                              "Already have an account?",
                              style: TextStyle(fontFamily: "Poppins", fontSize: 16.0, color: Colors.grey),
                            ),
                          ),
                          InkWell(
                            child: const Padding(
                              padding: EdgeInsets.only(
                                  right: 8.0,
                                  top: 4.0,
                                  bottom: 4.0),
                              child: Text(
                                "Log in",
                                style: TextStyle(
                                  decoration: TextDecoration.underline,
                                    fontSize: 16,//Theme.of(context).primaryTextTheme.display2!.fontSize,
                                    fontFamily: "Poppins",
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xff710193)),
                              ),
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => LoginView()),
                              );
                            },
                          ),
                        ])
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
  }

  void showSnackBar() {
    final snackBarContent = SnackBar(
      backgroundColor: Colors.red,
      content: Text('Please check your password'),
      duration: Duration(seconds: 1),
    );
    _scaffoldKey.currentState!.showSnackBar(snackBarContent);
  }
}