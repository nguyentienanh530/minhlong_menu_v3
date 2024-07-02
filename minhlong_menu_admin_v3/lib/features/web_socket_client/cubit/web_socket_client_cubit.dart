import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class WebSocketClientCubit extends Cubit<WebSocketChannel?> {
  WebSocketClientCubit() : super(null);

  void send(String event, dynamic payload) {
    if (state!.closeCode != null) {
      debugPrint('Not connected');
      return;
    }

    Map<String, dynamic> data = {
      'event': event,
      'payload': payload,
    };
    state!.sink.add(jsonEncode(data));
  }

  void disconnect() {
    if (state!.closeCode != null) {
      debugPrint('Not connected');
      return;
    }
    state!.sink.close();
  }

  void init(WebSocketChannel socket) async {
    emit(socket);
  }
}
