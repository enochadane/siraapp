import 'package:app/blocs/job/job.dart';
import 'package:app/repositories/repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import "package:meta/meta.dart";

class JobBloc extends Bloc<JobEvent, JobState> {
  final JobRepository jobRepository;

  JobBloc({@required this.jobRepository})
      : assert(jobRepository != null),
        super(JobLoading());

  @override
  Stream<JobState> mapEventToState(JobEvent event) async* {
    if (event is JobLoad) {
      yield JobLoading();
      try {
        var jobs;
        if (event.userType == "seeker") {
          jobs = await jobRepository.getJobs();
        } else {
          jobs = await jobRepository.getJobsByCompanyId(event.companyId);
        }
        yield JobsLoadedSuccess(jobs);
      } catch (_) {
        yield JobOperationFailure();
      }
    }
    if (event is JobCreate) {
      yield JobLoading();
      try {
        await jobRepository.createJob(event.job);
        // final jobs = await jobRepository.getJobs();

        var jobs;
        if (event.userType == "seeker") {
          jobs = await jobRepository.getJobs();
        } else {
          jobs = await jobRepository.getJobsByCompanyId(event.companyId);
        }

        yield JobsLoadedSuccess(jobs);
      } catch (_) {
        yield JobOperationFailure();
      }
    }

    if (event is JobUpdate) {
      yield JobLoading();
      try {
        final job = await jobRepository.updateJob(event.id, event.job);
        // final jobs = await jobRepository.getJobs();
        // yield JobsLoadedSuccess(jobs);

        var jobs;
        if (event.userType == "seeker") {
          jobs = await jobRepository.getJobs();
        } else {
          jobs = await jobRepository.getJobsByCompanyId(event.companyId);
        }
        yield JobsLoadedSuccess(jobs);
      } catch (_) {
        yield JobOperationFailure();
      }
    }

    if (event is JobDelete) {
      yield JobLoading();
      try {
        await jobRepository.deleteJob(event.job.id);
        final jobs = await jobRepository.getJobs();
        yield JobsLoadedSuccess(jobs);
      } catch (_) {
        print("there is an error on try catch");
        yield JobOperationFailure();
      }
    }
  }
}
