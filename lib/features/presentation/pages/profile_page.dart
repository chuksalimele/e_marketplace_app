// profile_page.dart
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  // Simulated user data
  final String _userName = 'John Doe';
  final String _userEmail = 'john.doe@example.com';
  final String _userTier = 'Gold Buyer'; // Example: Could be from a real user object

  void _onMenuItemTap(BuildContext context, String action) {
    print('Tapped on: $action');
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('$action (Simulated)')),
    );
    // In a real app, you would navigate to specific pages based on the action
    // E.g., if (action == 'My Orders') Navigator.push(context, MaterialPageRoute(...));
    // E.g., if (action == 'Logout') { /* perform logout logic */ Navigator.pushReplacementNamed(context, '/login'); }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Profile'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
      ),
      body: SingleChildScrollView( // Use SingleChildScrollView for scrollable content
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center, // Center profile picture and name
          children: [
            // User Profile Header
            CircleAvatar(
              radius: 50,
              backgroundColor: Theme.of(context).primaryColor.withOpacity(0.1),
              child: Icon(Icons.person, size: 60, color: Theme.of(context).primaryColor),
              // backgroundImage: NetworkImage('https://example.com/user_profile.jpg'), // For real image
            ),
            const SizedBox(height: 16),
            Text(
              _userName,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(
              _userEmail,
              style: const TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 8),
            Chip( // Display user tier or status
              label: Text(_userTier, style: TextStyle(color: Colors.white)),
              backgroundColor: Colors.amber,
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap, // Make it smaller
            ),
            const SizedBox(height: 32),

            // Profile Menu Options
            _buildProfileMenuItem(context, Icons.receipt_long, 'My Orders', () => _onMenuItemTap(context, 'My Orders')),
            _buildProfileMenuItem(context, Icons.location_on_outlined, 'Saved Addresses', () => _onMenuItemTap(context, 'Saved Addresses')),
            _buildProfileMenuItem(context, Icons.settings_outlined, 'Settings', () => _onMenuItemTap(context, 'Settings')),
            _buildProfileMenuItem(context, Icons.help_outline, 'Help & Support', () => _onMenuItemTap(context, 'Help & Support')),
            const Divider(height: 32, thickness: 1), // Separator

            _buildProfileMenuItem(context, Icons.logout, 'Logout', () => _onMenuItemTap(context, 'Logout'), isDestructive: true),
          ],
        ),
      ),
    );
  }

  // Helper method to build consistent menu items
  Widget _buildProfileMenuItem(BuildContext context, IconData icon, String title, VoidCallback onTap, {bool isDestructive = false}) {
    return Card(
      elevation: 0, // No shadow for list items
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
        side: BorderSide(color: Colors.grey[200]!, width: 1), // Subtle border
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(8.0),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Icon(icon, color: isDestructive ? Colors.red : Theme.of(context).primaryColor),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: isDestructive ? Colors.red : Colors.black87,
                  ),
                ),
              ),
              Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey[400]),
            ],
          ),
        ),
      ),
    );
  }
}