import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {}

class NoDataFailure extends Failure {
  @override
  List<Object> get props => [];
}

class EmpytInputFailure extends Failure {
  @override
  List<Object> get props => [];
}

class DatabaseFailure extends Failure {
  @override
  List<Object> get props => [];
}

class RetrieveFailure extends Failure {
  @override
  List<Object> get props => [];
}
