import 'package:equatable/equatable.dart';

abstract class PaginationState extends Equatable {
  const PaginationState();

  @override
  List<Object> get props => [];
}

class PaginationStateMessage extends PaginationState {}

class SplashStateMessage extends PaginationState {}

class PaginationStateProfile extends PaginationState {}

class PaginationStateAboutUs extends PaginationState {}
