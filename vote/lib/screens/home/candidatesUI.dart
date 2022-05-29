import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vote/contract_linking.dart';
import 'package:vote/services/storage.dart';
import 'package:vote/ui/votingui.dart';

class CandidatesUI extends StatelessWidget {
  const CandidatesUI({Key? key, required this.voter}) : super(key: key);
  final int voter;

  @override
  Widget build(BuildContext context) {
    var link = Provider.of<ContractLinking>(context, listen: false);

    return Scaffold(
      body: FutureProvider<List>(
        initialData: const [],
        create: (_) {
          // print('calling future');
          return link.inititalSetup().then((_) async => await load(context));
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
                                  leading: FutureProvider<String>(
                                    initialData: "assets/img/loading.gif",
                                    create: (_) async {
                                      final Storage _fs = Storage();
                                      return await _fs
                                          .getUrl(value[index][0].toString());
                                    },
                                    child: Consumer<String>(
                                        builder: ((context, url, child) =>
                                            Image.network(url))),
                                  ),
                                  title: Text(
                                    value[index][1].toString(),
                                  ),
                                  trailing: Text(
                                    value[index][2].toString(),
                                  ),
                                  onTap: () {
                                    BigInt rawId = value[index][0];
                                    final int id = rawId.toInt();

                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => VotingUi(
                                                id: id,
                                                name:
                                                    value[index][1].toString(),
                                                party:
                                                    value[index][2].toString(),
                                                voter: voter,
                                              )),
                                    );
                                  },
                                  dense: false,
                                ),
                              ),
                            ),
                          ),
                        ],
                      )),
          ),
        ),
      ),
    );
  }

  Future<List> load(context) async {
    var link = Provider.of<ContractLinking>(context, listen: false);
    List data = await link.getCandidateList();
    return data;
  }
}
