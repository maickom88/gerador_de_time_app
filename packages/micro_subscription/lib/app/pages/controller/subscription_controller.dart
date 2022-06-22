import 'package:flutter/foundation.dart';

import '../states/subscription_state.dart';

class SubscriptionController extends ValueNotifier<SubscriptionState> {
  SubscriptionController() : super(SubscriptionLoandingState());
}
