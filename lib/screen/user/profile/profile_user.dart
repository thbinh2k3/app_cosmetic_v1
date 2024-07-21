import 'package:app_cosmetic/screen/user/profile/forgot_pass.dart';
import 'package:app_cosmetic/screen/user/profile/process_oder.dart';
import 'package:app_cosmetic/screen/user/Home/home.dart';
import 'package:app_cosmetic/screen/sign_up.dart';
import 'package:app_cosmetic/widgets/navbar_user.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  final String? id;
  ProfileScreen({super.key, required this.id});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String userId = '';

  @override
  void initState() {
    super.initState();
    _loadUserId();
  }

  Future<void> _loadUserId() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      userId = prefs.getString('_id') ?? 'Unknown User';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(
                    'https://i.pinimg.com/564x/b3/e5/db/b3e5db5a3bf1399f74500a6209462794.jpg'),
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: CircleAvatar(
                    radius: 16,
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.edit,
                      color: Colors.brown,
                      size: 16,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16),
              Text(
                userId,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              Divider(),
              ListTile(
                leading: Icon(Icons.person, color: Colors.brown),
                title: Text('Your profile'),
                trailing: Icon(Icons.arrow_forward_ios, color: Colors.brown),
                onTap: () {
                  // Handle navigation to "Your profile"
                },
              ),
              ListTile(
                leading: Icon(Icons.payment, color: Colors.brown),
                title: Text('Payment Methods'),
                trailing: Icon(Icons.arrow_forward_ios, color: Colors.brown),
                onTap: () {
                  // Handle navigation to "Payment Methods"
                },
              ),
              ListTile(
                leading: Icon(Icons.shopping_bag, color: Colors.brown),
                title: Text('My Orders'),
                trailing: Icon(Icons.arrow_forward_ios, color: Colors.brown),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ProcessOder()),
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.settings, color: Colors.brown),
                title: Text('Change Password'),
                trailing: Icon(Icons.arrow_forward_ios, color: Colors.brown),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ForgotPassPage()),
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.logout, color: Colors.brown),
                title: Text('Log out'),
                trailing: Icon(Icons.arrow_forward_ios, color: Colors.brown),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SignUpPage()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
