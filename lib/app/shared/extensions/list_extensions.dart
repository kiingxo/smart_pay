extension Enumerate<T> on List<T> {
  List<(int, T)> enumerate() {
    return List.generate(length, (index) => (index, this[index]));
  }
}
