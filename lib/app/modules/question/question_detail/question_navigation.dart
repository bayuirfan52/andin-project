/// Finds an adjacent question ID without moving past the list boundaries.
String? questionIdAtOffset(List<String?> ids, String? currentId, int offset) {
  if (offset.abs() != 1) return null;
  final index = ids.indexOf(currentId);
  final targetIndex = index + offset;
  if (index < 0 || targetIndex < 0 || targetIndex >= ids.length) return null;
  return ids[targetIndex];
}
