import 'package:flutter_test/flutter_test.dart';
import 'package:training_app/models/client.dart';
import 'package:training_app/providers/clients.dart';
import 'package:mockito/mockito.dart';

class ClientsSpy extends Clients {
  final ClientsMock clientsMock;

  ClientsSpy(this.clientsMock);

  @override
  void notifyListeners() => clientsMock.notifyListeners();

  @override
  Future<String> readDataFromFile() async => clientsMock.readDataFromFile();
}

class ClientsMock extends Mock {
  Future<String> readDataFromFile();
  void notifyListeners();
}

void main() async {
  ClientsSpy clients;
  ClientsMock clientsMock;

  final clientsList = [
    Client(
      id: '1',
      birthDate: DateTime(1983, 04, 14),
      firstName: 'John',
      lastName: 'Doe',
      gender: Gender.Man,
      height: 175,
    ),
    Client(
      id: '2',
      birthDate: DateTime(1980, 02, 01),
      firstName: 'Stacy',
      lastName: 'Smith',
      gender: Gender.Woman,
      height: 165,
    )
  ];

  setUp(() {
    clientsMock = ClientsMock();
    clients = ClientsSpy(clientsMock);
  });

  group('Clients provider -', () {
    test('fetchClients() fetches data from file correctly', () async {
      when(clientsMock.readDataFromFile()).thenAnswer((_) async =>
          '[{"id":"1","firstName":"John","lastName":"Doe","gender":"Man","birthDate":"1983-04-14T00:00:00.000","height":175},'
          '{"id":"2","firstName":"Stacy","lastName":"Smith","gender":"Woman","birthDate":"1980-02-01T00:00:00.000","height":165}]');

      await clients.fetchClients();

      expect(clients.clients.length, 2);

      expect(clients.clients[0], clientsList[0]);
      expect(clients.clients[1], clientsList[1]);
      verify(clientsMock.notifyListeners());
    });

    test('addNewClient() works properly', () async {
      final clientToAdd = Client(
        id: '3',
        birthDate: DateTime(1980, 10, 20),
        firstName: 'Will',
        lastName: 'Johnson',
        gender: Gender.Man,
        height: 172,
      );

      when(clientsMock.readDataFromFile()).thenAnswer((_) async =>
          '[{"id":"1","firstName":"John","lastName":"Doe","gender":"Man","birthDate":"1983-04-14T00:00:00.000","height":175},'
          '{"id":"2","firstName":"Stacy","lastName":"Smith","gender":"Woman","birthDate":"1980-02-01T00:00:00.000","height":165}]');

      await clients.fetchClients();
      clients.addNewClient(clientToAdd);

      expect(clients.clients.length, 3);
      expect(clients.clients[2], clientToAdd);

      verify(clientsMock.notifyListeners());
    });

    test('getClientById() works properly', () async {
      when(clientsMock.readDataFromFile()).thenAnswer((_) async =>
          '[{"id":"1","firstName":"John","lastName":"Doe","gender":"Man","birthDate":"1983-04-14T00:00:00.000","height":175},'
          '{"id":"2","firstName":"Stacy","lastName":"Smith","gender":"Woman","birthDate":"1980-02-01T00:00:00.000","height":165}]');

      await clients.fetchClients();

      final client = clients.getClientById('2');

      expect(client, clientsList[1]);
    });

    test('getClientsByGender() works properly', () async {
      when(clientsMock.readDataFromFile()).thenAnswer((_) async =>
          '[{"id":"1","firstName":"John","lastName":"Doe","gender":"Man","birthDate":"1983-04-14T00:00:00.000","height":175},'
          '{"id":"2","firstName":"Stacy","lastName":"Smith","gender":"Woman","birthDate":"1980-02-01T00:00:00.000","height":165},'
          '{"id":"3","firstName":"Julia","lastName":"Dolan","gender":"Woman","birthDate":"1980-02-01T00:00:00.000","height":165},'
          '{"id":"4","firstName":"Margaret","lastName":"Cerny","gender":"Woman","birthDate":"1980-02-01T00:00:00.000","height":165}]');

      await clients.fetchClients();

      final womenByGender = clients.getClientsByGender(Gender.Woman);
      final menByGender = clients.getClientsByGender(Gender.Man);
      expect(womenByGender.length, 3);
      expect(menByGender.length, 1);
    });
  });
}
