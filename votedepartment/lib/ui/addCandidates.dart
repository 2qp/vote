import 'package:flutter/cupertino.dart';

class AddCandidates extends StatelessWidget {
  const AddCandidates({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: CupertinoFormSection(
              header: const Text("Add Candidate Data"),
              children: [
                CupertinoFormRow(
                    child: CupertinoTextFormFieldRow(
                  placeholder: "Candidate name",
                )),
                CupertinoFormRow(
                    child: CupertinoTextFormFieldRow(
                  placeholder: "Candidate's party",
                ))
              ]),
        ),
      ),
    );
  }
}
