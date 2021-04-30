import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:training_app/models/body_measurement.dart';
import 'package:training_app/models/measurement.dart';
import 'package:training_app/models/measurement_session.dart';

import '../setup/mocks_and_spies.dart';

void main() async {
  MeasurementsSpy measurements;
  MeasurementsMock measurementsMock;

  setUp(() {
    measurementsMock = MeasurementsMock();
    measurements = MeasurementsSpy(measurementsMock);
  });

  group('Measurements provider', () {
    group('fetchMeasurements -', () {
      test(
          'When returns a String, values are assigned to _measurements variable',
          () async {
        when(measurementsMock.readDataFromFile()).thenAnswer((_) async =>
            '[{"id":"2020-10-24 17:59:56.945015","clientId":"1","date":"2020-10-24T00:00:00.000","measurements":[{"value":20.5,"type":"Bodyfat"},{"value":82.0,"type":"Bodyweight"}], "bodyMeasurements":[{"value":82.0,"type":"BodyMeasurement","bodypart":"Waist"}]},'
            '{"id":"2020-10-24 17:59:56.949494","clientId":"2","date":"2020-10-14T00:00:00.000","measurements":[{"value":21.7,"type":"Bodyfat"},{"value":83.0,"type":"Bodyweight"}], "bodyMeasurements":[{"value":84.0,"type":"BodyMeasurement","bodypart":"Waist"},{"value":105.0,"type":"BodyMeasurement","bodypart":"Chest"}]}]');

        await measurements.fetchMeasurements();

        expect(measurements.measurements.length, 2);
        expect(measurements.measurements, _expectedFetchedMeasurements);
      });
      test('When throws an Exception, _workouts variable is empty', () async {
        when(measurementsMock.readDataFromFile())
            .thenThrow(Exception('An exception occured'));

        try {
          await measurements.fetchMeasurements();
        } catch (_) {}

        expect(measurements.measurements, []);
      });
    });

    group('When measurements had been fetched successfully -', () {
      setUp(() async {
        when(measurementsMock.readDataFromFile()).thenAnswer((_) async =>
            '[{"id":"2020-10-24 17:59:56.945015","clientId":"1","date":"2020-10-24T00:00:00.000","measurements":[{"value":20.5,"type":"Bodyfat"},{"value":82.0,"type":"Bodyweight"}], "bodyMeasurements":[{"value":82.0,"type":"BodyMeasurement","bodypart":"Waist"}]},'
            '{"id":"2020-10-24 17:59:56.949494","clientId":"2","date":"2020-10-14T00:00:00.000","measurements":[{"value":21.7,"type":"Bodyfat"},{"value":83.0,"type":"Bodyweight"}], "bodyMeasurements":[{"value":84.0,"type":"BodyMeasurement","bodypart":"Waist"},{"value":105.0,"type":"BodyMeasurement","bodypart":"Chest"}]}]');

        await measurements.fetchMeasurements();
      });

      test('addMeasurementSession() works properly', () async {
        measurements.addMeasurementSession(_measurementsSessionToAdd);

        expect(measurements.measurements.length, 3);
        expect(measurements.measurements[2], _measurementsSessionToAdd);
      });
      test('deleteMeasurementSession() works properly', () async {
        measurements.deleteMeasurementSession('2020-10-24 17:59:56.949494');

        expect(measurements.measurements.length, 1);
        expect(measurements.measurements[0], _expectedFetchedMeasurements[0]);
      });
      test('findByClientId() works properly', () async {
        reset(measurementsMock);

        when(measurementsMock.readDataFromFile()).thenAnswer((_) async =>
            '[{"id":"2020-10-24 17:59:56.945015","clientId":"1","date":"2020-10-24T00:00:00.000","measurements":[{"value":20.5,"type":"Bodyfat"},{"value":82.0,"type":"Bodyweight"}], "bodyMeasurements":[{"value":82.0,"type":"BodyMeasurement","bodypart":"Waist"}]},'
            '{"id":"2020-10-27 16:54:54.000322","clientId":"1","date":"2020-10-24T00:00:00.000","measurements":[{"value":20.5,"type":"Bodyfat"},{"value":82.0,"type":"Bodyweight"}], "bodyMeasurements":[{"value":82.0,"type":"BodyMeasurement","bodypart":"Waist"}]},'
            '{"id":"2020-10-24 17:59:56.949494","clientId":"2","date":"2020-10-14T00:00:00.000","measurements":[{"value":21.7,"type":"Bodyfat"},{"value":83.0,"type":"Bodyweight"}], "bodyMeasurements":[{"value":84.0,"type":"BodyMeasurement","bodypart":"Waist"},{"value":105.0,"type":"BodyMeasurement","bodypart":"Chest"}]}]');

        await measurements.fetchMeasurements();
        final clientsMeasurements = measurements.findByClientId('1');

        expect(clientsMeasurements.length, 2);
        expect(clientsMeasurements, _expectedClientMeasurements);
      });
    });
  });
}

final _expectedFetchedMeasurements = [
  MeasurementSession(
    id: '2020-10-24 17:59:56.945015',
    clientId: '1',
    date: DateTime(2020, 10, 24),
    measurements: [
      Measurement(type: MeasurementType.Bodyfat, value: 20.5),
      Measurement(type: MeasurementType.Bodyweight, value: 82.0),
    ],
    bodyMeasurements: [
      BodyMeasurement(
        value: 82.0,
        type: MeasurementType.BodyMeasurement,
        bodypart: Bodypart.Waist,
      ),
    ],
  ),
  MeasurementSession(
    id: '2020-10-24 17:59:56.949494',
    clientId: '2',
    date: DateTime(2020, 10, 14),
    measurements: [
      Measurement(type: MeasurementType.Bodyfat, value: 21.7),
      Measurement(type: MeasurementType.Bodyweight, value: 83.0),
    ],
    bodyMeasurements: [
      BodyMeasurement(
        value: 84.0,
        type: MeasurementType.BodyMeasurement,
        bodypart: Bodypart.Waist,
      ),
      BodyMeasurement(
        value: 105,
        type: MeasurementType.BodyMeasurement,
        bodypart: Bodypart.Chest,
      ),
    ],
  ),
];

final _measurementsSessionToAdd = MeasurementSession(
    id: '12345',
    clientId: 'client001',
    date: DateTime(2020, 10, 24),
    measurements: [
      Measurement(
        type: MeasurementType.Bodyfat,
        value: 18.5,
      ),
      Measurement(
        type: MeasurementType.Bodyweight,
        value: 78.7,
      ),
    ],
    bodyMeasurements: [
      BodyMeasurement(
        type: MeasurementType.Bodyweight,
        value: 78.7,
        bodypart: Bodypart.Waist,
      ),
    ]);

final _expectedClientMeasurements = [
  MeasurementSession(
    id: '2020-10-24 17:59:56.945015',
    clientId: '1',
    date: DateTime(2020, 10, 24),
    measurements: [
      Measurement(type: MeasurementType.Bodyfat, value: 20.5),
      Measurement(type: MeasurementType.Bodyweight, value: 82.0),
    ],
    bodyMeasurements: [
      BodyMeasurement(
        value: 82.0,
        type: MeasurementType.BodyMeasurement,
        bodypart: Bodypart.Waist,
      ),
    ],
  ),
  MeasurementSession(
    id: '2020-10-27 16:54:54.000322',
    clientId: '1',
    date: DateTime(2020, 10, 24),
    measurements: [
      Measurement(type: MeasurementType.Bodyfat, value: 20.5),
      Measurement(type: MeasurementType.Bodyweight, value: 82.0),
    ],
    bodyMeasurements: [
      BodyMeasurement(
        value: 82.0,
        type: MeasurementType.BodyMeasurement,
        bodypart: Bodypart.Waist,
      ),
    ],
  ),
];
