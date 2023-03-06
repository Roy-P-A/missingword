import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:missingword/extensions/list_shuffle.dart';

import '../../mixins/snackbar_mixin.dart';
import "dart:math";

class MissingWordTemplateController extends GetxController with SnackbarMixin {
  final String word = 'ELEPHANT';
  List<String> wordInList = [];

  final int maximumNumberOfKeys = 4;
  int remainingRandomKeys = 2;
  final _random = Random();

  final randomElement1 = "".obs;
  final randomElement2 = "".obs;

  final _randomElementIndex1 = 0.obs;
  int get randomElementIndex1 => _randomElementIndex1.value;

  final _randomElementIndex2 = 0.obs;
  int get randomElementIndex2 => _randomElementIndex2.value;

  final word1 = [].obs;
  List<String> _stringList = [];

  bool isSuccess = false;

  List<int> _shuffledIndices = [];
  final _displayList = (List<String>.empty()).obs;
  List<String> get displayList => _displayList;

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
    if (randomElementIndex1 < randomElementIndex2) {
      if (wordInList[randomElementIndex1] == '_') {
        wordInList[randomElementIndex1] = chr;
        update();
      } else if (wordInList[randomElementIndex2] == '_') {
        wordInList[randomElementIndex2] = chr;
        update();
      }
    } else {
      if (wordInList[randomElementIndex2] == '_') {
        wordInList[randomElementIndex2] = chr;
        update();
      } else if (wordInList[randomElementIndex1] == '_') {
        wordInList[randomElementIndex1] = chr;
        update();
      }
    }
  }

  _setValues() {
    wordInList = word.split("");

    debugPrint(wordInList.toString());
    randomElement1.value = wordInList[_random.nextInt(wordInList.length)];
    debugPrint(randomElement1.toString());
    _randomElementIndex1.value = wordInList.indexOf(randomElement1.value);
    debugPrint(randomElementIndex1.toString());

    

    do {
      randomElement2.value = wordInList[_random.nextInt(wordInList.length)];
    } while (randomElement2 == randomElement1);

    debugPrint(randomElement2.value);

    _randomElementIndex2.value = wordInList.indexOf(randomElement2.value);

    debugPrint(randomElementIndex2.toString());
    wordInList[randomElementIndex1] = '_';
    wordInList[randomElementIndex2] = '_';
    debugPrint(wordInList.toString());

    final keyListInset = Set.from(englishKeyList);
    debugPrint(keyListInset.toString());

    Set qwertyListEnglish1 =
        keyListInset.difference({randomElement1, randomElement2});
    final set4 = qwertyListEnglish1.toList();
    debugPrint(set4.toString());

    do {
      qwertyListHindi4.add(set4[_random.nextInt(set4.length)]);
    } while (qwertyListHindi4.where((e) => set4 != e).length < remainingRandomKeys);
    _stringList = qwertyListHindi4 + [randomElement1.value, randomElement2.value];
    debugPrint(_stringList.toString());

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
    if ((wordInList[randomElementIndex1] == '_') ||
        (wordInList[randomElementIndex2] == '_')) {
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
