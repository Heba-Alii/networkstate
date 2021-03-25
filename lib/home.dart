import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'api.dart';
import 'auther.dart';
import 'model.dart';

class Home extends StatefulWidget {
  Home({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<Home> {
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    Provider.of<EmployeeApi>(context, listen: false).getAllEmployee();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: FutureBuilder(
          future: Provider.of<EmployeeApi>(context,listen: false).getAllEmployee(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.data == null) {
              return Container(
                child: Center(
                  child: Text("Loading data"),
                ),
              );
            } else {
              return Consumer<EmployeeApi>(
                builder: (context, model, child) {
                  return ListView.builder(
                    itemCount: model.employees.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        title: Text(model.employees[index].name),
                        subtitle: Text(model.employees[index].age),
                      );
                    },
                  );
                },
              );
            }
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => NewEmployee()),
          );
        },
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}