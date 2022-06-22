import 'dart:async';

import 'package:flutter/services.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:logger/logger.dart';

class CustumInAppPurchese {
  StreamSubscription<List<PurchaseDetails>>? _subscription;
  InAppPurchase get inAppPurchase => InAppPurchase.instance;
  Logger get logger => Logger();
  String get productId => 'teste';
  set productId(String newProductId) => productId = newProductId;

  CustumInAppPurchese._run();
  static final CustumInAppPurchese _singleton = CustumInAppPurchese._run();
  static CustumInAppPurchese get instance => _singleton;
  factory CustumInAppPurchese() => _singleton;

  Future<void> initialize() async {
    final purchaseUpdated = inAppPurchase.purchaseStream;
    _subscription = purchaseUpdated.listen((purchaseDetailsList) {
      _listenToPurchaseUpdated(purchaseDetailsList);
    }, onDone: () {
      _subscription?.cancel();
    }, onError: (error) {
      logger.e('Error! ${error.toString()}', 'Error on purchases Stream');
    });
  }

  Future<void> dispose() async {
    await _subscription?.cancel();
  }

  void restorePurchases() async {
    if (!await inAppPurchase.isAvailable()) {
      logger.i('In App Purchases not available');
      return;
    }
    try {
      await inAppPurchase.restorePurchases();
      // ignore: avoid_catches_without_on_clauses
    } catch (error) {
      logger.e('Error! ${error.toString()}', 'Trying to restore buy');
    }
    logger.i('In App Purchases restore');
  }

  Future<void> _listenToPurchaseUpdated(
      List<PurchaseDetails> purchaseDetailsList) async {
    for (var purchaseDetails in purchaseDetailsList) {
      logger.v(
        {
          'productID': purchaseDetails.productID,
          'status': purchaseDetails.status,
          'purchaseID': purchaseDetails.purchaseID,
          'error': purchaseDetails.error,
          'peddingCompletePurchase': purchaseDetails.pendingCompletePurchase,
        },
      );

      switch (purchaseDetails.status) {
        case PurchaseStatus.pending:
          break;
        case PurchaseStatus.purchased:
        case PurchaseStatus.restored:
          final valid = await _verifyPurchase(purchaseDetails);
          if (valid) {
            if (purchaseDetails.status == PurchaseStatus.purchased) {
              //avisar que a compra foi feita com sucesso;
            }
          } else {
            logger.e('Error! $purchaseDetails', 'Purchase verification failed');
          }
          break;
        case PurchaseStatus.error:
          logger.e('Error! ${purchaseDetails.error}', 'Error with purchase');
          break;
        case PurchaseStatus.canceled:
          logger.i('In App Purchases canceled');
          break;
      }
      if (purchaseDetails.pendingCompletePurchase) {
        await inAppPurchase.completePurchase(purchaseDetails);
      }
    }
  }

  Future<bool> _verifyPurchase(PurchaseDetails purchaseDetails) {
    logger.i('Verifying purchase', purchaseDetails.verificationData);
    return Future<bool>.value(true);
  }

  Future<void> buy() async {
    if (!await inAppPurchase.isAvailable()) {
      logger.i('In App Purchases not available');
      return;
    }

    logger.i('querying the store with queryProductsDetails()');

    final response = await inAppPurchase.queryProductDetails({productId});

    if (response.error != null) {
      logger.e('Error! ${response.error}',
          'There was an error when making the purchase');
      return;
    }

    if (response.productDetails.length != 1) {
      logger.e('Error! Product does not exist',
          'There was an error when making the purchase');
      return;
    }

    final productDetails = response.productDetails.single;
    logger.i('Making the purchase');
    final purchaseParam = PurchaseParam(productDetails: productDetails);
    final success =
        await inAppPurchase.buyConsumable(purchaseParam: purchaseParam);
    logger.i('request was sent with success', success);
  }
}
