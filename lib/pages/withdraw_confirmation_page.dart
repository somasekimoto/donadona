import 'package:donadona/common/withdraw_confirmationi_arguments.dart';
import 'package:flutter/material.dart';

class WithdrawConfirmationPage extends StatefulWidget {
  const WithdrawConfirmationPage({ super.key });
  
  @override
  State<WithdrawConfirmationPage> createState() => _WithdrawConfirmationPageState();
}
class _WithdrawConfirmationPageState extends State<WithdrawConfirmationPage> {
  double withdrawAmount = 0;
  late WithdrawConfirmationArguments args;

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () async {
      setState(() {
        args = ModalRoute.of(context)?.settings.arguments as WithdrawConfirmationArguments;
      });
      withdrawAmount = args.withdrawAmount;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: ListView(
              children: [
                ListTile(title: Text('本当に引出しますか?')),
                ListTile(title: Text('お引出し額: ${withdrawAmount}JPYC')),
                ListTile(title: Text('余剰金額: ${withdrawAmount}JPYC')),
                const Spacer(),
                ListTile(title: Text('再分配先1: 0xsaibunpai')),
                ListTile(title: Text('再分配先2: 0xsaibunpai')),
              ]
            )
          )
        )]
    );
  } 
}