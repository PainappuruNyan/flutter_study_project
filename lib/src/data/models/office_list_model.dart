import '../../domain/entities/office_list_.dart';
import 'office_model.dart';

class OfficeListModel extends OfficeList{
  const OfficeListModel({required super.offices});


  factory OfficeListModel.fromJson(List<dynamic> json) {
    final List<OfficeModel> offices = json.map((i)=>OfficeModel.fromJson(i as Map<String, dynamic>)).toList();
    return OfficeListModel(offices: offices);
  }
}
