import 'package:flutter_test/flutter_test.dart';
import 'package:training_app/models/body_measurement.dart';
import 'package:training_app/models/measurement.dart';
import 'package:training_app/models/measurement_session.dart';

import '../lib/providers/measurements.dart';

class MockMeasurements extends Measurements {
  @override
  Future<String> readDataFromFile() async {
    return '[{"id":"2020-10-24 17:59:56.945015","clientId":"2020-09-27 10:54:08.975614","date":"2020-10-24T17:59:56.945006","measurements":[{"value":20.5,"type":"Bodyfat"},{"value":82.0,"type":"Bodyweight"},{"value":78.0,"type":"BodyMeasurement","bodypart":"Waist"}]},{"id":"2020-10-24 17:59:56.949494","clientId":"2020-09-27 10:54:08.975614","date":"2020-10-14T00:00:00.000","measurements":[{"value":20.5,"type":"Bodyfat"},{"value":19.7,"type":"Bodyfat"},{"value":82.0,"type":"Bodyweight"},{"value":78.0,"type":"BodyMeasurement","bodypart":"Waist"},{"value":78.0,"type":"BodyMeasurement","bodypart":"Waist"}]}]';
  }
}

void main() async {
  final mockMeasurements = MockMeasurements();
  await mockMeasurements.fetchMeasurements();

  group('Measurements provider fetches data correctly', () {
    test('_measurements ha correct length', () {
      expect(mockMeasurements.measurements.length, 2);
    });

    test(
        'First measurement session data (no measurements checked) is fetched correctly',
        () {
      final firstMeasurement = mockMeasurements.measurements[0];
      expect(firstMeasurement.id, '2020-10-24 17:59:56.945015');
      expect(firstMeasurement.clientId, '2020-09-27 10:54:08.975614');
      expect(firstMeasurement.date.toString(), '2020-10-24 17:59:56.945006');
    });

    test(
        'Measurements inside of single measurement session have correct length',
        () {
      expect(mockMeasurements.measurements[0].measurements.length, 3);
    });

    test(
        'Measurements inside of single measurement session are fetched correctly',
        () {
      final measurements = mockMeasurements.measurements[0].measurements[0];
      expect(measurements.value, 20.5);
      expect(measurements.type, MeasurementType.Bodyfat);
    });
  });

  group('Adding new measurement sessions works correctly', () {
    final sessionToAdd = MeasurementSession(
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
        BodyMeasurement(
          type: MeasurementType.Bodyweight,
          value: 78.7,
          bodypart: Bodypart.Waist,
        ),
      ],
    );

    test('Adding new measurement session increases _measurements length', () {
      mockMeasurements.addMeasurementSession(sessionToAdd);
      expect(mockMeasurements.measurements.length, 3);
    });

    test(
        'Added measurement session has all parameters set properly (no measurements checked)',
        () {
      expect(mockMeasurements.measurements[2].id, '12345');
      expect(mockMeasurements.measurements[2].clientId, 'client001');
      expect(mockMeasurements.measurements[2].date, DateTime(2020, 10, 24));
    });

    test('Added measurement session\'s measurements list has proper length',
        () {
      expect(mockMeasurements.measurements[2].measurements.length, 3);
    });
    test('First measurement of added session has all parameters set properly',
        () {
      final firstMeasurement = mockMeasurements.measurements[2].measurements[0];
      expect(firstMeasurement.value, 18.5);
      expect(firstMeasurement.type, MeasurementType.Bodyfat);
    });
  });
}
