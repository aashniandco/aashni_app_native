import 'package:flutter/material.dart';

class DesignersScreen extends StatefulWidget {
  @override
  _DesignersScreenState createState() => _DesignersScreenState();
}

class _DesignersScreenState extends State<DesignersScreen> {
  final TextEditingController _searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  List<String> designers = [
    "Amit Aggarwal",
    "Anamika Khanna",
    "Aseem Kapoor",
    "AUM Ashima & Asit",
    "Capisvirleo",
    "Cedar & Pine",
    "Elan",
    "Gulabo by Abu Sandeep",
    "Iqbal Hussain",
    "Mahima Mahajan",
    "Masaba",
    "MimamsAa by Ankita Singh",
    "Mrunalini Rao",
    "Nitya Bajaj",
    "Ralph Lauren",
    "Saint Laurent",
    "Tom Ford",
    "Valentino",
    "Versace",
  ];

  List<String> filteredDesigners = [];

  bool _isSearchVisible = true; // Tracks visibility of search bar
  double _lastScrollOffset = 0; // Keeps track of the last scroll offset

  @override
  void initState() {
    super.initState();
    filteredDesigners = designers;

    // Listen to scroll events
    _scrollController.addListener(() {
      double currentOffset = _scrollController.offset;

      // If scrolling down, hide the search bar
      if (currentOffset > _lastScrollOffset && _isSearchVisible) {
        setState(() {
          _isSearchVisible = false;
        });
      }
      // If scrolling up, show the search bar
      else if (currentOffset < _lastScrollOffset && !_isSearchVisible) {
        setState(() {
          _isSearchVisible = true;
        });
      }

      _lastScrollOffset = currentOffset;
    });
  }

  void _filterDesigners(String query) {
    setState(() {
      if (query.isEmpty) {
        filteredDesigners = designers;
      } else {
        filteredDesigners = designers
            .where((designer) =>
                designer.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  void _hideSearchField() {
    _scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );

    Future.delayed(const Duration(milliseconds: 300), () {
      setState(() {
        _isSearchVisible = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // List of Designers
          ListView.builder(
            controller: _scrollController,
            padding: EdgeInsets.only(top: _isSearchVisible ? 80 : 0),
            itemCount: filteredDesigners.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(filteredDesigners[index]),
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Clicked on ${filteredDesigners[index]}'),
                    ),
                  );
                },
              );
            },
          ),

          // Search Field (conditionally visible)
          if (_isSearchVisible)
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Container(
                color: Colors.white,
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    // Search Bar
                  Expanded(
  child: Container(
    height: 50, // Set the desired height here
    child: TextField(
      controller: _searchController,
      onChanged: _filterDesigners,
      decoration: InputDecoration(
        hintText: "Search designers...",
        prefixIcon: const Icon(Icons.search),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 10), // Adjust padding if needed
      ),
    ),
  ),
),

                    const SizedBox(width: 8),
                    // Close Icon
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () {
                        _searchController.clear();
                        _filterDesigners('');
                        _hideSearchField(); // Hide search bar on close
                      },
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _searchController.dispose();
    super.dispose();
  }
}
