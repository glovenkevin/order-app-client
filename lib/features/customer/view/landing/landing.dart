import 'package:flutter/material.dart';
import 'package:order_app_client/features/customer/resources/color/base_color.dart';
import 'package:order_app_client/features/customer/viewmodel/landing/landing_vm.dart';
import 'package:provider/provider.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => LandingPageState();
}

class LandingPageState extends State<LandingPage> {
  late LandingViewModel vm;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      vm.checkIsAlreadyLogIn(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    vm = Provider.of<LandingViewModel>(context);

    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(top: 110, left: 25, right: 25),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Text(
                'Welcome!',
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Let\' start by Login or Register to continue',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: Colors.black54,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 50),
              const Image(
                image: AssetImage(
                    'lib/features/customer/assets/images/ote_ote.jpeg'),
                width: 240,
                height: 240,
              ),
              const SizedBox(height: 50),
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
                    Navigator.pushNamed(context, '/login');
                  },
                  child: const Text('Go to Sign In',
                      style: TextStyle(fontSize: 14)),
                ),
              ),
              const SizedBox(height: 15),
              SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15))),
                    onPressed: () {
                      Navigator.pushNamed(context, '/register');
                    },
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text("Don't have an account? ",
                              style:
                                  TextStyle(fontSize: 14, color: Colors.grey)),
                          Text("Register",
                              style: TextStyle(
                                  fontSize: 14,
                                  color: AppDefaultColor.defaultBrown)),
                        ]),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
