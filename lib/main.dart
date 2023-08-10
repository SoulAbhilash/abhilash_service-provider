import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'RequestDetails/request_details.dart';
import 'Togglebuuton.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(ProviderScope(child: MyApp(),));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      //debugShowCheckedModeBanner: false,
      home: RequestDetails(ticketID: '64cc9e70554518f000b702d5'),
    );
  }
}
