// Screens/HomeScreen/CreatePlanScreen.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jivit_jal/Utils/AppColors.dart';
import 'package:jivit_jal/Screens/HomeScreen/OrderPreviewScreen.dart';
import 'package:jivit_jal/Screens/HomeScreen/AddAddressScreen.dart';
import 'package:jivit_jal/Screens/HomeScreen/TryWaterScreen.dart';

class CreatePlanScreen extends StatefulWidget {
  final String selectedPlan;

  const CreatePlanScreen({
    super.key,
    this.selectedPlan = 'Daily',
  });

  @override
  State<CreatePlanScreen> createState() => _CreatePlanScreenState();
}

class _CreatePlanScreenState extends State<CreatePlanScreen> {
  String _selectedRunType = 'Daily';
  int _numberOfDays = 0;
  String _selectedDay = 'Mon';
  Set<String> _selectedDays = {}; // For Custom plan - multiple selection
  String _selectedTimeSlot = '';
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _phoneCodeController = TextEditingController();

  // Address state
  String _selectedAddress = 'Home Address';
  String _addressDetails = '307, 8/2, Tapovan, Pathanwadi Road,\nMahad (west)';

  final List<String> _runTypes = ['Daily', 'Alternate', 'Weekly', 'Custom'];
  final List<String> _days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
  final List<String> _timeSlots = [
    '9 - 11 AM',
    '12 - 2 PM',
    '3 - 5 PM',
    '6 - 8 PM',
  ];

  @override
  void initState() {
    super.initState();
    _selectedRunType = widget.selectedPlan;
    // Initialize with Monday selected for Weekly
    _selectedDays = {'Mon'};
  }

  @override
  void dispose() {
    _dateController.dispose();
    _phoneCodeController.dispose();
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
        _addressDetails = '${result['house']}, ${result['area']},\n${result['city']} - ${result['pincode']}';
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

  void _validateAndConfirmPlan() {
    if (_numberOfDays == 0) {
      _showSnackBar('Please select number of days');
      return;
    }
    if (_selectedRunType != 'Daily' && _selectedRunType != 'Alternate' && _selectedDays.isEmpty) {
      _showSnackBar('Please select at least one day');
      return;
    }
    if (_dateController.text.isEmpty) {
      _showSnackBar('Please select a start date');
      return;
    }
    if (_selectedTimeSlot.isEmpty) {
      _showSnackBar('Please select a time slot');
      return;
    }

    // Navigate to OrderPreviewScreen with plan details
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => OrderPreviewScreen(
          jarCount: _numberOfDays,
          date: _dateController.text,
          timeSlot: _selectedTimeSlot,
          address: _addressDetails,
          source: 'createplan', // Pass source as 'createplan'
        ),
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

  bool _isDayDisabled(String day) {
    if (_selectedRunType == 'Daily' || _selectedRunType == 'Alternate') {
      return true;
    }
    return false;
  }

  bool _isDaySelected(String day) {
    if (_selectedRunType == 'Weekly') {
      return _selectedDay == day;
    } else if (_selectedRunType == 'Custom') {
      return _selectedDays.contains(day);
    }
    return false;
  }

  void _onDayTap(String day) {
    if (_isDayDisabled(day)) return;

    setState(() {
      if (_selectedRunType == 'Weekly') {
        _selectedDay = day;
      } else if (_selectedRunType == 'Custom') {
        if (_selectedDays.contains(day)) {
          _selectedDays.remove(day);
        } else {
          _selectedDays.add(day);
        }
      }
    });
  }

  String _getSelectedDaysDisplay() {
    if (_selectedDays.isEmpty) return 'None selected';
    final List<String> sorted = _selectedDays.toList()..sort();
    return sorted.join(', ');
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
            'Create Your Plan',
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
              // ── Run Type ──────────────────────────────────────────────
              const Text(
                'Run Type',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
              SizedBox(height: height * 0.008),
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: width * 0.03),
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.borderLight),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: _selectedRunType,
                    isExpanded: true,
                    icon: const Icon(
                      Icons.keyboard_arrow_down,
                      color: AppColors.iconGray,
                    ),
                    items: _runTypes.map((type) {
                      return DropdownMenuItem(
                        value: type,
                        child: Text(type),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedRunType = value!;
                        _selectedDay = 'Mon';
                        _selectedDays = {'Mon'};
                      });
                    },
                  ),
                ),
              ),
              SizedBox(height: height * 0.02),

              // ── Number of Jars ──────────────────────────────────────
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
                      if (_numberOfDays > 0) {
                        setState(() => _numberOfDays--);
                      }
                    }),
                    Text(
                      '$_numberOfDays',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    _buildQuantityButton(Icons.add, onTap: () {
                      setState(() => _numberOfDays++);
                    }),
                  ],
                ),
              ),
              SizedBox(height: height * 0.02),

              // ── Select the days ──────────────────────────────
              const Text(
                'Select the days',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
              SizedBox(height: height * 0.008),
              Wrap(
                spacing: width * 0.02,
                runSpacing: height * 0.01,
                children: _days.map((day) {
                  final isSelected = _isDaySelected(day);
                  final isDisabled = _isDayDisabled(day);

                  return GestureDetector(
                    onTap: isDisabled ? null : () => _onDayTap(day),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: width * 0.05,
                        vertical: height * 0.012,
                      ),
                      decoration: BoxDecoration(
                        color: isDisabled
                            ? Colors.grey.shade200
                            : isSelected
                            ? AppColors.primaryBlue
                            : AppColors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: isDisabled
                              ? Colors.grey.shade300
                              : isSelected
                              ? AppColors.primaryBlue
                              : AppColors.borderLight,
                          width: 1.5,
                        ),
                      ),
                      child: Text(
                        day,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: isDisabled
                              ? Colors.grey.shade500
                              : isSelected
                              ? Colors.white
                              : AppColors.textPrimary,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
              // ── Show selected days for Custom plan ──────────────
              if (_selectedRunType == 'Custom')
                Padding(
                  padding: EdgeInsets.only(top: height * 0.008),
                  child: Text(
                    'Selected days: ${_getSelectedDaysDisplay()}',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: AppColors.primaryBlue,
                    ),
                  ),
                ),
              if (_selectedRunType == 'Daily' || _selectedRunType == 'Alternate')
                Padding(
                  padding: EdgeInsets.only(top: height * 0.005),
                  child: Text(
                    _selectedRunType == 'Daily'
                        ? 'Days selection is disabled for Daily plan'
                        : 'Days selection is disabled for Alternate plan',
                    style: TextStyle(
                      fontSize: 12,
                      color: AppColors.textSecondary,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
              SizedBox(height: height * 0.02),

              // ── Select Start Date ──────────────────────────────────
              const Text(
                'Select Start Date',
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
                    lastDate: DateTime.now().add(const Duration(days: 365)),
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
                              ? 'dd/mm/yyyy'
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

              // ── Have Promo Code? ──────────────────────────────────
              const Text(
                'Have Promo Code?',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
              SizedBox(height: height * 0.008),
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(
                  horizontal: width * 0.04,
                  vertical: height * 0.005,
                ),
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.borderLight),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextField(
                  controller: _phoneCodeController,
                  decoration: const InputDecoration(
                    hintText: 'Enter',
                    border: InputBorder.none,
                  ),
                  style: const TextStyle(
                    fontSize: 14,
                    color: AppColors.textPrimary,
                  ),
                ),
              ),
              SizedBox(height: height * 0.02),

              // ── Select Time slot ──────────────────────────────────
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
                        color: isSelected ? AppColors.primaryBlue : AppColors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: isSelected ? AppColors.primaryBlue : AppColors.borderLight,
                          width: 1.5,
                        ),
                      ),
                      child: Text(
                        slot,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: isSelected ? Colors.white : AppColors.textPrimary,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
              SizedBox(height: height * 0.025),

              // ── Address Details ──────────────────────────────────────
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

              // ── Franchise ─────────────────────────────────────────────
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
                  'Serviced by: XTR Franchise',
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColors.textSecondary,
                  ),
                ),
              ),
              SizedBox(height: height * 0.03),

              // ── Action Buttons ─────────────────────────────────────────
              Row(
                children: [
                  // Try Water Button
                  Expanded(
                    child: OutlinedButton(
                      onPressed: _navigateToTryWater,
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: AppColors.primaryBlue),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Text(
                        'Try Water',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primaryBlue,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  // Confirm Plan Button
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _validateAndConfirmPlan,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryBlue,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text(
                        'Confirm Plan',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
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