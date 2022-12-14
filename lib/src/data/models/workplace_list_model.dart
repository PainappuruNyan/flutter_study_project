import '../../domain/entities/workplace_list.dart';
import 'workplase_model.dart';

class WorkplaceListModel extends WorkplaceList{
  const WorkplaceListModel({required super.places});


  factory WorkplaceListModel.fromJson(List<dynamic> json) {
    final List<WorkplaceModel> places = json.map((i)=>WorkplaceModel.fromJson(i as Map<String, dynamic>)).toList();
    return WorkplaceListModel(places: places);
  }
}
