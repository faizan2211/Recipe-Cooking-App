import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/recipe.dart';
import '../theme/app_theme.dart';
import 'cooking_mode_screen.dart';

class RecipeDetailScreen extends StatefulWidget {
  final Recipe recipe;
  final VoidCallback onFavoriteToggle;

  const RecipeDetailScreen({
    super.key,
    required this.recipe,
    required this.onFavoriteToggle,
  });

  @override
  State<RecipeDetailScreen> createState() => _RecipeDetailScreenState();
}

class _RecipeDetailScreenState extends State<RecipeDetailScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late int _servings;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _servings = widget.recipe.defaultServings;
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  double get _servingsMultiplier => _servings / widget.recipe.defaultServings;

  @override
  Widget build(BuildContext context) {
    final recipe = widget.recipe;

    return Scaffold(
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              // Hero Image Header
              SliverAppBar(
                expandedHeight: 320,
                pinned: true,
                backgroundColor: AppColors.background,
                leading: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircleAvatar(
                    backgroundColor: Colors.white.withOpacity(0.9),
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back, color: AppColors.textDark, size: 20),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                ),
                actions: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CircleAvatar(
                      backgroundColor: Colors.white.withOpacity(0.9),
                      child: IconButton(
                        icon: Icon(
                          recipe.isFavorite ? Icons.favorite : Icons.favorite_border,
                          color: recipe.isFavorite ? Colors.red : AppColors.textDark,
                          size: 20,
                        ),
                        onPressed: () {
                          setState(() {
                            recipe.isFavorite = !recipe.isFavorite;
                          });
                          widget.onFavoriteToggle();
                        },
                      ),
                    ),
                  ),
                ],
                flexibleSpace: FlexibleSpaceBar(
                  background: Stack(
                    fit: StackFit.expand,
                    children: [
                      Hero(
                        tag: 'recipe_image_${recipe.id}',
                        child: Image.network(
                          recipe.imageUrl,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) => Container(
                            color: AppColors.categoryChipBg,
                            child: const Center(
                              child: Icon(Icons.restaurant, size: 60, color: AppColors.textLight),
                            ),
                          ),
                        ),
                      ),
                      // Gradient overlay for smooth transition
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.black.withOpacity(0.3),
                              Colors.transparent,
                              Colors.black.withOpacity(0.6),
                            ],
                          ),
                        ),
                      ),
                      // Bottom rating badge over image
                      Positioned(
                        bottom: 16,
                        left: 20,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.7),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            children: [
                              const Icon(Icons.star, color: AppColors.accent, size: 18),
                              const SizedBox(width: 4),
                              Text(
                                '${recipe.rating}',
                                style: GoogleFonts.plusJakartaSans(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                              const SizedBox(width: 4),
                              Text(
                                '(${recipe.reviewCount} reviews)',
                                style: GoogleFonts.plusJakartaSans(
                                  color: Colors.white70,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Content Sliver
              SliverToBoxAdapter(
                child: Container(
                  transform: Matrix4.translationValues(0, -16, 0),
                  decoration: const BoxDecoration(
                    color: AppColors.background,
                    borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 24, 20, 100),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Category Tag & Difficulty
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                              decoration: BoxDecoration(
                                color: AppColors.primary.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                recipe.category.toUpperCase(),
                                style: GoogleFonts.plusJakartaSans(
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 11,
                                  letterSpacing: 1,
                                ),
                              ),
                            ),
                            const Spacer(),
                            Icon(Icons.bar_chart, size: 16, color: AppColors.textMedium),
                            const SizedBox(width: 4),
                            Text(
                              recipe.difficulty,
                              style: GoogleFonts.plusJakartaSans(
                                color: AppColors.textMedium,
                                fontWeight: FontWeight.w600,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),

                        // Title
                        Text(
                          recipe.title,
                          style: GoogleFonts.playfairDisplay(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textDark,
                          ),
                        ),
                        const SizedBox(height: 12),

                        // Description
                        Text(
                          recipe.description,
                          style: GoogleFonts.plusJakartaSans(
                            color: AppColors.textMedium,
                            fontSize: 14,
                            height: 1.5,
                          ),
                        ),
                        const SizedBox(height: 20),

                        // Quick info cards row (Prep time, Cook time, Calories)
                        Row(
                          children: [
                            _buildInfoCard(
                              icon: Icons.timer_outlined,
                              title: 'Prep Time',
                              value: '${recipe.prepTimeMinutes} mins',
                            ),
                            const SizedBox(width: 12),
                            _buildInfoCard(
                              icon: Icons.outdoor_grill_outlined,
                              title: 'Cook Time',
                              value: '${recipe.cookTimeMinutes} mins',
                            ),
                            const SizedBox(width: 12),
                            _buildInfoCard(
                              icon: Icons.local_fire_department_outlined,
                              title: 'Calories',
                              value: '${recipe.nutrition.calories} kcal',
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),

                        // Chef Info Card
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: Colors.black.withOpacity(0.05)),
                          ),
                          child: Row(
                            children: [
                              CircleAvatar(
                                radius: 22,
                                backgroundImage: NetworkImage(recipe.chefAvatarUrl),
                              ),
                              const SizedBox(width: 12),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Recipe Creator',
                                    style: GoogleFonts.plusJakartaSans(
                                      color: AppColors.textLight,
                                      fontSize: 11,
                                    ),
                                  ),
                                  Text(
                                    recipe.chefName,
                                    style: GoogleFonts.plusJakartaSans(
                                      color: AppColors.textDark,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 24),

                        // Dynamic Servings Controller
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Servings',
                              style: GoogleFonts.playfairDisplay(fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(color: Colors.black.withOpacity(0.08)),
                              ),
                              child: Row(
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.remove, size: 18),
                                    onPressed: _servings > 1
                                        ? () => setState(() => _servings--)
                                        : null,
                                  ),
                                  Text(
                                    '$_servings',
                                    style: GoogleFonts.plusJakartaSans(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.add, size: 18),
                                    onPressed: () => setState(() => _servings++),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),

                        // Custom Tab Bar
                        Container(
                          height: 48,
                          decoration: BoxDecoration(
                            color: AppColors.categoryChipBg,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: TabBar(
                            controller: _tabController,
                            indicator: BoxDecoration(
                              color: AppColors.primary,
                              borderRadius: BorderRadius.circular(14),
                            ),
                            labelColor: Colors.white,
                            unselectedLabelColor: AppColors.textMedium,
                            labelStyle: GoogleFonts.plusJakartaSans(
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                            ),
                            tabs: const [
                              Tab(text: 'Ingredients'),
                              Tab(text: 'Steps'),
                              Tab(text: 'Nutrition'),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),

                        // Tab Bar Views Content
                        SizedBox(
                          height: 380,
                          child: TabBarView(
                            controller: _tabController,
                            children: [
                              _buildIngredientsList(),
                              _buildStepsList(),
                              _buildNutritionView(),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),

          // Floating Bottom CTA Button: Start Cooking Mode
          Positioned(
            bottom: 20,
            left: 20,
            right: 20,
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                elevation: 8,
                shadowColor: AppColors.primary.withOpacity(0.5),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CookingModeScreen(recipe: recipe),
                  ),
                );
              },
              icon: const Icon(Icons.play_circle_fill, size: 24),
              label: Text(
                'Start Cooking Mode',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.black.withOpacity(0.04)),
        ),
        child: Column(
          children: [
            Icon(icon, color: AppColors.primary, size: 22),
            const SizedBox(height: 6),
            Text(
              title,
              style: GoogleFonts.plusJakartaSans(
                color: AppColors.textLight,
                fontSize: 11,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              value,
              style: GoogleFonts.plusJakartaSans(
                color: AppColors.textDark,
                fontWeight: FontWeight.bold,
                fontSize: 13,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIngredientsList() {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.zero,
      itemCount: widget.recipe.ingredients.length,
      itemBuilder: (context, index) {
        final ingredient = widget.recipe.ingredients[index];
        final scaledAmount = (ingredient.amount * _servingsMultiplier);
        final formattedAmount = scaledAmount % 1 == 0
            ? scaledAmount.toInt().toString()
            : scaledAmount.toStringAsFixed(1);

        return Card(
          elevation: 0,
          color: Colors.white,
          margin: const EdgeInsets.only(bottom: 10),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
            side: BorderSide(color: Colors.black.withOpacity(0.04)),
          ),
          child: CheckboxListTile(
            activeColor: AppColors.primary,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
            value: ingredient.isChecked,
            onChanged: (val) {
              setState(() {
                ingredient.isChecked = val ?? false;
              });
            },
            title: Text(
              ingredient.name,
              style: GoogleFonts.plusJakartaSans(
                fontWeight: FontWeight.w600,
                fontSize: 14,
                decoration: ingredient.isChecked
                    ? TextDecoration.lineThrough
                    : TextDecoration.none,
                color: ingredient.isChecked ? AppColors.textLight : AppColors.textDark,
              ),
            ),
            subtitle: Text(
              '$formattedAmount ${ingredient.unit}',
              style: GoogleFonts.plusJakartaSans(
                color: AppColors.primary,
                fontWeight: FontWeight.bold,
                fontSize: 13,
              ),
            ),
            secondary: Text(
              ingredient.icon,
              style: const TextStyle(fontSize: 24),
            ),
          ),
        );
      },
    );
  }

  Widget _buildStepsList() {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.zero,
      itemCount: widget.recipe.steps.length,
      itemBuilder: (context, index) {
        final step = widget.recipe.steps[index];

        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.black.withOpacity(0.04)),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 14,
                backgroundColor: step.isCompleted
                    ? AppColors.greenAccent
                    : AppColors.primary.withOpacity(0.15),
                child: Text(
                  step.isCompleted ? '✓' : '${step.stepNumber}',
                  style: TextStyle(
                    color: step.isCompleted ? Colors.white : AppColors.primary,
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      step.title,
                      style: GoogleFonts.plusJakartaSans(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: AppColors.textDark,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      step.description,
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 13,
                        color: AppColors.textMedium,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildNutritionView() {
    final nut = widget.recipe.nutrition;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.black.withOpacity(0.04)),
      ),
      child: Column(
        children: [
          _buildMacroRow('Protein', '${nut.proteinGrams}g', nut.proteinGrams / 50, Colors.orange),
          const SizedBox(height: 16),
          _buildMacroRow('Carbohydrates', '${nut.carbsGrams}g', nut.carbsGrams / 100, Colors.blue),
          const SizedBox(height: 16),
          _buildMacroRow('Fat', '${nut.fatGrams}g', nut.fatGrams / 50, Colors.redAccent),
          const SizedBox(height: 16),
          _buildMacroRow('Dietary Fiber', '${nut.fiberGrams}g', nut.fiberGrams / 25, Colors.green),
        ],
      ),
    );
  }

  Widget _buildMacroRow(String name, String value, double percent, Color color) {
    final clampedPercent = percent.clamp(0.0, 1.0);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              name,
              style: GoogleFonts.plusJakartaSans(
                fontWeight: FontWeight.w600,
                color: AppColors.textDark,
              ),
            ),
            Text(
              value,
              style: GoogleFonts.plusJakartaSans(
                fontWeight: FontWeight.bold,
                color: AppColors.textDark,
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: LinearProgressIndicator(
            value: clampedPercent,
            minHeight: 8,
            backgroundColor: AppColors.categoryChipBg,
            valueColor: AlwaysStoppedAnimation<Color>(color),
          ),
        ),
      ],
    );
  }
}
