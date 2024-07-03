import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class WebSocketClientCubit extends Cubit<WebSocketChannel?> {
  WebSocketClientCubit() : super(null);

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
