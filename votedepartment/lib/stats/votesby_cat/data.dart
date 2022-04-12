import 'package:provider/provider.dart';

import 'package:votedepartment/contract_link.dart';

class Data {
  Future<Map<String, double>> fetch(context) async {
    var link = Provider.of<ContractLinking>(context, listen: false);

    List data = await link.votesbycat();

    var map = {
      for (var v in data) v[0].toString(): double.parse(v[1].toString())
    };

    return map;
  }
}
