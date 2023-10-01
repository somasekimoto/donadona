import 'package:flutter/material.dart';

class DefaultLayout extends StatelessWidget {
  const DefaultLayout({super.key, required this.title, required this.body});
  final String title;
  final Widget body;

  @override
    Widget build(BuildContext context) {
      return Scaffold(
            appBar: AppBar(
              backgroundColor: Theme.of(context).colorScheme.inversePrimary,
              title: Text(title),
              leading: BackButton(
                onPressed: () {
                  Navigator.of(context).pop();
                }
              ),
              actions: [
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () { 
                    Navigator.pushNamed(context, '/project/edit');
                  })
              ]
            ),
            body: body// This trailing comma makes auto-formatting nicer for build methods.
          );
    }

}