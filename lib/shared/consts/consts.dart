import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart' as http;

String? token = '';

var serverToken =
    'AAAA9RKASx8:APA91bEdlimywOpMTsplBQpJI1BYlmhY07GwoyQ1EMZlZd8cN5OMFwxCdFhk1XH4pu0IB8k7GGyEN4Zlrzq5L1rXn2WehvCxyscPb5cmLtFMq6FW4LzSLSRqkTQu09s7p3QntTvjsJzj';
sendNotify(
    String title, String body, String id, String name, String price) async {
  await http.post(
    Uri.parse('https://fcm.googleapis.com/fcm/send'),
    headers: <String, String>{
      'Content-Type': 'application/json',
      'Authorization': 'key=$serverToken',
    },
    body: jsonEncode(
      <String, dynamic>{
        'notification': <String, dynamic>{'body': body, 'title': title},
        'priority': 'high',
        'data': <String, dynamic>{
          'click_action': 'FLUTTER_NOTIFICATION_CLICK',
          'id': id,
          'name': name,
          'price': price
        },
        'to': '/topics/$id',
      },
    ),
  );
}

void getMessage() {
  FirebaseMessaging.onMessage.listen((event) {
    print('===========================================================');
    print(event.notification!.title);
    print(event.notification!.body);
    print(event.data['price']);
    print('===========================================================');
  });
}

void subscribeToTopic(String mazadId) async {
  await FirebaseMessaging.instance.subscribeToTopic(mazadId);
}
