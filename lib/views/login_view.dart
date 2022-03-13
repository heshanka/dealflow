import 'package:dealflow_coding_assignment/controllers/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/src/provider.dart';

import 'home.dart';

class LoginView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LoginViewState();
  }
}

class LoginViewState extends State<LoginView> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  FocusNode usernameNode = FocusNode();
  FocusNode passwordNode = FocusNode();
  bool rememberMe = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    LoginController loginController = LoginController();
    //double logoPadding = Utils.screenRealEstate(context, hasNavBar: false, hasAppBar: false) * 0.1;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      child: Scaffold(
        key: _scaffoldKey,
        body: ListView(
          physics: const BouncingScrollPhysics(),
          children: <Widget>[
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/10, left: 16, bottom: 20),
                child: CircleAvatar(
                  backgroundColor: Color(0xffebcbf4),
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back_rounded, color: Color(0xff710193),),
                    onPressed: () { Navigator.pop(context);},
                  ),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 16, left: 16, bottom: 20),
              child: Text(
                "Welcome Back!",
                style: TextStyle(
                    fontSize: 28.0, fontFamily: "Poppins", fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  TextFormField(
                      autocorrect: false,
                      controller: usernameController,
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      focusNode: usernameNode,
                      onFieldSubmitted: (value) {
                        usernameNode.unfocus();
                        FocusScope.of(context).requestFocus(passwordNode);
                      },
                      decoration: const InputDecoration(
                        prefixIcon: Icon(
                          Icons.person,
                        ),
                        labelText: 'Username',
                      ),
                    ),
                  Padding(
                    padding: const EdgeInsets.only(top: 12.0),
                    child: TextFormField(
                          autocorrect: false,
                          controller: passwordController,
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.done,
                          obscureText: !context.watch<LoginController>().showPassword,
                          focusNode: passwordNode,
                          onFieldSubmitted: (value) async {
                            await loginMethod(context, loginController);
                          },
                          decoration: InputDecoration(
                            prefixIcon: const Icon(
                              Icons.lock,
                            ),
                            labelText: 'Password',
                            suffix: context.watch<LoginController>().showPassword
                                ? InkWell(
                              child: const Icon(
                                Icons.visibility,),
                              onTap: () {
                                context.read<LoginController>().updateShowPassword(value: false);
                              },
                            )
                                : InkWell(
                              child: const Icon(Icons.visibility_off,),
                              onTap: ()=> context.read<LoginController>().updateShowPassword(value: true),
                            ),
                            ),),
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
                            "Log in",
                            style: TextStyle(
                                fontSize: 20.0,
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.w500,
                                color: Colors.white),
                          ),
                        ),
                      ),
                      onTap: () async {
                              await loginMethod(context, loginController).then(
                                  (value) =>  Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => Home()),
                              ));
                        }
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future loginMethod(BuildContext context, LoginController model) async {
    FocusScope.of(context).unfocus();
    String _password = passwordController.text;
    setState(() {
      passwordController.text = "";
    });
    await model.loginRequest(usernameController.text, _password, rememberMe);
    if (model.isSuccess) {
    } else {
      showSnackBar();
    }
  }

  void showSnackBar() {
    final snackBarContent = const SnackBar(
      content: Text(
          'Incorrect username or password'
      ),
      duration: const Duration(seconds: 1),
    );
    //_scaffoldKey.currentState.showSnackBar(snackBarContent);
  }
}
