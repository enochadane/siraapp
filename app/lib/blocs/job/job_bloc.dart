import 'package:app/blocs/job/job.dart';
import 'package:app/models/models.dart';
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
        List<Job> jobs;
        if (event.user?.role == "EMPLOYER") {
          jobs = await jobRepository.getJobsByCompanyId(event.user.id);
        } else {
          jobs = await jobRepository.getJobs();
        }

        yield JobsLoadedSuccess(jobs);
      } catch (e) {
        print("error is $e");

        yield JobOperationFailure();
      }
    }
    if (event is JobCreate) {
      yield JobLoading();
      try {
        await jobRepository.createJob(event.job);
        var jobs;
        if (event.user?.role == "EMPLOYER") {
          jobs = await jobRepository.getJobsByCompanyId(event.user.id);
        } else {
          jobs = await jobRepository.getJobs();
        }

        yield JobsLoadedSuccess(jobs);
      } catch (e) {
        print("error is $e");

        yield JobOperationFailure();
      }
    }

    if (event is JobUpdate) {
      yield JobLoading();
      try {
        await jobRepository.updateJob(event.id, event.job);

        var jobs;
        if (event.user?.role == "SEEKER") {
          jobs = await jobRepository.getJobs();
        } else {
          jobs = await jobRepository.getJobsByCompanyId(event.user.id);
        }
        yield JobsLoadedSuccess(jobs);
      } catch (e) {
        print("error is $e");
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
        yield JobOperationFailure();
      }
    }
  }
}
