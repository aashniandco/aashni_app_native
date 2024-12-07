import 'dart:async';

import 'package:aashni_app/common/dialog.dart';
import 'package:aashni_app/features/accessories/accessories.dart';
import 'package:aashni_app/features/auth/view/login_screen.dart';
import 'package:aashni_app/features/categories/view/categories_screen.dart';
import 'package:aashni_app/features/auth/view/wishlist_screen.dart';
import 'package:aashni_app/features/auth/view_models/auth_view_model.dart';
import 'package:aashni_app/features/designers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthScreen extends ConsumerWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authViewModelProvider);

    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: Image.asset(
            'assets/logo.jpeg', // Replace with your image path
            height: 30, // Adjust height as needed
          ),
          elevation: 0,
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          bottom: TabBar(
            labelColor: Colors.black,
            indicatorColor: Colors.black,
            unselectedLabelColor: Colors.grey,
            labelPadding: const EdgeInsets.symmetric(horizontal: 0),
            tabs: const [
              Tab(
                child: Text(
                  "Exclusives",
                  style: TextStyle(fontSize: 12),
                ),
              ),
              Tab(
                child: Text(
                  "Categories",
                  style: TextStyle(fontSize: 12),
                ),
              ),
              Tab(
                child: Text(
                  "Accessories",
                  style: TextStyle(fontSize: 12),
                ),
              ),
              Tab(
                child: Text(
                  "Designers",
                  style: TextStyle(fontSize: 12),
                ),
              ),
            ],
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {
                  showDialog(
                  context: context,
                  builder: (BuildContext context) => const SearchScreen(),
                );
                print("Search clicked");
              },
            ),
            IconButton(
              icon: const Icon(Icons.shopping_bag_rounded),
              onPressed: () {
                print("Shopping bag clicked");
              },
            ),
          ],
        ),
        body: authState.isLoading
            ? const Center(child: CircularProgressIndicator())
            : TabBarView(
                children: [
                  // Home content reused here
                  HomeScreen(), // Reuse the Home content in the Exclusive tab
                  CategoriesPage(),

                  // _buildTabContent("Categories Content"),
                  // _buildTabContent("Accessories Content"),
                  Accessories(),
                  // _buildTabContent("Designers Content"),
                  DesignersScreen()
                ],
              ),
        bottomNavigationBar: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
            BottomNavigationBarItem(icon: Icon(Icons.favorite_border), label: "Wish List"),
            BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: "Accounts"),
          ],
          onTap: (index) {
            switch (index) {
              case 0:
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const AuthScreen()),
                  (Route<dynamic> route) => false,
                );
                break;
              case 1:
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const WishlistScreen()),
                  (Route<dynamic> route) => false,
                );
                break;             
              case 2:
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const AccountScreen()),
                  (Route<dynamic> route) => false,
                );
                break;
            }
          },
        ),
      ),
    );
  }

  Widget _buildTabContent(String text) {
    return Center(
      child: Text(
        text,
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }
}

// // HomeTab Widget reused in Exclusive and Home tab
// class HomeTab extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     // Reuse the content from the HomeScreen's `_buildHomeTab()` function
//     return Column(
//       children: [
//         // Add banners, categories, ready-to-ship sections here
//         Center(
//           child: Text(
//             "Home Tab Content",
//             style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//           ),
//         ),
//       ],
//     );
//   }
// }


class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0; // Keeps track of the selected tab
  int _currentBannerIndex = 0; // Keeps track of the current banner index
  final PageController _pageController = PageController();

  final List<String> bannerImages = [
    'assets/Banner-1.jpeg', // Replace with actual banner image paths
    'assets/Banner-2.jpeg',
    'assets/Banner-3.jpeg',
    'assets/Banner-4.jpeg',
    'assets/Banner-5.jpeg',
  ];

  // Function to handle tab selection
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index; // Update the selected index
    });
  }

  @override
  void initState() {
    super.initState();
    _startAutoSlide();
  }

  void _startAutoSlide() {
    Timer.periodic(Duration(seconds: 3), (timer) {
      if (_pageController.hasClients) {
        setState(() {
          _currentBannerIndex =
              (_currentBannerIndex + 1) % bannerImages.length;
        });
        _pageController.animateToPage(
          _currentBannerIndex,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

Widget _buildHomeTab() {
  final categories = [
    "New In",
    "Designers",
    "Women",
    "Bestsellers",
    "Jewellery",
    "Accessories",
    "Men",
    "Weddings",
    "Kids",
    "Sales",
    "Ready To Ship",
    "Journal"
  ];

  final designerData = [
    {'image': 'assets/New-In-5.jpeg', 'name': 'DIYARAJVIR'},
    {'image': 'assets/New-In-10.jpeg', 'name': 'SAFAA'},
    {'image': 'assets/New-In-13.jpeg', 'name': 'PEACHOO'},
  ];

    final readytoShip = [
    {'image': 'assets/RTS.jpeg', 'name': 'Ready To Ship'},
    {'image': 'assets/Sabya.jpeg', 'name': 'SABYASACHI'},
    {'image': 'assets/Occasion-wear-lehengas.jpeg', 'name': 'OCASSION Wear Lehengas'},
  ];

      final acoEdits = [
    {'image': 'assets/ACO-EDITS-1.png', 'name': 'Ready To Ship'},
    {'image': 'assets/ACO-EDITS-2.png', 'name': 'SABYASACHI'},
    {'image': 'assets/ACO-EDITS-3.png', 'name': 'OCASSION Wear Lehengas'},
    {'image': 'assets/ACO-EDITS-4.png', 'name': 'Ready To Ship'},
    {'image': 'assets/ACO-EDITS-5.png', 'name': 'SABYASACHI'},
    {'image': 'assets/ACO-EDITS-6.png', 'name': 'OCASSION Wear Lehengas'},    {'image': 'assets/ACO-EDITS-1.png', 'name': 'Ready To Ship'},
    {'image': 'assets/ACO-EDITS-7.png', 'name': 'SABYASACHI'},
    {'image': 'assets/ACO-EDITS-8.png', 'name': 'OCASSION Wear Lehengas'},
  ];


  return Column(
    children: [
      
    
      Expanded(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 150,
                child: PageView.builder(
                  controller: _pageController,
                  onPageChanged: (index) {
                    setState(() {
                      _currentBannerIndex = index;
                    });
                  },
                  itemCount: bannerImages.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image.asset(
                          bannerImages[index],
                          fit: BoxFit.cover,
                          width: double.infinity,
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 16), // Add spacing between sections
              Container(
                padding: const EdgeInsets.only(left: 16.0), // Add padding from the left
                alignment: Alignment.centerLeft,
                child: Text(
                  'New In',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 16),
              Container(
                height: 450, // Height for the horizontal slider
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: designerData.length,
                  itemBuilder: (context, index) {
                    final designer = designerData[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Column(
                        children: [
                          ClipRRect(
                            // borderRadius: BorderRadius.circular(8.0),
                            child: Image.asset(
                              designer['image']!,
                              width: 200,
                              height: 380,
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(height: 8),
                        ],
                      ),
                    );
                  },
                ),
              ),

                      Container(
                height: 450, // Height for the horizontal slider
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: readytoShip.length,
                  itemBuilder: (context, index) {
                    final rds = readytoShip[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Column(
                        children: [
                          ClipRRect(
                            // borderRadius: BorderRadius.circular(8.0),
                            child: Image.asset(
                              rds['image']!,
                              width: 200,
                              height: 380,
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(height: 8),
                        ],
                      ),
                    );
                  },
                ),
              ),




              // A+Co Edits

              Container(
                padding: const EdgeInsets.only(left: 16.0), // Add padding from the left
                alignment: Alignment.centerLeft,
                child: Text(
                  'A+Co Edits',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
                       Container(
                height: 450, // Height for the horizontal slider
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: acoEdits.length,
                  itemBuilder: (context, index) {
                    final aco = acoEdits[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Column(
                        children: [
                          ClipRRect(
                            // borderRadius: BorderRadius.circular(8.0),
                            child: Image.asset(
                              aco['image']!,
                              width: 200,
                              height: 380,
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(height: 8),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    ],
  );
}




  Widget _buildSearchTab() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.search, size: 50, color: Colors.green),
          SizedBox(height: 10),
          Text(
            "Search for items here!",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  @override
  
Widget build(BuildContext context) {
  final List<Widget> _tabs = [
    _buildHomeTab(),
    _buildSearchTab(),
// Use the separate ProfileWidget class
  ];

  return Scaffold(
    backgroundColor: Colors.white,
    // appBar: AppBar(
    //   title: Image.asset(
    //     'assets/logo.jpeg', // Replace with the path to your image
    //     height: 40, // Adjust height as needed
    //   ),
    //   centerTitle: true, // Centers the image in the AppBar
    //   backgroundColor: Colors.white, // Customize background color
    // ),
    body: _tabs[_selectedIndex], // Show content of the selected tab
  
  );
}



}
