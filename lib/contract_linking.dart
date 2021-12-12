import 'dart:convert';
import 'dart:ffi';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:web3dart/web3dart.dart';
import 'package:web_socket_channel/io.dart';

class ContractLinking extends ChangeNotifier {
  final String _rpcUrl = "http://127.0.0.1:7545";
  final String _wsUrl = "ws://127.0.0.1:7545/";
  final String _privateKey =
      "def10b44ed1b7cd4dda92877f5d42d8bc7730b2c93ebcbe78e67831f12c0815f";
  late EthereumAddress owner;

  late Web3Client _client;
  late String _abiCode;

  late Credentials _credentials;

  late EthereumAddress _contractAddress;

  late DeployedContract _contract;
  late ContractFunction _voting;
  late ContractFunction _addCandidate;
  late ContractFunction _voteFunc;
  late ContractFunction _totalVotes;
  late ContractFunction _numOfCandidates;
  late ContractFunction _numOfVoters;
  late ContractFunction _getCandidate;

  bool isLoading = true;

  ContractLinking() {
    inititalSetup();
  }

  inititalSetup() async {
    _client = Web3Client(_rpcUrl, Client(), socketConnector: () {
      return IOWebSocketChannel.connect(_wsUrl).cast<String>();
    });
    await getAbi();
    await getCredentials();
    await getDeployedContract();
    await voting();
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

    _addCandidate = _contract.function("addCandidate");
    _voteFunc = _contract.function("vote");
    _totalVotes = _contract.function("totalVotes");
    _numOfCandidates = _contract.function("getNumOfCandidates");
    _numOfVoters = _contract.function("getNumOfVoters");
    _getCandidate = _contract.function("getCandidate");
    _voting = _contract.function("Voting");
  }

  voting() async {
    await _client.call(contract: _contract, function: _voting, params: []);
  }

  registerVoter(Uint8List name, Uint8List party) async {
    isLoading = true;
    notifyListeners();
    await _client.sendTransaction(
        _credentials,
        Transaction.callContract(
            contract: _contract,
            function: _addCandidate,
            parameters: [name, party]));
    getNumOfCandidates();
    print("Voter Registered $name");
  }

  vote(String uid, String candidateID) async {
    isLoading = true;
    notifyListeners();
    await _client.sendTransaction(
        _credentials,
        Transaction.callContract(
            contract: _contract,
            function: _voteFunc,
            parameters: [(uid), candidateID]));
    //getChairperson();
  }

  getNumOfCandidates() async {
    notifyListeners();
    await _client.sendTransaction(
        _credentials,
        Transaction.callContract(
            contract: _contract, function: _numOfCandidates, parameters: []));
  }

  getNumOfVoters() async {
    notifyListeners();
    await _client.sendTransaction(
        _credentials,
        Transaction.callContract(
            contract: _contract, function: _numOfVoters, parameters: []));
  }

  getCandidate(BigInt candidateID) async {
    notifyListeners();
    var candida = await _client.sendTransaction(
        _credentials,
        Transaction.callContract(
            contract: _contract,
            function: _getCandidate,
            parameters: [candidateID]));

    // ignore: avoid_print
    return candida;
  }

  winner() async {
    var numOfVotes = await _client
        .call(contract: _contract, function: _totalVotes, params: []);
    return numOfVotes;
  }
}
