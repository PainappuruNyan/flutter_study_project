import '../../domain/entities/city_list.dart';
import 'city_model.dart';

class CityListModel extends CityList{
  const CityListModel({required super.cites});


  factory CityListModel.fromJson(List<dynamic> json) {
    final List<CityModel> cites = json.map((i)=>CityModel.fromJson(i as Map<String, dynamic>)).toList();
    return CityListModel(cites: cites);
  }
}
