import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:kyogojo_pay/providers/signup_provider.dart';
import 'package:provider/provider.dart';

class LoginPage extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final usernameController = useTextEditingController();
    final passwordController = useTextEditingController();
    final signupProvider = Provider.of<SignupDataProvider>(context);

    void login() async {
      final username = usernameController.text;
      final password = passwordController.text;

      var res = await signupProvider
          .login({"username": username, "password": password});
      if ([200, 201, 204].contains(res.statusCode) && context.mounted) {
        context.push('/application');
        return;
      }
      signupProvider.logout();
      // Perform your login logic here
    }

    bool isValidEmail(String email) {
      // Regular expression pattern for email validation
      final RegExp emailRegExp =
          RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');

      return emailRegExp.hasMatch(email);
    }

    useEffect(() {
      Future.microtask(() async {
        await signupProvider.init(context);
      });
    });

    return Scaffold(
      appBar: AppBar(
        leadingWidth: 200,
        leading: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          child: SvgPicture.asset(
            "images/Vectorkyogo.svg",
            fit: BoxFit.fill,
            width: 100,
            color: Colors.white,
            key: const Key("Logo"),
          ),
        ),
        backgroundColor: Color(0xFFB82832),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            width: 300,
            height: 300,
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Icon(
                  Icons.account_circle,
                  size: 60,
                  color: Color(0xFFB82832),
                ),
                // Center(
                //     child: Text(
                //   'Credentials ',
                //   style: TextStyle(
                //       color: Colors.blueGrey,
                //       fontWeight: FontWeight.w200,
                //       fontSize: 8),
                // )),
                TextField(
                  controller: usernameController,
                  decoration: InputDecoration(labelText: 'Email'),
                ),
                SizedBox(height: 16.0),
                TextField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: InputDecoration(labelText: 'Password'),
                ),
                SizedBox(height: 24.0),
                ElevatedButton(
                  onPressed: () {
                    if (usernameController.text == "" ||
                        passwordController.text == "" ||
                        !isValidEmail(usernameController.text)) {
                      return;
                    }
                    login();
                  },
                  style: ButtonStyle(
                    padding: MaterialStateProperty.all<EdgeInsets>(
                        EdgeInsets.all(20)),
                    backgroundColor: MaterialStateProperty.all<Color>(
                        usernameController.text == "" ||
                                passwordController.text == "" ||
                                !isValidEmail(usernameController.text)
                            ? Colors.grey
                            : Color(0xFFB82832)),
                  ),
                  child: Text(
                    'Login',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
