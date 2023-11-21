import 'package:flutter/material.dart';
import 'package:my_shop/providers/auth.dart';
import 'package:provider/provider.dart';

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
          SizedBox(
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
                  const AuthCard()
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
  var _isVisible = false;
  var _isLoading = false;
  Map<String, String> credentials = {
    'email': '',
    'password': '',
  };

  Future<void> _submit() async {
    var isValidated = _formKey.currentState!.validate();
    if (!isValidated) {
      return;
    }
    _formKey.currentState!.save();
    setState(() {
      _isLoading = true;
    });
    if (_authScreenStatus == AuthStatus.signin) {
      await Provider.of<Auth>(context, listen: false)
          .signUp(
        credentials['email']!,
        credentials['password']!,
      )
          .then((_) {
        _formKey.currentState?.reset();
        _passwordController.clear();
        setState(() {
          _authScreenStatus = AuthStatus.login;
        });
      });
    } else {
      await Provider.of<Auth>(context, listen: false)
          .logIn(
            credentials['email'],
            credentials['password'],
          )
          .then((value) => print('Logged in'));
    }
    setState(() {
      _isLoading = false;
    });
  }

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
                      onSaved: (newValue) {
                        credentials['email'] = newValue!;
                      },
                      validator: (value) {
                        if (!value!.contains('@')) {
                          return 'Invalid email type';
                        }
                        return null;
                      },
                    ),
                    // password textfield
                    TextFormField(
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              _isVisible = !_isVisible;
                            });
                          },
                          icon: _isVisible
                              ? const Icon(Icons.visibility_off)
                              : const Icon(Icons.visibility),
                        ),
                        labelText: 'Password',
                      ),
                      obscureText: _isVisible ? false : true,
                      autocorrect: false,
                      controller: _passwordController,
                      onSaved: (newValue) {
                        credentials['password'] = newValue!;
                      },
                      validator: (value) {
                        RegExp regexNumber = RegExp(r'^(?=.*\d).+$');
                        RegExp regexSpecialChar =
                            RegExp(r'^(?=.*[!@#$%^&*(),./?;:<>|{}]).+$');
                        if (value!.length < 8) {
                          return 'Password must be 8 characters long';
                        }
                        if (!regexNumber.hasMatch(value)) {
                          return 'Password must have at least one number';
                        }
                        if (!regexSpecialChar.hasMatch(value)) {
                          return 'Password must have at least one special character';
                        }
                        return null;
                      },
                    ),
                    // confirm password textfield
                    if (_authScreenStatus == AuthStatus.signin)
                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'Confirm Password',
                        ),
                        obscureText: _isVisible ? false : true,
                        autocorrect: false,
                        // onFieldSubmitted: (value) => _saveForm(),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Enter Password again';
                          }
                          if (value != _passwordController.text) {
                            return 'Password does not match!';
                          }
                          return null;
                        },
                      ),
                    const SizedBox(
                      height: 20,
                    ),
                    // Login or Signup button
                    _isLoading
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : ElevatedButton(
                            onPressed: () {
                              _submit();
                            },
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Theme.of(context).colorScheme.primary),
                                foregroundColor:
                                    MaterialStateProperty.all(Colors.white)),
                            child: _authScreenStatus == AuthStatus.login
                                ? const Text('LOGIN')
                                : const Text('SIGN-UP'),
                          ),
                    const SizedBox(
                      height: 3,
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
