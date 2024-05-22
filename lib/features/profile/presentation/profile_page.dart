
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
      return SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage('https://via.placeholder.com/150'), // Replace with actual image
              ),
            ),
            Text(
              'John Doe',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text(
              'john.doe@example.com',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            SizedBox(height: 20),
            Divider(),
            ListTile(
              leading: Icon(Icons.person),
              title: Text('Edit Profile'),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {
                // Navigate to edit profile screen
              },
            ),
          
            ListTile(
              leading: Icon(Icons.notifications),
              title: Text('Notifications'),
              trailing: Switch(
                value: true, // Replace with actual value
                onChanged: (value) {
                  // Handle notification toggle
                },
              ),
            ),
          
      
            ListTile(
              leading: Icon(Icons.info),
              title: Text('App Version'),
              trailing: Text('1.0.0'), 
            ),
       
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Logout'),
              onTap: () {
   
              },
            ),
          ],
        ),
      );
  }
}