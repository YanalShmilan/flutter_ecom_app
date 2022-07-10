import 'package:rxdart/rxdart.dart';


class InMemoryStore<T> {
    InMemoryStore(
     T initial
  ) :_subject = BehaviorSubject<T>.seeded(initial);
  final BehaviorSubject<T> _subject;
  Stream<T> get stream => _subject.stream;
  T get value => _subject.value;
  set value(T newValue) {
    _subject.add(newValue);
  }

  void close() {
    _subject.close();
  }
}
