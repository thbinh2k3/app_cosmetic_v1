import 'package:app_cosmetic/data/config.app.dart';
import 'package:app_cosmetic/model/voucher.model.dart';
import 'package:app_cosmetic/services/voucher_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

class CouponsScreen extends StatefulWidget {
  @override
  _CouponsScreenState createState() => _CouponsScreenState();
}

class _CouponsScreenState extends State<CouponsScreen> {
  late Future<List<VoucherDto>> vouchers;

  @override
  void initState() {
    super.initState();
    vouchers = VoucherService().fetchVoucherList();
  }

  String _formatMoney(int amount) {
    final formatter = NumberFormat.decimalPattern('vi_VN');
    return formatter.format(amount);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Danh sách mã giảm giá'),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Các ưu đãi cho bạn ',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Expanded(
              child: FutureBuilder<List<VoucherDto>>(
                future: vouchers,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(child: Text('No vouchers available'));
                  } else {
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        final voucher = snapshot.data![index];
                        return Card(
                          color: Color.fromARGB(255, 231, 232, 233),
                          margin: EdgeInsets.symmetric(vertical: 8),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Mã giảm giá : ${voucher.codeVoucher}',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  'Giảm giá ${voucher.percent_sale}% ',
                                  style: TextStyle(fontSize: 16),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  'Giảm tối đa ${_formatMoney(voucher.maxPriceSale)} đ',
                                ),
                                SizedBox(height: 8),
                                Text(
                                  'Số lượng còn lại: ${voucher.quantity}',
                                  style: TextStyle(color: Colors.red),
                                ),
                                SizedBox(height: 16),
                                ElevatedButton(
                                  onPressed: () {
                                    Clipboard.setData(ClipboardData(
                                        text: voucher.codeVoucher));
                                    Fluttertoast.showToast(
                                      msg:
                                          'Sao chép mã ${voucher.codeVoucher} thành công ',
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.BOTTOM,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: Colors.grey.shade200,
                                      textColor: Colors.brown,
                                      fontSize: 16.0,
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                    foregroundColor: AppColors.text,
                                    backgroundColor: AppColors.primaryColor,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(24),
                                    ),
                                    minimumSize: Size(double.infinity, 40),
                                  ),
                                  child: Text('SAO CHÉP MÃ'),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
