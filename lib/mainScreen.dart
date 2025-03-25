import 'package:bucket_list/addBucketList.dart';
import 'package:bucket_list/viewItem.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class Mainscreen extends StatefulWidget {
  const Mainscreen({super.key});

  @override
  State<Mainscreen> createState() => _MainscreenState();
}

class _MainscreenState extends State<Mainscreen> {
  List<dynamic> bucketListData = [];
  bool isLoading = false;

  Future<void> getData() async {
    setState(() {
      isLoading = true;
    });
    try {
      Response response = await Dio().get(
          "https://fluttertestapi-123-default-rtdb.firebaseio.com/bucketlist.json");

      bucketListData = response.data;

      isLoading = false;

      setState(() {});
    } catch (e) {
      isLoading = false;
      setState(() {});
      showDialog(
          context: context,
          builder: (context) {
            return const AlertDialog(
              title: Text("Apologies,"),
              content: Text(
                  "There is an issue with the server, try after a few seconds"),
            );
          });
    }
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return Addbucketlist();
            }));
          },
          child: Icon(Icons.add),
          shape: CircleBorder(),
        ),
        appBar: AppBar(
          title: const Text("Bucket List"),
          centerTitle: true,
          actions: [
            InkWell(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(Icons.refresh),
              ),
              onTap: getData,
            )
          ],
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            getData();
          },
          child: isLoading
              ? Center(child: CircularProgressIndicator())
              : ListView.builder(
                  itemCount: bucketListData.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListTile(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return Viewitem(
                              title: bucketListData[index]['Item'] ?? "",
                              image: bucketListData[index]['Image'] ?? "",
                            );
                          }));
                        },
                        leading: CircleAvatar(
                          radius: 25,
                          backgroundImage: NetworkImage(
                              bucketListData[index]['Image'] ?? ""),
                        ),
                        title: Text(bucketListData[index]['Item'] ?? ""),
                        trailing: Text(
                            bucketListData[index]['Cost'].toString() ?? ""),
                      ),
                    );
                  }),
        ));
  }
}
