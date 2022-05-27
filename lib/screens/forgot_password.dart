import 'package:flutter/material.dart';
import 'package:private_login/screens/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ForgotScreen extends StatefulWidget {
  final String email;
  const ForgotScreen({Key? key, required this.email}) : super(key: key);
  @override
  State<ForgotScreen> createState() => _ForgotScreenState(email);
}

class _ForgotScreenState extends State<ForgotScreen> {
  final password1 = TextEditingController();
  final password2 = TextEditingController();
  late SharedPreferences logindata;
  late String checkvalue;
  late String pswd;
  final String? email;

  _ForgotScreenState(this.email);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(50.0),
                  child: Image.asset("assets/forgotpwd.jpg"),
                ),
                const Text(
                  "Forgot Password ?",
                  style: TextStyle(fontSize: 25),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 10, left: 5),
                ),
                const Text(
                    "No Worries !! Please confirm your registered email to reset your password "),
                const Padding(
                  padding: EdgeInsets.only(top: 40),
                ),
                Text(email!),
                const Padding(padding: EdgeInsets.only(top: 20)),
                ElevatedButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              content: SizedBox(
                                height: 250,
                                child: Column(
                                  children: [
                                    Column(
                                      children: [
                                        const Text(
                                          "Reset Password",
                                          style: TextStyle(
                                              fontSize: 25,
                                              fontWeight: FontWeight.w700),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 20.0),
                                          child: TextField(
                                            controller: password1,
                                            obscureText: true,
                                            obscuringCharacter: '*',
                                            decoration: const InputDecoration(
                                                labelText: 'Password',
                                                prefixIcon:
                                                    Icon(Icons.password),
                                                suffixIcon:
                                                    Icon(Icons.visibility_off),
                                                filled: true,
                                                fillColor: Colors.white,
                                                border: OutlineInputBorder(
                                                    borderSide: BorderSide()),
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.teal,
                                                      width: 2.0),
                                                )),
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 8.0),
                                          child: TextField(
                                            controller: password2,
                                            obscureText: true,
                                            obscuringCharacter: '*',
                                            decoration: const InputDecoration(
                                                labelText: 'Confirm Password',
                                                prefixIcon:
                                                    Icon(Icons.password),
                                                suffixIcon:
                                                    Icon(Icons.visibility_off),
                                                filled: true,
                                                fillColor: Colors.white,
                                                border: OutlineInputBorder(
                                                    borderSide: BorderSide()),
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.teal,
                                                      width: 2.0),
                                                )),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(15.0),
                                          child: ElevatedButton(
                                              onPressed: () {
                                                confirmpassword();
                                              },
                                              child: const Text('Reset')),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            );
                          });
                    },
                    child: const Text('Confirm'))
              ],
            ),
          ],
        ),
      ),
    );
  }

  confirmpassword() async {
    String passwordone = password1.text;
    String passwordtwo = password2.text;
    if (passwordone == passwordtwo) {
      print('pswd matched');
      SharedPreferences logindata = await SharedPreferences.getInstance();
      logindata.reload();
      logindata.setString('password', passwordtwo);
      print(passwordtwo);
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const LoginScreen()));
    } else {
      print('pswd not matched');
    }
  }
}
