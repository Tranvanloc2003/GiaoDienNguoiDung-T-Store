// import '../../features/shop/models/cart_model.dart';

class TPricingCalculator {
  /// -- Tính tổng giá dựa trên thuế và phí vận chuyển
  static double calculateTotalPrice(double productPrice, String location) {
    double taxRate = getTaxRateForLocation(location);
    double taxAmount = productPrice * taxRate;

    double shippingCost = getShippingCost(location);

    double totalPrice = productPrice + taxAmount + shippingCost;
    return totalPrice;
  }

  /// -- Tính phí vận chuyển
  static String calculateShippingCost(double productPrice, String location) {
    double shippingCost = getShippingCost(location);
    return shippingCost.toStringAsFixed(2);
  }

  /// -- Tính thuế
  static String calculateTax(double productPrice, String location) {
    double taxRate = getTaxRateForLocation(location);
    double taxAmount = productPrice * taxRate;
    return taxAmount.toStringAsFixed(2);
  }

  /// Lấy tỷ lệ thuế cho địa điểm
  static double getTaxRateForLocation(String location) {
    // Tra cứu tỷ lệ thuế cho địa điểm từ cơ sở dữ liệu hoặc API thuế.
    // Trả về tỷ lệ thuế phù hợp.
    return 0.10; // Ví dụ: thuế 10%
  }

  /// Lấy phí vận chuyển cho địa điểm
  static double getShippingCost(String location) {
    // Tra cứu chi phí vận chuyển cho địa điểm bằng API tính phí vận chuyển.
    // Tính phí vận chuyển dựa trên các yếu tố như khoảng cách, trọng lượng, v.v.
    return 5.00; // Ví dụ: phí vận chuyển 5.000đ
  }

  /// -- Tính tổng giá trị giỏ hàng
  // static double calculateCartTotal(CartModel cart) {
  //   return cart.items.map((e) => e.price).fold(0, (previousPrice, currentPrice) => previousPrice + (currentPrice ?? 0));
  // }
}
