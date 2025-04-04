import 'package:bucket_list/Screens/add_screen.dart';
import 'package:bucket_list/Screens/view_screen.dart';
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
  bool isError = false;

  Future<void> getData() async {
    setState(() {
      isLoading = true;
    });
    try {
      Response response = await Dio().get(
          "https://fluttertestapi-123-default-rtdb.firebaseio.com/bucketlist.json");

      if (response.data is List) {
        bucketListData = response.data;
      } else {
        bucketListData = [];
      }

      isLoading = false;
      isError = false;

      setState(() {});
    } catch (e) {
      isLoading = false;
      isError = true;
      setState(() {});
    }
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  Widget errorWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.warning),
          Text("Error getting bucket list Data!"),
          ElevatedButton(onPressed: getData, child: Text("Try Again"))
        ],
      ),
    );
  }

  Widget ListDataWidget() {
    List<dynamic> filteredList = bucketListData
        .where((element) => !(element?["completed"] ?? false))
        .toList();

    return filteredList.length < 1
        ? Center(child: Text("No data on bucket List"))
        : ListView.builder(
            itemCount: bucketListData.length,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: (bucketListData[index] is Map &&
                        (!(bucketListData[index]?["completed"] ?? false)))
                    ? ListTile(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return Viewitem(
                              index: index,
                              title: bucketListData[index]['Item'] ?? " ",
                              image: bucketListData[index]['Image'] ?? " ",
                            );
                          })).then((value) {
                            if (value == "refresh") {
                              getData();
                            }
                          });
                        },
                        leading: CircleAvatar(
                          radius: 25,
                          backgroundImage: NetworkImage(
                              bucketListData[index]?['Image'] ?? ""),
                        ),
                        title: Text(bucketListData[index]?['Item'] ?? ""),
                        trailing: Text(
                            bucketListData[index]?['Cost'].toString() ?? ""),
                      )
                    : const SizedBox(),
              );
            });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return Addbucketlist(newIndex: bucketListData.length);
            })).then((value) {
              if (value == "refresh") {
                getData();
              }
            });
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
                : isError
                    ? errorWidget()
                    : bucketListData.length < 1
                        ? Center(child: Text("No Data on bucket list"))
                        : ListDataWidget()));
  }
}
