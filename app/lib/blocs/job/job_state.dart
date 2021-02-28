import 'package:app/models/job.dart';
import 'package:equatable/equatable.dart';

class JobState extends Equatable {
  const JobState();

  @override
  List<Object> get props => [];
}

class JobLoading extends JobState {}

class JobsLoadedSuccess extends JobState {
  final List<Job> jobs;

  JobsLoadedSuccess([this.jobs = const []]);

   @override
  List<Object> get props => [jobs];
}

class JobOperationFailure extends JobState {}
