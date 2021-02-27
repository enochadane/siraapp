
import 'package:app/data_provider/job_data.dart';
import 'package:app/models/job.dart';
import 'package:app/models/job_category.dart';
import 'package:meta/meta.dart';

class JobRepository {
  final JobDataProvider dataProvider;
  
  JobRepository({
    @required this.dataProvider,
  }) : assert(dataProvider != null);

  Future<Job> createJob(Job job) async {
    return await dataProvider.createJob(job);
  }

  Future<List<Job>> getJobs() async {
    return await dataProvider.getJobs();
  }

  Future<List<Job>> getJobsByCategory(JobCategory jobCategory) async {
    return await dataProvider.getJobsByCategory(jobCategory.id);
  }

  Future<List<Job>> getJobsByCompanyId(String companyId) async {
    return await dataProvider.getJobsByCompanyId(companyId);
  }

  Future<Job> updateJob(String id, Job job) async {
    return await dataProvider.updateJob(id, job);
  }

  Future<Job> getJob(String id) async {
    return await dataProvider.getJob(id);
  }

  Future<void> deleteJob(String id) async {
    return await dataProvider.deleteJob(id);
  }
}
