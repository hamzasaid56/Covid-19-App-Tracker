import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:practice_covid_19/Models/Services/Utilities/AppUrl.dart';
import 'package:practice_covid_19/Models/WorldStatsModel.dart';

class StatsServices{

  Future<WorldStatsModel> fetchWorldStatsApi() async{
    final response = await http.get(Uri.parse(AppUrl.worldStatsUrl));
    var data = jsonDecode(response.body);
    if(response.statusCode == 200){
      return WorldStatsModel.fromJson(data);
    }
    else{
      throw Exception("Error");
    }
  }
  Future<List<dynamic>> fetchCountryStatsApi() async{
    var data;
    final response = await http.get(Uri.parse(AppUrl.countriesUrl));
     data = jsonDecode(response.body);
    if(response.statusCode == 200){
      return data;
    }
    else{
      throw Exception("Error");
    }
  }
}