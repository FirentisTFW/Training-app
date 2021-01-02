import 'package:flutter_test/flutter_test.dart';
import 'package:training_app/models/client.dart';
import 'package:training_app/providers/clients.dart';

class MockClients extends Clients {
  @override
  Future<String> readDataFromFile() async {
    return '[{"id":"2020-09-27 10:54:08.975614","firstName":"Jan","lastName":"Kowalski","gender":"Man","birthDate":"1983-04-14T00:00:00.000","height":175,"bodyweight":76},{"id":"2020-09-27 10:55:29.392643","firstName":"Anna","lastName":"Nowakowska","gender":"Woman","birthDate":"1980-02-01T00:00:00.000","height":165,"bodyweight":56}]';
  }
}

void main() async {
  final mockClients = MockClients();
  await mockClients.fetchClients();

  group('Clients provider fetches data correctly', () {
    test('_clients has correct length', () {
      expect(mockClients.clients.length, 2);
    });

    test('first client is fetched correctly', () {
      expect(mockClients.clients[0].firstName, 'Jan');
      expect(mockClients.clients[0].lastName, 'Kowalski');
      expect(mockClients.clients[0].height, 175);
    });

    test('getClientById() works properly', () {
      final client = mockClients.getClientById('2020-09-27 10:54:08.975614');

      expect(client.firstName, 'Jan');
    });
  });

  group('Adding new clients works properly', () {
    final clientToAdd = Client(
      id: '012345',
      birthDate: DateTime(1980, 10, 20),
      firstName: 'Maciej',
      lastName: 'Mankiewicz',
      gender: Gender.Man,
      height: 172,
    );

    test('Adding new client increases _clients length', () {
      mockClients.addNewClient(clientToAdd);
      expect(mockClients.clients.length, 3);
    });

    test('Added client has all parameters set properly', () {
      expect(mockClients.clients[2].id, '012345');
      expect(mockClients.clients[2].birthDate, DateTime(1980, 10, 20));
      expect(mockClients.clients[2].firstName, 'Maciej');
      expect(mockClients.clients[2].lastName, 'Mankiewicz');
      expect(mockClients.clients[2].gender, 'Man');
      expect(mockClients.clients[2].height, 172);
    });
  });
}
