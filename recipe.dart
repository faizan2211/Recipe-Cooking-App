class Ingredient {
  final String name;
  final double amount;
  final String unit;
  final String icon;
  bool isChecked;

  Ingredient({
    required this.name,
    required this.amount,
    required this.unit,
    required this.icon,
    this.isChecked = false,
  });
}

class CookingStep {
  final int stepNumber;
  final String title;
  final String description;
  final int? durationMinutes;
  bool isCompleted;

  CookingStep({
    required this.stepNumber,
    required this.title,
    required this.description,
    this.durationMinutes,
    this.isCompleted = false,
  });
}

class NutritionInfo {
  final int calories;
  final int proteinGrams;
  final int carbsGrams;
  final int fatGrams;
  final int fiberGrams;

  const NutritionInfo({
    required this.calories,
    required this.proteinGrams,
    required this.carbsGrams,
    required this.fatGrams,
    required this.fiberGrams,
  });
}

class Recipe {
  final String id;
  final String title;
  final String description;
  final String category;
  final String imageUrl;
  final double rating;
  final int reviewCount;
  final int prepTimeMinutes;
  final int cookTimeMinutes;
  final String difficulty; // Easy, Medium, Hard
  final String chefName;
  final String chefAvatarUrl;
  final int defaultServings;
  final NutritionInfo nutrition;
  final List<Ingredient> ingredients;
  final List<CookingStep> steps;
  bool isFavorite;
  final bool isFeatured;

  Recipe({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.imageUrl,
    required this.rating,
    required this.reviewCount,
    required this.prepTimeMinutes,
    required this.cookTimeMinutes,
    required this.difficulty,
    required this.chefName,
    required this.chefAvatarUrl,
    required this.defaultServings,
    required this.nutrition,
    required this.ingredients,
    required this.steps,
    this.isFavorite = false,
    this.isFeatured = false,
  });

  int get totalTime => prepTimeMinutes + cookTimeMinutes;
}

final List<Recipe> sampleRecipes = [
  Recipe(
    id: 'r1',
    title: 'Truffle & Cream Mushroom Pasta',
    description: 'Creamy fettuccine tossed in a rich white truffle oil sauce with pan-seared wild mushrooms and freshly grated parmesan.',
    category: 'Dinner',
    imageUrl: 'https://images.unsplash.com/photo-1621996346565-e3dbc646d9a9?auto=format&fit=crop&w=800&q=80',
    rating: 4.9,
    reviewCount: 328,
    prepTimeMinutes: 15,
    cookTimeMinutes: 20,
    difficulty: 'Medium',
    chefName: 'Chef Marco Savori',
    chefAvatarUrl: 'https://images.unsplash.com/photo-1577219491135-ce391730fb2c?auto=format&fit=crop&w=200&q=80',
    defaultServings: 2,
    isFeatured: true,
    isFavorite: true,
    nutrition: const NutritionInfo(
      calories: 540,
      proteinGrams: 18,
      carbsGrams: 62,
      fatGrams: 24,
      fiberGrams: 4,
    ),
    ingredients: [
      Ingredient(name: 'Fettuccine Pasta', amount: 250, unit: 'g', icon: '🍝'),
      Ingredient(name: 'Wild Mushrooms', amount: 200, unit: 'g', icon: '🍄'),
      Ingredient(name: 'Heavy Cream', amount: 150, unit: 'ml', icon: '🥛'),
      Ingredient(name: 'White Truffle Oil', amount: 1.5, unit: 'tbsp', icon: '🍾'),
      Ingredient(name: 'Parmesan Cheese', amount: 50, unit: 'g', icon: '🧀'),
      Ingredient(name: 'Garlic Cloves', amount: 3, unit: 'cloves', icon: '🧄'),
      Ingredient(name: 'Fresh Parsley', amount: 15, unit: 'g', icon: '🌿'),
    ],
    steps: [
      CookingStep(
        stepNumber: 1,
        title: 'Boil Pasta',
        description: 'Bring a large pot of salted water to a rolling boil. Cook fettuccine until al dente (approx. 9-10 mins). Reserve 1/2 cup of pasta water.',
        durationMinutes: 10,
      ),
      CookingStep(
        stepNumber: 2,
        title: 'Sauté Mushrooms & Garlic',
        description: 'Melt butter in a large skillet over medium-high heat. Add minced garlic and sliced wild mushrooms. Sauté until golden brown.',
        durationMinutes: 6,
      ),
      CookingStep(
        stepNumber: 3,
        title: 'Prepare Cream Sauce',
        description: 'Reduce heat to medium-low. Pour heavy cream and truffle oil into skillet. Simmer gently for 4 minutes until sauce thickens slightly.',
        durationMinutes: 4,
      ),
      CookingStep(
        stepNumber: 4,
        title: 'Toss & Serve',
        description: 'Add cooked pasta into the skillet. Toss continuously with freshly grated parmesan and parsley until rich and glossy. Serve hot!',
        durationMinutes: 2,
      ),
    ],
  ),
  Recipe(
    id: 'r2',
    title: 'Avocado Egg & Salmon Toast',
    description: 'Crispy sourdough topped with smashed ripe avocado, smoked Atlantic salmon, poached eggs, and chili flakes.',
    category: 'Breakfast',
    imageUrl: 'https://images.unsplash.com/photo-1525351484163-7529414344d8?auto=format&fit=crop&w=800&q=80',
    rating: 4.8,
    reviewCount: 215,
    prepTimeMinutes: 10,
    cookTimeMinutes: 8,
    difficulty: 'Easy',
    chefName: 'Chef Elena Rostova',
    chefAvatarUrl: 'https://images.unsplash.com/photo-1583394838336-acd977736f90?auto=format&fit=crop&w=200&q=80',
    defaultServings: 2,
    isFeatured: true,
    isFavorite: false,
    nutrition: const NutritionInfo(
      calories: 410,
      proteinGrams: 22,
      carbsGrams: 30,
      fatGrams: 22,
      fiberGrams: 7,
    ),
    ingredients: [
      Ingredient(name: 'Artisan Sourdough', amount: 2, unit: 'slices', icon: '🍞'),
      Ingredient(name: 'Ripe Avocados', amount: 2, unit: 'whole', icon: '🥑'),
      Ingredient(name: 'Fresh Eggs', amount: 2, unit: 'large', icon: '🥚'),
      Ingredient(name: 'Smoked Salmon', amount: 100, unit: 'g', icon: '🐟'),
      Ingredient(name: 'Lemon Juice', amount: 1, unit: 'tbsp', icon: '🍋'),
      Ingredient(name: 'Chili Flakes & Dill', amount: 1, unit: 'tsp', icon: '🌶️'),
    ],
    steps: [
      CookingStep(
        stepNumber: 1,
        title: 'Toast Sourdough',
        description: 'Toast artisan sourdough slices until golden crispy on the outside and soft inside.',
        durationMinutes: 3,
      ),
      CookingStep(
        stepNumber: 2,
        title: 'Mash Avocado',
        description: 'In a small bowl, mash ripe avocados with fresh lemon juice, sea salt, and black pepper.',
        durationMinutes: 2,
      ),
      CookingStep(
        stepNumber: 3,
        title: 'Poach Eggs',
        description: 'Simmer water with 1 tbsp vinegar. Create a gentle whirlpool and slip eggs in one by one. Cook for 3 minutes for runny yolks.',
        durationMinutes: 3,
      ),
      CookingStep(
        stepNumber: 4,
        title: 'Assemble',
        description: 'Spread smashed avocado over warm toast, layer smoked salmon on top, place poached egg, and garnish with chili flakes.',
        durationMinutes: 2,
      ),
    ],
  ),
  Recipe(
    id: 'r3',
    title: 'Berry Acai Power Smoothie Bowl',
    description: 'Refreshing organic acai blended with frozen berries, topped with crunchy granola, chia seeds, fresh kiwi, and coconut flakes.',
    category: 'Healthy',
    imageUrl: 'https://images.unsplash.com/photo-1590301157890-4810ed352733?auto=format&fit=crop&w=800&q=80',
    rating: 4.7,
    reviewCount: 142,
    prepTimeMinutes: 10,
    cookTimeMinutes: 0,
    difficulty: 'Easy',
    chefName: 'Maya Lin',
    chefAvatarUrl: 'https://images.unsplash.com/photo-1544005313-94ddf0286df2?auto=format&fit=crop&w=200&q=80',
    defaultServings: 1,
    isFeatured: false,
    isFavorite: true,
    nutrition: const NutritionInfo(
      calories: 320,
      proteinGrams: 9,
      carbsGrams: 58,
      fatGrams: 8,
      fiberGrams: 11,
    ),
    ingredients: [
      Ingredient(name: 'Acai Packet', amount: 1, unit: 'pack', icon: '🫐'),
      Ingredient(name: 'Frozen Mixed Berries', amount: 150, unit: 'g', icon: '🍓'),
      Ingredient(name: 'Almond Milk', amount: 100, unit: 'ml', icon: '🥛'),
      Ingredient(name: 'Organic Granola', amount: 40, unit: 'g', icon: '🥣'),
      Ingredient(name: 'Chia Seeds', amount: 1, unit: 'tbsp', icon: '🌱'),
      Ingredient(name: 'Sliced Kiwi', amount: 1, unit: 'fruit', icon: '🥝'),
    ],
    steps: [
      CookingStep(
        stepNumber: 1,
        title: 'Blend Base',
        description: 'Combine acai, frozen berries, frozen banana slices, and almond milk in a high-speed blender. Blend until thick and smooth.',
        durationMinutes: 4,
      ),
      CookingStep(
        stepNumber: 2,
        title: 'Pour & Arrange Toppings',
        description: 'Pour thick smoothie mix into a cold serving bowl. Neatly line up granola, chia seeds, sliced kiwi, and berries on top.',
        durationMinutes: 4,
      ),
    ],
  ),
  Recipe(
    id: 'r4',
    title: 'Grilled Salmon with Honey Mustard',
    description: 'Juicy Atlantic salmon fillets glazed with honey whole-grain mustard, served alongside roasted asparagus and lemon butter sauce.',
    category: 'Lunch',
    imageUrl: 'https://images.unsplash.com/photo-1467003909585-2f8a72700288?auto=format&fit=crop&w=800&q=80',
    rating: 4.9,
    reviewCount: 410,
    prepTimeMinutes: 12,
    cookTimeMinutes: 15,
    difficulty: 'Medium',
    chefName: 'Chef Gordon Hayes',
    chefAvatarUrl: 'https://images.unsplash.com/photo-1560250097-0b93528c311a?auto=format&fit=crop&w=200&q=80',
    defaultServings: 2,
    isFeatured: true,
    isFavorite: false,
    nutrition: const NutritionInfo(
      calories: 480,
      proteinGrams: 38,
      carbsGrams: 14,
      fatGrams: 28,
      fiberGrams: 3,
    ),
    ingredients: [
      Ingredient(name: 'Salmon Fillets', amount: 2, unit: 'fillets', icon: '🐟'),
      Ingredient(name: 'Honey', amount: 2, unit: 'tbsp', icon: '🍯'),
      Ingredient(name: 'Whole Grain Mustard', amount: 2, unit: 'tbsp', icon: '🏺'),
      Ingredient(name: 'Fresh Asparagus', amount: 200, unit: 'g', icon: '🥬'),
      Ingredient(name: 'Olive Oil', amount: 2, unit: 'tbsp', icon: '🫒'),
      Ingredient(name: 'Fresh Lemon', amount: 1, unit: 'whole', icon: '🍋'),
    ],
    steps: [
      CookingStep(
        stepNumber: 1,
        title: 'Prepare Glaze',
        description: 'Whisk honey, whole grain mustard, olive oil, lemon zest, and minced garlic together in a bowl.',
        durationMinutes: 3,
      ),
      CookingStep(
        stepNumber: 2,
        title: 'Sear Salmon',
        description: 'Heat skillet over medium-high heat. Season salmon with salt and pepper. Sear skin side down for 5 minutes until crispy.',
        durationMinutes: 5,
      ),
      CookingStep(
        stepNumber: 3,
        title: 'Glaze & Roast',
        description: 'Brush glaze over fillets. Add asparagus to pan and transfer to preheated oven at 200°C for 6-8 minutes.',
        durationMinutes: 7,
      ),
    ],
  ),
  Recipe(
    id: 'r5',
    title: 'Molten Chocolate Lava Cake',
    description: 'Decadent warm dark chocolate cakes with a gooey flowing chocolate center, served with vanilla ice cream and raspberry drizzle.',
    category: 'Desserts',
    imageUrl: 'https://images.unsplash.com/photo-1606313564200-e75d5e30476c?auto=format&fit=crop&w=800&q=80',
    rating: 4.95,
    reviewCount: 520,
    prepTimeMinutes: 15,
    cookTimeMinutes: 12,
    difficulty: 'Hard',
    chefName: 'Claire Patissier',
    chefAvatarUrl: 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?auto=format&fit=crop&w=200&q=80',
    defaultServings: 4,
    isFeatured: false,
    isFavorite: false,
    nutrition: const NutritionInfo(
      calories: 610,
      proteinGrams: 8,
      carbsGrams: 64,
      fatGrams: 36,
      fiberGrams: 5,
    ),
    ingredients: [
      Ingredient(name: '70% Dark Chocolate', amount: 200, unit: 'g', icon: '🍫'),
      Ingredient(name: 'Unsalted Butter', amount: 100, unit: 'g', icon: '🧈'),
      Ingredient(name: 'Eggs & Yolks', amount: 4, unit: 'whole', icon: '🥚'),
      Ingredient(name: 'Powdered Sugar', amount: 100, unit: 'g', icon: '🍬'),
      Ingredient(name: 'All-Purpose Flour', amount: 40, unit: 'g', icon: '🌾'),
      Ingredient(name: 'Vanilla Gelato', amount: 4, unit: 'scoops', icon: '🍨'),
    ],
    steps: [
      CookingStep(
        stepNumber: 1,
        title: 'Melt Chocolate & Butter',
        description: 'Melt dark chocolate and butter together over a double boiler until smooth and glossy. Cool slightly.',
        durationMinutes: 5,
      ),
      CookingStep(
        stepNumber: 2,
        title: 'Whisk Eggs & Sugar',
        description: 'Whisk eggs, egg yolks, powdered sugar, and vanilla extract until pale and thick.',
        durationMinutes: 5,
      ),
      CookingStep(
        stepNumber: 3,
        title: 'Bake to Perfection',
        description: 'Fold chocolate mixture into eggs, sift in flour. Divide into buttered ramekins and bake at 210°C for 11 minutes until edges are set.',
        durationMinutes: 11,
      ),
    ],
  ),
  Recipe(
    id: 'r6',
    title: 'Iced Matcha Oat Milk Latte',
    description: 'Premium ceremonial grade Japanese Uji matcha whisked with warm water and poured over creamy chilled oat milk and vanilla syrup.',
    category: 'Drinks',
    imageUrl: 'https://images.unsplash.com/photo-1536256263959-770b48d82b0a?auto=format&fit=crop&w=800&q=80',
    rating: 4.85,
    reviewCount: 189,
    prepTimeMinutes: 5,
    cookTimeMinutes: 0,
    difficulty: 'Easy',
    chefName: 'Sora Takahashi',
    chefAvatarUrl: 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?auto=format&fit=crop&w=200&q=80',
    defaultServings: 1,
    isFeatured: false,
    isFavorite: false,
    nutrition: const NutritionInfo(
      calories: 140,
      proteinGrams: 3,
      carbsGrams: 18,
      fatGrams: 5,
      fiberGrams: 2,
    ),
    ingredients: [
      Ingredient(name: 'Ceremonial Matcha', amount: 1.5, unit: 'tsp', icon: '🍵'),
      Ingredient(name: 'Warm Water (80°C)', amount: 60, unit: 'ml', icon: '🫗'),
      Ingredient(name: 'Oat Milk', amount: 200, unit: 'ml', icon: '🥛'),
      Ingredient(name: 'Vanilla Bean Syrup', amount: 1, unit: 'tbsp', icon: '🫙'),
      Ingredient(name: 'Ice Cubes', amount: 6, unit: 'cubes', icon: '🧊'),
    ],
    steps: [
      CookingStep(
        stepNumber: 1,
        title: 'Whisk Matcha',
        description: 'Sift matcha powder into a bowl. Pour warm water and whisk vigorously in a "W" pattern using a bamboo whisk until frothy.',
        durationMinutes: 2,
      ),
      CookingStep(
        stepNumber: 2,
        title: 'Assemble Latte',
        description: 'Fill a tall glass with ice. Add oat milk and vanilla syrup. Gently layer the frothy matcha on top.',
        durationMinutes: 2,
      ),
    ],
  ),
];
