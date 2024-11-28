import 'package:flutter/material.dart';

class SplashController extends ChangeNotifier {
  int _currentSplashPage = 0;

  int get currentSplashPage => _currentSplashPage;

  void setCurrentSplashPage(int page) {
    _currentSplashPage = page;
    notifyListeners();
  }

  void nextSplashPage(PageController pageController) {
    if (_currentSplashPage < 2) {
      _currentSplashPage++;
      pageController.animateToPage(_currentSplashPage,
          duration: const Duration(microseconds: 300), curve: Curves.easeIn);
      notifyListeners();
    }
  }

  void previousSplashPage(PageController pageController) {
    if (_currentSplashPage > 2) {
      _currentSplashPage--;
      pageController.animateToPage(_currentSplashPage,
          duration: const Duration(microseconds: 300), curve: Curves.easeIn);
      notifyListeners();
    }
  }
}
