import 'dart:collection';
import 'dart:math';

import 'package:quiver/iterables.dart';

extension StringExtension on String {
  String capitalize() {
    if (isEmpty) return '';
    return '${this[0].toUpperCase()}${substring(1)}';
  }

  /// Adds a brake to a String
  /// [no parameters] Adds \n to the middle of the string by charactercount
  /// [biasUp]: if you prefer the top string to be longer
  /// [wCount]: The amount of words before the brake = 0 for half of the string
  /// [symbol]: The symbol to use for the break
  String br({
    bool biasUp = true,
    int wCount = 0,
    String symbol = '',
    bool keepSymbol = false,
  }) {
    if (isEmpty) return '';

    if (symbol != '') {
      return split(symbol)
          .map((e) => e.trim())
          .toList()
          .join(keepSymbol ? '$symbol\n' : '\n');
    }

    final words = split(' ');
    if (words.length == 1) return this;
    if (words.length == 2) return '${words[0]}\n${words[1]}';

    if ((wCount * (-1)) > 0) {
      return '${words.sublist(0, words.length + wCount).join(' ')}\n${words.sublist(words.length + wCount).join(' ')}';
    }

    var newWords = <String>[];
    int newcharCount = 0;

    if (wCount != 0) {
      for (var i = 0; i < words.length; i++) {
        if (i == wCount - 1) {
          newWords.add(words[i]);
          newcharCount += 1;
          break;
        } else {
          newWords.add(words[i]);
          newcharCount += words[i].length;
        }
      }
      return '${newWords.join(' ')}\n${words.sublist(wCount).join(' ')}';
    }

    for (var i = 0; i < words.length; i++) {
      if (!biasUp) newcharCount += (words[i].length + 1);
      if (newcharCount > (length / 2)) {
        break;
      }
      if (biasUp) newcharCount += (words[i].length + 1);
      newWords.add(words[i]);
    }
    return "${newWords.join(' ')}\n${words.sublist(newWords.length).join(' ')}";
  }

  // Add n line brakes to the string

  String mbr({int n = 3, bool biasUp = true}) {
    if (isEmpty) return '';
    final words = split(' ');
    var newWords = <String>[];
    int newcharCount = 0;
    String newString = '';

    for (var i = 0; i < words.length; i++) {
      if (!biasUp) newcharCount += (words[i].length + 1);
      if (newcharCount > (length / n)) {
        newcharCount = 0;
        newString = newString += '${newWords.join(' ')}\n';
        newWords = <String>[];
      }
      if (i == words.length - 1) {
        newWords.add(words[i]);
        newString = newString += newWords.join(' ');
      }
      newWords.add(words[i]);
      // newcharCount += (words[i].length + 1);
      if (biasUp) newcharCount += (words[i].length + 1);
    }
    return newString;
  }
}

typedef IndexedPredicate<T> = bool Function(int index, T);

extension Unique<E, Id> on List<E> {
  List<E> unique([Id Function(E element)? id, bool inplace = true]) {
    final Set ids = {};
    var list = inplace ? this : List<E>.from(this);
    list.retainWhere((x) => ids.add(id != null ? id(x) : x as Id));
    return list;
  }
}

extension CollectionsExtensions<T> on Iterable<T> {
  /// Returns this Iterable if it's not `null` and the empty list otherwise.
  Iterable<T> orEmpty() => this;

  ///Returns `true` if this nullable iterable is either null or empty.
  bool get isEmptyOrNull => isEmpty;

  /// Returns `true` if at least one element matches the given [predicate].
  bool any(bool Function(T element) predicate) {
    if (isEmptyOrNull) return false;
    for (final element in orEmpty()) {
      if (predicate(element)) return true;
    }
    return false;
  }

  /// Return a list concatenates the output of the current list and another [iterable]
  List<T> concatWithSingleList(Iterable<T> iterable) {
    if (isEmptyOrNull || iterable.isEmptyOrNull) return [];

    return <T>[...orEmpty(), ...iterable];
  }

  /// Return a list concatenates the output of the current list and multiple [iterables]
  List<T> concatWithMultipleList(List<Iterable<T>> iterables) {
    if (isEmptyOrNull || iterables.isEmptyOrNull) return [];
    final list = iterables.toList(growable: false).expand((i) => i);
    return <T>[...orEmpty(), ...list];
  }

  /// Convert iterable to set
  Set<T> toMutableSet() => Set.from(this);

  /// Returns a set containing all elements that are contained
  /// by both this set and the specified collection.
  Set<T> intersect(Iterable<T> other) {
    final set = toMutableSet();
    set.addAll(other);
    return set;
  }

  /// Returns a list containing only elements matching the given [predicate].
  List<T> filter(bool Function(T element) test) {
    final result = <T>[];
    forEach((e) {
      if (e != null && test(e)) {
        result.add(e);
      }
    });
    return result;
  }

  /// Returns a list containing all elements not matching the given [predicate] and will filter nulls as well.
  List<T> filterNot(bool Function(T element) test) {
    final result = <T>[];
    forEach((e) {
      if (e != null && !test(e)) {
        result.add(e);
      }
    });
    return result;
  }

// return the half size of a list
  int get halfLength => (length / 2).floor();

  /// Returns a list containing first [n] elements.
  List<T> takeOnly(int n) {
    if (n == 0) return [];

    var list = List<T>.empty();
    var thisList = toList();
    final resultSize = length - n;
    if (resultSize <= 0) return [];
    if (resultSize == 1) return [last];

    List.generate(n, (index) {
      list.add(thisList[index]);
    });
    return list;
  }

  /// Returns a list containing all elements except first [n] elements.
  List<T> drop(int n) {
    if (n == 0) return [];

    var list = List<T>.empty();
    var originalList = toList();
    final resultSize = length - n;
    if (resultSize <= 0) return [];
    if (resultSize == 1) return [last];

    originalList.removeRange(0, n);

    for (var element in originalList) {
      list.add(element);
    }
    return list;
  }

  // Retuns map operation as a List
  List<E> mapList<E>(E Function(T e) f) => map(f).toList();

  // Takes the first half of a list
  List<T> firstHalf() => take(halfLength).toList();

  // Takes the second half of a list
  List<T> secondHalf() => drop(halfLength).toList();

  /// returns a list with two swapped items
  /// [i] first item
  /// [j] second item
  List<T> swap(int i, int j) {
    final list = toList();
    final aux = list[i];
    list[i] = list[j];
    list[j] = aux;
    return list;
  }

  T getRandom() {
    Random generator = Random();
    final index = generator.nextInt(length);
    return toList()[index];
  }

  /// get the first element return null
  T? get firstOrNull => _elementAtOrNull(0);

  /// get the last element if the list is not empty or return null
  T? get lastOrNull => isNotEmpty ? last : null;

  T lastOrDefault(T defaultValue) => lastOrNull ?? defaultValue;

  T? firstOrNullWhere(bool Function(T element) predicate) {
    for (T element in this) {
      if (predicate(element)) return element;
    }
    return null;
  }

  /// get the first element or provider default
  /// example:
  /// var name = [danny, ronny, james].firstOrDefault["jack"]; // danny
  /// var name = [].firstOrDefault["jack"]; // jack
  T firstOrDefault(T defaultValue) => firstOrNull ?? defaultValue;

  /// Will retrun new [Iterable] with all elements that satisfy the predicate [predicate],
  Iterable<T> whereIndexed(IndexedPredicate<T> predicate) =>
      _IndexedWhereIterable(this, predicate);

  ///
  /// Performs the given action on each element on iterable, providing sequential index with the element.
  /// [item] the element on the current iteration
  /// [index] the index of the current iteration
  ///
  /// example:
  /// ["a","b","c"].forEachIndexed((element, index) {
  ///    print("$element, $index");
  ///  });
  /// result:
  /// a, 0
  /// b, 1
  /// c, 2
  void forEachIndexed(void Function(T element, int index) action) {
    var index = 0;
    for (var element in this) {
      action(element, index++);
    }
  }

  /// Returns a new list with all elements sorted according to descending
  /// natural sort order.
  List<T> sortedDescending() {
    var list = toList();
    list.sort((a, b) => -(a as Comparable).compareTo(b));
    return list;
  }

  /// Checks if all elements in the specified [collection] are contained in
  /// this collection.
  bool containsAll(Iterable<T> collection) {
    for (var element in collection) {
      if (!contains(element)) return false;
    }
    return true;
  }

  /// Return a number of the existing elements by a specific predicate
  /// example:
  ///  final aboveTwenty = [
  ///    User(33, "chicko"),
  ///    User(45, "ronit"),
  ///    User(19, "amsalam"),
  ///  ].count((user) => user.age > 20); // 2
  int count([bool Function(T element)? predicate]) {
    var count = 0;
    if (predicate == null) {
      return length;
    } else {
      for (var current in this) {
        if (predicate(current)) {
          count++;
        }
      }
    }

    return count;
  }

  /// Returns `true` if all elements match the given predicate.
  /// Example:
  /// [5, 19, 2].all(isEven), isFalse)
  /// [6, 12, 2].all(isEven), isTrue)
  bool all(bool Function(T pred)? predicate) {
    for (var e in this) {
      if (!predicate!(e)) return false;
    }
    return true;
  }

  /// Returns a list containing only the elements from given collection having distinct keys.
  ///
  /// Basically it's just like distinct function but with a predicate
  /// example:
  /// [
  ///    User(22, "Sasha"),
  ///    User(23, "Mika"),
  ///    User(23, "Miryam"),
  ///    User(30, "Josh"),
  ///    User(36, "Ran"),
  ///  ].distinctBy((u) => u.age).forEach((user) {
  ///    print("${user.age} ${user.name}");
  ///  });
  ///
  /// result:
  /// 22 Sasha
  /// 23 Mika
  /// 30 Josh
  /// 36 Ran
  List<T> distinctBy(Function(T selector) predicate) {
    final set = HashSet();
    final List<T> list = [];
    toList().forEach((e) {
      final key = predicate(e);
      if (set.add(key)) {
        list.add(e);
      }
    });

    return list;
  }

// get an element at specific index or return null
  T? _elementAtOrNull(int index) {
    return _elementOrNull(index, (_) => null);
  }

  _elementOrNull(int index, T? Function(int index) defaultElement) {
// if our index is smaller then 0 return the default
    if (index < 0) return defaultElement(index);

    var counter = 0;
    for (var element in this) {
      if (index == counter++) {
        return element;
      }
    }

    return defaultElement(index);
  }

  /// Returns a set containing all elements that are contained by this collection
  /// and not contained by the specified collection.
  /// The returned set preserves the element iteration order of the original collection.
  ///
  /// example:
  ///
  /// [1,2,3,4,5,6].subtract([4,5,6])
  ///
  /// result:
  /// 1,2,3
  subtract(Iterable<T> other) {
    final set = toSet();
    set.removeAll(other);
    return set;
  }

  /// Splits the Iterable into chunks of the specified size
  ///
  /// example:
  /// [1, 2, 3, 4, 5, 6, 7, 8, 9, 10].chunks(3))
  /// result:
  /// ([1, 2, 3], [4, 5, 6], [7, 8, 9], [10])
  Iterable<List<T>> chunks(int size) => partition(this, size);

  /// Returns the first element matching the given [predicate], or `null`
  /// if element was not found.
  T? find(Function(T selector) predicate) {
    for (final element in this) {
      if (predicate(element)) {
        return element;
      }
    }

    return null;
  }
}

// A lazy [Iterable] skip elements do **NOT** match the predicate [_f].
class _IndexedWhereIterable<E> extends Iterable<E> {
  final Iterable<E> _iterable;
  final IndexedPredicate<E> _f;

  _IndexedWhereIterable(this._iterable, this._f);

  @override
  Iterator<E> get iterator => _IndexedWhereIterator<E>(_iterable.iterator, _f);
}

/// [Iterator] for [_IndexedWhereIterable]
class _IndexedWhereIterator<E> extends Iterator<E> {
  final Iterator<E> _iterator;
  final IndexedPredicate<E> _f;
  int _index = 0;

  _IndexedWhereIterator(this._iterator, this._f);

  @override
  bool moveNext() {
    while (_iterator.moveNext()) {
      if (_f(_index++, _iterator.current)) {
        return true;
      }
    }
    return false;
  }

  @override
  E get current => _iterator.current;
}
