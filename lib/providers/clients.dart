import 'dart:io';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:training_app/services/storage_service.dart';

import '../models/client.dart';

class Clients with ChangeNotifier {
  static const String _clientsFileName = 'clients.json';

  List<Client> _clients = [];

  List<Client> get clients => _clients;

  List<Client> getClientsByGender(Gender gender) {
    var filteredClients = _clients;

    if (gender != null) {
      filteredClients =
          _clients.where((client) => client.gender == gender).toList();
    }

    return filteredClients;
  }

  Client getClientById(String id) =>
      _clients.firstWhere((client) => client.id == id);

  void addNewClient(Client newClient) {
    _clients.add(newClient);

    notifyListeners();
  }

  // STORAGE MANAGEMENT

  Future<File> get _localFile async {
    final path = await StorageService.localPath;
    return File('$path/$_clientsFileName');
  }

  Future<void> fetchClients() async {
    final fileData = await readDataFromFile();

    if (fileData != null) {
      final clientMap = jsonDecode(fileData) as List;
      _clients = clientMap.map((client) => Client.fromJson(client)).toList();
    }

    notifyListeners();
  }

  Future<String> readDataFromFile() async {
    final file = await _localFile;

    if (await file.exists()) {
      String content = await file.readAsString();
      return content;
    }
    return null;
  }

  Future<void> writeToFile() async {
    final file = await _localFile;
    final clientsInJson = jsonEncode(_clients);
    await file.writeAsString(clientsInJson.toString());

    notifyListeners();
  }
}
