import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login/blocs/auth_bloc.dart';

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  late String _username;
  late String _password;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            decoration: InputDecoration(labelText: 'Username'),
            onSaved: (value) => _username = value!,
            validator: (value) =>
            value.isEmpty ? 'Please enter your username' : null,
          ),
          TextFormField(
            decoration: InputDecoration(labelText: 'Password'),
            onSaved: (value) => _password = value,
            obscureText: true,
            validator: (value) =>
            value.isEmpty ? 'Please enter your password' : null,
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState.validate()) {
                _formKey.currentState.save();
                BlocProvider.of<AuthBloc>(context)
                    .add(LoginRequested(username: _username, password: _password));
              }
            },
            child: Text('Login'),
          ),
        ],
      ),
    );
  }
}
