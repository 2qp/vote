import 'dart:convert';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:vote/func/msg.dart';
import 'package:web3dart/web3dart.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class ContractLinking extends ChangeNotifier {
  final String _rpcUrl = "http://127.0.0.1:7545";
  final String _wsUrl = "ws://127.0.0.1:7545/";
  final String _privateKey =
      "fc479ea0cae52fa7b774bcd0969036489ae7b29c592d3512e897528480ae9e09";
  late EthereumAddress owner;

  late Web3Client _client;
  late String _abiCode;
  late Credentials _credentials;
  late EthereumAddress _contractAddress;
  late DeployedContract _contract;

  late ContractFunction _voteFunc;
  late ContractFunction _numOfVoters;

  late ContractFunction _getCandidate;
  late ContractFunction _numOfCandidates;

  late ContractEvent _error;

  bool isLoading = true;

  ContractLinking() {}

  Future<void> inititalSetup() async {
    _client = Web3Client(_rpcUrl, Client(), socketConnector: () {
      return WebSocketChannel.connect(Uri.parse(_wsUrl)).cast<String>();
    });
    await getAbi();
    await getCredentials();
    await getDeployedContract();
    await dispatch(errors());
  }

  Future<void> getAbi() async {
    String abiStringFile =
        await rootBundle.loadString("src/artifacts/Ballot.json");
    var jsonFile = jsonDecode(abiStringFile);
    _abiCode = jsonEncode(jsonFile["abi"]);
    _contractAddress =
        EthereumAddress.fromHex(jsonFile["networks"]["5777"]["address"]);
  }

  Future<void> getCredentials() async {
    _credentials = EthPrivateKey.fromHex(_privateKey);
    owner = await _credentials.extractAddress();
    notifyListeners();
  }

  Future<void> getDeployedContract() async {
    contract = DeployedContract(
        ContractAbi.fromJson(_abiCode, "Ballot"), _contractAddress);

    _voteFunc = contract.function("vote");
    _numOfVoters = contract.function("getNumOfVoters");
    _getCandidate = contract.function("getCandidate");
    _numOfCandidates = contract.function("getNumOfCandidates");

    _error = contract.event("Error2");
    notifyListeners();
  }

  DeployedContract get contract => _contract;
  set contract(DeployedContract value) {
    _contract = value;
    print("contract");
    notifyListeners();
  }

  // voting
  vote(BigInt candidateID, String rid) async {
    isLoading = true;
    notifyListeners();
    await _client.sendTransaction(
        _credentials,
        Transaction.callContract(
            contract: contract,
            function: _voteFunc,
            parameters: [candidateID, rid]));
  }

  // sub contract
  getNumOfVoters() async {
    notifyListeners();
    var noc = await _client
        .call(contract: contract, function: _numOfVoters, params: []);
    return "$noc";
  }

  // error handler
/*  Future<String> error() async {
    notifyListeners();
    final event = await _client
        .events(FilterOptions.events(contract: contract, event: _error))
        .first;
    final decoded = _error.decodeResults(event.topics!, event.data ?? '');
    final errorcode = decoded[0] ?? '';
    return errorcode;
  } */

  // candidates from ballot
  Future<BigInt> getNumOfCandidates() async {
    var candidates = await _client
        .call(contract: contract, function: _numOfCandidates, params: []);
    return candidates.first;
  }

  Future<List> getCandidateList() async {
    // rec a bigInt
    BigInt count = await getNumOfCandidates();
    // Parsing 2 int
    int count2 = count.toInt();
    var list = <List>[];

    for (int i = 0; i < count2; i++) {
      var candidate = await _client.call(
          contract: contract,
          function: _getCandidate,
          params: [BigInt.from(i)]);
      list.add(candidate);
    }
    isLoading = false;
    notifyListeners();
    print(list);
    return list;
  }

  // error catcher
  Stream<String> errors({BlockNum? fromBlock, BlockNum? toBlock}) {
    final event = _error;
    final filter = FilterOptions.events(
        contract: _contract,
        event: event,
        fromBlock: fromBlock,
        toBlock: toBlock);
    return _client.events(filter).map((FilterEvent result) {
      final decoded = event.decodeResults(result.topics!, result.data!);
      var state = decoded[0] ?? '';
      notifyListeners();
      return state;
    });
  }

  // error dispatcher

  // event dispatcher to front as toast
  Future<void> dispatch(stream) async {
    stream.listen((event) {
      showsnak(event.toString());
    });
  }
}
