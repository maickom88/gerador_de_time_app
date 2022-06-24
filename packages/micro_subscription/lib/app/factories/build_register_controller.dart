import 'package:micro_commons/app/factories/build_resources.dart';

import '../pages/controller/subscription_controller.dart';
import 'build_resources.dart';

SubscriptionController buildSubscriptionController() =>
    SubscriptionController(registerPurchaseUsecase, storage);
