import '../../domain/entities/workplace_list.dart';
import 'workplase_model.dart';

class WorkplaceListModel extends WorkplaceList{
  const WorkplaceListModel({required super.floors});


  factory WorkplaceListModel.fromJson(List<dynamic> json, bool isFree) {
    final List<WorkplaceModel> floors = json.map((i)=>WorkplaceModel.fromJson(i as Map<String, dynamic>, isFree)).toList();
    return WorkplaceListModel(floors: floors);
  }
}
