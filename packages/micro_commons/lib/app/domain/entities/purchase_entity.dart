import 'dart:convert';

import 'user_entity.dart';

class PurchaseEntity {
  final String guid;
  final UserEntity user;
  final DateTime datePurchase;
  final DateTime dateExpiredPurchase;
  final double? priceBr;
  final double? priceUsd;
  final PlatformMobile? platform;
  PurchaseEntity({
    required this.guid,
    required this.user,
    required this.datePurchase,
    required this.dateExpiredPurchase,
    this.priceBr,
    this.priceUsd,
    this.platform,
  });

  factory PurchaseEntity.fromMap(Map<String, dynamic> map) {
    return PurchaseEntity(
      guid: map['guid'] ?? '',
      user: UserEntity.fromMap(map['user']),
      datePurchase: DateTime.parse(map['date_purchase']),
      dateExpiredPurchase: DateTime.parse(map['date_expired_purchase']),
      priceBr: map['price_br']?.toDouble(),
      priceUsd: map['price_usd']?.toDouble(),
      platform: map['platform'] != null
          ? (map["platform"] as String).toPlatformMobile()
          : null,
    );
  }

  factory PurchaseEntity.fromJson(String source) =>
      PurchaseEntity.fromMap(json.decode(source));
}

enum PlatformMobile { android, ios }

extension OnPlatform on String {
  PlatformMobile? toPlatformMobile() {
    switch (this) {
      case 'ANDROID':
        return PlatformMobile.android;
      case 'IOS':
        return PlatformMobile.ios;
    }
    return null;
  }
}
