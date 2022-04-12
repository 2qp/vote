import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:web3dart/web3dart.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class ContractLinking extends ChangeNotifier {
  final String _rpcUrl = "http://127.0.0.1:7545";
  final String _wsUrl = "ws://127.0.0.1:7545/";
  final String _privateKey =
      "2c3ba7c96a6aeadf31c33b49be42c9ef1e16aef85c822e5a0a2c99355f30142e";
  late EthereumAddress owner;

  late Web3Client _client;
  late String _abiCode;
  late Credentials _credentials;
  late EthereumAddress _contractAddress;
  late DeployedContract _contract;

  late ContractFunction _voteFunc;
  late ContractFunction _numOfVoters;

  late ContractEvent _error;

  bool isLoading = true;

  ContractLinking() {
    inititalSetup();
  }

  inititalSetup() async {
    _client = Web3Client(_rpcUrl, Client(), socketConnector: () {
      return WebSocketChannel.connect(Uri.parse(_wsUrl)).cast<String>();
    });
    await getAbi();
    await getCredentials();
    await getDeployedContract();
  }

  getAbi() async {
    String abiStringFile =
        await rootBundle.loadString("src/artifacts/Ballot.json");
    var jsonFile = jsonDecode(abiStringFile);
    _abiCode = jsonEncode(jsonFile["abi"]);
    _contractAddress =
        EthereumAddress.fromHex(jsonFile["networks"]["5777"]["address"]);
  }

  getCredentials() async {
    _credentials = EthPrivateKey.fromHex(_privateKey);
    owner = await _credentials.extractAddress();
  }

  getDeployedContract() async {
    _contract = DeployedContract(
        ContractAbi.fromJson(_abiCode, "Ballot"), _contractAddress);

    _voteFunc = _contract.function("vote");
    _numOfVoters = _contract.function("getNumOfVoters");
    _error = _contract.event("Error");
  }

  // voting
  vote(BigInt candidateID, String rid) async {
    isLoading = true;
    notifyListeners();
    await _client.sendTransaction(
        _credentials,
        Transaction.callContract(
            contract: _contract,
            function: _voteFunc,
            parameters: [candidateID, rid]));
  }

  // sub contract
  getNumOfVoters() async {
    notifyListeners();
    var noc = await _client
        .call(contract: _contract, function: _numOfVoters, params: []);
    return "$noc";
  }

  // error handler
  Future<String> error() async {
    notifyListeners();
    final event = await _client
        .events(FilterOptions.events(contract: _contract, event: _error))
        .first;
    final decoded = _error.decodeResults(event.topics!, event.data ?? '');
    final errorcode = decoded[0] ?? '';
    return errorcode;
  }
}
