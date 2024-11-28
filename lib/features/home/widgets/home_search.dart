import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _controller = TextEditingController();

  void _clearSearch() {
    setState(() {
      _controller.clear(); // Clears the input field
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Page'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // Implement the search functionality here
              print("Search: ${_controller.text}");
            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.h),
        child: const Column(
          children: [],
        ),
      ),
    );
  }
}
