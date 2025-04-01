import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class Addbucketlist extends StatefulWidget {
  int newIndex;
  Addbucketlist({super.key, required this.newIndex});

  @override
  State<Addbucketlist> createState() => _AddbucketlistState();
}

class _AddbucketlistState extends State<Addbucketlist> {
  TextEditingController itemText = TextEditingController();

  TextEditingController costText = TextEditingController();

  TextEditingController imageURLText = TextEditingController();

  Future<void> AddData() async {
    try {
      Map<String, dynamic> data = {
        "Cost": costText.text,
        "Image": imageURLText.text,
        "Item": itemText.text,
        "completed": true
      };

      Response response = await Dio().patch(
          "https://fluttertestapi-123-default-rtdb.firebaseio.com/bucketlist/${widget.newIndex}.json",
          data: data);

      Navigator.pop(context, "refresh");
    } catch (e) {
      print("error");
    }
  }

  @override
  Widget build(BuildContext context) {
    var addForm = GlobalKey<FormState>();

    return Scaffold(
        appBar: AppBar(
          title: Text("Add Bucket List"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: addForm,
            child: Column(
              children: [
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (value.toString().length < 3) {
                      return "Must be more than 3 characters";
                    }
                    if (value == null || value.isEmpty) {
                      return "This must not be empty";
                    }
                  },
                  controller: itemText,
                  decoration: InputDecoration(label: Text("Item")),
                ),
                SizedBox(
                  height: 30,
                ),
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (value.toString().length < 3) {
                      return "Must be more than 3 characters";
                    }
                    if (value == null || value.isEmpty) {
                      return "This must not be empty";
                    }
                  },
                  controller: costText,
                  decoration: InputDecoration(label: Text("Estimated Cost")),
                ),
                SizedBox(
                  height: 30,
                ),
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (value.toString().length < 3) {
                      return "Must be more than 3 characters";
                    }
                    if (value == null || value.isEmpty) {
                      return "This must not be empty";
                    }
                  },
                  controller: imageURLText,
                  decoration: InputDecoration(label: Text("Image URL")),
                ),
                SizedBox(
                  height: 30,
                ),
                Row(
                  children: [
                    Expanded(
                        child: ElevatedButton(
                            onPressed: () {
                              if (addForm.currentState!.validate()) {
                                print("success");
                              } else {
                                print("Something is Wrong");
                              }
                            },
                            child: Text("Add Item"))),
                  ],
                )
              ],
            ),
          ),
        ));
  }
}
