// import 'package:atb_first_project/src/domain/entities/employee.dart';
// import 'package:atb_first_project/src/domain/repository/employee_repository.dart';
// import 'package:atb_first_project/src/domain/usecases/get_employee_by_id.dart';
// import 'package:dartz/dartz.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mockito/mockito.dart';
//
// class MockEmployeeRepository extends Mock
//     implements EmployeeRepository{}
//
// void main(){
//   GetEmployeeById usecase;
//   MockEmployeeRepository mockEmployeeRepository;
//
//   setUp(() {
//     mockEmployeeRepository = MockEmployeeRepository();
//     usecase = GetEmployeeById(mockEmployeeRepository);
//   });
//
//   final int tId = 1;
//   final Employee tEmployee = Employee(id: tId, name: 'Олег Оленников Освальдович', login: 'mrpresedent', password: '123', role: 'Сотрудник');
//
//
//   test('should get employee from repository',
//       () async {
//
//         when(mockEmployeeRepository.getEmployeeById(1))
//         .thenAnswer((_) async => Right(tEmployee));
//
//         final result = await usecase.execute(id: tId);
//
//         expect(result, Right(tEmployee));
//         verify(mockEmployeeRepository.getEmployeeById(42));
//         verifyNoMoreInteractions(mockEmployeeRepository);
//         },
//       );
// }
