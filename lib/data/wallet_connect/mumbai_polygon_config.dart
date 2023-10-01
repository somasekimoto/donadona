import 'ethereum_config.dart';

class SepoliaEthereumConfig implements EthereumConfig {
  @override
  String get ethereumRpcUrl => 'https://polygon-mumbai.g.alchemy.com/v2/6GX1xyPoN_YN_38KXWVvpbcQgMMTSP9L'; // TODO: Change this to your own RPC URL

  @override
  String get coinContractAddress => '0xA6b324b9eC351cB5BBCC870c890812311B86c712';

  @override
  String get walletConnectProjectId => '6f54a0067867587ed325b7845b182b0e'; // TODO: Change this to your own project ID
  @override
  String get walletConnectChainId => 'eip155:11155111';
  @override
  String get walletConnectParingMetadataName => 'Sample Dapp';
  @override
  String get walletConnectParingMetadataDescription => 'Sample Dapp';
  @override
  String get walletConnectParingMetadataUrl => 'https://walletconnect.com/';
  @override
  String get walletConnectParingMetadataIconUrl => 'https://i.imgur.com/sVny9Yi.png';
  @override
  String get walletConnectParingMetadataRedirectAppSchema => 'sampledapp://';
}