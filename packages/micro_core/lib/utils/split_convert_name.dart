extension SplitConvertName on String {
  String splitConvertName() {
    final listName = split(' ');
    if (listName.isEmpty) {
      return '$this ';
    }
    if (listName.length == 1) {
      return listName.first;
    }
    return '${listName[0]} ${listName[1][0]}. ';
  }
}
