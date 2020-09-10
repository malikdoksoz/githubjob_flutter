import 'dart:convert';

import 'package:githubjobsfinder/model/job_model.dart';
import 'package:http/http.dart' as http;

class ApiService {
  final String _endpoint =
      "https://jobs.github.com/positions.json?location=remote";

  List<JobModel> _jobRes = [];

  Future<List<JobModel>> getJobs() async {
    try {
      http.Response response = await http.get(_endpoint);
      if (response.statusCode == 200) {
        List jsonData = jsonDecode(response.body);
        _jobRes = jsonData.map((i) => JobModel.fromJson(i)).toList();
        return _jobRes;
      }
      throw Exception('Error:' + response.statusCode.toString());
    } on Exception catch (e) {
      throw 'Error: ' + e.toString();
    }
  }
}
