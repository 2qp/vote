import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vote/db/db.dart';
import 'package:vote/models/candidate.dart';

class ViewUserPage extends StatelessWidget {
  const ViewUserPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DatabaseService db = DatabaseService();
    List userList = Provider.of<List<Weapon>>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: const Text('Stream Provider'),
      ),
      body: ListView.builder(
        itemCount: userList.length,
        itemBuilder: (_, int index) => Padding(
          padding: const EdgeInsets.all(10.0),
          child: Card(
            child: ListTile(
              leading: const FlutterLogo(size: 56.0),
              title: Text(
                userList[index].name,
              ),
              subtitle: Text(
                userList[index].party + ' | ' + userList[index].id.toString(),
              ),
              trailing: const Icon(Icons.more_vert),
              onTap: () {},
              dense: false,
            ),
          ),
        ),
      ),
    );
  }
}
