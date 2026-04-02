import 'package:flutter/material.dart';

void main() {
  runApp(const CafeApp());
}

class CafeApp extends StatelessWidget {
  const CafeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Кафе "У Flutter"',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.brown,
        ),
        useMaterial3: true,
      ),
      home: const CategoriesScreen(),
    );
  }
}

// ==============================
// МОДЕЛЬ ДАННЫХ
// ==============================

class Dish {
  final String name;
  final String description;
  final double price;
  final String emoji;
  final List<String> ingredients;

  const Dish({
    required this.name,
    required this.description,
    required this.price,
    required this.emoji,
    required this.ingredients,
  });
}

class Category {
  final String name;
  final String emoji;
  final Color color;
  final List<Dish> dishes;

  const Category({
    required this.name,
    required this.emoji,
    required this.color,
    required this.dishes,
  });
}

// ==============================
// ДАННЫЕ МЕНЮ
// ==============================

final List<Category> menuData = [
  Category(
    name: 'Завтраки',
    emoji: '🍳',
    color: Colors.orange,
    dishes: [
      Dish(
        name: 'Омлет с сыром',
        description: 'Пышный омлет из трёх яиц '
            'с тёртым сыром и зеленью.',
        price: 250,
        emoji: '🍳',
        ingredients: ['Яйца', 'Сыр', 'Молоко', 'Зелень'],
      ),
      Dish(
        name: 'Овсянка с ягодами',
        description: 'Овсяная каша на молоке '
            'со свежими ягодами и мёдом.',
        price: 200,
        emoji: '🥣',
        ingredients: ['Овсянка', 'Молоко', 'Ягоды', 'Мёд'],
      ),
      Dish(
        name: 'Блинчики',
        description: 'Тонкие блинчики с вареньем '
            'или сметаной на выбор.',
        price: 220,
        emoji: '🥞',
        ingredients: ['Мука', 'Яйца', 'Молоко', 'Варенье'],
      ),
    ],
  ),
  Category(
    name: 'Супы',
    emoji: '🍲',
    color: Colors.red,
    dishes: [
      Dish(
        name: 'Борщ',
        description: 'Наваристый борщ со сметаной '
            'и чесночными пампушками.',
        price: 320,
        emoji: '🍲',
        ingredients: ['Свёкла', 'Капуста', 'Картофель', 'Мясо', 'Сметана'],
      ),
      Dish(
        name: 'Куриный бульон',
        description: 'Лёгкий куриный бульон '
            'с лапшой и зеленью.',
        price: 280,
        emoji: '🍜',
        ingredients: ['Курица', 'Лапша', 'Морковь', 'Зелень'],
      ),
    ],
  ),
  Category(
    name: 'Напитки',
    emoji: '☕',
    color: Colors.brown,
    dishes: [
      Dish(
        name: 'Капучино',
        description: 'Классический капучино '
            'с молочной пенкой.',
        price: 180,
        emoji: '☕',
        ingredients: ['Эспрессо', 'Молоко'],
      ),
      Dish(
        name: 'Чай с лимоном',
        description: 'Чёрный чай с долькой лимона '
            'и мёдом.',
        price: 120,
        emoji: '🍵',
        ingredients: ['Чай', 'Лимон', 'Мёд'],
      ),
      Dish(
        name: 'Морс',
        description: 'Домашний ягодный морс '
            'из клюквы и брусники.',
        price: 150,
        emoji: '🧃',
        ingredients: ['Клюква', 'Брусника', 'Сахар'],
      ),
    ],
  ),
  Category(
    name: 'Десерты',
    emoji: '🍰',
    color: Colors.pink,
    dishes: [
      Dish(
        name: 'Чизкейк',
        description: 'Нежный чизкейк с ягодным '
            'соусом.',
        price: 350,
        emoji: '🍰',
        ingredients: ['Сливочный сыр', 'Печенье', 'Ягодный соус'],
      ),
      Dish(
        name: 'Тирамису',
        description: 'Итальянский десерт '
            'с маскарпоне и кофе.',
        price: 380,
        emoji: '🍮',
        ingredients: ['Маскарпоне', 'Савоярди', 'Кофе', 'Какао'],
      ),
    ],
  ),
  // ЗАДАНИЕ 1: Новая категория "Основные блюда"
  Category(
    name: 'Основные блюда',
    emoji: '🍖',
    color: Colors.green,
    dishes: [
      Dish(
        name: 'Стейк из говядины',
        description: 'Сочный стейк средней прожарки с овощами гриль.',
        price: 650,
        emoji: '🥩',
        ingredients: [
          'Говядина',
          'Оливковое масло',
          'Перец',
          'Соль',
          'Овощи гриль'
        ],
      ),
      Dish(
        name: 'Паста Карбонара',
        description: 'Спагетти с беконом в сливочном соусе и пармезаном.',
        price: 450,
        emoji: '🍝',
        ingredients: ['Спагетти', 'Бекон', 'Сливки', 'Пармезан', 'Яйцо'],
      ),
      Dish(
        name: 'Куриное филе с рисом',
        description: 'Нежное куриное филе с ароматным рисом и соусом терияки.',
        price: 420,
        emoji: '🍗',
        ingredients: ['Куриное филе', 'Рис', 'Соус терияки', 'Овощи'],
      ),
    ],
  ),
];

// ЗАДАНИЕ 2: Глобальная переменная корзины
List<Map<String, dynamic>> cart = [];

// ==============================
// ЭКРАН 1: КАТЕГОРИИ (с поиском)
// ==============================

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  String _searchText = '';
  final TextEditingController _searchController = TextEditingController();

  List<Dish> _getFilteredDishes() {
    if (_searchText.isEmpty) return [];

    return menuData
        .expand((cat) => cat.dishes)
        .where((dish) =>
            dish.name.toLowerCase().contains(_searchText.toLowerCase()))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final filteredDishes = _getFilteredDishes();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Кафе "У Flutter"'),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        actions: [
          // ЗАДАНИЕ 2: Иконка корзины в AppBar
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const CartScreen()),
              );
            },
            icon: Badge(
              label: Text('${cart.length}'),
              isLabelVisible: cart.isNotEmpty,
              child: const Icon(Icons.shopping_cart),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // ЗАДАНИЕ 3: Поле поиска
          Padding(
            padding: const EdgeInsets.all(16),
            child: SearchBar(
              controller: _searchController,
              hintText: 'Поиск блюд...',
              leading: const Icon(Icons.search),
              onChanged: (value) {
                setState(() {
                  _searchText = value;
                });
              },
              trailing: [
                if (_searchText.isNotEmpty)
                  IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () {
                      setState(() {
                        _searchText = '';
                        _searchController.clear();
                      });
                    },
                  ),
              ],
            ),
          ),

          // Результаты поиска или список категорий
          Expanded(
            child: _searchText.isNotEmpty
                ? _buildSearchResults(filteredDishes)
                : _buildCategoriesList(),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoriesList() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: menuData.length,
      itemBuilder: (context, index) {
        final category = menuData[index];
        return _buildCategoryCard(context, category);
      },
    );
  }

  Widget _buildSearchResults(List<Dish> filteredDishes) {
    if (filteredDishes.isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.search_off, size: 64, color: Colors.grey),
            SizedBox(height: 16),
            Text(
              'Ничего не найдено',
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: filteredDishes.length,
      itemBuilder: (context, index) {
        final dish = filteredDishes[index];
        return _buildSearchResultCard(context, dish);
      },
    );
  }

  Widget _buildCategoryCard(BuildContext context, Category category) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DishesScreen(category: category),
            ),
          );
        },
        child: Container(
          height: 100,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                category.color.withOpacity(0.7),
                category.color.withOpacity(0.3),
              ],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Text(
                  category.emoji,
                  style: const TextStyle(fontSize: 44),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        category.name,
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${category.dishes.length} позиций',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white.withOpacity(0.8),
                        ),
                      ),
                    ],
                  ),
                ),
                const Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.white70,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSearchResultCard(BuildContext context, Dish dish) {
    // Находим категорию блюда для цвета
    final category = menuData.firstWhere(
      (cat) => cat.dishes.contains(dish),
      orElse: () => menuData.first,
    );

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DishDetailScreen(
                dish: dish,
                categoryColor: category.color,
              ),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: category.color.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Text(
                    dish.emoji,
                    style: const TextStyle(fontSize: 28),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      dish.name,
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      dish.description,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: category.color.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  '${dish.price.toInt()} ₽',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: category.color,
                    fontSize: 15,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ==============================
// ЭКРАН 2: СПИСОК БЛЮД
// ==============================

class DishesScreen extends StatelessWidget {
  final Category category;

  const DishesScreen({
    super.key,
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${category.emoji} ${category.name}'),
        backgroundColor: category.color.withOpacity(0.3),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const CartScreen()),
              );
            },
            icon: Badge(
              label: Text('${cart.length}'),
              isLabelVisible: cart.isNotEmpty,
              child: const Icon(Icons.shopping_cart),
            ),
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: category.dishes.length,
        itemBuilder: (context, index) {
          final dish = category.dishes[index];
          return _buildDishCard(context, dish);
        },
      ),
    );
  }

  Widget _buildDishCard(BuildContext context, Dish dish) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DishDetailScreen(
                dish: dish,
                categoryColor: category.color,
              ),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: category.color.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Text(
                    dish.emoji,
                    style: const TextStyle(fontSize: 28),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      dish.name,
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      dish.description,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: category.color.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  '${dish.price.toInt()} ₽',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: category.color,
                    fontSize: 15,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ==============================
// ЭКРАН 3: КАРТОЧКА БЛЮДА
// ==============================

class DishDetailScreen extends StatefulWidget {
  final Dish dish;
  final Color categoryColor;

  const DishDetailScreen({
    super.key,
    required this.dish,
    required this.categoryColor,
  });

  @override
  State<DishDetailScreen> createState() => _DishDetailScreenState();
}

class _DishDetailScreenState extends State<DishDetailScreen> {
  int _quantity = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.dish.name),
        backgroundColor: widget.categoryColor.withOpacity(0.3),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const CartScreen()),
              );
            },
            icon: Badge(
              label: Text('${cart.length}'),
              isLabelVisible: cart.isNotEmpty,
              child: const Icon(Icons.shopping_cart),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // --- Большой баннер с эмодзи ---
            Container(
              height: 200,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    widget.categoryColor.withOpacity(0.4),
                    widget.categoryColor.withOpacity(0.1),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: Center(
                child: Text(
                  widget.dish.emoji,
                  style: const TextStyle(fontSize: 100),
                ),
              ),
            ),

            // --- Основная информация ---
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Название
                  Text(
                    widget.dish.name,
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  // Цена
                  Text(
                    '${widget.dish.price.toInt()} ₽',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: widget.categoryColor,
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Описание
                  Text(
                    widget.dish.description,
                    style: const TextStyle(
                      fontSize: 16,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 24),

                  // --- Ингредиенты ---
                  const Text(
                    'Состав:',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: widget.dish.ingredients
                        .map(
                          (item) => Chip(
                            avatar: Icon(
                              Icons.check_circle,
                              size: 18,
                              color: widget.categoryColor,
                            ),
                            label: Text(item),
                          ),
                        )
                        .toList(),
                  ),
                  const SizedBox(height: 32),

                  // --- Выбор количества ---
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: () {
                          if (_quantity > 1) {
                            setState(() {
                              _quantity--;
                            });
                          }
                        },
                        icon: const Icon(Icons.remove_circle_outline),
                        iconSize: 36,
                        color: widget.categoryColor,
                      ),
                      const SizedBox(width: 16),
                      Text(
                        '$_quantity',
                        style: const TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 16),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            _quantity++;
                          });
                        },
                        icon: const Icon(Icons.add_circle_outline),
                        iconSize: 36,
                        color: widget.categoryColor,
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // --- Кнопка заказа ---
                  SizedBox(
                    width: double.infinity,
                    height: 54,
                    child: ElevatedButton(
                      onPressed: () {
                        final total = widget.dish.price * _quantity;

                        // ЗАДАНИЕ 2: Добавление в корзину
                        cart.add({
                          'name': widget.dish.name,
                          'price': widget.dish.price,
                          'quantity': _quantity,
                          'emoji': widget.dish.emoji,
                        });

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              '${widget.dish.name}'
                              ' x$_quantity'
                              ' = ${total.toInt()} ₽'
                              ' добавлено в заказ!',
                            ),
                            backgroundColor: widget.categoryColor,
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: widget.categoryColor,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        'В заказ — '
                        '${(widget.dish.price * _quantity).toInt()} ₽',
                        style: const TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ==============================
// ЗАДАНИЕ 2: ЭКРАН КОРЗИНЫ
// ==============================

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  double _getTotalPrice() {
    return cart.fold(
        0, (sum, item) => sum + (item['price'] * item['quantity']));
  }

  void _removeFromCart(int index) {
    setState(() {
      cart.removeAt(index);
    });
  }

  void _clearCart() {
    setState(() {
      cart.clear();
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Корзина очищена'),
        backgroundColor: Colors.green,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Корзина'),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        actions: [
          if (cart.isNotEmpty)
            IconButton(
              onPressed: _clearCart,
              icon: const Icon(Icons.delete_sweep),
              tooltip: 'Очистить корзину',
            ),
        ],
      ),
      body: cart.isEmpty
          ? const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.shopping_cart_outlined,
                      size: 80, color: Colors.grey),
                  SizedBox(height: 16),
                  Text(
                    'Корзина пуста',
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Добавьте блюда из меню',
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                ],
              ),
            )
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: cart.length,
                    itemBuilder: (context, index) {
                      final item = cart[index];
                      return Card(
                        margin: const EdgeInsets.only(bottom: 12),
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Row(
                            children: [
                              // Эмодзи блюда
                              Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Center(
                                  child: Text(
                                    item['emoji'],
                                    style: const TextStyle(fontSize: 24),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              // Информация о блюде
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      item['name'],
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      '${item['price'].toInt()} ₽ × ${item['quantity']}',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              // Итоговая цена и удаление
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    '${(item['price'] * item['quantity']).toInt()} ₽',
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.green,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  IconButton(
                                    onPressed: () => _removeFromCart(index),
                                    icon:
                                        const Icon(Icons.remove_circle_outline),
                                    color: Colors.red,
                                    iconSize: 20,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                // Итоговая сумма и кнопка заказа
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        blurRadius: 8,
                        offset: const Offset(0, -2),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Итого:',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '${_getTotalPrice().toInt()} ₽',
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        width: double.infinity,
                        height: 54,
                        child: ElevatedButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: const Text('Заказ оформлен!'),
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text('Ваш заказ принят.'),
                                    const SizedBox(height: 8),
                                    Text(
                                      'Сумма заказа: ${_getTotalPrice().toInt()} ₽',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.green,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    const Text('Спасибо за покупку!'),
                                  ],
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      setState(() {
                                        cart.clear();
                                      });
                                      Navigator.pop(context);
                                      Navigator.pop(context);
                                    },
                                    child: const Text('OK'),
                                  ),
                                ],
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: const Text(
                            'Оформить заказ',
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
