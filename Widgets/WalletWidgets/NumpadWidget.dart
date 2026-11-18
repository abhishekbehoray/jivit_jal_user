// Widgets/CommonWidget/NumpadWidget.dart
import 'package:flutter/material.dart';
import 'package:jivit_jal/Utils/AppColors.dart';

class NumpadWidget extends StatefulWidget {
  final Function(String) onValueChanged;
  final String initialValue;

  const NumpadWidget({
    super.key,
    required this.onValueChanged,
    this.initialValue = '',
  });

  @override
  State<NumpadWidget> createState() => _NumpadWidgetState();
}

class _NumpadWidgetState extends State<NumpadWidget> {
  late String _value;

  @override
  void initState() {
    super.initState();
    _value = widget.initialValue;
  }

  void _onKeyPressed(String key) {
    setState(() {
      if (key == '⌫') {
        if (_value.isNotEmpty) {
          _value = _value.substring(0, _value.length - 1);
        }
      } else if (key == '.') {
        if (!_value.contains('.')) {
          if (_value.isEmpty) {
            _value = '0.';
          } else {
            _value += '.';
          }
        }
      } else {
        if (_value.replaceAll('.', '').length < 8) {
          if (_value == '0' && key != '.') {
            _value = key;
          } else {
            _value += key;
          }
        }
      }
      widget.onValueChanged(_value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildRow(['1', '2', '3']),
        const SizedBox(height: 8),
        _buildRow(['4', '5', '6']),
        const SizedBox(height: 8),
        _buildRow(['7', '8', '9']),
        const SizedBox(height: 8),
        _buildRow(['.', '0', '⌫']),
      ],
    );
  }

  Widget _buildRow(List<String> keys) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: keys.map((key) {
        return _buildKeyButton(key);
      }).toList(),
    );
  }

  Widget _buildKeyButton(String label) {
    final isBackspace = label == '⌫';
    final isDecimal = label == '.';

    return GestureDetector(
      onTap: () => _onKeyPressed(label),
      child: Container(
        width: 72,
        height: 56,
        margin: const EdgeInsets.symmetric(horizontal: 12),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isBackspace
              ? Colors.transparent
              : isDecimal
              ? Colors.transparent
              : Colors.transparent,
          shape: BoxShape.circle,
        ),
        child: isBackspace
            ? const Icon(
          Icons.backspace_outlined,
          size: 24,
          color: AppColors.textPrimary,
        )
            : Text(
          label,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w500,
            color: AppColors.textPrimary,
          ),
        ),
      ),
    );
  }

  String get value => _value;

  void reset() {
    setState(() {
      _value = '';
      widget.onValueChanged(_value);
    });
  }
}