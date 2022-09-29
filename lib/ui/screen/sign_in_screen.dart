import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../core/base_view.dart';
import '../../core/enum/view_state.dart';
import '../../core/viewmodel/login_model.dart';
import '../../util/utils.dart';
import '../styling.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<LoginModel>(
      builder: (context, model, child) {
        return SafeArea(
          child: Scaffold(
            backgroundColor: lightGreyColor(),
            body: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Container(
                      height: 120,
                      width: 120,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("assets/images/logo.png"),
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    FractionallySizedBox(
                      widthFactor: 2 / 3,
                      child: Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 8.0),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(8.0)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 4.0,
                              spreadRadius: 0.0,
                              offset: Offset(0.0, 2.0),
                            )
                          ],
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Container(
                              height: 1.0,
                              color: Colors.black12,
                            ),
                            Container(
                              padding: const EdgeInsets.only(
                                left: 16.0,
                                right: 16.0,
                                top: 8.0,
                                bottom: 0.0,
                              ),
                              child: TextField(
                                controller: emailController,
                                textAlign: TextAlign.center,
                                maxLines: 1,
                                keyboardType: TextInputType.emailAddress,
                                textCapitalization: TextCapitalization.none,
                                autocorrect: false,
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Email",
                                  hintStyle: TextStyle(),
                                ),
                              ),
                            ),
                            Container(
                              height: 1.0,
                              color: Colors.black12,
                            ),
                            Container(
                              height: 1.0,
                              color: Colors.black12,
                            ),
                            Container(
                              padding: const EdgeInsets.only(
                                left: 16.0,
                                right: 16.0,
                                top: 8.0,
                                bottom: 0.0,
                              ),
                              child: TextField(
                                controller: passwordController,
                                textAlign: TextAlign.center,
                                maxLines: 1,
                                obscureText: true,
                                keyboardType: TextInputType.text,
                                textCapitalization: TextCapitalization.none,
                                autocorrect: false,
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Mot de passe",
                                  hintStyle: TextStyle(),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    FractionallySizedBox(
                      widthFactor: 2 / 3,
                      child: GestureDetector(
                        onTap: () async {
                          FocusScope.of(context).requestFocus(FocusNode());
                          var failureMessage = await model.login(
                            emailController.text,
                            passwordController.text,
                          );
                          debugPrint("loginFailureMessage : $failureMessage");
                          if (failureMessage != null) {
                            showListAlert(
                              context,
                              "Erreur",
                              content: Text(failureMessage),
                            );
                          }
                        },
                        child: Container(
                          width: double.maxFinite,
                          alignment: Alignment.center,
                          height: 48.0,
                          margin: const EdgeInsets.symmetric(
                            horizontal: 16.0,
                            vertical: 8.0,
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16.0,
                          ),
                          decoration: BoxDecoration(
                            color: mainColor(),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(8.0)),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 4.0,
                                spreadRadius: 0.0,
                                offset: Offset(0.0, 2.0),
                              )
                            ],
                          ),
                          child: Stack(
                            clipBehavior: Clip.none,
                            alignment: Alignment.center,
                            children: <Widget>[
                              Opacity(
                                opacity: model.state == ViewState.busy ? 0 : 1,
                                child: Text(
                                  "Se connecter",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1
                                      ?.copyWith(color: Colors.white),
                                ),
                              ),
                              model.state == ViewState.busy
                                  ? SizedBox(
                                      width: 32.0,
                                      child: SpinKitFadingCircle(
                                        color: lightGreyColor(),
                                        size: 32.0,
                                      ),
                                    )
                                  : Container()
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
