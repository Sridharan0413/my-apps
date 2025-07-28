import 'package:flutter/material.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  Widget _buildListTile(String title, IconData icon, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: Colors.black),
      title: Text(title),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: onTap,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text("Account", style: TextStyle(color: Colors.black)),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Profile Info
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Row(
              children: [
                const CircleAvatar(
                  radius: 30,
                  backgroundImage: AssetImage('images/u1.png'), // Replace with your image
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text("SRI", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      Text("APS0413@gmail.com", style: TextStyle(color: Colors.grey)),
                    ],
                  ),
                ),
                const Icon(Icons.edit, color: Colors.green),
              ],
            ),
          ),
          const SizedBox(height: 10),

          // List Items
          _buildListTile("Orders", Icons.shopping_bag_outlined, () {}),
          _buildListTile("My Details", Icons.person_outline, () {}),
          _buildListTile("Delivery Address", Icons.location_on_outlined, () {}),
          _buildListTile("Payment Methods", Icons.credit_card, () {}),
          _buildListTile("Promo Cord", Icons.sell_outlined, () {}),
          _buildListTile("Notifications", Icons.notifications_none, () {}),
          _buildListTile("Help", Icons.help_outline, () {}),
          _buildListTile("About", Icons.info_outline, () {}),

          const Spacer(),

          // Logout Button
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey[200],
                minimumSize: const Size.fromHeight(50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(context, '/', (_) => false);
              },
              icon: const Icon(Icons.logout, color: Colors.green),
              label: const Text("Log Out", style: TextStyle(color: Colors.green)),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),

      // Bottom Navigation Bar
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: 4, // index for "Account"
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          switch (index) {
            case 0:
              Navigator.pushReplacementNamed(context, '/homepage');
              break;
            case 1:
              Navigator.pushReplacementNamed(context, '/explore');
              break;
            case 2:
              Navigator.pushReplacementNamed(context, '/mycart');
              break;
            case 3:
              Navigator.pushReplacementNamed(context, '/favorites');
              break;
            case 4:
             Navigator.pushReplacementNamed(context, '/account');
              
              break;
          }
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.store), label: 'Shop'),
          BottomNavigationBarItem(icon: Icon(Icons.explore), label: 'Explore'),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: 'Cart'),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Favourite'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Account'),
        ],
      ),
    );
  }
}



