import 'package:donadona/api/login_api.dart';
import 'package:donadona/common/project_list_arguments.dart';
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
        key: _formKey,
        child: ListView(
          children: [
            SizedBox(height: MediaQuery.of(context).size.width * 0.45),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: TextFormField(
                  controller: _controller,
                  decoration: const InputDecoration(
                    labelText: 'パブリックアドレス',
                    hintText: '0xXXXXXXXXXXXXXXXXXXXXXXXX',
                  ),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'パブリックアドレスを入力してください';
                    }
                    return null;
                  },
                  onSaved: (value) => {
                    if(value != null) {
                      publicAddress = value
                    }
                  },
                ),
              ),
            SizedBox(height: MediaQuery.of(context).size.width * 0.45),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: MediaQuery.of(context).size.width * 0.2),
              child: ElevatedButton(
                onPressed: () async {
                  var flg = false;
                  if(_formKey.currentState == null) return;
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    flg = await LoginApi.certifyLogin(publicAddress);
                  }
                  if(!mounted) return;
                  if(flg) Navigator.pushNamed(context, '/project/search', arguments: ProjectListArguments(publicAddress) );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF89a8f9),
                  foregroundColor: const Color(0xFFFFFFFF),
                  ),
                child: const Text('ログイン'),
              ),
            ),
          ]
        ),
      ),
    );
  } 
}