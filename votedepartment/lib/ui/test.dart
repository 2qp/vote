import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:votedepartment/contract_link.dart';
import 'package:votedepartment/func/signup.dart';
import 'package:votedepartment/scoped/picker1.dart';

/*
 architecture
 stless {
   Widget build {
     ChangeNotifierProvider(
       Consumer(
         consumes changes by picker.tostring
       )
     )
   }

   Widget Cat {
     FutureProvider(
       Consumer(
         consumes future list from contract
         ChangeNotifierProvider(
           calls model change on selectionchange
         )
       )
     )
   }
 }


 */

class Sign extends StatelessWidget {
  final Picker pickerInstance = Picker();
  Sign({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController username = TextEditingController();
    TextEditingController password = TextEditingController();

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: username,
              decoration: const InputDecoration(
                hintText: "Email",
                border: OutlineInputBorder(),
                suffixIcon: Icon(
                  Icons.check_circle,
                ),
              ),
            ),
            TextField(
              controller: password,
              decoration: const InputDecoration(
                hintText: "Password",
                border: OutlineInputBorder(),
                suffixIcon: Icon(
                  Icons.check_circle,
                ),
              ),
            ),
            // picker trigger
            ChangeNotifierProvider<Picker>(
              create: (_) => pickerInstance,
              child: Consumer<Picker>(
                  builder: (context, model, _) => Column(
                        children: <Widget>[
                          Text(model.pick.selectedString.toString()),

                          // btn
                          OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              primary: Colors.black,
                              backgroundColor: Colors.white,
                            ),
                            onPressed: () async {
                              reg(context, username.text, password.text,
                                  model.pick.selectedItem);
                              //contractLink.registerVoter(Parse, canid.text);
                            },
                            child: const Text('Register'),
                          ),
                        ],
                      )),
            ),
            // btn
            OutlinedButton(
              style: OutlinedButton.styleFrom(
                primary: Colors.black,
                backgroundColor: Colors.white,
              ),
              onPressed: () async {
                catList(context);
                //contractLink.registerVoter(Parse, canid.text);
              },
              child: const Text('Show List'),
            ),

            Padding(
              padding: const EdgeInsets.all(50.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  // padding: const EdgeInsets.all(20.0),

                  const SizedBox(
                    height: 10.0,
                  ),

                  // candidate data
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void catList(context) {
    var link = Provider.of<ContractLinking>(context, listen: false);

    showCupertinoModalPopup(
        context: context,
        builder: (BuildContext build) {
          return FutureProvider<List>(
            initialData: const [],
            create: (_) {
              // print('calling future');
              return load(context);
            },
            child: Consumer<List>(
              builder: (_, value, __) => Center(
                child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: value.isEmpty && link.isLoading
                        ? const Center(
                            child: CupertinoActivityIndicator(),
                          )
                        : SizedBox(
                            height: 250,
                            width: 300,
                            child: ChangeNotifierProvider<Picker>(
                              create: (_) => pickerInstance,
                              child: CupertinoPicker.builder(
                                  diameterRatio: 360.0,
                                  useMagnifier: true,
                                  magnification: 1.0,
                                  backgroundColor: Colors.white,
                                  offAxisFraction: 100.0,
                                  selectionOverlay:
                                      const CupertinoPickerDefaultSelectionOverlay(
                                    background: Colors.transparent,
                                  ),
                                  childCount: value.length,
                                  itemExtent: 25,
                                  onSelectedItemChanged: (g) {
                                    pickerInstance.changed(
                                        g, value[g][1].toString());
                                  },
                                  itemBuilder: (_, int index) =>
                                      Text(value[index][1].toString())),
                            ),
                          )),
              ),
            ),
          );
        });
  }
}

// Drop Down

// future func
Future<List> load(context) async {
  var link = Provider.of<ContractLinking>(context, listen: false);
  List data = await link.returnCats();
  return data;
}
// End

void reg(BuildContext context, String email, String pass, int id) async {
  final auth = Auth();

  await auth.sign(email, pass, id);
}
