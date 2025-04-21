import 'package:flutter/material.dart';
import 'package:pomme_dapi/common/widgets/custom_shapes/container/circular_container.dart';
import 'package:pomme_dapi/utils/helpers/helper_functions.dart';

class AppChoiceChip extends StatelessWidget {
  const AppChoiceChip({
    super.key,
    required this.text,
    this.onSelected,
    required this.selected,
  });

  final String text;
  final ValueChanged<bool>? onSelected;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    final isColor = AppHelperFunctions.getColor(text);
    return Theme(
      data: Theme.of(context).copyWith(canvasColor: Colors.transparent),
      child: ChoiceChip(
        label: isColor != null ? const SizedBox() : Text(text),
        avatar:
            isColor != null
                ? AppCircularContainer(backgroundColor: isColor)
                : null,
        selected: selected,
        selectedColor: isColor,
        onSelected: onSelected,
        labelStyle: TextStyle(color: selected ? Colors.white : null),
        labelPadding: isColor != null ? const EdgeInsets.all(0) : null,
        padding: isColor != null ? const EdgeInsets.all(0) : null,
        shape: isColor != null ? const CircleBorder() : null,
        backgroundColor: isColor,
      ),
    );
  }
}
