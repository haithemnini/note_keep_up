import 'package:flutter/material.dart';

import '/core/util/util.dart';
import 'linear_color_picker.dart';

class PopoverColoringNote extends StatelessWidget {
  const PopoverColoringNote({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //  HeaderSectionText(text: 'Colour'),
        _buildHeaderSectionText(context),
        const LinearColorPicker(),
        const SizedBox(height: 16.0),
      ],
    );
  }

  Widget _buildHeaderSectionText(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Colour', style: context.textTheme.titleMedium),
        ],
      ),
    );
  }
}
