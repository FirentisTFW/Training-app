import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:training_app/screens/add_client_screen.dart';

import '../providers/clients.dart';
import '../widgets/main_drawer.dart';
import '../widgets/client_item.dart';

class ClientsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final clientsData = Provider.of<Clients>(context);
    final clients = clientsData.clients;
    return Scaffold(
      appBar: AppBar(
        title: Text('Clients'),
        actions: [
          IconButton(
            icon: Icon(
              Icons.add,
              size: 30,
              color: Theme.of(context).accentColor,
            ),
            onPressed: () {
              Navigator.of(context).pushNamed(AddClientScreen.routeName);
            },
          ),
          PopupMenuButton(
            onSelected: (selectedValue) {},
            icon: Icon(Icons.more_vert),
            itemBuilder: (_) => [
              PopupMenuItem(
                child: Text('Show Only Men'),
                value: 'aa',
              ),
              PopupMenuItem(
                child: Text('Show Only Women'),
                value: 'aa',
              ),
            ],
          ),
        ],
      ),
      drawer: MainDrawer(),
      body: ListView.builder(
        itemCount: clients.length,
        itemBuilder: (ctx, index) {
          return ClientItem(
            clients[index].firstName,
            clients[index].lastName,
          );
        },
      ),
    );
  }
}
