import 'package:flutter/material.dart';

class OutputFormatDropdown extends StatelessWidget {
  final String value;
  final List<String> formats;
  final ValueChanged<String> onChanged;

  const OutputFormatDropdown({
    super.key,
    required this.value,
    required this.formats,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return InputDecorator(
      decoration: InputDecoration(
        labelText: 'Formato de saída',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          icon: const Icon(Icons.arrow_drop_down),
          borderRadius: BorderRadius.circular(8),
          onChanged: (String? newValue) {
            if (newValue != null) {
              onChanged(newValue);
            }
          },
          items: formats.map((String format) {
            return DropdownMenuItem<String>(
              value: format,
              child: Text(format.toUpperCase()),
            );
          }).toList(),
        ),
      ),
    );
  }
}
