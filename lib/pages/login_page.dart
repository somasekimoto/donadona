import 'package:donadona/api/login_api.dart';
import 'package:donadona/common/project_list_arguments.dart';
import 'package:donadona/store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../common/ethereum_screen_state.dart';

class LoginPage extends ConsumerWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final balance = ref.watch(ethereumScreenStateProvider).balance;
    final address = ref.watch(ethereumScreenStateProvider).address;
    final walletConnectServiceInitialized = ref.watch(ethereumScreenStateProvider).walletConnectServiceInitialized;
    
    final _controller = TextEditingController();
    final _formKey = GlobalKey<FormState>();
    String publicAddress = '';

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
              Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: MediaQuery.of(context).size.width * 0.2),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Theme.of(context).primaryColor,
                  minimumSize: const Size(200.0, 52.0),
                  shape: const StadiumBorder(),
                ),
                onPressed: walletConnectServiceInitialized
                    ? () {
                        ref
                            .read(ethereumScreenStateProvider.notifier)
                            .openConnectWalletModal(context);
                      }
                    : null,
                child: const Text('ウォレット接続'),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.width * 0.45),
            
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: MediaQuery.of(context).size.width * 0.2),
              child: ElevatedButton(
                onPressed: () async {
                  var userType = 0;
                  if(_formKey.currentState == null) return;
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    userType = await LoginApi.certifyLogin(publicAddress);
                  }
                  // if(!mounted) return;
                  if(userType != 0) {
                    Store store = Store();
                    store.setUserType(userType);
                    Navigator.pushNamed(context, '/project/search', arguments: ProjectListArguments(publicAddress) );
                    }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF89a8f9),
                  foregroundColor: const Color(0xFFFFFFFF),
                  ),
                child: const Text('ログイン'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
          