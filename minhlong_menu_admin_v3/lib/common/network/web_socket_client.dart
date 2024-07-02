// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../../features/dinner_table/data/model/table_model.dart';

class WebSocketClient {
  WebSocketChannel? channel;
  // var tableList = <TableModel>[].obs;
  // var orderList = <OrderModel>[].obs;
  // var indexSelected = 0.obs;
  void changeTableSelected(TableModel table) {
    // indexSelected.value = table.id;
  }

  Future connect(String url) async {
    if (channel != null && channel!.closeCode == null) {
      log('Already connected');
      return;
    }

    log('Connecting to the server...');
    channel = WebSocketChannel.connect(Uri.parse(url));
    await channel!.ready;
    // channel!.stream.listen(
    //   (event) {
    //     Map<String, dynamic> data = jsonDecode(event);

    //     switch (data['event']) {
    //       case 'tables-ws':
    //         var res = jsonDecode(data['payload']);
    //         tableList.value =
    //             List<TableModel>.from(res.map((x) => TableModel.fromJson(x)));
    //         break;
    //       case 'orders-ws':
    //         var res = jsonDecode(data['payload']);
    //         // var orders =
    //         //     List<OrderModel>.from(res.map((x) => OrderModel.fromJson(x)));

    //         if (indexSelected.value != 0) {
    //           orderList.value = [];
    //           for (var order in orders) {
    //             if (order.tableId == indexSelected.value) {
    //               orderList.add(order);
    //             }
    //           }
    //         } else {
    //           orderList.value = orders;
    //         }

    //         break;
    //       default:
    //         log('event: $event');
    //         break;
    //     }
    //   },
    //   onDone: () {
    //     log('Connection closed');
    //   },
    //   onError: (error) {
    //     log('Error: $error');
    //   },
    // );
  }

  void send(String event, dynamic payload) {
    if (channel == null || channel!.closeCode != null) {
      debugPrint('Not connected');
      return;
    }

    Map<String, dynamic> data = {
      'event': event,
      'payload': payload,
    };
    channel!.sink.add(jsonEncode(data));
  }

  // Stream<Map<String, dynamic>> messageUpdates() {
  //   return messageController.stream;
  // }

  void disconnect() {
    if (channel == null || channel!.closeCode != null) {
      debugPrint('Not connected');
      return;
    }
    channel!.sink.close();
  }
}
