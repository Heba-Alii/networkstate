import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'api.dart';
import 'auther.dart';
import 'model.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Future<List<Author>> authors;

  @override
  void initState() {
    super.initState();

      authors = API.getAllAuthors();


  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Employees'),
      ),
      body: FutureBuilder<List<Author>>(
        future: authors,
        builder: (context, snapshot) {

          if (snapshot.hasData) {
            return ListView.builder(


                itemCount: snapshot.data.length,
                itemBuilder: (context, i) {
                  return Card(
                    child: ListTile(
                      title: Text(snapshot.data[i].employee_name),
                      subtitle: Row(
                        children: <Widget>[
                          Text(snapshot.data[i].profile_image),
                          SizedBox(
                            width: 100,
                          ),
                          Text('${snapshot.data[i].employee_age}'),
                        ],
                      ),
                    ),
                  );
                });
          } else if (snapshot.hasError) {
            print(snapshot.error);
            return
              Text('Sorry there is an error');


          }
          return CircularProgressIndicator();
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddAuthor(),
            ),
          );
          setState(() {
            authors = API.getAllAuthors();
          });
        },
      ),
    );
  }
}
