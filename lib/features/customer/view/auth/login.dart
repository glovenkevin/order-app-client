import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:order_app_client/features/customer/resources/color/base_color.dart';
import 'package:order_app_client/features/customer/viewmodel/auth/login_vm.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<LoginViewModel>(context);
    final routeArgs = ModalRoute.of(context)?.settings.arguments;
    var args = <String, dynamic>{};
    if (routeArgs != null) {
      args = routeArgs as Map<String, dynamic>;
      if (args['email'] != "") {
        vm.setEmail(args['email']);
      }
    }

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
          padding: const EdgeInsets.only(top: 0, left: 35, right: 35),
          child: Form(
            key: vm.formState,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.popAndPushNamed(context, "/");
                      },
                      icon: const Icon(
                        Icons.arrow_back,
                        color: AppDefaultColor.defaultBrown,
                      ),
                      tooltip: "Back to Home",
                    ),
                  ],
                ),
                const SizedBox(height: 40),
                Container(
                  padding: const EdgeInsets.only(left: 15, right: 15),
                  child: Column(children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: const [
                        Text(
                          'Welcome',
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: const [
                        Text(
                          'Back!',
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                    const Divider(
                      color: AppDefaultColor.defaultYellow,
                      thickness: 5,
                      endIndent: 280,
                    ),
                    const SizedBox(height: 25),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: const [
                        Text(
                          'Email',
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.black87,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        hintText: 'Enter your email',
                        hintStyle: TextStyle(color: Colors.black, fontSize: 14),
                      ),
                      maxLength: 30,
                      onChanged: (value) => vm.setEmail(value),
                      validator: (value) => vm.isValidEmail(value),
                      initialValue: args['email'] ?? "",
                    ),
                    const SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: const [
                        Text(
                          'Password',
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.black87,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    TextFormField(
                      obscureText: true,
                      autocorrect: false,
                      enableSuggestions: false,
                      decoration: const InputDecoration(
                        hintText: 'Enter your password',
                        hintStyle: TextStyle(color: Colors.black, fontSize: 14),
                      ),
                      maxLength: 20,
                      onChanged: (value) => vm.setPassword(value),
                      validator: (value) => vm.isValidPassword(value),
                    ),
                    const SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        RichText(
                          text: TextSpan(children: [
                            const TextSpan(
                              text: 'Did not have an account?',
                              style: TextStyle(
                                color: Colors.black87,
                                fontSize: 12,
                              ),
                            ),
                            TextSpan(
                              text: " Sign Up",
                              style: const TextStyle(
                                color: AppDefaultColor.defaultYellow,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.pushNamed(context, '/register');
                                },
                            )
                          ]),
                        ),
                      ],
                    ),
                  ]),
                ),
                const SizedBox(height: 40),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: AppDefaultColor.defaultBrown,
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15))),
                    onPressed: () {
                      if (!vm.formState.currentState!.validate()) {
                        EasyLoading.showError('Parameter is invalid');
                        return;
                      }

                      if (vm.isLoading) return;
                      EasyLoading.show(status: 'Logging in...');

                      vm
                          .doLogin()
                          .then((value) => {
                                EasyLoading.showSuccess('Login success'),
                                vm.setIsLoading(false),
                                Future.delayed(const Duration(seconds: 1), () {
                                  Navigator.popAndPushNamed(context, '/main');
                                })
                              })
                          .catchError((error) => {
                                EasyLoading.showError(error),
                                vm.setIsLoading(false)
                              });
                    },
                    child: const Text('Login', style: TextStyle(fontSize: 16)),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
