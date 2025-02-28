import 'package:flutter/material.dart';
import 'package:mypokedex/app/core/utils/common_functions.dart';
import 'package:mypokedex/app/data/local/pokemon_data.dart';

class FilterWidget extends StatefulWidget {
  const FilterWidget({super.key});

  @override
  State<FilterWidget> createState() => _FilterWidgetState();
}

class _FilterWidgetState extends State<FilterWidget> {
  // List of all Pokémon types
  final List<String> types = pokemonTypes;

  // Selected type (null if no filter)
  String? selectedType;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Filter Pokémon",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              IconButton(
                icon: Icon(Icons.close),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
          SizedBox(height: 16),
          Text(
            "By Type",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              // "All" chip
              FilterChip(
                selected: selectedType == null,
                label: Text('All'),
                backgroundColor: Colors.grey[200],
                selectedColor: Colors.grey[400],
                onSelected: (selected) {
                  setState(() {
                    selectedType = null;
                  });
                },
              ),
              // Type chips
              ...types.map((type) {
                // Get color for this type
                Color typeColor = CommonFunctions.getTypeColor(type);

                return FilterChip(
                  selected: selectedType == type,
                  label: Text(
                    CommonFunctions.capitalize(type),
                    style: TextStyle(
                      color: selectedType == type ? Colors.white : Colors.black,
                    ),
                  ),
                  backgroundColor: typeColor.withOpacity(0.3),
                  selectedColor: typeColor,
                  onSelected: (selected) {
                    setState(() {
                      selectedType = selected ? type : null;
                    });
                  },
                );
              }),
            ],
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              // Pass selectedType back to the caller
              Navigator.pop(context, selectedType);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
              minimumSize: Size(double.infinity, 50),
            ),
            child: Text('Apply Filter'),
          ),
        ],
      ),
    );
  }
}
