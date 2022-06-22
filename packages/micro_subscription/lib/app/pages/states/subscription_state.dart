import 'package:micro_core/core/errors/errors.dart';

abstract class SubscriptionState {}

class SubscriptionLoandingState extends SubscriptionState {}

class InitialSubscriptionState extends SubscriptionState {}

class SubscriptionSuccessState extends SubscriptionState {}

class SubscriptionErrorState extends SubscriptionState {
  final Failure error;
  SubscriptionErrorState({
    required this.error,
  });
}
