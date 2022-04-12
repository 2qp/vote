import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:votedepartment/contract_link.dart';
import 'package:votedepartment/stats/advanced_votes/view.dart';

class Lists extends StatelessWidget {
  const Lists({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                                  value[index][1].toString(),
                                ),
                                title: Text(
                                  value[index][2].toString(),
                                ),
                                subtitle: Text(
                                  "Votes :" + value[index][3].toString(),
                                ),
                                trailing: const Icon(Icons.more_vert),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => PieCharts(
                                              candidateId: value[index][0],
                                            )),
                                  );
                                },
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
    List data = await link.getCandidateData();
    print(data);
    return data;
  }
}
