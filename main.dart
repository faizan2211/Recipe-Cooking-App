import 'package:flutter/material.dart';
import 'models/recipe.dart';
import 'theme/app_theme.dart';
import 'screens/login_screen.dart';
import 'screens/home_screen.dart';
import 'screens/explore_screen.dart';
import 'screens/favorites_screen.dart';
import 'screens/profile_screen.dart';
import 'widgets/custom_bottom_nav.dart';

void main() {
  runApp(const GourmetRecipeApp());
}

class GourmetRecipeApp extends StatefulWidget {
  const GourmetRecipeApp({super.key});

  @override
  State<GourmetRecipeApp> createState() => _GourmetRecipeAppState();
}

class _GourmetRecipeAppState extends State<GourmetRecipeApp> {
  bool _isLoggedIn = false;
  String _userEmail = '';
  String _userName = '';

  void _handleLogin(String email, String name) {
    setState(() {
      _userEmail = email;
      _userName = name;
      _isLoggedIn = true;
    });
  }

  void _handleLogout() {
    setState(() {
      _isLoggedIn = false;
      _userEmail = '';
      _userName = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gourmet Cooking & Recipe App',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: _isLoggedIn
          ? MainTabWrapper(
              userName: _userName,
              userEmail: _userEmail,
              onLogout: _handleLogout,
            )
          : LoginScreen(
              onLoginSuccess: _handleLogin,
            ),
    );
  }
}

class MainTabWrapper extends StatefulWidget {
  final String userName;
  final String userEmail;
  final VoidCallback onLogout;

  const MainTabWrapper({
    super.key,
    required this.userName,
    required this.userEmail,
    required this.onLogout,
  });

  @override
  State<MainTabWrapper> createState() => _MainTabWrapperState();
}

class _MainTabWrapperState extends State<MainTabWrapper> {
  int _currentIndex = 0;
  final List<Recipe> _recipes = sampleRecipes;

  void _onFavoriteToggle() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final savedCount = _recipes.where((r) => r.isFavorite).length;

    final screens = [
      HomeScreen(
        recipes: _recipes,
        onFavoriteToggle: _onFavoriteToggle,
      ),
      ExploreScreen(
        recipes: _recipes,
        onFavoriteToggle: _onFavoriteToggle,
      ),
      FavoritesScreen(
        recipes: _recipes,
        onFavoriteToggle: _onFavoriteToggle,
      ),
      ProfileScreen(
        userName: widget.userName,
        userEmail: widget.userEmail,
        savedRecipesCount: savedCount,
        onLogout: widget.onLogout,
      ),
    ];

    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: screens,
      ),
      bottomNavigationBar: CustomBottomNav(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
