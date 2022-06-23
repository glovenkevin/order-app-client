import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:order_app_client/features/customer/resources/color/base_color.dart';
import 'package:order_app_client/features/customer/viewmodel/auth/register_vm.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  RegisterPageState createState() => RegisterPageState();
}

class RegisterPageState extends State<RegisterPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    RegisterViewModel vm = Provider.of<RegisterViewModel>(context);

    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          automaticallyImplyLeading: false,
        ),
        body: SingleChildScrollView(
          padding:
              const EdgeInsets.only(top: 0, left: 35, right: 35, bottom: 35),
          child: Form(
              key: vm.formState,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(
                          Icons.arrow_back,
                          color: AppDefaultColor.defaultBrown,
                        ),
                        tooltip: "Back to Home",
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.only(left: 15, right: 15),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: const [
                            Text(
                              'Create New',
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
                              'Account',
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
                          endIndent: 270,
                        ),
                        const SizedBox(height: 30),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: const [
                            Text(
                              'Email Address',
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
                            hintStyle:
                                TextStyle(color: Colors.black, fontSize: 14),
                          ),
                          maxLength: 30,
                          onChanged: (value) => vm.setEmail(value),
                          validator: (value) => vm.isValidEmail(value),
                        ),
                        const SizedBox(height: 20),
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
                            hintStyle:
                                TextStyle(color: Colors.black, fontSize: 14),
                          ),
                          maxLength: 20,
                          onChanged: (value) => vm.setPassword(value),
                          validator: (value) => vm.isValidPassword(value),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: const [
                            Text(
                              'Re-type Password',
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
                            hintStyle:
                                TextStyle(color: Colors.black, fontSize: 14),
                          ),
                          maxLength: 20,
                          onChanged: (value) => vm.setConfirmPassword(value),
                          validator: (value) =>
                              vm.isValidConfirmPassword(value),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: const [
                            Text(
                              'Full Name',
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black87,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        TextFormField(
                          decoration: const InputDecoration(
                            hintText: 'Enter your full name',
                            hintStyle:
                                TextStyle(color: Colors.black, fontSize: 14),
                          ),
                          maxLength: 50,
                          onChanged: (value) => vm.setName(value),
                          validator: (value) => vm.isEmpty(value),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: const [
                            Text(
                              'Phone Number',
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black87,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        TextFormField(
                          decoration: const InputDecoration(
                            hintText: 'Enter your phone number',
                            hintStyle:
                                TextStyle(color: Colors.black, fontSize: 14),
                          ),
                          maxLength: 13,
                          keyboardType: TextInputType.phone,
                          onChanged: (value) => vm.setPhoneNumber(value),
                          validator: (value) => vm.isEmpty(value),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
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
                        EasyLoading.show(status: 'Registering...');

                        vm
                            .register()
                            .then((value) => {
                                  vm.setIsLoading(false),
                                  EasyLoading.showSuccess(
                                      'Register is Success'),
                                  Future.delayed(
                                      const Duration(seconds: 1),
                                      () => Navigator.pushNamedAndRemoveUntil(
                                              context, "/login", (r) => false,
                                              arguments: {
                                                'email': vm.email,
                                              }))
                                })
                            .catchError((err) => {
                                  vm.setIsLoading(false),
                                  EasyLoading.showError("Failed to register")
                                });
                      },
                      child:
                          const Text('Sign Up', style: TextStyle(fontSize: 16)),
                    ),
                  ),
                ],
              )),
        ));
  }
}
