import 'package:flutter/material.dart';

class SpinnerListBox extends StatefulWidget {
  final List<String> options;
  final Function(String) onSelectOption;

  const SpinnerListBox(
      {super.key, required this.options, required this.onSelectOption});

  @override
  // ignore: library_private_types_in_public_api
  _SpinnerListBoxState createState() => _SpinnerListBoxState();
}

class _SpinnerListBoxState extends State<SpinnerListBox> {
  String? selectedOption;

  @override
  void initState() {
    super.initState();
    // Set the default option as the first one ("Select a Plan (inclusive of GST)")
    selectedOption = widget.options.first;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.green, width: 2),
        color: const Color(0xFFFFFFFF),
      ),
      child: DropdownButton<String>(
        hint: const Text("Select Option"),
        value: selectedOption,
        onChanged: (value) {
          setState(() {
            selectedOption = value;
          });
          if (value != null) {
            widget.onSelectOption(value);
          }
        },
        isExpanded: true,
        underline: const SizedBox(),
        items: widget.options.map((option) {
          var parts = option.split(' - Rs. ');
          if (parts.length == 2) {
            var originalAndDiscounted = parts[1].split('  Rs. ');
            if (originalAndDiscounted.length == 2) {
              String originalPrice = originalAndDiscounted[0];
              String discountedPrice = originalAndDiscounted[1];

              if (option == '12 Months - Rs. 25000  Rs. 20000') {
                return DropdownMenuItem(
                  value: option,
                  child: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: '${parts[0]} - ',
                          style: const TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                        TextSpan(
                          text: 'Rs. $originalPrice',
                          style: const TextStyle(
                            decoration: TextDecoration.lineThrough,
                            color: Colors.grey,
                          ),
                        ),
                        TextSpan(
                          text: ' Rs. $discountedPrice',
                          style: const TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }
            }
          }

          return DropdownMenuItem(
            value: option,
            child: Text(
              option,
              style: const TextStyle(
                color: Colors.grey,
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
