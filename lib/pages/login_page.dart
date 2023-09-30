import 'package:donadona/api/login_api.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({ super.key });
  
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late TextEditingController _controller;
  String publicAddress = '';
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(); 
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Form(
        child: Column(
          children: [
            TextFormField(
              controller: _controller,
              decoration: const InputDecoration(
                labelText: 'ログインId',
                hintText: 'ログインId',
              ),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'ログインIdを入力してください';
                }
                return null;
              },
              onSaved: (value) => {
                if(value != null) {
                  publicAddress = value
                }
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: ElevatedButton(
                onPressed: () async {
                  var flg = false;
                  if(_formKey.currentState == null) return;
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    flg = await LoginApi.certifyLogin(publicAddress);
                  }
                  if(!mounted) return;
                  if(flg) Navigator.pushNamed(context, '/project/search');
                },
                child: const Text('ログイン'),
              ),
            ),
          ]
        ),
      ),
    );
  } 
}