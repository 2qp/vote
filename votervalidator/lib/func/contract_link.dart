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
      "47ef1b923039012a89b1b8172fa74c4d2f416d74cc7714ca9c924bee64cadf36";
  late EthereumAddress owner;

  late Web3Client _client;
  late String _abiCode;

  late Credentials _credentials;

  late EthereumAddress _contractAddress;

  late DeployedContract _contract;
  late ContractFunction _entry;
  late ContractFunction _returnMappingValue;

  late ContractFunction _catCount;
  late ContractFunction _returnCats;

  bool isLoading = true;

  // temp
  var txt = TextEditingController();

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
    //await voting();
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

    _entry = _contract.function("entry");
    _returnMappingValue = _contract.function("returnMappingValue");

    _catCount = _contract.function("returnCatCount");
    _returnCats = _contract.function("returnCats");
  }

  // dep.app
  votervalid(String rid, BigInt id) async {
    isLoading = true;
    notifyListeners();
    await _client.sendTransaction(
        _credentials,
        Transaction.callContract(
            contract: _contract, function: _entry, parameters: [rid, id]));
    // ignore: avoid_print
    print("Voter Registered $rid");
  }

  keyreturns(String rid) async {
    notifyListeners();

    var tvotes = await _client.call(
        contract: _contract, function: _returnMappingValue, params: [rid]);
    return "$tvotes";
  }

  Future<BigInt> catCount() async {
    var numOfVotes = await _client
        .call(contract: _contract, function: _catCount, params: []);
    return numOfVotes.first;
  }

  Future<List> returnCats(BigInt id) async {
    final List list = await _client
        .call(contract: _contract, function: _returnCats, params: [id]);
    notifyListeners();
    return list;
  }
}
