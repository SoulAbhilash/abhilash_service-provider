
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart';

import 'mapbox_searchmodel.dart';
import 'model.dart';

//64cc9e70554518f000b702d5

/*final userDetailsProvider =
Provider<IRepository>((ref) => Repository());*/

final getUserDetails = FutureProvider.family<RequestUserDetails,String>((ref,ticketID) async{
  //final repository = ref.watch(userDetailsProvider);
  //return repository.userdetailsget();
  return userdetailsget(ticketID);
});

Future<RequestUserDetails> userdetailsget(ticketID) async{
  final Dio _dio =Dio();
  try{
    var response = await _dio.get('https://service-provider-apis.onrender.com/api/v1/ticket/mechanic/${ticketID}');



    if (response.statusCode == 201) {
      print('Response : ${response.data}');
      print('Response Code: ${response.statusCode}');
      print('Response Headers: ${response.headers}');
      print('Response REALURI is ${response.realUri.path}');

      return RequestUserDetails.fromJson(response.data);
    } else {
      throw response.statusCode ?? 500;
    }
  }on DioException catch(e){
    throw Exception(e.response?.data);
  }
}

//Mapbox API call to convert LatLng to address


Future<List<SearchPlaces>> convertLL(LatLng latLng) async {
  Dio _dio = Dio();
  String accessKey = 'pk.eyJ1IjoidmVudW1hbGxhY2hhcmkiLCJhIjoiY2xsZHZyNHExMGp0MzNlcDE3cHU0dGlqayJ9.1DfG1lq1qjYTGpXYfoczFw';
  String baseUrl = 'https://api.mapbox.com/geocoding/v5/mapbox.places';
  String query = '${latLng.longitude},${latLng.latitude}';

  try {
    final String url = '$baseUrl/$query.json?access_token=$accessKey';

    Response response = await _dio.get(url);

    final List<SearchPlaces> getPlaces = (response.data['features'] as List)
        .map((res) => SearchPlaces.fromJson(res))
        .toList();
    return getPlaces;
  } on DioError catch (e) {
    throw Exception(e.response?.statusMessage);
  }
}