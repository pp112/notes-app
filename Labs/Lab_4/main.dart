import 'package:flutter/material.dart';

void main() {
  runApp(const FitDayApp());
}

class FitDayApp extends StatelessWidget {
  const FitDayApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FitDay',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.teal,
        ),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}

// ==============================
// МОДЕЛЬ ДАННЫХ
// ==============================

class Exercise {
  String name;
  String emoji;
  int sets;
  int reps;
  int calories;
  bool isDone;

  Exercise({
    required this.name,
    required this.emoji,
    required this.sets,
    required this.reps,
    required this.calories,
    this.isDone = false,
  });
}

// ==============================
// ДАННЫЕ ТРЕНИРОВКИ
// ==============================

List<Exercise> todayWorkout = [
  Exercise(
    name: 'Отжимания',
    emoji: '💪',
    sets: 3,
    reps: 15,
    calories: 50,
  ),
  Exercise(
    name: 'Приседания',
    emoji: '🧎',
    sets: 4,
    reps: 20,
    calories: 70,
  ),
  Exercise(
    name: 'Планка',
    emoji: '🧘',
    sets: 3,
    reps: 1,
    calories: 40,
  ),
  Exercise(
    name: 'Бёрпи',
    emoji: '🔥',
    sets: 3,
    reps: 10,
    calories: 90,
  ),
  Exercise(
    name: 'Скручивания',
    emoji: '🏋',
    sets: 3,
    reps: 20,
    calories: 45,
  ),
  Exercise(
    name: 'Выпады',
    emoji: '🏃',
    sets: 3,
    reps: 12,
    calories: 60,
  ),
];

// Цель по калориям (изменяется в настройках)
int calorieGoal = 300;

// История тренировок
List<Map<String, dynamic>> history = [];

// Начальные данные тренировки
List<Exercise> getInitialWorkout() => [
      Exercise(
        name: 'Отжимания',
        emoji: '💪',
        sets: 3,
        reps: 15,
        calories: 50,
      ),
      Exercise(
        name: 'Приседания',
        emoji: '🧎',
        sets: 4,
        reps: 20,
        calories: 70,
      ),
      Exercise(
        name: 'Планка',
        emoji: '🧘',
        sets: 3,
        reps: 1,
        calories: 40,
      ),
      Exercise(
        name: 'Бёрпи',
        emoji: '🔥',
        sets: 3,
        reps: 10,
        calories: 90,
      ),
      Exercise(
        name: 'Скручивания',
        emoji: '🏋',
        sets: 3,
        reps: 20,
        calories: 45,
      ),
      Exercise(
        name: 'Выпады',
        emoji: '🏃',
        sets: 3,
        reps: 12,
        calories: 60,
      ),
    ];

// ==============================
// ГЛАВНЫЙ ЭКРАН С ВКЛАДКАМИ
// ==============================

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: 4, // Изменено на 4
      vsync: this,
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _refresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FitDay'),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(
              icon: Icon(Icons.fitness_center),
              text: 'Тренировка',
            ),
            Tab(
              icon: Icon(Icons.bar_chart),
              text: 'Прогресс',
            ),
            Tab(
              icon: Icon(Icons.settings),
              text: 'Настройки',
            ),
            Tab(
              icon: Icon(Icons.history),
              text: 'История',
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          WorkoutTab(onChanged: _refresh),
          const ProgressTab(),
          SettingsTab(onChanged: _refresh),
          HistoryTab(onChanged: _refresh),
        ],
      ),
    );
  }
}

// ==============================
// ВКЛАДКА 1: ТРЕНИРОВКА
// ==============================

class WorkoutTab extends StatefulWidget {
  final VoidCallback onChanged;

  const WorkoutTab({
    super.key,
    required this.onChanged,
  });

  @override
  State<WorkoutTab> createState() => _WorkoutTabState();
}

class _WorkoutTabState extends State<WorkoutTab> {
  void _addExercise() {
    final nameController = TextEditingController();
    final setsController = TextEditingController(text: '3');
    final repsController = TextEditingController(text: '10');

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Новое упражнение'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: 'Название',
                hintText: 'Например: Подтягивания',
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: setsController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Подходы',
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: TextField(
                    controller: repsController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Повторения',
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Отмена'),
          ),
          FilledButton(
            onPressed: () {
              if (nameController.text.isNotEmpty) {
                setState(() {
                  todayWorkout.add(Exercise(
                    name: nameController.text,
                    emoji: '⭐',
                    sets: int.tryParse(setsController.text) ?? 3,
                    reps: int.tryParse(repsController.text) ?? 10,
                    calories: 30,
                  ));
                });
                widget.onChanged();
                Navigator.pop(context);
              }
            },
            child: const Text('Добавить'),
          ),
        ],
      ),
    );
  }

  void _completeDay() {
    final doneCount = todayWorkout.where((e) => e.isDone).length;
    final totalCalories = todayWorkout
        .where((e) => e.isDone)
        .fold(0, (sum, e) => sum + e.calories);

    if (doneCount == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Выполните хотя бы одно упражнение!'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Завершить день?'),
        content: Text(
          'Выполнено: $doneCount упражнений\n'
          'Сожжено: $totalCalories ккал\n\n'
          'Тренировка будет сохранена в истории.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Отмена'),
          ),
          FilledButton(
            onPressed: () {
              // Сохраняем в историю
              history.add({
                'date': DateTime.now().toString().substring(0, 10),
                'exercises': doneCount,
                'calories': totalCalories,
              });

              // Сбрасываем текущую тренировку
              setState(() {
                todayWorkout.clear();
                todayWorkout.addAll(getInitialWorkout());
              });

              widget.onChanged();
              Navigator.pop(context);

              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('День завершён! Тренировка сохранена.'),
                  backgroundColor: Colors.green,
                ),
              );
            },
            child: const Text('Завершить'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final doneCount = todayWorkout.where((e) => e.isDone).length;

    return Scaffold(
      body: Column(
        children: [
          // --- Заголовок-статистика ---
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            color:
                Theme.of(context).colorScheme.primaryContainer.withOpacity(0.3),
            child: Column(
              children: [
                Text(
                  'Сегодня: $doneCount '
                  'из ${todayWorkout.length}',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: LinearProgressIndicator(
                    value: todayWorkout.isEmpty
                        ? 0
                        : doneCount / todayWorkout.length,
                    minHeight: 12,
                    backgroundColor: Colors.grey[300],
                  ),
                ),
                const SizedBox(height: 12),
                // Кнопка завершения дня
                ElevatedButton.icon(
                  onPressed: _completeDay,
                  icon: const Icon(Icons.check_circle),
                  label: const Text('Завершить день'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          // --- Список упражнений ---
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: todayWorkout.length,
              itemBuilder: (context, index) {
                final ex = todayWorkout[index];
                return Card(
                  color: ex.isDone ? Colors.teal.withOpacity(0.1) : null,
                  margin: const EdgeInsets.only(bottom: 8),
                  child: ListTile(
                    leading: Text(
                      ex.emoji,
                      style: const TextStyle(fontSize: 32),
                    ),
                    title: Text(
                      ex.name,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        decoration:
                            ex.isDone ? TextDecoration.lineThrough : null,
                      ),
                    ),
                    subtitle: Text(
                      '${ex.sets} подходов '
                      '× ${ex.reps} повт. '
                      '| ${ex.calories} ккал',
                    ),
                    trailing: Switch(
                      value: ex.isDone,
                      onChanged: (val) {
                        setState(() {
                          ex.isDone = val;
                        });
                        widget.onChanged();
                      },
                    ),
                    onTap: () {
                      // Открываем таймер при нажатии
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TimerScreen(
                            exerciseName: ex.name,
                            sets: ex.sets,
                          ),
                        ),
                      ).then((_) => widget.onChanged());
                    },
                    onLongPress: () {
                      // Удаление упражнения
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text('Удалить упражнение'),
                          content: Text(
                            'Вы уверены, что хотите удалить "${ex.name}"?',
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text('Отмена'),
                            ),
                            FilledButton(
                              onPressed: () {
                                setState(() {
                                  todayWorkout.removeAt(index);
                                });
                                widget.onChanged();
                                Navigator.pop(context);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('${ex.name} удалено'),
                                    backgroundColor: Colors.red,
                                  ),
                                );
                              },
                              child: const Text('Удалить'),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addExercise,
        child: const Icon(Icons.add),
      ),
    );
  }
}

// ==============================
// ЭКРАН ТАЙМЕРА (ИСПРАВЛЕННЫЙ)
// ==============================

class TimerScreen extends StatefulWidget {
  final String exerciseName;
  final int sets;

  const TimerScreen({
    super.key,
    required this.exerciseName,
    required this.sets,
  });

  @override
  State<TimerScreen> createState() => _TimerScreenState();
}

class _TimerScreenState extends State<TimerScreen> {
  int _currentSet = 1;
  int _secondsRemaining = 30;
  bool _isRunning = false;
  late int _totalSeconds;

  @override
  void initState() {
    super.initState();
    _totalSeconds = _secondsRemaining;
  }

  void _startTimer() {
    if (_isRunning) return;
    _isRunning = true;
    _runTimer();
  }

  void _runTimer() {
    Future.delayed(const Duration(seconds: 1), () {
      if (_isRunning && mounted) {
        if (_secondsRemaining > 0) {
          setState(() {
            _secondsRemaining--;
          });
          _runTimer();
        } else {
          // Время вышло
          setState(() {
            _isRunning = false;
          });
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Подход $_currentSet завершён!'),
              backgroundColor: Colors.green,
              duration: const Duration(seconds: 2),
            ),
          );

          // Переход к следующему подходу
          if (_currentSet < widget.sets) {
            setState(() {
              _currentSet++;
              _secondsRemaining = 30;
              _totalSeconds = 30;
            });
          } else {
            // Все подходы завершены
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text('Тренировка завершена!'),
                content: Text(
                  'Поздравляем! Вы выполнили ${widget.sets} подходов '
                  'упражнения "${widget.exerciseName}".',
                ),
                actions: [
                  FilledButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Отлично!'),
                  ),
                ],
              ),
            );
          }
        }
      }
    });
  }

  void _pauseTimer() {
    setState(() {
      _isRunning = false;
    });
  }

  void _resetTimer() {
    setState(() {
      _isRunning = false;
      _secondsRemaining = 30;
      _totalSeconds = 30;
      _currentSet = 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Таймер: ${widget.exerciseName}'),
        backgroundColor: Colors.teal,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Подход $_currentSet из ${widget.sets}',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 40),
            Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: 250,
                  height: 250,
                  child: CircularProgressIndicator(
                    value: _secondsRemaining / _totalSeconds,
                    strokeWidth: 8,
                    backgroundColor: Colors.grey[300],
                    valueColor:
                        const AlwaysStoppedAnimation<Color>(Colors.teal),
                  ),
                ),
                Text(
                  '${(_secondsRemaining ~/ 60).toString().padLeft(2, '0')}:'
                  '${(_secondsRemaining % 60).toString().padLeft(2, '0')}',
                  style: const TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (!_isRunning)
                  ElevatedButton.icon(
                    onPressed: _startTimer,
                    icon: const Icon(Icons.play_arrow),
                    label: const Text('Старт'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 12,
                      ),
                    ),
                  ),
                if (_isRunning)
                  ElevatedButton.icon(
                    onPressed: _pauseTimer,
                    icon: const Icon(Icons.pause),
                    label: const Text('Пауза'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 12,
                      ),
                    ),
                  ),
                const SizedBox(width: 16),
                ElevatedButton.icon(
                  onPressed: _resetTimer,
                  icon: const Icon(Icons.refresh),
                  label: const Text('Сброс'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 12,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// ==============================
// ВКЛАДКА 2: ПРОГРЕСС
// ==============================

class ProgressTab extends StatelessWidget {
  const ProgressTab({super.key});

  @override
  Widget build(BuildContext context) {
    final doneCount = todayWorkout.where((e) => e.isDone).length;
    final totalCalories = todayWorkout
        .where((e) => e.isDone)
        .fold(0, (sum, e) => sum + e.calories);
    final totalMinutes = doneCount * 5;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Прогресс за сегодня',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),

          // --- Карточка: упражнения ---
          _buildGoalCard(
            context,
            emoji: '🎯',
            title: 'Упражнения',
            current: doneCount,
            goal: todayWorkout.length,
            unit: 'шт.',
            color: Colors.teal,
          ),
          const SizedBox(height: 12),

          // --- Карточка: калории ---
          _buildGoalCard(
            context,
            emoji: '🔥',
            title: 'Калории',
            current: totalCalories,
            goal: calorieGoal,
            unit: 'ккал',
            color: Colors.orange,
          ),
          const SizedBox(height: 12),

          // --- Карточка: время ---
          _buildGoalCard(
            context,
            emoji: '⏱',
            title: 'Время',
            current: totalMinutes,
            goal: 45,
            unit: 'мин',
            color: Colors.blue,
          ),
          const SizedBox(height: 24),

          // --- Список выполненных ---
          const Text(
            'Выполнено:',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          ...todayWorkout.where((e) => e.isDone).map((e) => Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: Row(
                  children: [
                    Text(e.emoji, style: const TextStyle(fontSize: 20)),
                    const SizedBox(width: 8),
                    Text(
                      '${e.name} — '
                      '${e.calories} ккал',
                      style: const TextStyle(fontSize: 15),
                    ),
                  ],
                ),
              )),
          if (doneCount == 0)
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Text(
                'Пока ничего. '
                'Отметьте упражнения '
                'на вкладке "Тренировка"!',
                style: TextStyle(
                  color: Colors.grey[500],
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildGoalCard(
    BuildContext context, {
    required String emoji,
    required String title,
    required int current,
    required int goal,
    required String unit,
    required Color color,
  }) {
    final progress = goal > 0 ? (current / goal).clamp(0.0, 1.0) : 0.0;
    final percent = (progress * 100).toInt();

    return Card(
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: [
          // Фоновый градиент
          Container(
            height: 110,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  color.withOpacity(0.15),
                  color.withOpacity(0.05),
                ],
              ),
            ),
          ),
          // Контент поверх
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(emoji, style: const TextStyle(fontSize: 28)),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        title,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Text(
                      '$percent%',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: color,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child: LinearProgressIndicator(
                    value: progress,
                    minHeight: 10,
                    backgroundColor: Colors.grey[300],
                    valueColor: AlwaysStoppedAnimation(color),
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  '$current / $goal $unit',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 13,
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

// ==============================
// ВКЛАДКА 3: НАСТРОЙКИ
// ==============================

class SettingsTab extends StatefulWidget {
  final VoidCallback onChanged;

  const SettingsTab({
    super.key,
    required this.onChanged,
  });

  @override
  State<SettingsTab> createState() => _SettingsTabState();
}

class _SettingsTabState extends State<SettingsTab> {
  bool _notifications = true;
  bool _sound = false;
  bool _vibration = true;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Настройки',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),

          // --- Секция: Уведомления ---
          Card(
            child: Column(
              children: [
                SwitchListTile(
                  title: const Text('Уведомления'),
                  subtitle: const Text('Напоминания о тренировке'),
                  secondary: const Icon(Icons.notifications),
                  value: _notifications,
                  onChanged: (val) {
                    setState(() {
                      _notifications = val;
                    });
                  },
                ),
                const Divider(height: 1),
                SwitchListTile(
                  title: const Text('Звук'),
                  subtitle: const Text('Звуковые эффекты'),
                  secondary: const Icon(Icons.volume_up),
                  value: _sound,
                  onChanged: (val) {
                    setState(() {
                      _sound = val;
                    });
                  },
                ),
                const Divider(height: 1),
                SwitchListTile(
                  title: const Text('Вибрация'),
                  subtitle: const Text('При выполнении упражнения'),
                  secondary: const Icon(Icons.vibration),
                  value: _vibration,
                  onChanged: (val) {
                    setState(() {
                      _vibration = val;
                    });
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // --- Секция: Цель калорий ---
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.local_fire_department,
                          color: Colors.orange),
                      const SizedBox(width: 8),
                      const Text(
                        'Цель по калориям',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Spacer(),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.orange.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          '$calorieGoal ккал',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.orange,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Slider(
                    value: calorieGoal.toDouble(),
                    min: 100,
                    max: 800,
                    divisions: 14,
                    label: '$calorieGoal ккал',
                    onChanged: (val) {
                      setState(() {
                        calorieGoal = val.toInt();
                      });
                      widget.onChanged();
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('100 ккал',
                          style:
                              TextStyle(color: Colors.grey[500], fontSize: 12)),
                      Text('800 ккал',
                          style:
                              TextStyle(color: Colors.grey[500], fontSize: 12)),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),

          // --- Секция: О приложении ---
          Card(
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.info_outline),
                  title: const Text('О приложении'),
                  subtitle: const Text('FitDay v1.0 — '
                      'Лабораторная работа №3'),
                ),
                const Divider(height: 1),
                ListTile(
                  leading: const Icon(Icons.delete_outline, color: Colors.red),
                  title: const Text(
                    'Сбросить тренировку',
                    style: TextStyle(color: Colors.red),
                  ),
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('Подтверждение'),
                        content: const Text(
                          'Сбросить все '
                          'отметки выполнения?',
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text('Отмена'),
                          ),
                          FilledButton(
                            onPressed: () {
                              for (var e in todayWorkout) {
                                e.isDone = false;
                              }
                              setState(() {});
                              widget.onChanged();
                              Navigator.pop(context);
                            },
                            child: const Text('Сбросить'),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ==============================
// ВКЛАДКА 4: ИСТОРИЯ
// ==============================

class HistoryTab extends StatelessWidget {
  final VoidCallback onChanged;

  const HistoryTab({
    super.key,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    if (history.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.history,
              size: 80,
              color: Colors.grey[400],
            ),
            const SizedBox(height: 16),
            Text(
              'История пуста',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Завершите день на вкладке "Тренировка",\nчтобы сохранить результаты',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey[500],
              ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: history.length,
      itemBuilder: (context, index) {
        final day = history[history.length - 1 - index]; // Новые сверху
        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.calendar_today, size: 20),
                    const SizedBox(width: 8),
                    Text(
                      day['date'],
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          const Icon(Icons.fitness_center, color: Colors.teal),
                          const SizedBox(height: 4),
                          Text(
                            '${day['exercises']}',
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Text('упражнений'),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          const Icon(Icons.local_fire_department,
                              color: Colors.orange),
                          const SizedBox(height: 4),
                          Text(
                            '${day['calories']}',
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Text('калорий'),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
