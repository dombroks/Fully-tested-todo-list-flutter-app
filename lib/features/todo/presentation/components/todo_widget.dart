import 'package:flutter/material.dart';

class TodoWidget extends StatelessWidget {
  final String title;
  const TodoWidget({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      child: Container(
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                      icon: Icon(
                        Icons.delete,
                        size: 20,
                        color: Colors.grey,
                      ),
                      onPressed: () {})
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
