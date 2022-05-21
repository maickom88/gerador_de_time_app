extension FormateDate on DateTime {
  String formateDateString() {
    List months = [
      'Janeiro',
      'Fevereiro',
      'Março',
      'Abril',
      'Maio',
      'Junho',
      'Julho',
      'Agosto',
      'Setembro',
      'Outubro',
      'Novembro',
      'Dezembro',
    ];
    return '$day, ${months[month - 1]} de $year';
  }
}
