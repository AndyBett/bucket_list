import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class Mainscreen extends StatefulWidget {
  const Mainscreen({super.key});

  @override
  State<Mainscreen> createState() => _MainscreenState();
}

class _MainscreenState extends State<Mainscreen> {
  List<dynamic> bucketListData = [];

  Future<void> getData() async {
    try {
      Response response = await Dio().get(
          "https://fluttertestapi-123-default-rtdb.firebaseio.com/bucketlist.json");

      bucketListData = response.data;

      setState(() {});
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
      body: Column(
        children: [
          (ElevatedButton(onPressed: getData, child: Text("Get Data"))),
          Expanded(
            child: ListView.builder(
                itemCount: bucketListData.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListTile(
                      leading: CircleAvatar(
                        radius: 25,
                        backgroundImage:
                            NetworkImage(bucketListData[index]['Image'] ?? ""),
                      ),
                      title: Text(bucketListData[index]['Item'] ?? ""),
                      trailing:
                          Text(bucketListData[index]['Cost'].toString() ?? ""),
                    ),
                  );
                }),
          )
        ],
      ),
    );
  }
}
