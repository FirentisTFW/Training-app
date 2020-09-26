import 'dart:io';
import 'dart:convert';

import 'package:flutter/material.dart';

import '../models/client.dart';
import '../database/storage_provider.dart';

class Clients with ChangeNotifier {
  List<Client> _clients = [
    // Client(
    //   id: "aasdasd23123",
    //   firstName: 'Jan',
    //   lastName: 'Kowalski',
    //   gender: "Man",
    //   height: 178,
    //   bodyweight: 78,
    // ),
    // Client(
    //   id: "aasdasd231adsadasd23",
    //   firstName: 'KAsia',
    //   lastName: 'Kowalska',
    //   gender: "Man",
    //   height: 178,
    //   bodyweight: 78,
    // ),
  ];

  List<Client> get clients {
    return [..._clients];
  }

  Future<void> fetchClients() async {
    final fileData = await readDataFromFile();
    final clientMap = jsonDecode(fileData) as List;
    _clients = clientMap.map((client) => Client.fromJson(client)).toList();

    notifyListeners();
  }

  Future<File> get localFile async {
    final path = await StorageProvider.localPath;
    return File('$path/clients.json');
  }

  void addNewClient(Client newClient) {
    _clients.add(newClient);

    notifyListeners();
  }

  Future<File> writeToFile() async {
    final file = await localFile;
    final clientsInJson = jsonEncode(clients);
    return file.writeAsString(clientsInJson.toString());
  }

  Future<String> readDataFromFile() async {
    try {
      final file = await localFile;
      String content = await file.readAsString();
      return content;
    } catch (e) {
      return "An error occured";
    }
  }
}
