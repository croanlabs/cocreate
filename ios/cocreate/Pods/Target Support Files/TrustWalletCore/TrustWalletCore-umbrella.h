#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "TWAccount.h"
#import "TWAES.h"
#import "TWAESPaddingMode.h"
#import "TWAeternityProto.h"
#import "TWAionProto.h"
#import "TWAlgorandProto.h"
#import "TWAnyAddress.h"
#import "TWAnySigner.h"
#import "TWBase.h"
#import "TWBase58.h"
#import "TWBinanceProto.h"
#import "TWBitcoinAddress.h"
#import "TWBitcoinProto.h"
#import "TWBitcoinScript.h"
#import "TWBitcoinSigHashType.h"
#import "TWBlockchain.h"
#import "TWCoinType.h"
#import "TWCoinTypeConfiguration.h"
#import "TWCosmosProto.h"
#import "TWCurve.h"
#import "TWData.h"
#import "TWDecredProto.h"
#import "TWElrondProto.h"
#import "TWEOSProto.h"
#import "TWEthereumAbiEncoder.h"
#import "TWEthereumAbiFunction.h"
#import "TWEthereumAbiValueDecoder.h"
#import "TWEthereumAbiValueEncoder.h"
#import "TWEthereumChainID.h"
#import "TWEthereumProto.h"
#import "TWFilecoinProto.h"
#import "TWFIOAccount.h"
#import "TWFIOProto.h"
#import "TWGroestlcoinAddress.h"
#import "TWHarmonyProto.h"
#import "TWHash.h"
#import "TWHDVersion.h"
#import "TWHDWallet.h"
#import "TWHRP.h"
#import "TWIconProto.h"
#import "TWIoTeXProto.h"
#import "TWNanoProto.h"
#import "TWNEARProto.h"
#import "TWNebulasProto.h"
#import "TWNEOProto.h"
#import "TWNimiqProto.h"
#import "TWNULSProto.h"
#import "TWOntologyProto.h"
#import "TWPolkadotProto.h"
#import "TWPrivateKey.h"
#import "TWPublicKey.h"
#import "TWPublicKeyType.h"
#import "TWPurpose.h"
#import "TWRippleProto.h"
#import "TWRippleXAddress.h"
#import "TWSegwitAddress.h"
#import "TWSolanaProto.h"
#import "TWSS58AddressType.h"
#import "TWStellarMemoType.h"
#import "TWStellarPassphrase.h"
#import "TWStellarProto.h"
#import "TWStellarVersionByte.h"
#import "TWStoredKey.h"
#import "TWString.h"
#import "TWTezosProto.h"
#import "TWThetaProto.h"
#import "TWTronProto.h"
#import "TWVeChainProto.h"
#import "TWWavesProto.h"
#import "TWZilliqaProto.h"
#import "TWFoundationData.h"
#import "TWFoundationString.h"
#import "TrustWalletCore.h"
#import "TWAccount.h"
#import "TWAES.h"
#import "TWAESPaddingMode.h"
#import "TWAeternityProto.h"
#import "TWAionProto.h"
#import "TWAlgorandProto.h"
#import "TWAnyAddress.h"
#import "TWAnySigner.h"
#import "TWBase.h"
#import "TWBase58.h"
#import "TWBinanceProto.h"
#import "TWBitcoinAddress.h"
#import "TWBitcoinProto.h"
#import "TWBitcoinScript.h"
#import "TWBitcoinSigHashType.h"
#import "TWBlockchain.h"
#import "TWCoinType.h"
#import "TWCoinTypeConfiguration.h"
#import "TWCosmosProto.h"
#import "TWCurve.h"
#import "TWData.h"
#import "TWDecredProto.h"
#import "TWElrondProto.h"
#import "TWEOSProto.h"
#import "TWEthereumAbiEncoder.h"
#import "TWEthereumAbiFunction.h"
#import "TWEthereumAbiValueDecoder.h"
#import "TWEthereumAbiValueEncoder.h"
#import "TWEthereumChainID.h"
#import "TWEthereumProto.h"
#import "TWFilecoinProto.h"
#import "TWFIOAccount.h"
#import "TWFIOProto.h"
#import "TWGroestlcoinAddress.h"
#import "TWHarmonyProto.h"
#import "TWHash.h"
#import "TWHDVersion.h"
#import "TWHDWallet.h"
#import "TWHRP.h"
#import "TWIconProto.h"
#import "TWIoTeXProto.h"
#import "TWNanoProto.h"
#import "TWNEARProto.h"
#import "TWNebulasProto.h"
#import "TWNEOProto.h"
#import "TWNimiqProto.h"
#import "TWNULSProto.h"
#import "TWOntologyProto.h"
#import "TWPolkadotProto.h"
#import "TWPrivateKey.h"
#import "TWPublicKey.h"
#import "TWPublicKeyType.h"
#import "TWPurpose.h"
#import "TWRippleProto.h"
#import "TWRippleXAddress.h"
#import "TWSegwitAddress.h"
#import "TWSolanaProto.h"
#import "TWSS58AddressType.h"
#import "TWStellarMemoType.h"
#import "TWStellarPassphrase.h"
#import "TWStellarProto.h"
#import "TWStellarVersionByte.h"
#import "TWStoredKey.h"
#import "TWString.h"
#import "TWTezosProto.h"
#import "TWThetaProto.h"
#import "TWTronProto.h"
#import "TWVeChainProto.h"
#import "TWWavesProto.h"
#import "TWZilliqaProto.h"
#import "TWFoundationData.h"
#import "TWFoundationString.h"

FOUNDATION_EXPORT double TrustWalletCoreVersionNumber;
FOUNDATION_EXPORT const unsigned char TrustWalletCoreVersionString[];
