// Screens/HomeScreen/PaymentScreen.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jivit_jal/Screens/OrderScreen/TrackOrderScreen.dart';
import 'package:jivit_jal/Utils/AppColors.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  String _selectedPayment = 'UPI';
  bool _isProcessing = false;
  final List<Map<String, dynamic>> _paymentMethods = [
    {'icon': Icons.qr_code, 'label': 'UPI', 'subtitle': ''},
    {'icon': Icons.money, 'label': 'COD', 'subtitle': '(Cash on Delivery)'},
    {'icon': Icons.account_balance_wallet, 'label': 'Wallets', 'subtitle': ''},
  ];

  void _handlePayment() {
    setState(() {
      _isProcessing = true;
    });

    // Simulate payment processing
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        _isProcessing = false;
      });

      // Navigate to TrackOrderScreen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const TrackOrderScreen(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      ),
      child: Scaffold(
        backgroundColor: AppColors.white,
        appBar: AppBar(
          backgroundColor: AppColors.white,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
            onPressed: () => Navigator.pop(context),
          ),
          title: const Text(
            'Payment Method',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ),
          centerTitle: true,
        ),
        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.all(width * 0.05),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Select Payment Method',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    SizedBox(height: height * 0.015),
                    ..._paymentMethods.map((method) => _buildPaymentOption(
                      method,
                      width,
                      height,
                    )),

                    // ── Payment Summary ──────────────────────────────────
                    SizedBox(height: height * 0.03),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(width * 0.04),
                      decoration: BoxDecoration(
                        color: AppColors.background,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        children: [
                          _buildSummaryRow('Subtotal', '₹6,000'),
                          const SizedBox(height: 8),
                          _buildSummaryRow('Taxes & fees', '₹560'),
                          const Divider(height: 16, color: AppColors.borderLight),
                          _buildSummaryRow(
                            'Total Amount',
                            '₹6,560',
                            isTotal: true,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // ── Bottom Section ──────────────────────────────────────────
            Container(
              padding: EdgeInsets.all(width * 0.05),
              decoration: BoxDecoration(
                color: AppColors.white,
                border: Border(
                  top: BorderSide(color: AppColors.borderLight),
                ),
              ),
              child: GestureDetector(
                onTap: _isProcessing ? null : _handlePayment,
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(
                    horizontal: width * 0.04,
                    vertical: height * 0.018,
                  ),
                  decoration: BoxDecoration(
                    color: _isProcessing ? AppColors.borderLight : AppColors.primaryBlue,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Text(
                            '₹6,560',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Text(
                            _isProcessing ? 'Processing...' : 'Pay Now',
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      if (!_isProcessing)
                        const Icon(
                          Icons.arrow_forward_ios,
                          size: 18,
                          color: Colors.white,
                        )
                      else
                        const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentOption(Map<String, dynamic> method, double width, double height) {
    final isSelected = _selectedPayment == method['label'];

    return GestureDetector(
      onTap: _isProcessing ? null : () {
        setState(() {
          _selectedPayment = method['label'] as String;
        });
      },
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(width * 0.04),
        margin: EdgeInsets.only(bottom: height * 0.01),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primaryBlue.withOpacity(0.05) : AppColors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? AppColors.primaryBlue : AppColors.borderLight,
            width: isSelected ? 1.5 : 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: isSelected ? AppColors.primaryBlue : AppColors.background,
                shape: BoxShape.circle,
              ),
              child: Icon(
                method['icon'] as IconData,
                color: isSelected ? Colors.white : AppColors.primaryBlue,
                size: 20,
              ),
            ),
            SizedBox(width: width * 0.03),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    method['label'] as String,
                    style: TextStyle(
                      fontSize: width * 0.035,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  if (method['subtitle'].toString().isNotEmpty)
                    Text(
                      method['subtitle'] as String,
                      style: TextStyle(
                        fontSize: width * 0.028,
                        color: AppColors.textSecondary,
                      ),
                    ),
                ],
              ),
            ),
            if (isSelected)
              Icon(
                Icons.check_circle,
                color: AppColors.primaryBlue,
                size: 20,
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value, {bool isTotal = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: isTotal ? 14 : 13,
            fontWeight: isTotal ? FontWeight.w700 : FontWeight.w400,
            color: isTotal ? AppColors.textPrimary : AppColors.textSecondary,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: isTotal ? 14 : 13,
            fontWeight: isTotal ? FontWeight.w700 : FontWeight.w500,
            color: isTotal ? AppColors.primaryBlue : AppColors.textPrimary,
          ),
        ),
      ],
    );
  }
}