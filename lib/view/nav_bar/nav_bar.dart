import 'package:flutter/material.dart';
import 'package:kompanyon_app/const/color.dart';
import 'package:kompanyon_app/const/image.dart';
import 'package:kompanyon_app/view/add_screen/add_screen.dart';
import 'package:kompanyon_app/view/home_screen/home_screen.dart';
import 'package:kompanyon_app/view/notification_screen/notification.dart';
import 'package:kompanyon_app/view/profile/profile.dart';
import 'package:kompanyon_app/view/search_screen/search_screen.dart';

class NavBar extends StatefulWidget {
  @override
  _NavBarState createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildPageContent(_selectedIndex),
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          splashColor: Colors.transparent, // Removes splash color
          highlightColor: Colors.transparent, // Removes highlight color
        ),
        child: BottomNavigationBar(
          backgroundColor: Colors.white,
          type: BottomNavigationBarType.fixed,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: ImageIcon(AssetImage(AppImages.homeIcon)),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: ImageIcon(AssetImage(AppImages.searchIcon)),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Container(
                width: 25, // Adjust the size to be more visible
                height: 25, // Adjust the size to be more visible
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(
                      color: _selectedIndex != 2 ? Colors.grey : primaryColor,
                      width: 1),
                  color: Colors.white,
                ),
                child: Center(
                  // Center the icon within the container
                  child: Icon(
                    Icons.add,
                    // Set the color of the icon if needed
                    size: 24, // Adjust the size of the icon
                  ),
                ),
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: ImageIcon(AssetImage(AppImages.bellIcon)),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: CircleAvatar(
                backgroundImage: AssetImage(AppImages.profileIcon),
                radius: 12,
              ),
              label: '',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: primaryColor,
          unselectedItemColor: Colors.grey,
          onTap: _onItemTapped,
        ),
      ),
    );
  }

  Widget _buildPageContent(int index) {
    switch (index) {
      case 0:
        return HomeScreen();
      case 1:
        return SearchScreen();
      case 2:
        return AddScreen();
      case 3:
        return NotificationScreen();
      case 4:
        return Profile();
      default:
        return HomeScreen(); // Default to HomeScreen for safety
    }
  }
}
