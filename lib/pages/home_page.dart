import 'package:flutter/material.dart';
import './sevice/api_service.dart';
import 'login_page.dart'; 

class HomePage extends StatefulWidget {
  final String userId;

  HomePage({required this.userId});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ApiService apiService = ApiService();
  String name = "", email = "", phone = "", address = "";
  bool isEditing = false;

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchUserProfile();
  }

  void fetchUserProfile() async {
    try {
      var userProfile = await apiService.getUserProfile(widget.userId);
      setState(() {
        name = userProfile["name"];
        email = userProfile["email"];
        phone = userProfile["phone"];
        address = userProfile["address"];
      });
    } catch (e) {
      print("Error: $e");
    }
  }

  void updateUserProfile() async {
    try {
      await apiService.updateUserProfile(
        widget.userId,
        nameController.text,
        emailController.text,
        phoneController.text,
        addressController.text,
      );
      fetchUserProfile();
      setState(() {
        isEditing = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Profile Updated Successfully')),
      );
    } catch (e) {
      print("Error updating profile: $e");
    }
  }

  void deleteUserProfile() async {
    try {
      await apiService.deleteUserProfile(widget.userId);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
    } catch (e) {
      print("Error deleting profile: $e");
    }
  }

  void confirmDelete() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Delete Profile"),
        content: Text("Are you sure you want to delete your profile? This action cannot be undone."),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Tutup dialog
              deleteUserProfile(); // Hapus profil
            },
            child: Text(
              "Delete",
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue.shade700, Colors.blue.shade300],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: isEditing ? buildEditForm() : buildProfileView(),
            ),
          ),
        ),
      ),
      floatingActionButton: !isEditing
          ? FloatingActionButton(
              onPressed: () {
                setState(() {
                  isEditing = true;
                });
              },
              child: Icon(Icons.edit, color: Colors.white),
              backgroundColor: Colors.blue.shade700,
            )
          : null,
    );
  }

  Widget buildProfileView() {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.person,
              size: 80,
              color: Colors.blue.shade700,
            ),
            SizedBox(height: 20),
            Text(
              name,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.blue.shade700,
                  ),
            ),
            SizedBox(height: 10),
            Text(
              email,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.grey.shade600,
                  ),
            ),
            Text(
              phone,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.grey.shade600,
                  ),
            ),
            Text(
              address,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.grey.shade600,
                  ),
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: confirmDelete,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                "Delete Profile",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildEditForm() {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController..text = name,
              decoration: InputDecoration(
                labelText: "Name",
                prefixIcon: Icon(Icons.person),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: emailController..text = email,
              decoration: InputDecoration(
                labelText: "Email",
                prefixIcon: Icon(Icons.email),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: phoneController..text = phone,
              decoration: InputDecoration(
                labelText: "Phone",
                prefixIcon: Icon(Icons.phone),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: addressController..text = address,
              decoration: InputDecoration(
                labelText: "Address",
                prefixIcon: Icon(Icons.home),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: updateUserProfile,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue.shade700,
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                "Update Profile",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(height: 10),
            TextButton(
              onPressed: () => setState(() => isEditing = false),
              child: Text(
                "Cancel",
                style: TextStyle(
                  color: Colors.blue.shade700,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}