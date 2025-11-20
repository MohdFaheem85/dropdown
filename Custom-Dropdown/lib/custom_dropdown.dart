// import 'package:flutter/material.dart';
//
// class CustomDropdownWidget extends StatefulWidget {
//   final List<Map<String, dynamic>> items;
//   final String displayKey;
//   final String? hint;
//   final double? width;
//   final double? dropdownMaxHeight;
//   final Function(Map<String, dynamic>?)? onChanged;
//   final Map<String, dynamic>? initialValue;
//   final Color? backgroundColor;
//   final Color? dropdownColor;
//   final bool showSearch; // New parameter to enable/disable search
//
//   const CustomDropdownWidget({
//     super.key,
//     required this.items,
//     required this.displayKey,
//     this.hint,
//     this.width,
//     this.dropdownMaxHeight,
//     this.onChanged,
//     this.initialValue,
//     this.backgroundColor,
//     this.dropdownColor,
//     this.showSearch = false, // Default is false (hidden)
//   });
//
//   @override
//   State<CustomDropdownWidget> createState() => _CustomDropdownWidgetState();
// }
//
// class _CustomDropdownWidgetState extends State<CustomDropdownWidget> {
//   Map<String, dynamic>? selectedValue;
//
//   @override
//   void initState() {
//     super.initState();
//     selectedValue = widget.initialValue;
//   }
//
//   void _showSearchableDropdown() {
//     // Get the RenderBox to calculate position and width
//     final RenderBox? renderBox = context.findRenderObject() as RenderBox?;
//     final Size size = renderBox?.size ?? Size.zero;
//     final Offset offset = renderBox?.localToGlobal(Offset.zero) ?? Offset.zero;
//
//     showDialog(
//       context: context,
//       barrierColor: Colors.transparent,
//       builder: (BuildContext context) {
//         return Stack(
//           children: [
//             // Transparent barrier to close dialog
//             GestureDetector(
//               onTap: () => Navigator.pop(context),
//               child: Container(
//                 color: Colors.black26,
//               ),
//             ),
//             // Positioned dialog
//             Positioned(
//               left: offset.dx,
//               top: offset.dy ,
//               child: Material(
//                 elevation: 8,
//                 borderRadius: BorderRadius.circular(12),
//                 child: _SearchableDropdownDialog(
//                   items: widget.items,
//                   displayKey: widget.displayKey,
//                   selectedValue: selectedValue,
//                   dropdownColor: widget.dropdownColor,
//                   width: widget.width ?? size.width,
//                   onChanged: (newValue) {
//                     setState(() {
//                       selectedValue = newValue;
//                     });
//                     if (widget.onChanged != null) {
//                       widget.onChanged!(newValue);
//                     }
//                     Navigator.pop(context);
//                   },
//                 ),
//               ),
//             ),
//           ],
//         );
//       },
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     // If search is enabled, use custom dialog instead of default dropdown
//     if (widget.showSearch) {
//       return GestureDetector(
//         onTap: _showSearchableDropdown,
//         child: Container(
//           width: widget.width,
//           padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
//           decoration: BoxDecoration(
//             color: widget.backgroundColor ?? Colors.white,
//             borderRadius: BorderRadius.circular(8),
//             border: Border.all(color: Colors.grey.shade300),
//           ),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Expanded(
//                 child: Text(
//                   selectedValue != null
//                       ? selectedValue![widget.displayKey]?.toString() ?? ''
//                       : widget.hint ?? "Select an option",
//                   style: TextStyle(
//                     color: selectedValue != null ? Colors.black : Colors.grey,
//                   ),
//                   overflow: TextOverflow.ellipsis,
//                 ),
//               ),
//               const Icon(Icons.keyboard_arrow_down),
//             ],
//           ),
//         ),
//       );
//     }
//
//     // Default dropdown without search
//     return Container(
//       width: widget.width,
//       decoration: BoxDecoration(
//         color: widget.backgroundColor ?? Colors.white,
//         borderRadius: BorderRadius.circular(8),
//         border: Border.all(color: Colors.grey.shade300),
//       ),
//       child: ButtonTheme(
//         alignedDropdown: true,
//         child: DropdownButtonHideUnderline(
//           child: DropdownButton<Map<String, dynamic>>(
//             hint: Text(widget.hint ?? "Select an option"),
//             value: selectedValue,
//             icon: const Icon(Icons.keyboard_arrow_down),
//             isExpanded: true,
//             dropdownColor: widget.dropdownColor ?? Colors.white,
//             menuMaxHeight: widget.dropdownMaxHeight ?? 300,
//             items: widget.items.map((Map<String, dynamic> item) {
//               return DropdownMenuItem<Map<String, dynamic>>(
//                 value: item,
//                 child: Text(
//                   item[widget.displayKey]?.toString() ?? '',
//                   overflow: TextOverflow.ellipsis,
//                 ),
//               );
//             }).toList(),
//             onChanged: (newValue) {
//               setState(() {
//                 selectedValue = newValue;
//               });
//               if (widget.onChanged != null) {
//                 widget.onChanged!(newValue);
//               }
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// // Searchable Dropdown Dialog
// class _SearchableDropdownDialog extends StatefulWidget {
//   final List<Map<String, dynamic>> items;
//   final String displayKey;
//   final Map<String, dynamic>? selectedValue;
//   final Color? dropdownColor;
//   final double width;
//   final Function(Map<String, dynamic>?) onChanged;
//
//   const _SearchableDropdownDialog({
//     required this.items,
//     required this.displayKey,
//     required this.selectedValue,
//     required this.dropdownColor,
//     required this.width,
//     required this.onChanged,
//   });
//
//   @override
//   State<_SearchableDropdownDialog> createState() =>
//       _SearchableDropdownDialogState();
// }
//
// class _SearchableDropdownDialogState extends State<_SearchableDropdownDialog> {
//   late List<Map<String, dynamic>> filteredItems;
//   final TextEditingController searchController = TextEditingController();
//
//   @override
//   void initState() {
//     super.initState();
//     filteredItems = widget.items;
//   }
//
//   void _filterItems(String query) {
//     setState(() {
//       if (query.isEmpty) {
//         filteredItems = widget.items;
//       } else {
//         filteredItems = widget.items.where((item) {
//           final name = item[widget.displayKey]?.toString().toLowerCase() ?? '';
//           return name.contains(query.toLowerCase());
//         }).toList();
//       }
//     });
//   }
//
//   @override
//   void dispose() {
//     searchController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: widget.width,
//       constraints: const BoxConstraints(maxHeight: 250),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(12),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.1),
//             blurRadius: 10,
//             offset: const Offset(0, 4),
//           ),
//         ],
//       ),
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           // Search Field
//           Padding(
//             padding: const EdgeInsets.all(12.0),
//             child: TextField(
//               controller: searchController,
//               autofocus: true,
//               decoration: InputDecoration(
//                 hintText: 'Search...',
//                 prefixIcon: const Icon(Icons.search, size: 20),
//                 suffixIcon: searchController.text.isNotEmpty
//                     ? IconButton(
//                   icon: const Icon(Icons.clear, size: 20),
//                   onPressed: () {
//                     searchController.clear();
//                     _filterItems('');
//                   },
//                 )
//                     : null,
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//                 contentPadding: const EdgeInsets.symmetric(
//                   horizontal: 12,
//                   vertical: 8,
//                 ),
//                 isDense: true,
//               ),
//               onChanged: _filterItems,
//             ),
//           ),
//           const Divider(height: 1),
//           // Items List
//           Flexible(
//             child: filteredItems.isEmpty
//                 ? const Center(
//               child: Padding(
//                 padding: EdgeInsets.all(20.0),
//                 child: Text('No items found'),
//               ),
//             )
//                 : ListView.builder(
//               shrinkWrap: true,
//               itemCount: filteredItems.length,
//               itemBuilder: (context, index) {
//                 final item = filteredItems[index];
//                 final isSelected = widget.selectedValue == item;
//                 return ListTile(
//                   dense: true,
//                   title: Text(
//                     item[widget.displayKey]?.toString() ?? '',
//                   ),
//                   tileColor: isSelected
//                       ? Colors.blue.shade50
//                       : widget.dropdownColor,
//                   trailing: isSelected
//                       ? const Icon(Icons.check, color: Colors.blue, size: 20)
//                       : null,
//                   onTap: () {
//                     widget.onChanged(item);
//                   },
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }