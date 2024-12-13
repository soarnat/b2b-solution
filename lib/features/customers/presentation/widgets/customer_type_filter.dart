// lib/features/customers/presentation/widgets/customer_type_filter.dart
import 'package:flutter/material.dart';
import '../../domain/enums/customer_enums.dart';

class CustomerTypeFilter extends StatelessWidget {
  final CustomerType selectedType;
  final ValueChanged<CustomerType> onTypeSelected;

  const CustomerTypeFilter({
    super.key,
    required this.selectedType,
    required this.onTypeSelected,
  });

  @override
  Widget build(BuildContext context) {
    return SegmentedButton<CustomerType>(
      selected: {selectedType},
      onSelectionChanged: (Set<CustomerType> selected) {
        if (selected.isNotEmpty) {
          onTypeSelected(selected.first);
        }
      },
      segments: CustomerType.values
          .map(
            (type) => ButtonSegment<CustomerType>(
              value: type,
              label: Text(type.display),
            ),
          )
          .toList(),
    );
  }
}
