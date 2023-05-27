import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
// eUkloKuzRYmKXUiMXyq5gd:APA91bGDXXXs31loVi4M49tVhstFjbbRjbcaUo8RrbcTHnyEJy2sez-e1lf4oDFyg0CoVn-689O1xVTriYnvTi_HY3mo5eLoiOjDY6XKVO-n0K1CwDm7Jr24DpzvI-7Y1XaGapAMtwNc
class PushNotificationService{

  static FirebaseMessaging messaging = FirebaseMessaging.instance;
  static String? token;
  static StreamController<String> _messageStream = new StreamController.broadcast();
  static Stream<String> get messagesStream => _messageStream.stream;

  static Future _backgroundHandler (RemoteMessage message)async{
  //  print('onBackgroundHandler Handler ${message.messageId}');
  print(message.data);

  //  _messageStream.add(message.notification?.body ?? 'No title');

 // _messageStream.add(message.data.toString() ?? 'No title');

 final argumento = message.data ['comida'];
 print('$argumento');
  _messageStream.add(argumento);

  }

  
  static Future _onMessageHandler (RemoteMessage message)async{
    //print('onMessageHandler Handler ${message.messageId}');
    print(message.data);
    //_messageStream.add(message.notification?.body ?? 'No title');
    //_messageStream.add(message.data.toString() ?? 'No title');

    final argumento = message.data ['comida'];
    print('$argumento');
    _messageStream.add(argumento);
  }

  
  static Future _onOpenMessageOpenApp (RemoteMessage message)async{
    //print('onOpenMessageOpenApp Handler ${message.messageId}');
    print(message.data);
    //_messageStream.add(message.notification?.body ?? 'No title');
    //_messageStream.add(message.data.toString() ?? 'No title');

    final argumento = message.data ['comida'];
    print('$argumento');
    _messageStream.add(argumento);

  }

  static Future initializeApp()async{
    //push Notificacion 
    await Firebase.initializeApp();
    token = await FirebaseMessaging.instance.getToken();
    print('Token: $token');

    //local notification


    // Handlers
    FirebaseMessaging.onBackgroundMessage(_backgroundHandler);
    FirebaseMessaging.onMessage.listen(_onMessageHandler);
    FirebaseMessaging.onMessageOpenedApp.listen(_onOpenMessageOpenApp);
  }

  static closeStreams(){
    _messageStream.close();
  }

}