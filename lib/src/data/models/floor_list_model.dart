import '../../domain/entities/floor_list.dart';
import 'floor_model.dart';

class FloorListModel extends FloorList{
  const FloorListModel({required super.floors});


  factory FloorListModel.fromJson(List<dynamic> json) {
    final List<FloorModel> floors = json.map((i)=>FloorModel.fromJson(i as Map<String, dynamic>)).toList();
    return FloorListModel(floors: floors);
  }
}
