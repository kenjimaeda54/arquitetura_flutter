import 'package:internet_connection_checker/internet_connection_checker.dart';

class Helpers {
  Future<bool> shouldUpdateOrNoDatabase(
      {required int? compare, required int withTimeMinutes}) async {
    if (compare == null) return false;
    bool isConnected = await InternetConnectionChecker().hasConnection;
    var dateDatabase = DateTime.fromMillisecondsSinceEpoch(compare);
    var dateNow = DateTime.now();
    final diference = dateNow.difference(dateDatabase);

    if (diference.inMinutes > withTimeMinutes && isConnected) {
      return true;
    }
    return false;
  }
}
