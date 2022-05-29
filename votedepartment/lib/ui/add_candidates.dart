import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:votedepartment/contract_link.dart';
import 'package:votedepartment/db/db.dart';
import 'package:votedepartment/msg.dart';
import 'package:votedepartment/services/storage.dart';

class AddCandidates extends StatelessWidget {
  AddCandidates({Key? key}) : super(key: key);

  bool isPicked = false;
  late FilePickerResult? result;

  @override
  Widget build(BuildContext context) {
    TextEditingController _name = TextEditingController();
    TextEditingController _party = TextEditingController();

    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          children: <Widget>[
            const SizedBox(
              height: 30.00,
            ),
            CupertinoFormSection.insetGrouped(
                backgroundColor: CupertinoColors.black,
                header: const Text('Add Candidate'),
                children: [
                  CupertinoTextFormFieldRow(
                    controller: _name,
                    prefix: const Icon(CupertinoIcons.person),
                    style: const TextStyle(color: Colors.white),
                    placeholder: 'name',
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a value';
                      }
                      return null;
                    },
                  ),
                  CupertinoTextFormFieldRow(
                    controller: _party,
                    prefix: const Icon(CupertinoIcons.person_2_square_stack),
                    style: const TextStyle(color: Colors.white),
                    placeholder: 'party',
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a value';
                      }
                      return null;
                    },
                  ),
                  IconButton(
                      onPressed: () async {
                        result = await FilePicker.platform.pickFiles();

                        if (result != null) {
                          isPicked = true;
                        }
                      },
                      icon: const Icon(Icons.file_upload_outlined)),
                ]),
            Padding(
              padding: const EdgeInsets.all(30.00),
              child: CupertinoButton.filled(
                onPressed: () async {
                  Storage _st = Storage();

                  await inputData(context, _name.text, _party.text);
                },
                child: const Text('Add'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> inputData(
      BuildContext context, String name, String party) async {
    var contractLink = Provider.of<ContractLinking>(context, listen: false);

    // image
    if (isPicked == true) {
      await contractLink.inititalSetup();

      // contract call
      await contractLink.addCandidate(name, party);

      BigInt id = await contractLink.returnCandidateID();

      // core
      Uint8List? fileBytes = result!.files.first.bytes;

      // Upload file
      Storage _fs = Storage();
      await _fs.upload(id.toString(), fileBytes);
    } else {
      showsnak("Please Select an image");
      print("vbruh");
    }

    // firebase add candidate id
    //final db = DatabaseService();
    // await db.addCandidate(id.toInt(), name, party);
  }
}
