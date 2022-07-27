import 'package:flutter/material.dart';

class ProductGridPage extends StatelessWidget {
  ProductGridPage({Key? key}) : super(key: key);
  final gridView = List<String>.generate(50, (index) => 'null');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Product Grid"),
        backgroundColor: Colors.lightBlue.shade300,
        centerTitle: true,
      ),
      body: GridView.builder(
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(5.0),
        itemCount: gridView.length,

        //builder
        itemBuilder: (BuildContext context, int index) {
          return Card(
            color: Colors.lightBlue.shade100,
            child: Container(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset("image/flutter.png"),
                  Text("Product No ${index + 1}")
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
