import 'package:flutter/material.dart';

class Addbucketlist extends StatefulWidget {
  const Addbucketlist({super.key});

  @override
  State<Addbucketlist> createState() => _AddbucketlistState();
}

class _AddbucketlistState extends State<Addbucketlist> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
      title: Text("Add Bucket List"),
    ));
  }
}
