import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'dart:async';

class WebSocketManager {
  static final WebSocketManager _instance = WebSocketManager._internal();
  final Map<String, WebSocketChannel> _channels = {};
  final Map<String, StreamController<dynamic>> _controllers = {};

  factory WebSocketManager() {
    return _instance;
  }

  WebSocketManager._internal();

  WebSocketChannel? getChannel(String key) {
    return _channels[key];
  }

  Future<void> createChannel(String key, String url) async {
    if (!_channels.containsKey(key)) {
      final channel = WebSocketChannel.connect(Uri.parse(url));

      _channels[key] = channel;

      // final controller = StreamController<dynamic>.broadcast();
      // // _controllers[key] = controller;

      // _channels[key]!.stream.listen(
      //   (data) {
      //     debugPrint('Received data: $data');
      //     controller.add(data);
      //     _controllers[key] = controller;
      //   },
      //   onDone: () {
      //     debugPrint('WebSocket closed');
      //     controller.close();
      //     _channels.remove(key);
      //     _controllers.remove(key);
      //   },
      //   onError: (error) {
      //     debugPrint('WebSocket error: $error');
      //     controller.addError(error);
      //   },
      // );

      try {
        await channel.ready; // Đảm bảo kết nối đã sẵn sàng
      } catch (e) {
        debugPrint('Failed to connect to WebSocket: $e');
        _channels.remove(key); // Xóa kênh nếu kết nối không thành công
        _controllers.remove(key);
      }
    }
  }

  Stream<dynamic>? getStream(String key) {
    // _controllers[key]!.stream.listen((data) {
    //   debugPrint('Received data: $data');
    // }, onError: (error) {
    //   debugPrint('Error: $error');
    // }, onDone: () {
    //   debugPrint('Stream closed');
    // });
    return _controllers[key]?.stream;
  }

  void sendSocket(String key, String event, dynamic payload) {
    final channel = _channels[key];
    if (channel == null || channel.closeCode != null) {
      debugPrint('Channel not available or already closed');
      return;
    }

    Map<String, dynamic> data = {
      'event': event,
      'payload': payload,
    };
    channel.sink.add(jsonEncode(data));
  }

  void joinRoom(String key, dynamic room) {
    final channel = _channels[key];
    if (channel == null || channel.closeCode != null) {
      debugPrint('Channel not available or already closed');
      return;
    }

    Map<String, dynamic> data = {
      'event': 'join-room',
      'room': room,
    };
    channel.sink.add(jsonEncode(data));
  }

  void leaveRoom(String key, dynamic room) {
    // sendSocket(key, 'leave-room', room);
    final channel = _channels[key];
    if (channel == null || channel.closeCode != null) {
      debugPrint('Channel not available or already closed');
      return;
    }

    Map<String, dynamic> data = {
      'event': 'leave-room',
      'room': room,
    };
    channel.sink.add(jsonEncode(data));
  }

  void closeChannel(String key) {
    final channel = _channels[key];
    if (channel != null) {
      channel.sink.close();
      _channels.remove(key);
      _controllers[key]?.close();
      _controllers.remove(key);
    }
  }

  void closeAllChannels() {
    for (var channel in _channels.values) {
      channel.sink.close();
    }
    _channels.clear();
    for (var controller in _controllers.values) {
      controller.close();
    }
    _controllers.clear();
  }
}
