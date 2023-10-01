import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/wallet_connect/ethereum_config.dart';
import '../data/wallet_connect/mumbai_polygon_config.dart';
import '../data/wallet_connect/cloud_ethereum_service.dart';
import '../data/wallet_connect/ethereum_service.dart';
import '../../data/wallet_connect/wallet_connect_service.dart';
import '../../data/wallet_connect/wallet_connect_service_impl.dart';

import '../data/wallet_connect/logger.dart';
import '../data/wallet_connect/logger_impl.dart';

final loggerProvider = Provider<Logger>((ref) {
  return LoggerImpl();
});

final ethereumConfigProvider = Provider<EthereumConfig>((ref) {
  return SepoliaEthereumConfig();
});

final ethereumServiceProvider = Provider<EthereumService>((ref) {
  return CloudEthereumService(
    ethereumConfig: ref.read(ethereumConfigProvider),
    logger: ref.read(loggerProvider),
  );
});

final walletConnectServiceProvider = Provider<WalletConnectService>((ref) {
  return WalletConnectServiceImpl(
    ethereumConfig: ref.read(ethereumConfigProvider),
    logger: ref.read(loggerProvider),
  );
});
