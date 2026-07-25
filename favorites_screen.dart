import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/recipe.dart';
import '../theme/app_theme.dart';
import 'recipe_detail_screen.dart';

class FavoritesScreen extends StatelessWidget {
  final List<Recipe> recipes;
  final VoidCallback onFavoriteToggle;

  const FavoritesScreen({
    super.key,
    required this.recipes,
    required this.onFavoriteToggle,
  });

  @override
  Widget build(BuildContext context) {
    final favoriteRecipes = recipes.where((r) => r.isFavorite).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Saved Recipes',
          style: GoogleFonts.playfairDisplay(
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
      ),
      body: favoriteRecipes.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('❤️', style: TextStyle(fontSize: 64)),
                  const SizedBox(height: 16),
                  Text(
                    'No Favorites Yet',
                    style: GoogleFonts.playfairDisplay(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textDark,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Tap the heart icon on any recipe to save it here!',
                    style: GoogleFonts.plusJakartaSans(
                      color: AppColors.textMedium,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(20),
              itemCount: favoriteRecipes.length,
              itemBuilder: (context, index) {
                final recipe = favoriteRecipes[index];
                return Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.04),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(20),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RecipeDetailScreen(
                            recipe: recipe,
                            onFavoriteToggle: onFavoriteToggle,
                          ),
                        ),
                      );
                    },
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.horizontal(
                            left: Radius.circular(20),
                          ),
                          child: Image.network(
                            recipe.imageUrl,
                            width: 110,
                            height: 110,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 8,
                                        vertical: 4,
                                      ),
                                      decoration: BoxDecoration(
                                        color: AppColors.primary.withOpacity(0.1),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Text(
                                        recipe.category,
                                        style: GoogleFonts.plusJakartaSans(
                                          color: AppColors.primary,
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    const Spacer(),
                                    IconButton(
                                      icon: const Icon(Icons.favorite, color: Colors.red, size: 20),
                                      onPressed: () {
                                        recipe.isFavorite = false;
                                        onFavoriteToggle();
                                      },
                                    ),
                                  ],
                                ),
                                Text(
                                  recipe.title,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.playfairDisplay(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Row(
                                  children: [
                                    const Icon(Icons.timer_outlined,
                                        size: 14, color: AppColors.textLight),
                                    const SizedBox(width: 4),
                                    Text(
                                      '${recipe.totalTime} mins',
                                      style: GoogleFonts.plusJakartaSans(
                                        fontSize: 12,
                                        color: AppColors.textMedium,
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    const Icon(Icons.star,
                                        size: 14, color: AppColors.accent),
                                    const SizedBox(width: 4),
                                    Text(
                                      '${recipe.rating}',
                                      style: GoogleFonts.plusJakartaSans(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.textDark,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
