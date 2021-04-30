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
import 'package:training_app/ui/universal_components/loading_spinner.dart';

import '../setup/mocks_and_spies.dart';

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

    testWidgets('When first created, widget shows loading spinner',
        (tester) async {
      await _pumpScreenWithProviders(tester, clients, workoutPrograms);
      expect(find.byType(LoadingSpinner), findsOneWidget);
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
        await tester.pump();

        expect(find.byType(ClientItem), findsNWidgets(2));
        expect(find.text('John Doe'), findsOneWidget);
        expect(find.text('Stacy Smith'), findsOneWidget);

        expect(find.byType(ErrorInformator), findsNothing);
      });
      testWidgets(
          'After adding a client to provider, widget rebuilds itself and shows new client item',
          (tester) async {
        await _pumpScreenWithProviders(tester, clients, workoutPrograms);
        await tester.pump();

        expect(find.text('Will Stewart'), findsNothing);

        clients.addNewClient(_clientToAdd);

        await tester.pump();
        expect(find.text('Will Stewart'), findsOneWidget);
      });
      testWidgets(
          'When sorted by gender, widget shows only clients of that gender',
          (tester) async {
        await _pumpScreenWithProviders(tester, clients, workoutPrograms);
        await tester.pump();

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
    testWidgets(
        'When there is an exception when fetching clients or workout programs, widget shows error message',
        (tester) async {
      when(clientsMock.readDataFromFile())
          .thenThrow(Exception('Some exception'));
      when(programsMock.readDataFromFile())
          .thenThrow(Exception('Some exception'));

      await _pumpScreenWithProviders(tester, clients, workoutPrograms);
      await tester.pump();

      expect(find.byType(ErrorInformator), findsOneWidget);
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
