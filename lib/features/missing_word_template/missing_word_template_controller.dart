import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:missingword/extensions/list_shuffle.dart';
import '../../mixins/snackbar_mixin.dart';
import "dart:math";

class MissingWordTemplateController extends GetxController with SnackbarMixin {
  final String word = 'ELEPHANT';
  List<String> wordInList = [];

  int remainingRandomKeys = 2;
  final _random = Random();

  final _randomElement1 = "".obs;
  String get randomElement1 => _randomElement1.value;
  final _randomElement2 = "".obs;
  String get randomElement2 => _randomElement2.value;

  final _randomElementIndex1 = 0.obs;
  int get randomElementIndex1 => _randomElementIndex1.value;

  final _randomElementIndex2 = 0.obs;
  int get randomElementIndex2 => _randomElementIndex2.value;

  List<String> _stringList = [];

  bool isSuccess = false;

  List<int> _shuffledIndices = [];
  final _displayList = (List<String>.empty()).obs;
  List<String> get displayList => _displayList;

  String get question => 'Complete the word by clicking on letters below';
  List<String> partialRandomKeys = [];

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
    _setValues();
    super.onInit();
  }

  _setValues() {
    wordInList = word.split("");
    _randomElement1.value = wordInList[_random.nextInt(wordInList.length)];
    _randomElementIndex1.value = wordInList.indexOf(_randomElement1.value);
    do {
      _randomElement2.value = wordInList[_random.nextInt(wordInList.length)];
    } while (randomElement2 == randomElement1);
    _randomElementIndex2.value = wordInList.indexOf(_randomElement2.value);
    wordInList[randomElementIndex1] = '_';
    wordInList[randomElementIndex2] = '_';
    final keyListInset = Set.from(englishKeyList);
    Set remainingEnglishAlphabetInSet =
        keyListInset.difference({randomElement1, randomElement2});
    final remainingEnglishAlphabetInList =
        remainingEnglishAlphabetInSet.toList();
    do {
      partialRandomKeys.add(remainingEnglishAlphabetInList[
          _random.nextInt(remainingEnglishAlphabetInList.length)]);
    } while ((partialRandomKeys.length < remainingRandomKeys) || (partialRandomKeys[0] == partialRandomKeys[1]));
    _stringList =
        partialRandomKeys + [_randomElement1.value, _randomElement2.value];
    debugPrint(_stringList.toString());

    _shuffleValues();
  }

  _shuffleValues() {
    _shuffledIndices = [for (var i = 0; i < _stringList.length; i++) i]
      ..shuffleList();
    List<String> shuffledAlphabets = [];
    for (int i in _shuffledIndices) {
      shuffledAlphabets.add(_stringList[i]);
    }
    _displayList(shuffledAlphabets);
    update();
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
