import 'package:provider/provider.dart';
import 'package:votervalidator/func/contract_link.dart';

class Streams {
  Future<Stream<bool>> isVoting(context) async {
    var link = Provider.of<ContractLinking>(context, listen: false);
    bool data = await link.votingState();
    return data as Future<Stream<bool>>;
  }
}
