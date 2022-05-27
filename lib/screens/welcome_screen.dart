import 'package:flutter/material.dart';
import 'package:private_login/screens/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  late SharedPreferences logindata;
  late String email;
  @override
  void initState() {
    initial();
    super.initState();
  }

  initial() async {
    logindata = await SharedPreferences.getInstance();
    setState(() {
      email = logindata.getString('emailid')!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.only(top: 30),
            child: Image.asset("welcomeimage.png"),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 30.0),
            child: Text(
              "Welcome $email",
              style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(padding: EdgeInsets.only(top: 10)),
          ElevatedButton(
              onPressed: () {
                signout(context);
              },
              child: const Text("Logout"))
        ],
      ),
    ));
  }

  signout(BuildContext ctx) async {
    final logindata = await SharedPreferences.getInstance();
    await logindata.clear();
    Navigator.of(ctx).pushAndRemoveUntil(
        MaterialPageRoute(builder: (ctx1) => const LoginScreen()),
        (route) => false);
  }
}
