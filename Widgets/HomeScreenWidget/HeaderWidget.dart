// Widgets/HomeScreen/HeaderWidget.dart
import 'package:flutter/material.dart';
import 'package:jivit_jal/Screens/HomeScreen/TryWaterScreen.dart';
import 'package:jivit_jal/Utils/AppColors.dart';
import 'package:jivit_jal/Utils/ImageAssets.dart';

class HeaderWidget extends StatefulWidget {
  final String name;
  final String greeting;
  final String title;
  final String subtitle;
  final String? bannerImagePath;
  final String? avatarImagePath;
  final VoidCallback? onNotificationTap;
  final ValueChanged<String>? onSearchChanged;
  final ValueChanged<String>? onFilterSelected;
  final VoidCallback? onTryWaterTap;

  const HeaderWidget({
    super.key,
    required this.name,
    required this.greeting,
    required this.title,
    required this.subtitle,
    this.bannerImagePath = ImageAssets.homeBannerImage,
    this.avatarImagePath,
    this.onNotificationTap,
    this.onSearchChanged,
    this.onFilterSelected,
    this.onTryWaterTap,
  });

  @override
  State<HeaderWidget> createState() => _HeaderWidgetState();
}

class _HeaderWidgetState extends State<HeaderWidget> {
  bool _isSearching = false;
  final TextEditingController _searchController = TextEditingController();

  void _toggleSearch() {
    setState(() {
      _isSearching = !_isSearching;
      if (!_isSearching) {
        _searchController.clear();
        widget.onSearchChanged?.call('');
      }
    });
  }

  void _showFilterBottomSheet() {
    showModalBottomSheet(
      context: context,
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
                  _buildFilterOption('All'),
                  _buildFilterOption('Excellent'),
                  _buildFilterOption('Alert'),
                  _buildFilterOption('Acceptable'),
                  const SizedBox(height: 16),
                  Center(
                    child: GestureDetector(
                      onTap: () {
                        widget.onFilterSelected?.call('All');
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
    );
  }

  Widget _buildFilterOption(String label) {
    return GestureDetector(
      onTap: () {
        widget.onFilterSelected?.call(label);
        Navigator.pop(context);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: AppColors.borderLight),
          ),
        ),
        child: Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: AppColors.textPrimary,
          ),
        ),
      ),
    );
  }

  void _handleTryWaterTap() {
    // If external callback is provided, use it
    if (widget.onTryWaterTap != null) {
      widget.onTryWaterTap!();
    } else {
      // Default navigation to TryWaterScreen
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const TryWaterScreen(),
        ),
      );
    }
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

    return Padding(
      padding: EdgeInsets.fromLTRB(
        width * 0.05,
        height * 0.018,
        width * 0.05,
        0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Greeting row ────────────────────────────────────────────
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Avatar + greeting
              if (!_isSearching)
                Row(
                  children: [
                    CircleAvatar(
                      radius: 18,
                      backgroundColor: AppColors.background,
                      backgroundImage: widget.avatarImagePath != null
                          ? AssetImage(widget.avatarImagePath!)
                          : null,
                      child: widget.avatarImagePath == null
                          ? const Icon(Icons.person,
                          color: AppColors.primaryBlue, size: 20)
                          : null,
                    ),
                    SizedBox(width: width * 0.025),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.greeting,
                          style: TextStyle(
                            fontSize: width * 0.032,
                            color: AppColors.textSecondary,
                          ),
                        ),
                        Text(
                          'Hi, ${widget.name}',
                          style: TextStyle(
                            fontSize: width * 0.042,
                            fontWeight: FontWeight.w700,
                            color: AppColors.textPrimary,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

              // Search + Notification
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    if (_isSearching)
                      Expanded(
                        child: Container(
                          height: 40,
                          margin: const EdgeInsets.only(right: 8),
                          padding: const EdgeInsets.symmetric(horizontal: 14),
                          decoration: BoxDecoration(
                            color: AppColors.background,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.search,
                                  size: 18, color: AppColors.primaryBlue),
                              const SizedBox(width: 8),
                              Expanded(
                                child: TextField(
                                  controller: _searchController,
                                  autofocus: true,
                                  onChanged: widget.onSearchChanged,
                                  decoration: const InputDecoration(
                                    hintText: 'Search',
                                    hintStyle: TextStyle(
                                      fontSize: 13,
                                      color: AppColors.textSecondary,
                                    ),
                                    border: InputBorder.none,
                                    isDense: true,
                                  ),
                                  style: const TextStyle(
                                    fontSize: 13,
                                    color: AppColors.textPrimary,
                                  ),
                                ),
                              ),
                              // ── Filter Icon (only visible when searching) ──
                              GestureDetector(
                                onTap: _showFilterBottomSheet,
                                child: Container(
                                  padding: const EdgeInsets.all(5),
                                  margin: const EdgeInsets.only(right: 4),
                                  decoration: BoxDecoration(
                                    color: AppColors.primaryBlue,
                                    borderRadius: BorderRadius.circular(14),
                                  ),
                                  child: const Icon(
                                    Icons.tune_rounded,
                                    size: 16,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 4),
                              GestureDetector(
                                onTap: _toggleSearch,
                                child: Icon(Icons.close_rounded,
                                    size: 18, color: AppColors.textSecondary),
                              ),
                            ],
                          ),
                        ),
                      )
                    else
                      GestureDetector(
                        onTap: _toggleSearch,
                        child: Container(
                          height: 36,
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          decoration: BoxDecoration(
                            color: AppColors.background,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.search,
                                  size: 18, color: AppColors.textSecondary),
                              const SizedBox(width: 8),
                              Text(
                                'Search',
                                style: TextStyle(
                                  fontSize: width * 0.03,
                                  color: AppColors.textSecondary,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                    if (!_isSearching) ...[
                      const SizedBox(width: 8),
                      GestureDetector(
                        onTap: widget.onNotificationTap,
                        child: Stack(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: AppColors.background,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.notifications_none_rounded,
                                color: AppColors.primaryBlue,
                                size: 20,
                              ),
                            ),
                            Positioned(
                              right: 6,
                              top: 6,
                              child: Container(
                                height: 8,
                                width: 8,
                                decoration: const BoxDecoration(
                                  color: AppColors.error,
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),

          SizedBox(height: height * 0.02),

          // ── Banner with Try Water Button ────────────────────────────
          Container(
            width: double.infinity,
            height: height * 0.16,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Stack(
              children: [
                // Background Image - showing upper portion
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: widget.bannerImagePath != null
                      ? Image.asset(
                    widget.bannerImagePath!,
                    width: double.infinity,
                    height: height * 0.16,
                    fit: BoxFit.cover,
                    alignment: Alignment.topCenter,
                  )
                      : Container(
                    color: AppColors.primaryBlue,
                  ),
                ),
                // Overlay gradient for text readability
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [
                        Colors.black.withOpacity(0.35),
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
                // Text Content with Try Water Button
                Padding(
                  padding: EdgeInsets.all(width * 0.045),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        widget.title,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: width * 0.045,
                          fontWeight: FontWeight.w700,
                          height: 1.1,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        widget.subtitle,
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.85),
                          fontSize: width * 0.032,
                          height: 1.3,
                        ),
                      ),
                      const SizedBox(height: 12),
                      // ── Try Water Button ──────────────────────────────
                      GestureDetector(
                        onTap: _handleTryWaterTap,
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: width * 0.06,
                            vertical: height * 0.01,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            'Try Water',
                            style: TextStyle(
                              color: AppColors.primaryBlue,
                              fontSize: width * 0.035,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}