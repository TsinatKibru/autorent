// import 'package:flutter/material.dart';

// class SearchBarWithFilter extends StatelessWidget {
//   final TextEditingController searchController;
//   final Function(String) onSearch;
//   final VoidCallback onFilter; // Callback for filter actions

//   const SearchBarWithFilter({
//     Key? key,
//     required this.searchController,
//     required this.onSearch,
//     required this.onFilter,
//   }) : super(key: key);
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         color: Colors.white54,
//         borderRadius: BorderRadius.circular(15.0),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.withOpacity(0.3), // Reduced shadow opacity
//             spreadRadius: 0,
//             blurRadius: 3,
//             offset: const Offset(0, 2), // Subtle shadow
//           ),
//         ],
//       ),
//       child: Padding(
//         padding: const EdgeInsets.symmetric(vertical: 7.0, horizontal: 14.0),
//         child: Row(
//           children: [
//             // Search Icon
//             Padding(
//               padding: const EdgeInsets.only(left: 1.0),
//               child: Icon(
//                 Icons.search,
//                 color: Colors.black45,
//                 size: 32,
//               ),
//             ),
//             // Search TextField
//             Expanded(
//               child: TextField(
//                   controller: searchController,
//                   decoration: InputDecoration(
//                     hintText: 'Search any car',
//                     border: InputBorder.none,
//                     hintStyle: TextStyle(
//                         color: Colors.grey, fontWeight: FontWeight.w400),
//                     enabledBorder:
//                         InputBorder.none, // Removes the enabled border
//                     focusedBorder:
//                         InputBorder.none, // Removes the focused border
//                     isDense: true, // Reduces the padding within the text field
//                     contentPadding: EdgeInsets.symmetric(horizontal: 10.0),
//                   ),
//                   onChanged: onSearch),
//             ),
//             // Filter Icon
//             IconButton(
//               icon: Icon(Icons.filter_list, color: Colors.black45, size: 32),
//               onPressed: () {
//                 _showFilterDialog(context);
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   // Show filter options dialog
//   void _showFilterDialog(BuildContext context) {
//     showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           title: Text("Filter Options"),
//           content: Text("Add filter options here."),
//           actions: [
//             TextButton(
//               onPressed: () => Navigator.pop(context),
//               child: Text("Close"),
//             ),
//           ],
//         );
//       },
//     );
//   }
// }
import 'package:flutter/material.dart';

class SearchBarWithFilter extends StatelessWidget {
  final TextEditingController searchController;
  final Function(String) onSearch;
  final VoidCallback onFilter;

  const SearchBarWithFilter({
    Key? key,
    required this.searchController,
    required this.onSearch,
    required this.onFilter,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final bool isDark = theme.brightness == Brightness.dark;

    return Container(
      height: 65, // Increased height for a bigger search bar
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceVariant,
        border: Border.all(color: Colors.black12),
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Row(
          children: [
            // Leading Search Icon
            IconButton(
              icon: Icon(
                Icons.search,
                size: 28, // Slightly larger icon
                color: isDark
                    ? theme.colorScheme.onSurfaceVariant
                    : Colors.black45,
              ),
              onPressed: () {}, // Placeholder for search-related actions
            ),
            // Search TextField
            Expanded(
              child: TextField(
                controller: searchController,
                decoration: InputDecoration(
                  hintText: 'Search any car',
                  border: InputBorder.none, // Removes borders for a clean look
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(horizontal: 12.0),
                  hintStyle: theme.textTheme.bodyLarge?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                    fontSize: 16, // Larger font size for better readability
                  ),
                ),
                style: theme.textTheme.bodyLarge?.copyWith(fontSize: 16),
                onChanged: onSearch,
              ),
            ),
            // Filter Icon
            IconButton(
              icon: Icon(
                Icons.filter_list,
                size: 28, // Slightly larger icon
                color: isDark
                    ? theme.colorScheme.onSurfaceVariant
                    : Colors.black45,
              ),
              onPressed: onFilter,
            ),
          ],
        ),
      ),
    );
  }
}
