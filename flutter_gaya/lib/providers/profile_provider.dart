import 'package:flutter/foundation.dart';
import '../services/api_service.dart';
import '../models/user_profile.dart';

class ProfileProvider extends ChangeNotifier {
  final ApiService _apiService = ApiService();
  UserProfile? _profile;
  bool _isLoading = false;
  String? _error;

  UserProfile? get profile => _profile;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> loadUserProfile(int userId) async {
    if (_isLoading) return;
    
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      print('ProfileProvider: Loading profile for user ID: $userId');
      final data = await _apiService.getUserProfileById(userId.toString());
      print('ProfileProvider: Profile data received: $data');
      _profile = UserProfile.fromJson(data);
    } catch (e) {
      print('ProfileProvider: Error loading profile: $e');
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> updateProfile(int userId, Map<String, dynamic> updates) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final data = await _apiService.updateUserProfile(userId.toString(), updates);
      _profile = UserProfile.fromJson(data);
    } catch (e) {
      _error = e.toString();
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void clearError() {
    _error = null;
    notifyListeners();
  }
} 