/// this file is used to send whatsapp notification message
/// It is a generalized file in which we can pass custom templates of different messages for different events.
/// the api url is official whatsapp api.
/// can be run on all platforms
/// Pending: where to call this functionality
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  void sendWhatsapp() async {
    try {
      /// api url
      String url = 'https://graph.facebook.com/v17.0/116784751506628/messages';
      // headers
      Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Authorization':
            'EAAI7Hruc5i4BO2eSFK2h7E6PC0vOdv5D0970jnQalxq7e4s4DrEc4DFCLQEMqyAOONwV1ipJZC50x9HIiZA5iZAH1ZAsdzuZAarwVbNTSPEdJK2pKPhm3ftES9bAoMJ5cpHhszpddMh4OjD58StQtjCuVLb2xdsEDgJbJdVP6PRymekUzoerZBIIwZB7pa3z3A7Se64Us6ZC80an9lulzSYSjR3nNRuAnuZBdTCAZD'
      };
      // body
      Map<String, dynamic> body = {
        "messaging_product": "whatsapp",
        "to": "917982880637",
        "type": "template",
        "template": {
          "name": "helpy_moto",
          "language": {"code": "en_US"}
        }
      };
      // send whatsapp message request
      var response = await http.post(Uri.parse(url),
          headers: headers, body: jsonEncode(body));
      print("response ${response.body}");
      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("success")));
        print("response ${response.body}");
      } else {
        print(response.reasonPhrase);
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("fail ${response.reasonPhrase}")));
      }
    } catch (e) {
      print("error : $e");
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("error $e")));
    }
  }

  @override
  Widget build(BuildContext context) {
    print("here");
    return Scaffold(
        body: Center(
      child: ElevatedButton(
        onPressed: sendWhatsapp,
        child: Text("send whatsapp"),
      ),
    ));
  }
}
