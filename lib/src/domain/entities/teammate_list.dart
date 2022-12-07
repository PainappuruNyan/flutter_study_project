import 'package:atb_first_project/src/domain/entities/teammate.dart';
import 'package:equatable/equatable.dart';

class TeammateList extends Equatable{

  const TeammateList({
    required this.teammates
  });
  final List<Teammate> teammates;

  @override
  List<Object> get props => [teammates];
}