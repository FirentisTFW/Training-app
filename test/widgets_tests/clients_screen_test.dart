import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import 'package:training_app/models/client.dart';
import 'package:training_app/providers/clients.dart';
import 'package:training_app/providers/workout_programs.dart';
import 'package:training_app/ui/screens/clients_screen/clients_screen.dart';
import 'package:training_app/ui/screens/clients_screen/components/client_item.dart';
import 'package:training_app/ui/universal_components/error_informator.dart';
import 'package:training_app/ui/universal_components/no_items_added_yet_informator.dart';

class ClientsSpy extends Clients {
  final ClientsMock clientsMock;

  ClientsSpy({@required this.clientsMock});

  @override
  Future<String> readDataFromFile() async => clientsMock.readDataFromFile();
}

class ClientsMock extends Mock {
  Future<String> readDataFromFile();
}

class WorkoutProgramsSpy extends WorkoutPrograms {
  final WorkoutProgramsMock programsMock;

  WorkoutProgramsSpy(this.programsMock);

  @override
  Future<String> readDataFromFile() async => programsMock.readDataFromFile();
}

class WorkoutProgramsMock extends Mock {
  Future<String> readDataFromFile();
}

void main() {
  group('ClientsScreenTest -', () {
    ClientsMock clientsMock;
    ClientsSpy clients;
    WorkoutProgramsSpy workoutPrograms;
    WorkoutProgramsMock programsMock;

    setUp(() {
      clientsMock = ClientsMock();
      clients = ClientsSpy(clientsMock: clientsMock);

      programsMock = WorkoutProgramsMock();
      workoutPrograms = WorkoutProgramsSpy(programsMock);
    });

    group('When clients and workout programs are properly fetched -', () {
      setUp(() {
        when(clientsMock.readDataFromFile()).thenAnswer((_) async =>
            '[{"id":"1","firstName":"John","lastName":"Doe","gender":"Man","birthDate":"1983-04-14T00:00:00.000","height":175},'
            '{"id":"2","firstName":"Stacy","lastName":"Smith","gender":"Woman","birthDate":"1980-02-01T00:00:00.000","height":165}]');

        when(programsMock.readDataFromFile()).thenAnswer((_) async => '[]');
      });

      testWidgets('Widget shows clients list', (tester) async {
        await _pumpScreenWithProviders(tester, clients, workoutPrograms);
        await tester.pump(Duration(seconds: 1));

        expect(find.byType(ClientItem), findsNWidgets(2));
        expect(find.text('John Doe'), findsOneWidget);
        expect(find.text('Stacy Smith'), findsOneWidget);
      });
      testWidgets(
          'After adding a client to provider, widget rebuilds itself and shows new client item',
          (tester) async {
        await _pumpScreenWithProviders(tester, clients, workoutPrograms);
        await tester.pump(Duration(seconds: 1));

        expect(find.text('Will Stewart'), findsNothing);

        clients.addNewClient(_clientToAdd);

        await tester.pump(Duration(seconds: 1));
        expect(find.text('Will Stewart'), findsOneWidget);
      });
      testWidgets(
          'When sorted by gender, widget shows only clients of that gender',
          (tester) async {
        await _pumpScreenWithProviders(tester, clients, workoutPrograms);
        await tester.pump(Duration(seconds: 1));

        // show men
        await tester.tap(find.byIcon(Icons.more_vert));
        await tester.pumpAndSettle();
        await tester.tap(find.text('Show Only Men'));
        await tester.pump();

        expect(find.text('John Doe'), findsOneWidget);
        expect(find.text('Stacy Smith'), findsNothing);

        // show women
        await tester.tap(find.byIcon(Icons.more_vert));
        await tester.pumpAndSettle();
        await tester.tap(find.text('Show Only Women'));
        await tester.pump();

        expect(find.text('John Doe'), findsNothing);
        expect(find.text('Stacy Smith'), findsOneWidget);

        // show all clients
        await tester.tap(find.byIcon(Icons.more_vert));
        await tester.pumpAndSettle();
        await tester.tap(find.text('Show All Clients'));
        await tester.pump();

        expect(find.text('John Doe'), findsOneWidget);
        expect(find.text('Stacy Smith'), findsOneWidget);
      });
    });
  });
}

Future<void> _pumpScreenWithProviders(WidgetTester tester, Clients clients,
    WorkoutPrograms workoutPrograms) async {
  await tester.pumpWidget(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<Clients>.value(value: clients),
        ChangeNotifierProvider<WorkoutPrograms>.value(value: workoutPrograms),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        initialRoute: '/',
        routes: {
          '/': (_) => ClientsScreen(),
        },
      ),
    ),
  );
}

final _clientToAdd = Client(
  id: '3',
  firstName: 'Will',
  lastName: 'Stewart',
  gender: Gender.Man,
  birthDate: DateTime(1995, 02, 03),
  height: 175,
);
