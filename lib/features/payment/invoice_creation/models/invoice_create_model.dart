import 'package:crafty_bay/features/payment/invoice_creation/models/invoice_create_data.dart';

class CreateInvoiceModel {
  String? msg;
  List<InvoiceCreateData>? invoiceCreateData;

  CreateInvoiceModel({this.msg, this.invoiceCreateData});

  CreateInvoiceModel.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
    if (json['data'] != null) {
      invoiceCreateData = <InvoiceCreateData>[];
      json['data'].forEach((v) {
        invoiceCreateData!.add(new InvoiceCreateData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['msg'] = this.msg;
    if (this.invoiceCreateData != null) {
      data['data'] = this.invoiceCreateData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}