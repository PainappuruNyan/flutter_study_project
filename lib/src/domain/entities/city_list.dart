import 'package:equatable/equatable.dart';

import 'city.dart';

class CityList extends Equatable{

  const CityList({
    required this.cites
  });
  final List<City> cites;

  @override
  List<Object> get props => [cites];
}
