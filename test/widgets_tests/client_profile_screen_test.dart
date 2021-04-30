import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:training_app/models/client.dart';
import 'package:training_app/providers/clients.dart';
import 'package:training_app/providers/workouts.dart';
import 'package:training_app/ui/screens/client_profile_screen/client_profile_screen.dart';
import 'package:training_app/ui/universal_components/error_informator.dart';
import 'package:training_app/ui/universal_components/loading_spinner.dart';
import 'package:mockito/mockito.dart';

import '../setup/mocks_and_spies.dart';

void main() {
  group('ClientProfileScreenTest -', () {
    ClientsMock clientsMock;
    ClientsSpy clients;
    WorkoutsSpy workouts;
    WorkoutsMock workoutsMock;

    setUp(() {
      clientsMock = ClientsMock();
      clients = ClientsSpy(clientsMock: clientsMock);

      workoutsMock = WorkoutsMock();
      workouts = WorkoutsSpy(workoutsMock);
    });

    setUp(() {
      when(clientsMock.getClientById(any)).thenReturn(_client);
    });

    testWidgets('When first created, widget shows loading spinner',
        (tester) async {
      await _pumpScreenWithProviders(tester, clients, workouts);
      expect(find.byType(LoadingSpinner), findsOneWidget);
    });
    group('When workouts are successfully fetched -', () {
      setUp(() {
        when(workoutsMock.readDataFromFile()).thenAnswer((_) async =>
            '[{"id":"W1","clientId":"1","date":"2021-01-02T00:00:00.000","programName":"PULL","exercises":[{"name":"Pull Ups","sets":[{"reps":10,"weight":0,"exerciseType":"ForRepetitions"},{"reps":10,"weight":0,"exerciseType":"ForRepetitions"}]},{"name":"Australian Pull Ups","sets":[{"reps":15,"weight":0,"exerciseType":"ForRepetitions"},{"reps":15,"weight":0,"exerciseType":"ForRepetitions"}]}]},'
            '{"id":"W2","clientId":"2","date":"2021-01-05T00:00:00.000","programName":"PUSH","exercises":[{"name":"Dips","sets":[{"reps":10,"weight":0,"exerciseType":"ForRepetitions"},{"reps":10,"weight":0,"exerciseType":"ForRepetitions"}]},{"name":"Push Ups","sets":[{"reps":15,"weight":0,"exerciseType":"ForRepetitions"},{"reps":15,"weight":0,"exerciseType":"ForRepetitions"}]}]}]');
      });

      testWidgets('Widget displays clients first and last name',
          (tester) async {
        await _pumpScreenWithProviders(tester, clients, workouts);
        await tester.pump();

        expect(find.text('John'), findsOneWidget);
        expect(find.text('Doe'), findsOneWidget);
      });
      testWidgets('Widget displays date of last workout', (tester) async {
        when(workoutsMock.getLastWorkoutDateByClientId(any))
            .thenReturn(DateTime(2021, 01, 05));

        await _pumpScreenWithProviders(tester, clients, workouts);
        await tester.pump();

        expect(find.text('Last Workout: 1/5/2021'), findsOneWidget);
      });
    });
    testWidgets(
        'When there is an exception when fetching workouts, widget shows error message',
        (tester) async {
      when(workoutsMock.readDataFromFile())
          .thenThrow(Exception('Some exception'));

      await _pumpScreenWithProviders(tester, clients, workouts);
      await tester.pump();

      expect(find.byType(ErrorInformator), findsOneWidget);
    });
  });
}

Future<void> _pumpScreenWithProviders(
    WidgetTester tester, Clients clients, Workouts workoutPrograms) async {
  await tester.pumpWidget(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<Clients>.value(value: clients),
        ChangeNotifierProvider<Workouts>.value(value: workoutPrograms),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        initialRoute: '/',
        routes: {
          '/': (_) => ClientProfileScreen(),
        },
      ),
    ),
  );
}

final _client = Client(
  id: '1',
  firstName: 'John',
  lastName: 'Doe',
  gender: Gender.Man,
  birthDate: DateTime(1983, 02, 02),
  height: 175,
);
