import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:latlong2/latlong.dart';


class SearchPlaces {
  String? placeName;
  // List<double> center;
  Geometry geometry;

  SearchPlaces({this.placeName, required this.geometry});

  static SearchPlaces fromJson(Map<String, dynamic> json) {
    return SearchPlaces(
        placeName: json['place_name'],
        // center: json['center'].cast<double>(),
        geometry: Geometry.fromJson(json['geometry']));
  }
}

class Geometry {
  String? type;
  List<double>? coordinates;

  Geometry({this.type, this.coordinates});

  Geometry.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    coordinates = json['coordinates'].cast<double>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['type'] = type;
    data['coordinates'] = coordinates;
    return data;
  }
}

// class Reverse{
//   String? placeName;
//
//   Reverse({this.placeName});
//
//   static Reverse fromJson(Map<String, dynamic> json) {
//     return Reverse(
//         placeName: json['place_name'],
//         // center: json['center'].cast<double>(),
//
//     );
//   }
//
// }

/*

class MapBoxApi {
  Dio _dio = Dio();

  String accessKey =
      'sk.eyJ1Ijoic3RpcGUwMDciLCJhIjoiY2xkbzVmbXV2MDN1eTNudGVmbGJxazF0MCJ9.V32YJ4lkL3uwTZ69xJBf3A';
  String country = 'in';
  String searchType =
      'region,postcode,district,place,locality,neighborhood,address,poi';
  String baseUrl = 'https://api.mapbox.com/geocoding/v5/mapbox.places';

  Future<List<SearchPlaces?>> mapBoxPlaces(String query) async {
    try {
      final String url =
          '$baseUrl/$query.json?country=$country&types=$searchType&access_token=$accessKey';

      Response response = await _dio.get(url);

      final List<SearchPlaces> getPlaces = (response.data['features'] as List)
          .map((res) => SearchPlaces.fromJson(res))
          .toList();
      return getPlaces;
    } on DioError catch (e) {
      throw Exception(e.response?.statusMessage);
    }
  }

  Future<List<SearchPlaces?>> reverseGeoCoding(LatLng latLng) async {
    String accessKey =
        'sk.eyJ1Ijoic3RpcGUwMDciLCJhIjoiY2xkbzVmbXV2MDN1eTNudGVmbGJxazF0MCJ9.V32YJ4lkL3uwTZ69xJBf3A';
    String baseUrl = 'https://api.mapbox.com/geocoding/v5/mapbox.places';
    String query = '${latLng.longitude},${latLng.latitude}';

    try {
      final String url = '$baseUrl/$query.json?access_token=$accessKey';

      Response response = await _dio.get(url);
      //return Reverse.fromJson(response.data);
      // return response.data;
      //final SearchPlaces searchPlaces = (response.data['features'] as List).map((e) => SearchPlaces.fromJson(e)) as SearchPlaces;
      //return searchPlaces;
      //return SearchPlaces.fromJson(response.data['place_name']);
      final List<SearchPlaces> getPlaces = (response.data['features'] as List)
          .map((res) => SearchPlaces.fromJson(res))
          .toList();
      return getPlaces;
    } on DioError catch (e) {
      throw Exception(e.response?.statusMessage);
    }
  }

//Mapbox
//sk.eyJ1IjoicGF2YW4wMjczIiwiYSI6ImNsYm01NGUybjAxYzAzdW1xd2MyaGcwbnMifQ.hloVxuFV5yFw-hztH4-9rQ

}

Future mapBoxNavigation(LatLng source, LatLng destination) async {
  String baseUrl = 'https://api.mapbox.com/directions/v5/mapbox';
  String accessKey =
      'pk.eyJ1IjoiaGVscHltb3RvIiwiYSI6ImNsamNscHVuejAyOXAzZG1vNXppYnM1NzkifQ.BB9fpPJb9eDpRJkWwkRHXA';
  String navigation = 'driving';

  Dio _dio = Dio();

  String url =
      '$baseUrl/$navigation/${source.longitude},${source.latitude};${destination.longitude},${destination.latitude}?alternatives=true&continue_straight=true&geometries=geojson&language=en&overview=full&steps=true&access_token=$accessKey';

  try {
    final responseData = await _dio.get(url);
    print(responseData.realUri);
    return responseData.data;
  } on DioError catch (e) {
    throw Exception(e.response?.statusMessage);
  }
}

Future<Map> navigationResponse(
    LatLng sourceLatLng, LatLng destinationLatLng) async {
  final response = await mapBoxNavigation(sourceLatLng, destinationLatLng);

  Map geometry = response['routes'][0]['geometry'];
  num duration = response['routes'][0]['duration'];
  num distance = response['routes'][0]['distance'];

  Map modifiedResponse = {
    "geometry": geometry,
    "duration": duration,
    "distance": distance,
  };

  return modifiedResponse;
}

Future getReverseGeocodingGivenLatLngUsingMapbox(LatLng latLng) async {
  String accessKey = 'pk.eyJ1IjoiaGVscHltb3RvIiwiYSI6ImNsamNscHVuejAyOXAzZG1vNXppYnM1NzkifQ.BB9fpPJb9eDpRJkWwkRHXA';
  String baseUrl = 'https://api.mapbox.com/geocoding/v5/mapbox.places';
  String query = '${latLng.longitude},${latLng.latitude}';
  Dio _dio = Dio();

  String url = '$baseUrl/$query.json?access_token=$accessKey';
  url = Uri.parse(url).toString();
  print(url);
  try {
    _dio.options.contentType = Headers.jsonContentType;
    final responseData = await _dio.get(url);
    return responseData.data;
  } on DioError catch (e) {
    throw Exception(e.response?.statusMessage);
  }
}

Future<Map> getParsedReverseGeocoding(LatLng latLng) async {
  var response =
  json.decode(await getReverseGeocodingGivenLatLngUsingMapbox(latLng));
  Map feature = response['features'][0];
  Map revGeocode = {
    'name': feature['text'],
    'address': feature['place_name'].split('${feature['text']}, ')[1],
    'place': feature['place_name'],
    'location': latLng
  };
  return revGeocode;
}
*/
