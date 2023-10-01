import 'package:flutter/material.dart';

class DonatePage extends StatefulWidget {
  const DonatePage({ super.key });
  
  @override
  State<DonatePage> createState() => _DonatePageState();
}
class _DonatePageState extends State<DonatePage> {
  late TextEditingController _controller;
  double donationAmount = 0;
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
                    labelText: '支払額',
                    hintText: '100000',
                    suffix: Text('円'),
                  ),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if(value != null && double.tryParse(value) == null) {
                      return '支払額には数値のみが有効です';
                    }
                    return null;
                  },
                  onSaved: (value) => {
                    if(value != null) {
                      donationAmount = double.parse(value)
                    }
                  },
                ),
              ),
            SizedBox(height: MediaQuery.of(context).size.width * 0.45),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: MediaQuery.of(context).size.width * 0.2),
              child: ElevatedButton(
                onPressed: () async {

                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF89a8f9),
                  foregroundColor: const Color(0xFFFFFFFF),
                  ),
                child: const Text('寄付'),
              ),
            ),
          ]
        ),
      ),
    );
  } 
}