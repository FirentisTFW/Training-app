import 'dart:core';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:training_app/ui/universal_components/loading_spinner.dart';
import 'package:training_app/widgets/no_items_added_yet_informator.dart';

import '../../../providers/clients.dart';
import '../../../providers/workout_programs.dart';
import '../../../widgets/main_drawer.dart';
import 'components/client_item.dart';
import 'components/app_bar_clients_screen.dart';

class ClientsScreen extends StatefulWidget {
  @override
  _ClientsScreenState createState() => _ClientsScreenState();
}

class _ClientsScreenState extends State<ClientsScreen> {
  var _isLoading = true;
  var counter = 0;

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    if (_isLoading) {
      await Provider.of<Clients>(context, listen: false).fetchClients();
      await Provider.of<WorkoutPrograms>(context, listen: false)
          .fetchWorkoutPrograms();

      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarClientsScreen(),
      drawer: MainDrawer(),
      body: _isLoading
          ? LoadingSpinner()
          : Consumer<Clients>(
              builder: (context, clients, _) => clients.clients.length == 0
                  ? NoItemsAddedYetInformator('No clients added yet.')
                  : ListView.builder(
                      itemCount: clients.clients.length,
                      itemBuilder: (ctx, index) => ClientItem(
                        clients.clients[index].id,
                        clients.clients[index].firstName,
                        clients.clients[index].lastName,
                      ),
                    ),
            ),
    );
  }
}
