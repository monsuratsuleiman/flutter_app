
class PagedItems<T> {
  final List<T> items;

  final int startingIndex;

  final bool hasNext;

  PagedItems({
    required this.items,
    required this.startingIndex,
    required this.hasNext,
  });
}