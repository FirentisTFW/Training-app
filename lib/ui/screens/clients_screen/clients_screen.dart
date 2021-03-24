import 'dart:core';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:training_app/models/client.dart';
import 'package:training_app/providers/workout_programs.dart';
import 'package:training_app/ui/universal_components/error_informator.dart';
import 'package:training_app/ui/universal_components/loading_spinner.dart';
import 'package:training_app/ui/universal_components/no_items_added_yet_informator.dart';

import '../../../providers/clients.dart';
import '../../universal_components/main_drawer.dart';
import 'components/client_item.dart';
import 'components/app_bar_clients_screen.dart';

class ClientsScreen extends StatefulWidget {
  @override
  _ClientsScreenState createState() => _ClientsScreenState();
}

class _ClientsScreenState extends State<ClientsScreen> {
  var _isLoading = true;
  bool _hasError = false;
  Gender _genderFilter;

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    await _fetchWorkoutPrograms();
  }

  @override
  Widget build(BuildContext context) {
    _fetchClients();
    return Scaffold(
      appBar: AppBarClientsScreen(filterByGender),
      drawer: MainDrawer(),
      body: _isLoading
          ? LoadingSpinner()
          : Consumer<Clients>(
              builder: (context, clients, _) => _hasError
                  ? ErrorInformator('An error occured. Try again.')
                  : clients.clients.length == 0
                      ? NoItemsAddedYetInformator('No clients added yet.')
                      : ListView(
                          children: clients
                              .getClientsByGender(_genderFilter)
                              .map((client) => ClientItem(
                                    client.id,
                                    client.firstName,
                                    client.lastName,
                                  ))
                              .toList(),
                        ),
            ),
    );
  }

  void filterByGender(Gender gender) {
    setState(() {
      _genderFilter = gender;
      _isLoading = true;
      if (gender == Gender.Unknown) {
        _genderFilter = null;
      }
    });
  }

  Future<void> _fetchClients() async {
    super.didChangeDependencies();
    if (_isLoading) {
      try {
        await Provider.of<Clients>(context, listen: false).fetchClients();
      } catch (err) {
        _hasError = true;
      }

      setState(() => _isLoading = false);
    }
  }

  Future<void> _fetchWorkoutPrograms() async {
    try {
      await Provider.of<WorkoutPrograms>(context, listen: false)
          .fetchWorkoutPrograms();
    } catch (err) {
      _hasError = true;
    }
  }
}
