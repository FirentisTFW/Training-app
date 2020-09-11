import 'package:flutter/material.dart';

import '../models/client.dart';

class AddClientScreen extends StatefulWidget {
  static const routeName = '/add-client';

  @override
  _AddClientScreenState createState() => _AddClientScreenState();
}

class _AddClientScreenState extends State<AddClientScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Client'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Form(
          child: ListView(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'First Name'),
                textInputAction: TextInputAction.next,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Last Name'),
                textInputAction: TextInputAction.next,
              ),
              DropdownButtonFormField(
                items: [
                  DropdownMenuItem(
                    value: 'Man',
                    child: Row(
                      children: [
                        Icon(Icons.donut_small),
                        Text('Man'),
                      ],
                    ),
                  ),
                  DropdownMenuItem(
                    value: 'Woman',
                    child: Text('Woman'),
                  ),
                ],
                onChanged: (value) {},
              )
            ],
          ),
        ),
      ),
    );
  }
}
