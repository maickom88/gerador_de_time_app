extension SplitConvertName on String {
  String splitConvertName() {
    final listName = split(' ');
    if (listName.isEmpty) {
      return '$this ';
    }
    if (listName.length == 1) {
      return "${listName.first[0].toUpperCase()}${substring(1).toLowerCase()}";
    }
    return '${listName[0].toCapitalized()} ${listName[1][0].toCapitalized()}.';
  }
}

extension StringCasingExtension on String {
  String toCapitalized() =>
      length > 0 ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}' : '';
  String toTitleCase() => replaceAll(RegExp(' +'), ' ')
      .split(' ')
      .map((str) => str.toCapitalized())
      .join(' ');
}
