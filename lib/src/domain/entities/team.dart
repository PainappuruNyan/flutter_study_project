import 'package:equatable/equatable.dart';
class Team extends Equatable{
  const Team({
    required this.id
  });

  final int id;
  @override
  List<Object> get props => [id];
}