import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:training_app/screens/add_client_screen.dart';

import '../providers/clients.dart';
import '../widgets/main_drawer.dart';
import '../widgets/client_item.dart';

class ClientsScreen extends StatefulWidget {
  @override
  _ClientsScreenState createState() => _ClientsScreenState();
}

class _ClientsScreenState extends State<ClientsScreen> {
  var _isLoading = true;

  @override
  void didChangeDependencies() {
    if (_isLoading) {
      Provider.of<Clients>(context).fetchClients().then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: try to use Consumer instead of Provider
    final clientsData = Provider.of<Clients>(context);
    final clients = clientsData.clients;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Clients'),
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
                child: const Text('Show Only Men'),
                value: 'aa',
              ),
              PopupMenuItem(
                child: const Text('Show Only Women'),
                value: 'aa',
              ),
            ],
          ),
        ],
      ),
      drawer: MainDrawer(),
      body: _isLoading
          ? Container(child: CircularProgressIndicator())
          : ListView.builder(
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
