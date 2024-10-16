import 'package:crafty_bay/core/services/network_repository.dart';
import 'package:crafty_bay/core/services/network_urls/network_urls.dart';

class InvoiceService extends NetworkRepository {
  static InvoiceService? _instance;

  InvoiceService._();

  factory InvoiceService() => _instance ??= InvoiceService._();

  Future<Object> createInvoice(String token) async {
    return getRequest(
      url: NetworkUrls.createInvoice,
      headers: {
        "token": token,
      },
    );
  }
}
