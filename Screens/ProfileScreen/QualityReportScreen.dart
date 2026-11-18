// Screens/ProfileScreen/QualityReportScreen.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jivit_jal/Utils/AppColors.dart';
import 'package:jivit_jal/Utils/ImageAssets.dart';
import 'package:jivit_jal/Screens/ProfileScreen/WaterDetailsScreen.dart';

class QualityReportScreen extends StatefulWidget {
  const QualityReportScreen({super.key});

  @override
  State<QualityReportScreen> createState() => _QualityReportScreenState();
}

class _QualityReportScreenState extends State<QualityReportScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  String _selectedFilter = 'All';

  final List<String> _filterOptions = ['All', 'Excellent', 'Alert', 'Acceptable'];

  final List<Map<String, dynamic>> _allReports = const [
    {'batch': 'Batch #00231', 'date': '10 May 2025, 08:30 AM', 'status': 'Excellent', 'color': 0xFF2ECC71},
    {'batch': 'Batch #00231', 'date': '10 May 2025, 08:30 AM', 'status': 'Alert', 'color': 0xFFFF6B6B},
    {'batch': 'Batch #00231', 'date': '10 May 2025, 08:30 AM', 'status': 'Acceptable', 'color': 0xFFFFA500},
    {'batch': 'Batch #00231', 'date': '10 May 2025, 08:30 AM', 'status': 'Excellent', 'color': 0xFF2ECC71},
    {'batch': 'Batch #00231', 'date': '10 May 2025, 08:30 AM', 'status': 'Acceptable', 'color': 0xFFFFA500},
  ];

  List<Map<String, dynamic>> get _filteredReports {
    return _allReports.where((report) {
      final matchesSearch = report['batch'].toLowerCase().contains(_searchQuery.toLowerCase()) ||
          report['date'].toLowerCase().contains(_searchQuery.toLowerCase()) ||
          report['status'].toLowerCase().contains(_searchQuery.toLowerCase());
      final matchesFilter = _selectedFilter == 'All' || report['status'] == _selectedFilter;
      return matchesSearch && matchesFilter;
    }).toList();
  }

  void _showFilterBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setStateSheet) {
            return Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Filter',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Quality',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  ..._filterOptions.map((option) {
                    return GestureDetector(
                      onTap: () {
                        setStateSheet(() {
                          _selectedFilter = option;
                        });
                        Navigator.pop(context);
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(color: AppColors.borderLight),
                          ),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                option,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: _selectedFilter == option
                                      ? FontWeight.w600
                                      : FontWeight.w400,
                                  color: _selectedFilter == option
                                      ? AppColors.primaryBlue
                                      : AppColors.textPrimary,
                                ),
                              ),
                            ),
                            if (_selectedFilter == option)
                              Icon(
                                Icons.check_circle,
                                color: AppColors.primaryBlue,
                                size: 20,
                              ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                  const SizedBox(height: 16),
                  Center(
                    child: GestureDetector(
                      onTap: () {
                        setStateSheet(() {
                          _selectedFilter = 'All';
                        });
                        Navigator.pop(context);
                      },
                      child: Text(
                        'Reset',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primaryBlue,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                ],
              ),
            );
          },
        );
      },
    ).then((_) {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
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
            'Quality Report History',
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
            // ── Title ────────────────────────────────────────────────────
            Padding(
              padding: EdgeInsets.fromLTRB(
                width * 0.05,
                height * 0.02,
                width * 0.05,
                height * 0.01,
              ),
              child: const Text(
                'All Reports',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
            ),

            // ── Search Bar + Filter Icon ───────────────────────────────
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: width * 0.05,
                vertical: height * 0.01,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.cardBackground,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: AppColors.borderLight),
                      ),
                      child: Row(
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(left: 12),
                            child: Icon(
                              Icons.search,
                              color: AppColors.iconGray,
                              size: 20,
                            ),
                          ),
                          Expanded(
                            child: TextField(
                              controller: _searchController,
                              onChanged: (value) {
                                setState(() {
                                  _searchQuery = value;
                                });
                              },
                              decoration: const InputDecoration(
                                hintText: 'Search reports...',
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 12,
                                ),
                                hintStyle: TextStyle(
                                  color: AppColors.iconGray,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ),
                          if (_searchQuery.isNotEmpty)
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  _searchQuery = '';
                                  _searchController.clear();
                                });
                              },
                              child: const Padding(
                                padding: EdgeInsets.only(right: 12),
                                child: Icon(
                                  Icons.close,
                                  color: AppColors.iconGray,
                                  size: 18,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  // ── Filter Icon ─────────────────────────────────────────
                  GestureDetector(
                    onTap: _showFilterBottomSheet,
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: AppColors.primaryBlue.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: AppColors.borderLight),
                      ),
                      child: Icon(
                        Icons.filter_list,
                        color: AppColors.primaryBlue,
                        size: 24,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // ── Active Filter Display ───────────────────────────────────
            if (_selectedFilter != 'All')
              Padding(
                padding: EdgeInsets.symmetric(horizontal: width * 0.05),
                child: Row(
                  children: [
                    const Text(
                      'Filter: ',
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.textSecondary,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                      decoration: BoxDecoration(
                        color: AppColors.primaryBlue.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        _selectedFilter,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primaryBlue,
                        ),
                      ),
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedFilter = 'All';
                        });
                      },
                      child: const Text(
                        'Clear',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: AppColors.primaryBlue,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

            SizedBox(height: height * 0.015),

            // ── Reports List ────────────────────────────────────────────
            Expanded(
              child: _filteredReports.isEmpty
                  ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.assessment_outlined,
                      size: 64,
                      color: AppColors.iconGray,
                    ),
                    SizedBox(height: height * 0.02),
                    const Text(
                      'No reports found',
                      style: TextStyle(
                        fontSize: 16,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              )
                  : SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.symmetric(horizontal: width * 0.05),
                child: Column(
                  children: [
                    ..._filteredReports.map((report) => _buildReportItem(report, width, height)),
                    SizedBox(height: height * 0.03),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildReportItem(Map<String, dynamic> report, double width, double height) {
    final colorValue = report['color'] as int;
    final status = report['status'] as String;
    final batch = report['batch'] as String;
    final date = report['date'] as String;
    final statusColor = Color(colorValue);

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const WaterDetailsScreen(),
          ),
        );
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: height * 0.015),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: AppColors.borderLight),
          ),
        ),
        child: Row(
          children: [
            // ── Bottle Icon ──────────────────────────────────────────────
            Image.asset(
              ImageAssets.bottleOne,
              width: width * 0.08,
              height: width * 0.08,
              fit: BoxFit.contain,
            ),
            SizedBox(width: width * 0.03),

            // ── Report Details ───────────────────────────────────────────
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    batch,
                    style: TextStyle(
                      fontSize: width * 0.035,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  SizedBox(height: height * 0.003),
                  Text(
                    date,
                    style: TextStyle(
                      fontSize: width * 0.028,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),

            // ── Status Badge ─────────────────────────────────────────────
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                color: statusColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
                border: status == 'Alert' ? Border.all(color: statusColor) : null,
              ),
              child: Text(
                status,
                style: TextStyle(
                  fontSize: width * 0.028,
                  fontWeight: FontWeight.w600,
                  color: statusColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}