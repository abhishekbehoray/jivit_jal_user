// Screens/HomeScreen/QuickRefillScreen.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jivit_jal/Utils/AppColors.dart';
import 'package:jivit_jal/Utils/ImageAssets.dart';
import 'package:jivit_jal/Screens/HomeScreen/RefillPreviewScreen.dart';
import 'package:jivit_jal/Screens/HomeScreen/AddAddressScreen.dart';
import 'package:jivit_jal/Screens/HomeScreen/TryWaterScreen.dart';

class QuickRefillScreen extends StatefulWidget {
  const QuickRefillScreen({super.key});

  @override
  State<QuickRefillScreen> createState() => _QuickRefillScreenState();
}

class _QuickRefillScreenState extends State<QuickRefillScreen> {
  int _jarCount = 0;
  String _selectedDeliveryOption = 'Quick Delivery';
  String _selectedTimeSlot = '';
  final TextEditingController _dateController = TextEditingController();

  // Address state
  String _selectedAddress = 'Home Address';
  String _addressDetails = '307, B/2, Tapovan, Pathanwadi Road,\nMalad (east)';

  final List<String> _timeSlots = [
    '9 - 11 AM',
    '12 - 2 PM',
    '3 - 5 PM',
    '6 - 8 PM',
  ];

  final List<Map<String, dynamic>> _deliveryOptions = [
    {
      'label': 'Quick Delivery',
      'subtitle': '40-60 Mins',
      'icon': Icons.speed,
    },
    {
      'label': 'Schedule',
      'subtitle': 'Choose Time',
      'icon': Icons.calendar_today,
    },
  ];

  @override
  void dispose() {
    _dateController.dispose();
    super.dispose();
  }

  void _navigateToAddAddress() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const AddAddressScreen(),
      ),
    );

    if (result != null && result is Map<String, String>) {
      setState(() {
        _selectedAddress = result['type'] ?? 'Home Address';
        _addressDetails =
        '${result['house']}, ${result['area']},\n${result['city']} - ${result['pincode']}';
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Address added successfully!'),
          backgroundColor: AppColors.success,
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  void _navigateToTryWater() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const TryWaterScreen(),
      ),
    );
  }

  void _validateAndConfirmRefill() {
    if (_jarCount == 0) {
      _showSnackBar('Please select at least 1 jar');
      return;
    }
    if (_selectedDeliveryOption == 'Schedule' && _dateController.text.isEmpty) {
      _showSnackBar('Please select a date');
      return;
    }
    if (_selectedDeliveryOption == 'Schedule' && _selectedTimeSlot.isEmpty) {
      _showSnackBar('Please select a time slot');
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const RefillPreviewScreen(),
      ),
    );
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.orange,
        duration: const Duration(seconds: 2),
      ),
    );
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
            'Quick Refill',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.all(width * 0.05),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── Product Card ───────────────────────────────────────────
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(width * 0.04),
                decoration: BoxDecoration(
                  color: AppColors.primaryBlue.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: AppColors.primaryBlue.withOpacity(0.15),
                  ),
                ),
                child: Row(
                  children: [
                    Image.asset(
                      ImageAssets.quickRefileImg,
                      width: width * 0.15,
                      height: width * 0.15,
                      fit: BoxFit.contain,
                    ),
                    SizedBox(width: width * 0.03),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Mineral Water Jar',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: AppColors.textPrimary,
                            ),
                          ),
                          const SizedBox(height: 4),
                          const Text(
                            '₹199/Bottle',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: AppColors.primaryBlue,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              const Icon(
                                Icons.delivery_dining,
                                size: 14,
                                color: AppColors.textSecondary,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                'Delivery in 45-60 mins',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: AppColors.textSecondary,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: height * 0.02),

              // ── Number of Jars ─────────────────────────────────────────
              const Text(
                'Number of Jars',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
              SizedBox(height: height * 0.008),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(width * 0.03),
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.borderLight),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildQuantityButton(Icons.remove, onTap: () {
                      if (_jarCount > 0) {
                        setState(() => _jarCount--);
                      }
                    }),
                    Text(
                      '$_jarCount',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    _buildQuantityButton(Icons.add, onTap: () {
                      setState(() => _jarCount++);
                    }),
                  ],
                ),
              ),
              SizedBox(height: height * 0.02),

              // ── Delivery Options (Row) ───────────────────────────────────
              const Text(
                'Delivery',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
              SizedBox(height: height * 0.008),
              Row(
                children: _deliveryOptions.map((option) {
                  final isSelected = _selectedDeliveryOption == option['label'];
                  return Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedDeliveryOption = option['label'] as String;
                          if (_selectedDeliveryOption == 'Quick Delivery') {
                            _dateController.clear();
                            _selectedTimeSlot = '';
                          }
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: width * 0.025,
                          vertical: height * 0.015,
                        ),
                        margin: EdgeInsets.only(
                          right: _deliveryOptions.indexOf(option) == 0
                              ? width * 0.02
                              : 0,
                        ),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? AppColors.primaryBlue.withOpacity(0.05)
                              : AppColors.white,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: isSelected
                                ? AppColors.primaryBlue
                                : AppColors.borderLight,
                            width: isSelected ? 2 : 1,
                          ),
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width: 18,
                                  height: 18,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: isSelected
                                          ? AppColors.primaryBlue
                                          : AppColors.borderLight,
                                      width: 2,
                                    ),
                                  ),
                                  child: isSelected
                                      ? Center(
                                    child: Container(
                                      width: 9,
                                      height: 9,
                                      decoration: const BoxDecoration(
                                        color: AppColors.primaryBlue,
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                  )
                                      : null,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  option['label'] as String,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: isSelected
                                        ? AppColors.primaryBlue
                                        : AppColors.textPrimary,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 4),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  option['icon'] as IconData,
                                  size: 14,
                                  color: isSelected
                                      ? AppColors.primaryBlue
                                      : AppColors.textSecondary,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  option['subtitle'] as String,
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: isSelected
                                        ? AppColors.primaryBlue
                                        : AppColors.textSecondary,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
              SizedBox(height: height * 0.02),

              // ── Schedule Fields (Conditional) ─────────────────────────
              if (_selectedDeliveryOption == 'Schedule') ...[
                // ── Select Date ─────────────────────────────────────────
                const Text(
                  'Select Date',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
                SizedBox(height: height * 0.008),
                GestureDetector(
                  onTap: () async {
                    final picked = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime.now().add(const Duration(days: 30)),
                      builder: (context, child) {
                        return Theme(
                          data: Theme.of(context).copyWith(
                            colorScheme: const ColorScheme.light(
                              primary: AppColors.primaryBlue,
                            ),
                          ),
                          child: child!,
                        );
                      },
                    );
                    if (picked != null) {
                      setState(() {
                        _dateController.text =
                        '${picked.day}/${picked.month}/${picked.year}';
                      });
                    }
                  },
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(
                      horizontal: width * 0.04,
                      vertical: height * 0.018,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.borderLight),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.calendar_today,
                          size: 18,
                          color: AppColors.iconGray,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            _dateController.text.isEmpty
                                ? '08/05/2026'
                                : _dateController.text,
                            style: TextStyle(
                              fontSize: 14,
                              color: _dateController.text.isEmpty
                                  ? AppColors.textHint
                                  : AppColors.textPrimary,
                            ),
                          ),
                        ),
                        Icon(
                          Icons.keyboard_arrow_down,
                          size: 18,
                          color: AppColors.iconGray,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: height * 0.02),

                // ── Select Time Slot ──────────────────────────────────────
                const Text(
                  'Select Time slot',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
                SizedBox(height: height * 0.008),
                Wrap(
                  spacing: width * 0.02,
                  runSpacing: height * 0.012,
                  children: _timeSlots.map((slot) {
                    final isSelected = _selectedTimeSlot == slot;
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedTimeSlot = slot;
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: width * 0.06,
                          vertical: height * 0.015,
                        ),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? AppColors.primaryBlue
                              : AppColors.white,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: isSelected
                                ? AppColors.primaryBlue
                                : AppColors.borderLight,
                            width: 1.5,
                          ),
                        ),
                        child: Text(
                          slot,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: isSelected
                                ? Colors.white
                                : AppColors.textPrimary,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
                SizedBox(height: height * 0.025),
              ],

              // ── Address Details ────────────────────────────────────────
              const Text(
                'Address Details',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
              SizedBox(height: height * 0.008),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(width * 0.04),
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.borderLight),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _selectedAddress,
                      style: TextStyle(
                        fontSize: width * 0.035,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    SizedBox(height: height * 0.005),
                    Text(
                      _addressDetails,
                      style: TextStyle(
                        fontSize: width * 0.032,
                        color: AppColors.textSecondary,
                      ),
                    ),
                    SizedBox(height: height * 0.01),
                    GestureDetector(
                      onTap: _navigateToAddAddress,
                      child: Text(
                        '+ Add Address',
                        style: TextStyle(
                          fontSize: width * 0.032,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primaryBlue,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: height * 0.02),

              // ── Franchise ──────────────────────────────────────────────
              const Text(
                'Franchise',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
              SizedBox(height: height * 0.008),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(width * 0.04),
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.borderLight),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'Serviced by: XYZ Franchise',
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColors.textSecondary,
                  ),
                ),
              ),
              SizedBox(height: height * 0.03),

              // ── Confirm Refill Order Button ────────────────────────────
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: _validateAndConfirmRefill,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryBlue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    'Confirm Refill Order',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(height: height * 0.02),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildQuantityButton(IconData icon, {required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: AppColors.primaryBlue.withOpacity(0.1),
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          size: 20,
          color: AppColors.primaryBlue,
        ),
      ),
    );
  }
}