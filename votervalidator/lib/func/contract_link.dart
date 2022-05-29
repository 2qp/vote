import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:votervalidator/func/msg.dart';
import 'package:web3dart/web3dart.dart';
import 'package:web3dart/web3dart.dart' as _i1;
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
  late ContractFunction _entry;
  late ContractFunction _returnMappingValue;

  late ContractFunction _catCount;
  late ContractFunction _returnCats;

  late ContractEvent _isVoting;

  late ContractEvent _error;

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
    dispatch(errors());

    //await voting();
  }

  getAbi() async {
    String abiStringFile =
        await rootBundle.loadString("src/artifacts/Ballot.json");
    var jsonFile = await jsonDecode(abiStringFile);
    _abiCode = jsonEncode(jsonFile["abi"]);
    _contractAddress =
        EthereumAddress.fromHex(jsonFile["networks"]["5777"]["address"]);
  }

  getCredentials() async {
    _credentials = EthPrivateKey.fromHex(_privateKey);
    owner = await _credentials.extractAddress();
  }

  getDeployedContract() async {
    contract = DeployedContract(
        ContractAbi.fromJson(_abiCode, "Ballot"), _contractAddress);

    _entry = contract.function("entry");
    _returnMappingValue = contract.function("returnMappingValue");

    _catCount = contract.function("returnCatCount");
    _returnCats = contract.function("returnCats");

    _isVoting = contract.event("isVoting");
    _error = contract.event("Error");
  }

  DeployedContract get contract => _contract;
  set contract(DeployedContract value) {
    _contract = value;
    notifyListeners();
  }

  // dep.app
  votervalid(String rid, BigInt id) async {
    isLoading = true;
    notifyListeners();
    await _client.sendTransaction(
        _credentials,
        Transaction.callContract(
            contract: contract, function: _entry, parameters: [rid, id]));
    // ignore: avoid_print
    print("Voter Registered $rid");
  }

  keyreturns(String rid) async {
    notifyListeners();

    var tvotes = await _client
        .call(contract: contract, function: _returnMappingValue, params: [rid]);
    return "$tvotes";
  }

  Future<BigInt> catCount() async {
    var numOfVotes =
        await _client.call(contract: contract, function: _catCount, params: []);
    return numOfVotes.first;
  }

  Future<List> returnCats(BigInt id) async {
    final List list = await _client
        .call(contract: contract, function: _returnCats, params: [id]);
    notifyListeners();
    print(list);
    return list;
  }

  // voting states event catcher
  Future<bool> votingState() async {
    final event = await _client
        .events(FilterOptions.events(contract: contract, event: _isVoting))
        .first;
    final decoded = _isVoting.decodeResults(event.topics!, event.data ?? '');
    final state = decoded[0] ?? '' as bool;
    notifyListeners();
    print(state);
    return state;
  }

  //event stream

  Stream<bool> transferEvents(
      {_i1.BlockNum? fromBlock, _i1.BlockNum? toBlock}) {
    final event = _isVoting;
    final filter = _i1.FilterOptions.events(
        contract: contract,
        event: event,
        fromBlock: fromBlock,
        toBlock: toBlock);
    return _client.events(filter).map((_i1.FilterEvent result) {
      final decoded = event.decodeResults(result.topics!, result.data!);
      var state = decoded[0] ?? '' as bool;
      notifyListeners();
      print(state);
      return state;
    });
  }

  // error catcher
  Stream<String> errors({_i1.BlockNum? fromBlock, _i1.BlockNum? toBlock}) {
    final event = _error;
    final filter = _i1.FilterOptions.events(
        contract: contract,
        event: event,
        fromBlock: fromBlock,
        toBlock: toBlock);
    return _client.events(filter).map((_i1.FilterEvent result) {
      final decoded = event.decodeResults(result.topics!, result.data!);
      var state = decoded[0] ?? '';
      notifyListeners();
      return state;
    });
  }

  // event dispatcher to front as toast
  void dispatch(stream) {
    stream.listen((event) {
      showsnak(event.toString());
    });
  }
}
