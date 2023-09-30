import 'package:donadona/api/project_api.dart';
import 'package:donadona/common/project_detail_arguments.dart';
import 'package:donadona/common/project_list_arguments.dart';
import 'package:donadona/model/project.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ProjectListPage extends StatefulWidget {
  const ProjectListPage({ super.key });
  
  @override
  State<ProjectListPage> createState() => _ProjectListPageState();
}

class _ProjectListPageState extends State<ProjectListPage> {
  late TextEditingController _controller;
  late int studyTime;
  late List<Project> projects = [];
  final _formKey = GlobalKey<FormState>();
  late ProjectListArguments args;

  @override
  void initState()  {
    super.initState();
    _controller = TextEditingController(); 

    Future.delayed(Duration.zero, () async {
      setState(() {
        args = ModalRoute.of(context)?.settings.arguments as ProjectListArguments;
      });
      ProjectApi.getProject(args.publicAddress).then((projects) => {
        setState(() {
          this.projects = projects;
        })
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Row(
                children: [
                  Flexible(
                    child: TextFormField(
                      controller: _controller,
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      decoration: const InputDecoration(
                        labelText: '勉強時間',
                        hintText: '6',
                        suffix: Text('時間'),
                      ),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        if(value != null && int.tryParse(value) == null) {
                          return '勉強時間には数値のみが有効です';
                        }
                        return null;
                      },
                      onSaved: (value) => {
                        if(value != null) {
                          studyTime = int.parse(value)
                        }
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 5, 0, 0),
                    child: IconButton(
                      icon: const Icon(Icons.search),
                      iconSize: 36,
                      onPressed: () async {
                        if(_formKey.currentState == null) return;
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                        }
                      },
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 50, 0, 0),
              child: SizedBox(
                height: 400,
                child: ListView(
                  addAutomaticKeepAlives: true,
                  children: projects.map<ListTile>((project) => ListTile(
                      title: Text(project.projectName),
                      subtitle: Text(project.overview),
                      trailing: Image.asset(
                        project.imagePath,
                        height: 75,
                        width:75,
                        fit: BoxFit.fitHeight,
                      ),
                      enabled: true,
                      onTap: () {
                        Navigator.pushNamed(context, '/project/detail', arguments: ProjectDetailArguments(project.id) );
                      }
                    )).toList(),
                )
              )
            ),
          ]
        ),
      ),
    );
  } 
}