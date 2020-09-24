import 'package:flutter/material.dart';

import '../models/client.dart';
import '../database/database_provider.dart';

class Clients with ChangeNotifier {
  List<Client> _clients = [
    // Client(
    //   firstName: 'Jan',
    //   lastName: 'Kowalski',
    // ),
    // Client(
    //   firstName: 'Anna',
    //   lastName: 'Nowak',
    // ),
    // Client(
    //   firstName: 'Marek',
    //   lastName: 'Wojciechowski',
    // ),
    // Client(
    //   firstName: 'Kasia',
    //   lastName: 'Jankowska',
    // ),
  ];

  List<Client> get clients {
    return [..._clients];
  }

  Future<void> fetchClients() async {
    _clients = await DatabaseProvider.db.getClients();
    notifyListeners();
  }
}
