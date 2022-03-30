String toPrecision(double a) {
  if (a % 1 == 0) {
    return a.toStringAsFixed(0);
  }
  return a.toStringAsFixed(2);
}
