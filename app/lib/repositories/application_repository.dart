import 'package:app/data_provider/application_data.dart';
import 'package:app/models/application.dart';
import 'package:meta/meta.dart';

class ApplicationRepository {
  final ApplicationDataProvider dataProvider;

  ApplicationRepository({@required this.dataProvider})
      : assert(dataProvider != null);

  Future<Application> createApplication(Application application) async {
    return await dataProvider.createApplication(application);
  }

  Future<List<Application>> getApplications(String companyId) async {
    return await dataProvider.getApplications(companyId);
  }

  Future<void> updateApplication(Application application) async {
    await dataProvider.updateApplication(application);
  }

  Future<void> deleteApplication(String id) async {
    await dataProvider.deleteApplication(id);
  }
}
