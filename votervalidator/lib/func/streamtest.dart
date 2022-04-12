import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'contract_link.dart';

class Streamers extends StatefulWidget {
  const Streamers({Key? key}) : super(key: key);

  @override
  State<Streamers> createState() => _StreamersState();
}

class _StreamersState extends State<Streamers> {
  @override
  Widget build(BuildContext context) {
    var link = Provider.of<ContractLinking>(context, listen: false);
    return Scaffold(
      body: Center(
          child: StreamBuilder<bool>(
              stream: link.transferEvents(),
              builder: (BuildContext context, AsyncSnapshot<bool> snapshot) =>
                  (Text(snapshot.data.toString())))),
    );
  }
}
