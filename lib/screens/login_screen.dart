import 'package:flutter/material.dart';
import 'package:private_login/screens/forgot_password.dart';
import 'package:private_login/screens/welcome_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key, email}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  late SharedPreferences logindata;
  late bool newuser;
  late String email;

  @override
  void initState() {
    check_already_login();
    super.initState();
  }

  check_already_login() async {
    logindata = await SharedPreferences.getInstance();
    newuser = (logindata.getBool('login') ?? true);
    print("new user");
    if (newuser == false) {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const WelcomeScreen()));
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 200,
            child: Image.asset(
              "assets/readingbook.png",
              fit: BoxFit.fill,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
              padding: const EdgeInsets.only(left: 30, right: 30),
              child: TextFormField(
                controller: emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  prefixIcon: Icon(Icons.person),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(borderSide: BorderSide()),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.teal, width: 2.0),
                  ),
                ),
              )),
          const SizedBox(height: 10),
          Padding(
              padding: const EdgeInsets.only(left: 30, right: 30, top: 18),
              child: TextFormField(
                controller: passwordController,
                obscureText: true,
                obscuringCharacter: '*',
                decoration: const InputDecoration(
                    labelText: 'Password',
                    prefixIcon: Icon(Icons.password),
                    suffixIcon: Icon(Icons.visibility_off),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(borderSide: BorderSide()),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.teal, width: 2.0),
                    )),
              )),
          Padding(
            padding: const EdgeInsets.only(left: 330.0),
            child: TextButton(
              onPressed: () {
                reset_password(context);
              },
              child: const Text(
                'Forgot password',
                style: TextStyle(color: Colors.grey),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                  primary: Colors.white,
                  onPrimary: Colors.teal,
                  side: const BorderSide(color: Colors.teal)),
              onPressed: () {
                String emailid = emailController.text;
                String password = passwordController.text;
                if (emailid != "" && password != "") {
                  print("Successfull");
                  logindata.setBool("login", false);
                  logindata.setString('emailid', emailid);
                  logindata.setString('password', password);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const WelcomeScreen()));
                } else {}
              },
              child: const Text("Login")),
        ],
      ),
    );
  }

  reset_password(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ForgotScreen(email: emailController.text)));
  }
}
