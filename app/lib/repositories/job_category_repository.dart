import 'package:app/data_provider/job_category_data.dart';
import 'package:app/models/job_category.dart';
import 'package:meta/meta.dart';

class JobCategoryRepository {
  final JobCategoryDataProvider dataProvider;
  
  JobCategoryRepository({
    @required this.dataProvider,
  }) : assert(dataProvider != null);

  Future<List<JobCategory>> getJobCategories() async {
    return await dataProvider.getJobCategories();
  }
}
