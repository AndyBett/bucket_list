import 'package:flutter/material.dart';

class Viewitem extends StatefulWidget {
  String title;
  String image;

  Viewitem({super.key, required this.title, required this.image});

  @override
  State<Viewitem> createState() => _ViewitemState();
}

class _ViewitemState extends State<Viewitem> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          PopupMenuButton(onSelected: (value) {
            if (value == 1)
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text("Are you sure want to delete?"),
                      actions: [
                        InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Text("Cancel")),
                        SizedBox(),
                        Text("Confirm")
                      ],
                    );
                  });
          }, itemBuilder: (context) {
            return [
              PopupMenuItem(value: 1, child: Text("Delete")),
              PopupMenuItem(value: 2, child: Text("Mark as done"))
            ];
          })
        ],
        title: Text("${widget.title}"),
      ),
      body: Column(
        children: [
          Container(
            height: 300,
            width: double.infinity,
            decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover, image: NetworkImage(widget.image))),
          ),
        ],
      ),
    );
  }
}
