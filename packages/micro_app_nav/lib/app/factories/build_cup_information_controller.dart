import '../pages/controllers/cup_information_controller.dart';
import 'build_resources.dart';

CupInformationController buildCupInformationController() =>
    CupInformationController(getCupInformationUsecase);
