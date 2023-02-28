extension ShuffleList<E> on List<E> {
  shuffleList() {
    if (isEmpty) return this;

    final tempList = map((e) => e).toList();

    var list = Iterable<int>.generate(tempList.length).toList();

    do {
      list.shuffle();
    } while (list.where((e) => list[e] == e).toList().isNotEmpty);

    clear();

    for (int i = 0; i < list.length; i++) {
      add(tempList[list[i]]);
    }
    //shuffle();
  }
}