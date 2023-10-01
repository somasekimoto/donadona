import 'package:donadona/api/project_api.dart';
import 'package:donadona/common/withdraw_confirmationi_arguments.dart';
import 'package:donadona/model/project.dart';
import 'package:flutter/material.dart';

class WithdrawConfirmationPage extends StatefulWidget {
  const WithdrawConfirmationPage({ super.key });
  
  @override
  State<WithdrawConfirmationPage> createState() => _WithdrawConfirmationPageState();
}
class _WithdrawConfirmationPageState extends State<WithdrawConfirmationPage> {
  double withdrawAmount = 0;
  late String projectId;
  late WithdrawConfirmationArguments args;
  late Project project;

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () async {
      setState(() async {
        args = ModalRoute.of(context)?.settings.arguments as WithdrawConfirmationArguments;
      });
      withdrawAmount = args.withdrawAmount;
      projectId = args.projectId;
      project = await ProjectApi.getProjectById(projectId) ?? Project.empty();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24.0, 48.0, 24.0, 0),
            child: ListView(
              children: [
                ListTile(title: Text('本当にお引出ししますか?', style: Theme.of(context).textTheme.titleLarge)),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.fromLTRB(48.0, 12.0, 48.0, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('お引出し額: ${withdrawAmount}JPYC', style: Theme.of(context).textTheme.titleMedium),
                      Text('余剰金額: ${withdrawAmount - 100000}JPYC', style: Theme.of(context).textTheme.titleMedium),
                      Text('再分配先1: 0xsaibunpai', style: Theme.of(context).textTheme.titleMedium),
                      Text('再分配先2: 0xsaibunpai', style: Theme.of(context).textTheme.titleMedium)
                  ],)
                )
              ]
            )
          )
        )]
    );
  } 
}