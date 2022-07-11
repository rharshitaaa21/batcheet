import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  AuthForm(this.submitFn, this.isLoading);
  final bool isLoading;
  final void Function(String email, String password, String username,
      bool isLogin, BuildContext ctx) submitFn;

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formkey = GlobalKey<FormState>();
  String _userEmail = '';
  String _userPassowrd = '';
  String _userName = '';

  var _isLogin = true;
  void _trysubmit() {
    final isValid = _formkey.currentState.validate();

    FocusScope.of(context).unfocus();
    if (isValid) {
      _formkey.currentState.save();
      widget.submitFn(_userEmail.trim(), _userName.trim(), _userPassowrd.trim(),
          _isLogin, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Card(
      margin: EdgeInsets.all(20),
      child: SingleChildScrollView(
          child: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
            key: _formkey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                TextFormField(
                  key: ValueKey('email '),
                  validator: (value) {
                    if (value.isEmpty || !value.contains('@')) {
                      return 'Please enter a valid email address';
                    }
                  },
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(labelText: 'Email Address'),
                  onSaved: (value) {
                    _userEmail = value;
                  },
                ),
                if (!_isLogin)
                  TextFormField(
                    key: ValueKey('username'),
                    onSaved: (value) {
                      _userName = value;
                    },
                    validator: (value) {
                      if (value.isEmpty || value.length < 4) {
                        return 'User Name must be 4 characters long';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(labelText: 'User Name'),
                  ),
                TextFormField(
                  key: ValueKey('password'),
                  onSaved: (value) {
                    _userPassowrd = value;
                  },
                  validator: (value) {
                    if (value.isEmpty || value.length < 7) {
                      return 'Password must be at least 7 characters long';
                    }
                    return null;
                  },
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Password',
                  ),
                ),
                SizedBox(
                  height: 14,
                ),
                if (widget.isLoading) CircularProgressIndicator(),
                if (!widget.isLoading)
                  RaisedButton(
                    onPressed: _trysubmit,
                    child: Text(_isLogin ? 'Login' : 'SignUp'),
                  ),
                if (!widget.isLoading)
                  FlatButton(
                    textColor: Theme.of(context).primaryColor,
                    onPressed: () {
                      setState(() {
                        _isLogin = !_isLogin;
                      });
                    },
                    child: Text(_isLogin
                        ? 'Create new Account'
                        : 'Already have an account'),
                  ),
              ],
            )),
      )),
    ));
  }
}
