class Failure implements Exception {
  String get message => '';
}

class KeyNotExist implements Failure {
  @override
  String get message => 'Chave não existe no Firebase Remote Config';
}

class NotFound implements Failure {
  @override
  String get message => 'Item não encontrado';
}

class UnexpectedError implements Failure {
  @override
  String get message => 'Ocorreu um error inesperado';
}

class ConnectTimeoutError implements Failure {
  @override
  String get message => 'Sua requisição demorou muito, tente novamente';
}

class Unauthorized implements Failure {
  @override
  String get message => 'Acesso não autorizado';
}

class NotAvailable implements Failure {
  @override
  String get message => 'Não está disponivél no momento';
}

class FailedRestored implements Failure {
  @override
  String get message => 'Falha ao tentar restaurar compra';
}

class FailedPurchase implements Failure {
  @override
  String get message => 'Houve uma falha ao efetuar assinatura';
}
