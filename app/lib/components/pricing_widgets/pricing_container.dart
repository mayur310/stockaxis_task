import 'package:app/components/pricing_widgets/spinner_list_box.dart';
import 'package:flutter/material.dart';

class PricingContainer extends StatelessWidget {
  final String title;
  final String subtitle;
  final String description;
  final List<String> options;
  final Function(String) onSelectOption;
  final IconData icon;

  // ignore: prefer_const_constructors_in_immutables
  PricingContainer({
    super.key,
    required this.title,
    required this.subtitle,
    required this.description,
    required this.options,
    required this.onSelectOption,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: const Color(0xFFFFFFFF),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(
                icon,
                size: 30,
                color: Colors.orange,
              ),
              const SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              IconButton(
                icon: const Icon(
                  Icons.info_outline,
                  size: 25,
                  color: Colors.grey,
                ),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      content: Text('Information about $title'),
                    ),
                  );
                },
              )
            ],
          ),
          const Divider(
            color: Color.fromARGB(255, 228, 227, 227),
            thickness: 2,
            height: 16,
          ),
          const SizedBox(height: 8),
          Text(
            description,
            style: const TextStyle(fontSize: 14, color: Colors.black54),
          ),
          const SizedBox(height: 16),
          SpinnerListBox(
            options: options,
            onSelectOption: onSelectOption,
          ),
        ],
      ),
    );
  }
}
