
import 'dart:io';
import 'package:open_file/open_file.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:t_store/features/shop/models/order_model.dart';
import 'package:intl/intl.dart';

class PdfService {
  static Future<void> generateOrderPdf(DonHangModel order) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              // Header
              pw.Center(
                child: pw.Text('HÓA ĐƠN BÁN HÀNG',
                    style: pw.TextStyle(
                        fontSize: 20, fontWeight: pw.FontWeight.bold)),
              ),
              pw.SizedBox(height: 20),

              // Order Info
              pw.Text('Mã đơn hàng: ${order.id}'),
              pw.Text('Ngày đặt: ${order.ngayDatHangDinhDang}'),
              pw.Text('Khách hàng: ${order.diaChi?.hoTen ?? ""}'),
              pw.Text('Địa chỉ: ${order.diaChi?.diaChiDaChon ?? ""}'),
              pw.SizedBox(height: 20),

              // Products Table
              pw.Table(
                border: pw.TableBorder.all(),
                children: [
                  // Table Header
                  pw.TableRow(
                    children: [
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(5),
                        child: pw.Text('Sản phẩm'),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(5),
                        child: pw.Text('Số lượng'),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(5),
                        child: pw.Text('Đơn giá'),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(5),
                        child: pw.Text('Thành tiền'),
                      ),
                    ],
                  ),
                  // Product Rows
                  ...order.danhSachSanPham.map((item) => pw.TableRow(
                    children: [
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(5),
                        child: pw.Text(item.tenSanPham),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(5),
                        child: pw.Text('${item.soLuong}'),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(5),
                        child: pw.Text(
                            NumberFormat.currency(locale: 'vi').format(item.gia)),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(5),
                        child: pw.Text(
                            NumberFormat.currency(locale: 'vi')
                                .format(item.gia * item.soLuong)),
                      ),
                    ],
                  )),
                ],
              ),
              pw.SizedBox(height: 20),

              // Total
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.end,
                children: [
                  pw.Text(
                    'Tổng tiền: ${NumberFormat.currency(locale: 'vi').format(order.tongTien)}',
                    style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );

    // Save PDF
    final output = await getTemporaryDirectory();
    final file = File('${output.path}/Invoice_${order.id}.pdf');
    await file.writeAsBytes(await pdf.save());

    // Open PDF
    await OpenFile.open(file.path);
  }
}