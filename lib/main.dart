import 'package:flutter/material.dart';
import 'package:githubjobsfinder/api_service.dart';

import 'model/job_model.dart';

void main() {
  runApp(MaterialApp(
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Github Find Job(s)"),
      ),
      body: Container(
        child: FutureBuilder<List<JobModel>>(
          future: ApiService().getJobs(),
          builder:
              (BuildContext context, AsyncSnapshot<List<JobModel>> snapshot) {
            if (snapshot.connectionState == ConnectionState.done &&
                snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(snapshot.data[index].title),
                      subtitle: Text(snapshot.data[index].company),
                    );
                  });
            } else if (!snapshot.hasData) {
              // data gelmezse
              return AlertDialog(
                content:
                    Text("Error: An error occurred while retrieving data.. "),
              );
            }
            return Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
