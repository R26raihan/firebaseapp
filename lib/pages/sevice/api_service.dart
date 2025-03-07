import 'package:dio/dio.dart';

class ApiService {
  final Dio _dio = Dio(BaseOptions(baseUrl: "http://192.168.1.6:8000/"));

  // Register user
  Future<void> registerUser(String id, String name, String email, String password, String phone, String address) async {
    try {
      Response response = await _dio.post("users/register", data: {
        "user_id": id,
        "name": name,
        "email": email,
        "password": password,
        "phone": phone,
        "address": address,
      });

      if (response.statusCode == 200) {
        print("Registration successful!");
      } else {
        print("Failed to register user: ${response.statusCode}");
      }
    } catch (e) {
      print("Error during registration: $e");
      throw Exception("Failed to register user: $e");
    }
  }

  // Login user
  Future<String> loginUser(String email, String password) async {
    try {
      Response response = await _dio.post("users/login", data: {
        "email": email,
        "password": password,
      });

      if (response.statusCode == 200) {
        return response.data["user_id"];
      } else {
        throw Exception("Login failed with status: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Invalid credentials: $e");
    }
  }

  // Get user profile by ID
  Future<Map<String, dynamic>> getUserProfile(String userId) async {
    try {
      Response response = await _dio.get("users/$userId");

      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw Exception("Failed to fetch user profile");
      }
    } catch (e) {
      throw Exception("Error fetching user profile: $e");
    }
  }

  // Update user profile
  Future<void> updateUserProfile(String userId, String name, String email, String phone, String address) async {
    try {
      Response response = await _dio.put("users/$userId", data: {
        "name": name,
        "email": email,
        "phone": phone,
        "address": address,
      });

      if (response.statusCode == 200) {
        print("User profile updated successfully");
      } else {
        throw Exception("Failed to update user profile");
      }
    } catch (e) {
      throw Exception("Error updating user profile: $e");
    }
  }

  // Delete user profile
  Future<void> deleteUserProfile(String userId) async {
    try {
      Response response = await _dio.delete("users/$userId");

      if (response.statusCode == 200) {
        print("User profile deleted successfully");
      } else {
        throw Exception("Failed to delete user profile");
      }
    } catch (e) {
      throw Exception("Error deleting user profile: $e");
    }
  }
}
