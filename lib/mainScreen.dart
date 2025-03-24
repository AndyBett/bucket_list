import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class Mainscreen extends StatefulWidget {
  const Mainscreen({super.key});

  @override
  State<Mainscreen> createState() => _MainscreenState();
}

class _MainscreenState extends State<Mainscreen> {
  Future<void> getData() async {
    try {
      Response response = await Dio().get(
          "https://fluttertestapi-123-default-rtdb.firebaseio.com/bucketlist.json");

      print(response.statusCode);
    } catch (e) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text("Apologies,"),
              content: Text(
                  "There is an issue with the server, try after a few seconds"),
            );
          });
    }
  }

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
