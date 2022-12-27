part of 'office_create_3_bloc.dart';

abstract class OfficeCreate3Event extends Equatable {
  const OfficeCreate3Event();

  @override
  List<Object> get props => [];
}

//Начальная загрузка экрана
class LoadScreen extends OfficeCreate3Event {

}

//Выбрано поле
class FloorSelected extends OfficeCreate3Event {

}

//Загрузить карту
class LoadMap extends OfficeCreate3Event {
  LoadMap({required this.filePath, required this.floorId});

  final String filePath;
  final int floorId;

  @override
  List<Object> get props => [filePath, floorId];
}
