import 'package:equatable/equatable.dart';

import 'office.dart';

class OfficeList extends Equatable{

  const OfficeList({
    required this.offices
  });
  final List<Office> offices;

  @override
  List<Object> get props => [offices];
}
