import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/auth/login/login_screen.dart';
import 'package:todoapp/component%20/custom_text_from_feild.dart';
import 'package:todoapp/dialog_utils.dart';
import 'package:todoapp/firebase_utils.dart';
import 'package:todoapp/home/home_screen.dart';
import 'package:todoapp/model/mu_user.dart';
import 'package:todoapp/provider/auth_provider.dart';

class RegisterScreen extends StatefulWidget {
  static const String routeName = 'register';

  RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  var nameController = TextEditingController();

  var emailController = TextEditingController();

  var passwordController = TextEditingController();

  var confirmationPasswordController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            'assets/images/main_background.png',
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.fill,
          ),
          Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.3,
                  ),
                  CustomTextFormField(
                    label: "User Name",
                    type: TextInputType.name,
                    controller: nameController,
                    validator: (text) {
                      if (text == null || text.trim().isEmpty) {
                        return "Please Enter User Name";
                      }
                      return null;
                    },
                  ),
                  CustomTextFormField(
                    label: "Email Address",
                    type: TextInputType.emailAddress,
                    controller: emailController,
                    validator: (text) {
                      if (text == null || text.trim().isEmpty) {
                        return "Please Enter Email";
                      }
                      bool emailValid = RegExp(
                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                          .hasMatch(text);
                      if (!emailValid) {
                        return "Please enter valid email";
                      }
                      return null;
                    },
                  ),
                  CustomTextFormField(
                    isPassword: true,
                    label: "Password",
                    type: TextInputType.number,
                    controller: passwordController,
                    validator: (text) {
                      if (text == null || text.trim().isEmpty) {
                        return "Please Enter Password";
                      }
                      if (text.length < 6) {
                        return "Password should be at least 6 chars";
                      }
                      return null;
                    },
                  ),
                  CustomTextFormField(
                    isPassword: true,
                    label: "Confirm Password",
                    type: TextInputType.number,
                    controller: confirmationPasswordController,
                    validator: (text) {
                      if (text == null || text.trim().isEmpty) {
                        return "Please Enter Confirm Password";
                      }
                      if (text != passwordController.text) {
                        return "Password doesn't match";
                      }
                      return null;
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: ElevatedButton(
                      onPressed: () {
                        register();
                      },
                      child: Text(
                        "Register",
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 10),
                      ),
                    ),
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed(LoginScreen.routeName);
                      },
                      child: Text("Already have an acount"))
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  void register() async {
    if (formKey.currentState?.validate() == true) {
      DialogUtils.showLoading(context, 'Loading...');
      try {
        var credential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: emailController.text, password: passwordController.text);
        MyUser myUser = MyUser(id: credential.user?.uid??'', name: nameController.text, email: emailController.text);
        var authProvider = Provider.of<AuthProvider>(context, listen: false);
        authProvider.updateUser(myUser);
        await FirebaseUtils.addUserToFireStore(myUser);
        DialogUtils.hideLoading(context);
        DialogUtils.showMessage(context, "register Successfully",
            title: 'Success',
            posActionName: 'Ok',
            barrierDismissible: false, posAction: () {
          Navigator.pushReplacementNamed(context, HomeScreen.routeName);
        });
        print("register Successfully");
        print(credential.user?.uid ?? ' ');
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          DialogUtils.hideLoading(context);
          DialogUtils.showMessage(context, "The password provided is too weak.",
              title: 'Error', posActionName: 'Ok', barrierDismissible: false);
          print('The password provided is too weak.');
        } else if (e.code == 'email-already-in-use') {
          DialogUtils.hideLoading(context);
          DialogUtils.showMessage(
              context, "TThe account already exists for that email.",
              title: 'Error', posActionName: 'Ok', barrierDismissible: false);
          print('The account already exists for that email.');
        }
      } catch (e) {
        DialogUtils.hideLoading(context);
        DialogUtils.showMessage(context, e.toString(),
            title: 'Error', posActionName: 'Ok', barrierDismissible: false);
        print(e);
      }
    }
  }
}
