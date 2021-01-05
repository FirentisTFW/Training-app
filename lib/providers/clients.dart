import 'dart:io';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:training_app/services/storage_service.dart';

import '../models/client.dart';

class Clients with ChangeNotifier {
  List<Client> _clients = [];

  List<Client> get clients => _clients;

  Client getClientById(String id) =>
      _clients.firstWhere((client) => client.id == id);

  void addNewClient(Client newClient) {
    _clients.add(newClient);

    notifyListeners();
  }

  // STORAGE MANAGEMENT

  Future<File> get localFile async {
    final path = await StorageService.localPath;
    return File('$path/${StorageService.clientsFileName}');
  }

  Future<void> fetchClients() async {
    final fileData = await readDataFromFile();
    final clientMap = jsonDecode(fileData) as List;
    _clients = clientMap.map((client) => Client.fromJson(client)).toList();

    notifyListeners();
  }

  Future<void> writeToFile() async {
    final file = await localFile;
    final clientsInJson = jsonEncode(_clients);
    await file.writeAsString(clientsInJson.toString());

    notifyListeners();
  }

  Future<String> readDataFromFile() async {
    final file = await localFile;
    String content = await file.readAsString();
    return content;
  }
}
