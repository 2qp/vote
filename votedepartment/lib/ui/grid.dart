import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Grid extends StatelessWidget {
  const Grid({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: GridView.count(
          crossAxisCount: 3,
          crossAxisSpacing: 10,
          primary: false,
          padding: const EdgeInsets.all(1.5),
          childAspectRatio: 1,
          mainAxisSpacing: 1.0,
          shrinkWrap: true,
          children: List.generate(
            6,
            (index) {
              return Card(
                  child: InkWell(
                onTap: () {
                  print("clicked");
                },
                child: Container(
                  color: Colors.grey,
                  child: const Center(
                    child: Icon(CupertinoIcons.settings_solid),
                  ),
                ),
              ));
            },
          ),
        ),
      ),
    );
  }
}
