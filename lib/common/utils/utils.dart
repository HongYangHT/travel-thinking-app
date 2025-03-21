bool isStringNullOrEmpty<T>(T obj) {
  if (obj == null) {
    return true;
  }
  if (obj is String) {
    return obj.isEmpty || obj == 'null';
  }

  return false;
}
