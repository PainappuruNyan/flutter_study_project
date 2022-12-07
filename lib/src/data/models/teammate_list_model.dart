import '../../domain/entities/teammate_list.dart';
import 'teammate_model.dart';

class TeammateListModel extends TeammateList{
  const TeammateListModel({required super.teammates});

  factory TeammateListModel.fromJson(List<dynamic> json) {
    final List<TeammateModel> teammates = json.map((i)=>TeammateModel.fromJson(i as Map<String, dynamic>)).toList();
    return TeammateListModel(teammates: teammates);
  }
}