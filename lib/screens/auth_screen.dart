import 'package:flutter/material.dart';

enum AuthStatus {
  login,
  signin,
}

class AuthScreen extends StatelessWidget {
  static const routeName = '/Auth';
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          // static background container with a gradient
          Container(
            height: screenSize.height,
            width: screenSize.width,
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    const Color.fromARGB(255, 97, 38, 164).withOpacity(0.9),
                    const Color.fromARGB(255, 167, 118, 35).withOpacity(0.9)
                  ],
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                ),
              ),
            ),
          ),
          SingleChildScrollView(
            child: SizedBox(
              height: screenSize.height,
              width: screenSize.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Flexible(
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 24),
                      padding: const EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 90,
                      ),
                      transform: Matrix4.rotationZ(270),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 130, 48, 19),
                        borderRadius: BorderRadius.circular(25),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black54,
                            blurRadius: 8,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: const Text(
                        'MyShop',
                        style: TextStyle(
                            fontSize: 50,
                            color: Colors.white,
                            fontFamily: 'Anon',
                            fontWeight: FontWeight.normal),
                      ),
                    ),
                  ),
                  AuthCard()
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class AuthCard extends StatefulWidget {
  const AuthCard({super.key});

  @override
  State<AuthCard> createState() => _AuthCardState();
}

class _AuthCardState extends State<AuthCard> {
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  var _authScreenStatus = AuthStatus.login;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      margin: const EdgeInsets.symmetric(horizontal: 40),
      child: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(2.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    // e-mail textfield
                    TextFormField(
                      decoration: const InputDecoration(labelText: 'E-Mail'),
                      keyboardType: TextInputType.emailAddress,
                    ),
                    // password textfield
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Password',
                      ),
                      obscureText: true,
                      autocorrect: false,
                      controller: _passwordController,
                    ),
                    // confirm password textfield
                    if (_authScreenStatus == AuthStatus.signin)
                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'Confirm Password',
                        ),
                        obscureText: true,
                        autocorrect: false,
                      ),
                    const SizedBox(
                      height: 20,
                    ),
                    // Login or Signup button
                    ElevatedButton(
                      onPressed: () {},
                      child: _authScreenStatus == AuthStatus.login
                          ? const Text('LOGIN')
                          : const Text('SIGN-UP'),
                    ),
                    // button to switch between login and signup screen
                    TextButton(
                      onPressed: () {
                        if (_authScreenStatus == AuthStatus.login) {
                          setState(() {
                            _authScreenStatus = AuthStatus.signin;
                          });
                        } else {
                          setState(() {
                            _authScreenStatus = AuthStatus.login;
                          });
                        }
                      },
                      child: _authScreenStatus == AuthStatus.login
                          ? const Text('Not registered? SIGNUP')
                          : const Text('Already registered? LOGIN'),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
