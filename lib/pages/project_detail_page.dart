import 'package:donadona/api/project_api.dart';
import 'package:donadona/common/donate_arguments.dart';
import 'package:donadona/common/project_detail_arguments.dart';
import 'package:donadona/model/project.dart';
import 'package:donadona/store.dart';
import 'package:flutter/material.dart';

class ProjectDetailPage extends StatefulWidget {
  const ProjectDetailPage({ super.key });
  
  @override
  State<ProjectDetailPage> createState() => _ProjectDetailPageState();
}

class _ProjectDetailPageState extends State<ProjectDetailPage> {
  Project? project;
  late ProjectDetailArguments args;

  @override
  void initState()  {
    super.initState();

    Future.delayed(Duration.zero, () async {
      setState(() {
        args = ModalRoute.of(context)?.settings.arguments as ProjectDetailArguments;
      });
      ProjectApi.getProjectById(args.projectId).then((project) => {
        setState(() {
          if (project != null) {
            this.project = project;
          }
        })
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Store store = Store();
    Widget buttonChild() {
      if(store.userType == 1) {
        return Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                ElevatedButton(
                  onPressed: () => {
                    if (project != null) {
                      Navigator.pushNamed(context, '/withdraw', arguments: DonateArguments(project!.id))
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF89a8f9),
                    foregroundColor: const Color(0xFFFFFFFF),
                  ),
                  child: Text('お引出し')
                ),
                ElevatedButton(
                  onPressed: () => {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFFFFFF),
                    foregroundColor: const Color(0xFF89a8f9),
                    ),
                  child: Text('編集')
                ),
              ],);
      }
      else {
        return ElevatedButton(
          onPressed: () => {
            if (project != null) {
              Navigator.pushNamed(context, '/donate', arguments: DonateArguments(project!.id))
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF89a8f9),
            foregroundColor: const Color(0xFFFFFFFF),
          ),
          child: Text('寄付')
        );
      }
    }
    return Center(
      child: Expanded(
        child:
            Card(
              elevation: 5,
              shadowColor: Colors.black,
              color: Colors.white,
              shape: RoundedRectangleBorder( // 枠線を変更できる
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: project == null ? [
                  Container(     
                    alignment: Alignment.center,     
                    child: const CircularProgressIndicator(       
                      color: Color(0xFFCDF5FD)    
                    )   
                  )
                ] :[
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.45,
                    child: Image.asset(
                          project!.imagePath,
                          fit: BoxFit.fitHeight,
                        ),
                  ),
                  ListTile(
                    title: Text(project!.projectName),
                    subtitle: Text(project!.overview),
                    isThreeLine: true,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [ buttonChild() ],)
              ],),
            )
        ),
      );
  } 
}