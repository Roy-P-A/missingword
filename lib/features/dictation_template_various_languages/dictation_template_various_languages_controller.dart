import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:missingword/extensions/list_shuffle.dart';

import '../../mixins/snackbar_mixin.dart';
import "dart:math";

class DictationTemplateVariousLanguagesController extends GetxController
    with SnackbarMixin {
  final String word = 'HORSE';
  List<String> wordInList = [];

  final int maximumNumberOfKeys = 4;
  int remainingRandomKeys = 3;
  final _random = Random();

  final _randomElementIndex = 0.obs;
  int get randomElementIndex => _randomElementIndex.value;

  final word1 = [].obs;
  List<String> _stringList = [];

  bool isSuccess = false;

  List<int> _shuffledIndices = [];
  final _displayList = (List<String>.empty()).obs;
  List<String> get displayList => _displayList.value;

  String get question => 'Complete the word by clicking on letters below.';
  List<String> qwertyListHindi4 = [];

  final englishKeyList = [
    'A',
    'B',
    'C',
    'D',
    'E',
    'F',
    'G',
    'H',
    'I',
    'J',
    'K',
    'L',
    'M',
    'N',
    'O',
    'P',
    'Q',
    'R',
    'S',
    'T',
    'U',
    'V',
    'W',
    'X',
    'Y',
    'Z'
  ];

  @override
  void onInit() {
    for (int i = 0; i < word.length; i++) {
      word1.add(word[i]);
    }
    _setValues();
    super.onInit();
  }

  onTappedKeyboardButton(String chr) {
    if (wordInList[randomElementIndex] == '_') {
      print(chr);
      wordInList[randomElementIndex] = chr;
      update();
    }
  }

  _setValues() {
    wordInList = word.split("");

    debugPrint(wordInList.toString());
    var randomElement = wordInList[_random.nextInt(wordInList.length)];
    debugPrint(randomElement);

    _randomElementIndex.value = wordInList.indexOf(randomElement);
    debugPrint(randomElementIndex.toString());
    wordInList[randomElementIndex] = '_';
    debugPrint(wordInList.toString());

    final keyListInset = Set.from(englishKeyList);
    debugPrint(keyListInset.toString());

    Set qwertyListEnglish1 = keyListInset.difference({randomElement});
    final set4 = qwertyListEnglish1.toList();
    debugPrint(set4.toString());

    do {
      qwertyListHindi4.add(set4[_random.nextInt(set4.length)]);
    } while (qwertyListHindi4.where((e) => set4 != e).length < 3);
    _stringList = qwertyListHindi4 + [randomElement];
    print(_stringList);

    _shuffleValues();
  }

  _shuffleValues() {
    _shuffledIndices = [for (var i = 0; i < _stringList.length; i++) i]
      ..shuffleList();

    List<String> displayList1 = [];
    for (int i in _shuffledIndices) {
      displayList1.add(_stringList[i]);
    }
    _displayList(displayList1);
    update();
  }

  onTappedDoneButton() {
    if (wordInList[randomElementIndex] == '_') {
      showErrorSnackbar(title: 'Error', message: 'Complete the word');
      return;
    }

    isSuccess = wordInList.join() == word;

    if (isSuccess) {
      showSuccessSnackbar(
          title: 'Success', message: 'You got the correct answer');
    } else {
      showErrorSnackbar(title: 'Error', message: 'Incorrect answer');
    }
  }
}
