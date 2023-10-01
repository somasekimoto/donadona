import 'package:donadona/common/donate_arguments.dart';
import 'package:donadona/common/withdraw_confirmationi_arguments.dart';
import 'package:flutter/material.dart';

class WithdrawPage extends StatefulWidget {
  const WithdrawPage({ super.key });
  
  @override
  State<WithdrawPage> createState() => _WithdrawPageState();
}
class _WithdrawPageState extends State<WithdrawPage> {
  late TextEditingController _controller;
  double withdrawAmount = 0;
  final _formKey = GlobalKey<FormState>();
  late DonateArguments args;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(); 

        Future.delayed(Duration.zero, () async {
      setState(() {
        args = ModalRoute.of(context)?.settings.arguments as DonateArguments;
      });
    });
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
                  textAlign: TextAlign.end,
                  decoration: InputDecoration(
                    labelText: 'お引出し額',
                    hintText: '100000',
                    suffix: Text('JPYC'),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  autovalidateMode: AutovalidateMode.onUserInteraction  ,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'お引出し額を入力してください';
                    }
                    if(value != null && double.tryParse(value) == null) {
                      return 'お引出し額には数値のみが有効です';
                    }
                    return null;
                  },
                  onSaved: (value) => {
                    if(value != null) {
                      withdrawAmount = double.parse(value)
                    }
                  },
                ),
              ),
            SizedBox(height: MediaQuery.of(context).size.width * 0.45),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: MediaQuery.of(context).size.width * 0.2),
              child: ElevatedButton(
                onPressed: () async {
                  if(_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    Navigator.pushNamed(context, '/withdraw/confirmation', arguments: WithdrawConfirmationArguments(withdrawAmount, args.projectId));
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF89a8f9),
                  foregroundColor: const Color(0xFFFFFFFF),
                  ),
                child: const Text('お引出し'),
              ),
            ),
          ]
        ),
      ),
    );
  } 
}