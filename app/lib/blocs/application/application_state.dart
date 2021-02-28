import 'package:app/models/application.dart';
import 'package:equatable/equatable.dart';

class ApplicationState extends Equatable {
  const ApplicationState();

  @override
  List<Object> get props => [];
}

class ApplicationLoading extends ApplicationState {}

class ApplicationLoadSuccess extends ApplicationState {
  final List<Application> applications;

  ApplicationLoadSuccess([this.applications = const []]);

  @override
  List<Object> get props => [applications];
}

class ApplicationOperationFailure extends ApplicationState {}
