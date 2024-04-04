import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:product_app/core/internet_connection/internet_connection_status.dart';

class InternetConnectionStatusImpl extends InternetConnectionStatus{

  final InternetConnection connection;

  InternetConnectionStatusImpl(this.connection);

  @override
  Future<bool> get isConnected async=> await connection.hasInternetAccess;
}