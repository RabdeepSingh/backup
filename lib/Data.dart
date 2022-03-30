class QRDetail {
  int product_id;
  String product_name;
  int notification_count;
  int impression_count;
  QRDetail(this.product_id, this.product_name, this.notification_count,
      this.impression_count);
}

class QRData {
  QRData(this.x, this.y);
  final String x;
  final int y;
}
