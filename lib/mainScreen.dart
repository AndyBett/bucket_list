import 'package:flutter/material.dart';

class Mainscreen extends StatefulWidget {
  const Mainscreen({super.key});

  @override
  State<Mainscreen> createState() => _MainscreenState();
}

class _MainscreenState extends State<Mainscreen> {
  void getData() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bucket List"),
        centerTitle: true,
      ),
      body: Center(
          child: ElevatedButton(onPressed: getData, child: Text("Get Data"))),
    );
  }
}
