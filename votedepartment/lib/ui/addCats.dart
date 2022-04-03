import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:votedepartment/contract_link.dart';
// state changer
import 'package:votedepartment/scoped/states.dart';

class AddCats extends StatelessWidget {
  const AddCats({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var link = Provider.of<ContractLinking>(context, listen: true);
    TextEditingController name = TextEditingController();

    // state instance
    final Scoped scope = Scoped();

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: link.isLoading
            ? const Center(
                child: CupertinoActivityIndicator(),
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  ListTile(
                    leading: const Icon(Icons.info),
                    title: TextField(
                      controller: name,
                      decoration: const InputDecoration(
                        hintText: "Province",
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(50.0),
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        primary: Colors.black,
                        backgroundColor: Colors.white,
                      ),
                      onPressed: () async {
                        await link.addCat(name.text);
                      },
                      child: const Text('Save Data'),
                    ),
                  ),
                  ChangeNotifierProvider<Scoped>(
                    create: (_) => scope,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          // Widget trigger
                          OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              primary: Colors.black,
                              backgroundColor: Colors.white,
                            ),
                            onPressed: () async {
                              scope.togle();
                            },
                            child: const Text('Load Categories'),
                          ),
                          Consumer<Scoped>(
                              builder: (context, model, _) => Column(
                                    children: <Widget>[
                                      model.state1.togle
                                          ? catList(context)
                                          : Container()
                                    ],
                                  )),
                        ]),
                  )
                ],
              ),
      ),
    );
  }

  Widget catList(context) {
    var link = Provider.of<ContractLinking>(context, listen: false);

    return FutureProvider<List>(
      initialData: const [],
      create: (_) {
        // print('calling future');
        return load(context);
      },
      child: Consumer<List>(
        builder: (_, value, __) => Center(
          child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: link.isLoading
                  ? const Center(
                      child: CupertinoActivityIndicator(),
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: value.length,
                          itemBuilder: (_, int index) => Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Card(
                              child: ListTile(
                                leading: Text(
                                  value[index][0].toString(),
                                ),
                                title: Text(
                                  value[index][1].toString(),
                                ),
                                subtitle: Text(
                                  "Votes :" + value[index][2].toString(),
                                ),
                                trailing: const Icon(Icons.more_vert),
                                onTap: () {},
                                dense: true,
                              ),
                            ),
                          ),
                        ),
                      ],
                    )),
        ),
      ),
    );
  }

  Future<List> load(context) async {
    var link = Provider.of<ContractLinking>(context, listen: false);
    List data = await link.returnCats();
    return data;
  }
}
