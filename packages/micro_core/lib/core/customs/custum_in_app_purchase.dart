import 'dart:async';

import 'package:in_app_purchase/in_app_purchase.dart';

import '../errors/errors.dart';

class CustumInAppPurchese {
  StreamSubscription<List<PurchaseDetails>>? _subscription;
  static final StreamController<PurchaseDetails> _purchaseController =
      StreamController<PurchaseDetails>();
  Stream<PurchaseDetails> onBuy =
      _purchaseController.stream.asBroadcastStream();
  InAppPurchase get inAppPurchase => InAppPurchase.instance;

  String get productId => 'gerador_de_times';
  List<ProductDetails> products = [];
  set productId(String newProductId) => productId = newProductId;

  CustumInAppPurchese._run();
  static final CustumInAppPurchese _singleton = CustumInAppPurchese._run();
  static CustumInAppPurchese get instance => _singleton;
  factory CustumInAppPurchese() => _singleton;

  Future<void> initialize() async {
    final purchaseUpdated = inAppPurchase.purchaseStream;
    await getProducts();
    _subscription = purchaseUpdated.listen((purchaseDetailsList) {
      _listenToPurchaseUpdated(purchaseDetailsList);
    }, onDone: () {
      _subscription?.cancel();
    }, onError: (error) {
      _purchaseController.addError(UnexpectedError());
    });
  }

  Future<void> dispose() async {
    await _subscription?.cancel();
  }

  Future<void> getProducts() async {
    final ProductDetailsResponse productDetailResponse =
        await inAppPurchase.queryProductDetails({productId}.toSet());
    if (productDetailResponse.error == null) {
      products = productDetailResponse.productDetails;
    }
  }

  Future<void> restorePurchases() async {
    if (!await inAppPurchase.isAvailable()) {
      _purchaseController.addError(NotAvailable());
      return;
    }
    try {
      await inAppPurchase.restorePurchases();
      // ignore: avoid_catches_without_on_clauses
    } catch (error) {
      _purchaseController.addError(FailedRestored());
    }
  }

  Future<void> _listenToPurchaseUpdated(
      List<PurchaseDetails> purchaseDetailsList) async {
    for (var purchaseDetails in purchaseDetailsList) {
      switch (purchaseDetails.status) {
        case PurchaseStatus.pending:
          break;
        case PurchaseStatus.purchased:
        case PurchaseStatus.restored:
          final valid = await _verifyPurchase(purchaseDetails);
          if (valid) {
            if (purchaseDetails.status == PurchaseStatus.purchased) {
              await deliverProduct(purchaseDetails);
            }
          }
          break;
        case PurchaseStatus.error:
          _purchaseController.addError(UnexpectedError());
          break;
        case PurchaseStatus.canceled:
          break;
      }
      if (purchaseDetails.pendingCompletePurchase) {
        await inAppPurchase.completePurchase(purchaseDetails);
      }
    }
  }

  Future<void> deliverProduct(PurchaseDetails details) async {
    _purchaseController.add(details);
  }

  Future<bool> _verifyPurchase(PurchaseDetails purchaseDetails) {
    return Future<bool>.value(true);
  }

  Future<void> buy() async {
    if (!await inAppPurchase.isAvailable()) {
      _purchaseController.addError(NotAvailable());
      return;
    }
    final response =
        await inAppPurchase.queryProductDetails({productId}.toSet());
    if (response.error != null) {
      _purchaseController.addError(UnexpectedError());
      return;
    }
    if (response.productDetails.length != 1) {
      _purchaseController.addError(NotFound());
      return;
    }
    final productDetails = response.productDetails.single;
    final purchaseParam = PurchaseParam(productDetails: productDetails);
    final result =
        await inAppPurchase.buyNonConsumable(purchaseParam: purchaseParam);
    if (result) {
      _purchaseController.addError(FailedPurchase());
    }
  }
}
