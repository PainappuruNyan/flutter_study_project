// class MockEmployeeRepository extends Mock
//     implements EmployeeRepository{}

import 'package:atb_first_project/src/core/utils/date_time_parser.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('checking date time', () {
    final DateTime testDate = DateTime.parse('2022-12-13 10:00');


    expect(DateParser.parseForGetRequest(testDate), '2022-12-13%2010%3A00');
  });
}
