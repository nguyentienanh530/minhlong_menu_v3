import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minhlong_menu_admin_v3/core/utils.dart';
import 'package:minhlong_menu_admin_v3/features/order/data/model/food_order_model.dart';
import 'package:minhlong_menu_admin_v3/features/order/data/model/order_item.dart';
import 'package:minhlong_menu_admin_v3/features/user/cubit/user_cubit.dart';
import 'package:minhlong_menu_admin_v3/features/user/data/model/user_model.dart';

import 'dart:typed_data';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class PrintScreen extends StatelessWidget {
  final OrderItem order;

  const PrintScreen({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    var user = context.watch<UserCubit>().state;
    return Scaffold(
      appBar: AppBar(title: const Text('In hóa đơn')),
      body: PdfPreview(
        maxPageWidth: 800,
        initialPageFormat: PdfPageFormat.roll80,
        // useActions: false,
        build: (format) => _generatePdf(format, user),
      ),
    );
  }

  Future<Uint8List> _generatePdf(PdfPageFormat format, UserModel user) async {
    final pdf = pw.Document(version: PdfVersion.pdf_1_5, compress: true);
    final font = await PdfGoogleFonts.robotoRegular();
    final fontTitle = await PdfGoogleFonts.robotoBold();
    double? bodySize = 8;
    var bodyStyle = pw.TextStyle(font: font, fontSize: bodySize);
    pdf.addPage(
      pw.Page(
        pageFormat: format,
        build: (context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.center,
            children: [
              pw.Text(
                user.fullName,
                style: pw.TextStyle(fontSize: 23, font: fontTitle),
              ),
              pw.SizedBox(height: 10),
              pw.Text(
                user.address,
                style: bodyStyle,
              ),
              pw.SizedBox(height: 10),
              pw.Row(mainAxisAlignment: pw.MainAxisAlignment.center, children: [
                pw.Text(
                  '0${user.phoneNumber}',
                  style: bodyStyle,
                ),
                user.subPhoneNumber == 0
                    ? pw.Container()
                    : pw.Text(
                        ' - 0${user.subPhoneNumber}',
                        style: bodyStyle,
                      ),
              ]),
              pw.SizedBox(height: 10),
              pw.Text(
                'Phiếu Thanh Toán'.toUpperCase(),
                style: pw.TextStyle(
                  font: fontTitle,
                  fontSize: 14,
                ),
              ),
              pw.SizedBox(height: 5),
              pw.Text(
                'Bàn: ${order.tableName}',
                style: pw.TextStyle(
                    font: font,
                    fontSize: bodySize,
                    fontWeight: pw.FontWeight.bold),
              ),
              pw.SizedBox(height: 10),
              pw.Row(children: [
                pw.Text(
                    'Ngày: ${Ultils.formatDateToString(DateTime.now().toString(), isShort: true)}',
                    style: bodyStyle),
              ]),
              pw.SizedBox(height: 10),
              pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Text(
                        'Giờ vào: ${Ultils.formatStringToTime(order.createdAt.toString(), isShort: true)}',
                        style: bodyStyle),
                    order.payedAt != null
                        ? pw.Text(
                            'Giờ ra: ${Ultils.formatStringToTime(order.payedAt.toString(), isShort: true)}',
                            style: bodyStyle)
                        : pw.Text(''),
                  ]),
              pw.SizedBox(height: 20),
              pw.Table(children: [
                pw.TableRow(
                    verticalAlignment: pw.TableCellVerticalAlignment.middle,
                    children: [
                      pw.Expanded(
                          flex: 3, child: pw.Text("Tên món", style: bodyStyle)),
                      pw.Expanded(
                          child: pw.Text("SL",
                              style: bodyStyle,
                              textAlign: pw.TextAlign.center)),
                      pw.Expanded(
                          flex: 2,
                          child: pw.Text("Giá",
                              style: bodyStyle,
                              textAlign: pw.TextAlign.center)),
                      pw.Expanded(
                          flex: 2,
                          child: pw.Text("T.Tiền",
                              style: bodyStyle, textAlign: pw.TextAlign.right)),
                    ]),
              ]),
              pw.Table(
                border: const pw.TableBorder(
                    top: pw.BorderSide(style: pw.BorderStyle.dotted),
                    bottom: pw.BorderSide(style: pw.BorderStyle.dotted)),
                children: order.foodOrders
                    .map((e) => _buildRowData(e, bodyStyle))
                    .toList(),
              ),
              pw.SizedBox(height: 10),
              pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Text('Tổng tiền:',
                        style: pw.TextStyle(font: fontTitle, fontSize: 14)),
                    pw.Text(' ${Ultils.currencyFormat(order.totalPrice)}',
                        style: pw.TextStyle(font: fontTitle, fontSize: 14)),
                  ]),
              pw.SizedBox(height: 10),
              pw.Text('Cảm ơn Quý khách. Hẹn gặp lại.!',
                  style: pw.TextStyle(
                      font: font,
                      fontSize: 11,
                      fontStyle: pw.FontStyle.italic)),
            ],
          );
        },
      ),
    );

    return pdf.save();
  }

  pw.TableRow _buildRowData(FoodOrderModel foodOrder, pw.TextStyle bodyStyle) {
    return pw.TableRow(children: [
      _buildItem(foodOrder.name, bodyStyle, flex: 3),
      _buildItem(foodOrder.quantity.toString(), bodyStyle,
          textAlign: pw.TextAlign.center),
      _buildItem(Ultils.currencyFormat(foodOrder.price), bodyStyle,
          flex: 2, textAlign: pw.TextAlign.center),
      _buildItem(Ultils.currencyFormat(foodOrder.totalAmount), bodyStyle,
          textAlign: pw.TextAlign.right, flex: 2),
    ]);
  }

  pw.Widget _buildItem(String value, pw.TextStyle bodyStyle,
      {int flex = 1, pw.TextAlign? textAlign = pw.TextAlign.left}) {
    return pw.Expanded(
      flex: flex,
      child: pw.Text(value, style: bodyStyle, textAlign: textAlign),
    );
  }
}
