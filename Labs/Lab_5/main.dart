import 'package:flutter/material.dart';

void main() {
  runApp(const EventHubApp());
}

class EventHubApp extends StatelessWidget {
  const EventHubApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EventHub',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
        ),
        useMaterial3: true,
      ),
      home: const EventListScreen(),
    );
  }
}

// ==============================
// МОДЕЛЬ ДАННЫХ
// ==============================

class EventCategory {
  final String name;
  final IconData icon;
  final Color color;

  const EventCategory({
    required this.name,
    required this.icon,
    required this.color,
  });
}

class Event {
  String title;
  String description;
  String location;
  EventCategory category;
  DateTime date;
  TimeOfDay time;
  List<String> participants;
  String emoji;

  Event({
    required this.title,
    required this.description,
    required this.location,
    required this.category,
    required this.date,
    required this.time,
    required this.participants,
    required this.emoji,
  });
}

// ==============================
// КАТЕГОРИИ
// ==============================

const categories = [
  EventCategory(
    name: 'Учёба',
    icon: Icons.school,
    color: Colors.blue,
  ),
  EventCategory(
    name: 'Спорт',
    icon: Icons.sports_soccer,
    color: Colors.green,
  ),
  EventCategory(
    name: 'Развлечения',
    icon: Icons.celebration,
    color: Colors.orange,
  ),
  EventCategory(
    name: 'Работа',
    icon: Icons.work,
    color: Colors.red,
  ),
  EventCategory(
    name: 'Личное',
    icon: Icons.favorite,
    color: Colors.pink,
  ),
];

// ==============================
// НАЧАЛЬНЫЕ ДАННЫЕ
// ==============================

List<Event> events = [
  Event(
    title: 'Лекция по Flutter',
    description: 'Лабораторная работа №4. '
        'Создание приложения EventHub '
        'с использованием GridView, '
        'BottomSheet и других виджетов.',
    location: 'Аудитория 305',
    category: categories[0],
    date: DateTime.now(),
    time: const TimeOfDay(hour: 9, minute: 0),
    participants: [
      'Иванов А.',
      'Петрова Б.',
      'Сидоров В.',
    ],
    emoji: '📚',
  ),
  Event(
    title: 'Футбол с друзьями',
    description: 'Товарищеский матч 5 на 5. '
        'Не забудь форму и воду!',
    location: 'Стадион «Спартак»',
    category: categories[1],
    date: DateTime.now().add(const Duration(days: 1)),
    time: const TimeOfDay(hour: 18, minute: 30),
    participants: [
      'Команда А',
      'Команда Б',
    ],
    emoji: '⚽',
  ),
  Event(
    title: 'Кинопремьера',
    description: 'Новый фильм в IMAX. '
        'Билеты уже куплены, ряд 7.',
    location: 'Кинотеатр «Синема Парк»',
    category: categories[2],
    date: DateTime.now().add(const Duration(days: 2)),
    time: const TimeOfDay(hour: 20, minute: 0),
    participants: [
      'Аня',
      'Максим',
      'Даша',
    ],
    emoji: '🎬',
  ),
  Event(
    title: 'Митап по мобильной разработке',
    description: 'Доклады: Compose vs Flutter, '
        'архитектура чистого кода, '
        'CI/CD для мобильных приложений.',
    location: 'Коворкинг «Точка кипения»',
    category: categories[3],
    date: DateTime.now().add(const Duration(days: 3)),
    time: const TimeOfDay(hour: 19, minute: 0),
    participants: [
      'Спикер 1',
      'Спикер 2',
      '~50 участников',
    ],
    emoji: '💻',
  ),
  Event(
    title: 'День рождения Маши',
    description: 'Собираемся у Маши дома. '
        'Подарок: книга по Dart.',
    location: 'ул. Ленина, 42',
    category: categories[4],
    date: DateTime.now().add(const Duration(days: 5)),
    time: const TimeOfDay(hour: 17, minute: 0),
    participants: [
      'Маша',
      'Ваня',
      'Катя',
      'Олег',
      'Лиза',
    ],
    emoji: '🎂',
  ),
  Event(
    title: 'Защита курсовой',
    description: 'Финальная защита курсовой '
        'работы по дисциплине '
        '«Мобильная разработка».',
    location: 'Аудитория 112',
    category: categories[0],
    date: DateTime.now().add(const Duration(days: 7)),
    time: const TimeOfDay(hour: 10, minute: 0),
    participants: [
      'Группа ИСТ-21',
      'Преподаватель',
    ],
    emoji: '🎓',
  ),
];

// ==============================
// ГЛАВНЫЙ ЭКРАН
// ==============================

class EventListScreen extends StatefulWidget {
  const EventListScreen({super.key});

  @override
  State<EventListScreen> createState() => _EventListScreenState();
}

class _EventListScreenState extends State<EventListScreen> {
  String _selectedCategory = 'Все';
  String _searchQuery = '';
  String _sortBy = 'date'; // date, title, category

  List<Event> get _filteredEvents {
    List<Event> filtered = events;

    // Фильтрация по категории
    if (_selectedCategory != 'Все') {
      filtered =
          filtered.where((e) => e.category.name == _selectedCategory).toList();
    }

    // Фильтрация по поиску
    if (_searchQuery.isNotEmpty) {
      filtered = filtered
          .where(
              (e) => e.title.toLowerCase().contains(_searchQuery.toLowerCase()))
          .toList();
    }

    // Сортировка
    if (_sortBy == 'date') {
      filtered.sort((a, b) => a.date.compareTo(b.date));
    } else if (_sortBy == 'title') {
      filtered.sort((a, b) => a.title.compareTo(b.title));
    } else if (_sortBy == 'category') {
      filtered.sort((a, b) => a.category.name.compareTo(b.category.name));
    }

    return filtered;
  }

  // --- Форматирование даты ---
  String _formatDate(DateTime d) {
    final months = [
      '',
      'янв',
      'фев',
      'мар',
      'апр',
      'май',
      'июн',
      'июл',
      'авг',
      'сен',
      'окт',
      'ноя',
      'дек',
    ];
    return '${d.day} ${months[d.month]}';
  }

  String _formatTime(TimeOfDay t) {
    final h = t.hour.toString().padLeft(2, '0');
    final m = t.minute.toString().padLeft(2, '0');
    return '$h:$m';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _searchQuery.isEmpty
            ? const Text('EventHub')
            : TextField(
                autofocus: true,
                decoration: const InputDecoration(
                  hintText: 'Поиск...',
                  border: InputBorder.none,
                  hintStyle: TextStyle(color: Colors.white70),
                ),
                style: const TextStyle(color: Colors.white),
                onChanged: (value) {
                  setState(() {
                    _searchQuery = value;
                  });
                },
              ),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        actions: [
          // Кнопка поиска
          IconButton(
            icon: Icon(_searchQuery.isEmpty ? Icons.search : Icons.close),
            onPressed: () {
              setState(() {
                if (_searchQuery.isNotEmpty) {
                  _searchQuery = '';
                } else {
                  _searchQuery = ' ';
                }
              });
            },
          ),
          // Кнопка сортировки
          PopupMenuButton<String>(
            icon: const Icon(Icons.sort),
            onSelected: (value) {
              setState(() {
                _sortBy = value;
              });
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'date',
                child: Row(
                  children: [
                    Icon(Icons.calendar_today, size: 20),
                    SizedBox(width: 8),
                    Text('По дате'),
                  ],
                ),
              ),
              const PopupMenuItem(
                value: 'title',
                child: Row(
                  children: [
                    Icon(Icons.title, size: 20),
                    SizedBox(width: 8),
                    Text('По названию'),
                  ],
                ),
              ),
              const PopupMenuItem(
                value: 'category',
                child: Row(
                  children: [
                    Icon(Icons.category, size: 20),
                    SizedBox(width: 8),
                    Text('По категории'),
                  ],
                ),
              ),
            ],
          ),
          // Кнопка статистики
          IconButton(
            icon: const Icon(Icons.pie_chart),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const StatisticsScreen(),
                ),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // === Фильтр по категориям ===
          Container(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
            color: Theme.of(context).colorScheme.surface,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  // Чип «Все»
                  Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: ChoiceChip(
                      label: const Text('Все'),
                      avatar: const Icon(Icons.apps, size: 18),
                      selected: _selectedCategory == 'Все',
                      onSelected: (selected) {
                        setState(() {
                          _selectedCategory = 'Все';
                        });
                      },
                    ),
                  ),
                  // Чипы категорий
                  ...categories.map(
                    (cat) => Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: ChoiceChip(
                        label: Text(cat.name),
                        avatar: Icon(cat.icon, size: 18),
                        selected: _selectedCategory == cat.name,
                        onSelected: (selected) {
                          setState(() {
                            _selectedCategory = selected ? cat.name : 'Все';
                          });
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // === Строка статистики ===
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                Icon(Icons.event_note, size: 18, color: Colors.grey[600]),
                const SizedBox(width: 6),
                Text(
                  _selectedCategory == 'Все'
                      ? 'Всего событий: '
                          '${_filteredEvents.length}'
                      : '$_selectedCategory: '
                          '${_filteredEvents.length} '
                          'из ${events.length}',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 14,
                  ),
                ),
                if (_searchQuery.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.deepPurple.shade100,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        'Поиск: $_searchQuery',
                        style: const TextStyle(fontSize: 12),
                      ),
                    ),
                  ),
              ],
            ),
          ),

          // === Сетка событий ===
          Expanded(
            child: _filteredEvents.isEmpty
                ? Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.event_busy,
                            size: 64, color: Colors.grey[300]),
                        const SizedBox(height: 12),
                        Text(
                          'Нет событий',
                          style: TextStyle(
                            color: Colors.grey[400],
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  )
                : GridView.count(
                    crossAxisCount: 2,
                    padding: const EdgeInsets.all(12),
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 0.85,
                    children: _filteredEvents
                        .map((event) => _buildEventCard(event))
                        .toList(),
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showAddEventSheet(context),
        icon: const Icon(Icons.add),
        label: const Text('Событие'),
      ),
    );
  }

  // === Карточка события (с Dismissible) ===
  Widget _buildEventCard(Event event) {
    return Dismissible(
      key: ValueKey(event),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        decoration: BoxDecoration(
          color: Colors.red[400],
          borderRadius: BorderRadius.circular(16),
        ),
        child: const Icon(Icons.delete, color: Colors.white, size: 32),
      ),
      onDismissed: (direction) {
        setState(() {
          events.remove(event);
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${event.title} удалено'),
            action: SnackBarAction(
              label: 'Отменить',
              onPressed: () {
                setState(() {
                  events.add(event);
                });
              },
            ),
          ),
        );
      },
      child: GestureDetector(
        onTap: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => EventDetailScreen(event: event),
            ),
          );
          if (result == true) {
            setState(() {});
          }
        },
        child: Card(
          clipBehavior: Clip.antiAlias,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Цветной заголовок
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      event.category.color.withOpacity(0.7),
                      event.category.color.withOpacity(0.4),
                    ],
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(event.emoji, style: const TextStyle(fontSize: 32)),
                    const SizedBox(height: 4),
                    Text(
                      event.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
              ),
              // Информация
              Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.calendar_today,
                            size: 14, color: Colors.grey[600]),
                        const SizedBox(width: 4),
                        Text(
                          _formatDate(event.date),
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                        ),
                        const SizedBox(width: 8),
                        Icon(Icons.access_time,
                            size: 14, color: Colors.grey[600]),
                        const SizedBox(width: 4),
                        Text(
                          _formatTime(event.time),
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        Icon(Icons.location_on,
                            size: 14, color: Colors.grey[600]),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            event.location,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[600],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // === BottomSheet для добавления ===
  void _showAddEventSheet(BuildContext context) {
    final titleCtrl = TextEditingController();
    final descCtrl = TextEditingController();
    final locationCtrl = TextEditingController();
    EventCategory selectedCat = categories[0];
    DateTime selectedDate = DateTime.now();
    TimeOfDay selectedTime = TimeOfDay.now();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) {
        return StatefulBuilder(
          builder: (ctx, setSheetState) {
            return Padding(
              padding: EdgeInsets.only(
                left: 20,
                right: 20,
                top: 20,
                bottom: MediaQuery.of(ctx).viewInsets.bottom + 20,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Заголовок
                  Row(
                    children: [
                      const Icon(Icons.add_circle, color: Colors.deepPurple),
                      const SizedBox(width: 8),
                      const Text(
                        'Новое событие',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Spacer(),
                      IconButton(
                        onPressed: () => Navigator.pop(ctx),
                        icon: const Icon(Icons.close),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  // Название
                  TextField(
                    controller: titleCtrl,
                    decoration: const InputDecoration(
                      labelText: 'Название',
                      prefixIcon: Icon(Icons.title),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Место
                  TextField(
                    controller: locationCtrl,
                    decoration: const InputDecoration(
                      labelText: 'Место',
                      prefixIcon: Icon(Icons.location_on),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Категория (Dropdown)
                  DropdownButtonFormField<EventCategory>(
                    value: selectedCat,
                    decoration: const InputDecoration(
                      labelText: 'Категория',
                      prefixIcon: Icon(Icons.category),
                      border: OutlineInputBorder(),
                    ),
                    items: categories
                        .map((cat) => DropdownMenuItem(
                              value: cat,
                              child: Row(
                                children: [
                                  Icon(cat.icon, size: 20, color: cat.color),
                                  const SizedBox(width: 8),
                                  Text(cat.name),
                                ],
                              ),
                            ))
                        .toList(),
                    onChanged: (val) {
                      if (val != null) {
                        setSheetState(() {
                          selectedCat = val;
                        });
                      }
                    },
                  ),
                  const SizedBox(height: 12),

                  // Дата и время
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () async {
                            final d = await showDatePicker(
                              context: ctx,
                              initialDate: selectedDate,
                              firstDate: DateTime.now(),
                              lastDate:
                                  DateTime.now().add(const Duration(days: 365)),
                            );
                            if (d != null) {
                              setSheetState(() {
                                selectedDate = d;
                              });
                            }
                          },
                          icon: const Icon(Icons.calendar_today),
                          label: Text(
                            '${selectedDate.day}.'
                            '${selectedDate.month}.'
                            '${selectedDate.year}',
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () async {
                            final t = await showTimePicker(
                              context: ctx,
                              initialTime: selectedTime,
                            );
                            if (t != null) {
                              setSheetState(() {
                                selectedTime = t;
                              });
                            }
                          },
                          icon: const Icon(Icons.access_time),
                          label: Text(
                            '${selectedTime.hour.toString().padLeft(2, "0")}:'
                            '${selectedTime.minute.toString().padLeft(2, "0")}',
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Кнопка
                  FilledButton.icon(
                    onPressed: () {
                      if (titleCtrl.text.isNotEmpty) {
                        setState(() {
                          events.add(Event(
                            title: titleCtrl.text,
                            description: descCtrl.text.isNotEmpty
                                ? descCtrl.text
                                : 'Без описания',
                            location: locationCtrl.text.isNotEmpty
                                ? locationCtrl.text
                                : 'Не указано',
                            category: selectedCat,
                            date: selectedDate,
                            time: selectedTime,
                            participants: [],
                            emoji: '📌',
                          ));
                        });
                        Navigator.pop(ctx);
                      }
                    },
                    icon: const Icon(Icons.check),
                    label: const Text('Создать событие'),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}

// ==============================
// ЭКРАН ДЕТАЛЕЙ СОБЫТИЯ (С РЕДАКТИРОВАНИЕМ)
// ==============================

class EventDetailScreen extends StatefulWidget {
  final Event event;

  const EventDetailScreen({
    super.key,
    required this.event,
  });

  @override
  State<EventDetailScreen> createState() => _EventDetailScreenState();
}

class _EventDetailScreenState extends State<EventDetailScreen> {
  void _editEvent(BuildContext context) {
    final titleCtrl = TextEditingController(text: widget.event.title);
    final descCtrl = TextEditingController(text: widget.event.description);
    final locationCtrl = TextEditingController(text: widget.event.location);
    EventCategory selectedCat = widget.event.category;
    DateTime selectedDate = widget.event.date;
    TimeOfDay selectedTime = widget.event.time;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) {
        return StatefulBuilder(
          builder: (ctx, setSheetState) {
            return Padding(
              padding: EdgeInsets.only(
                left: 20,
                right: 20,
                top: 20,
                bottom: MediaQuery.of(ctx).viewInsets.bottom + 20,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.edit, color: Colors.deepPurple),
                      const SizedBox(width: 8),
                      const Text(
                        'Редактировать событие',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Spacer(),
                      IconButton(
                        onPressed: () => Navigator.pop(ctx),
                        icon: const Icon(Icons.close),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: titleCtrl,
                    decoration: const InputDecoration(
                      labelText: 'Название',
                      prefixIcon: Icon(Icons.title),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: locationCtrl,
                    decoration: const InputDecoration(
                      labelText: 'Место',
                      prefixIcon: Icon(Icons.location_on),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 12),
                  DropdownButtonFormField<EventCategory>(
                    value: selectedCat,
                    decoration: const InputDecoration(
                      labelText: 'Категория',
                      prefixIcon: Icon(Icons.category),
                      border: OutlineInputBorder(),
                    ),
                    items: categories
                        .map((cat) => DropdownMenuItem(
                              value: cat,
                              child: Row(
                                children: [
                                  Icon(cat.icon, size: 20, color: cat.color),
                                  const SizedBox(width: 8),
                                  Text(cat.name),
                                ],
                              ),
                            ))
                        .toList(),
                    onChanged: (val) {
                      if (val != null) {
                        setSheetState(() {
                          selectedCat = val;
                        });
                      }
                    },
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () async {
                            final d = await showDatePicker(
                              context: ctx,
                              initialDate: selectedDate,
                              firstDate: DateTime.now()
                                  .subtract(const Duration(days: 365)),
                              lastDate:
                                  DateTime.now().add(const Duration(days: 365)),
                            );
                            if (d != null) {
                              setSheetState(() {
                                selectedDate = d;
                              });
                            }
                          },
                          icon: const Icon(Icons.calendar_today),
                          label: Text(
                            '${selectedDate.day}.'
                            '${selectedDate.month}.'
                            '${selectedDate.year}',
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () async {
                            final t = await showTimePicker(
                              context: ctx,
                              initialTime: selectedTime,
                            );
                            if (t != null) {
                              setSheetState(() {
                                selectedTime = t;
                              });
                            }
                          },
                          icon: const Icon(Icons.access_time),
                          label: Text(
                            '${selectedTime.hour.toString().padLeft(2, "0")}:'
                            '${selectedTime.minute.toString().padLeft(2, "0")}',
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: descCtrl,
                    maxLines: 3,
                    decoration: const InputDecoration(
                      labelText: 'Описание',
                      prefixIcon: Icon(Icons.description),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 20),
                  FilledButton.icon(
                    onPressed: () {
                      // Обновляем данные события
                      setState(() {
                        widget.event.title = titleCtrl.text;
                        widget.event.description = descCtrl.text;
                        widget.event.location = locationCtrl.text;
                        widget.event.category = selectedCat;
                        widget.event.date = selectedDate;
                        widget.event.time = selectedTime;
                      });
                      Navigator.pop(ctx, true);
                    },
                    icon: const Icon(Icons.save),
                    label: const Text('Сохранить изменения'),
                  ),
                ],
              ),
            );
          },
        );
      },
    ).then((_) {
      Navigator.pop(context, true);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.event.title),
        backgroundColor: widget.event.category.color.withOpacity(0.3),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () => _editEvent(context),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // --- Баннер ---
            Container(
              height: 180,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    widget.event.category.color.withOpacity(0.6),
                    widget.event.category.color.withOpacity(0.2),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Stack(
                children: [
                  // Эмодзи фон
                  Positioned(
                    right: 20,
                    bottom: 10,
                    child: Text(
                      widget.event.emoji,
                      style: TextStyle(
                        fontSize: 100,
                        color: Colors.white.withOpacity(0.3),
                      ),
                    ),
                  ),
                  // Контент
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white24,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                widget.event.category.icon,
                                size: 16,
                                color: Colors.white,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                widget.event.category.name,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 13,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          widget.event.title,
                          style: const TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // --- Дата, время, место ---
            Padding(
              padding: const EdgeInsets.all(16),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      _infoRow(
                        Icons.calendar_today,
                        'Дата',
                        '${widget.event.date.day}.'
                            '${widget.event.date.month}.'
                            '${widget.event.date.year}',
                        widget.event.category.color,
                      ),
                      const Divider(),
                      _infoRow(
                        Icons.access_time,
                        'Время',
                        '${widget.event.time.hour.toString().padLeft(2, "0")}:'
                            '${widget.event.time.minute.toString().padLeft(2, "0")}',
                        widget.event.category.color,
                      ),
                      const Divider(),
                      _infoRow(
                        Icons.location_on,
                        'Место',
                        widget.event.location,
                        widget.event.category.color,
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // --- Раскрываемое описание ---
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Card(
                clipBehavior: Clip.antiAlias,
                child: ExpansionTile(
                  leading: Icon(Icons.description,
                      color: widget.event.category.color),
                  title: const Text(
                    'Описание',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  initiallyExpanded: true,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Text(
                        widget.event.description,
                        style: const TextStyle(
                          fontSize: 15,
                          height: 1.5,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 8),

            // --- Раскрываемые участники ---
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Card(
                clipBehavior: Clip.antiAlias,
                child: ExpansionTile(
                  leading:
                      Icon(Icons.people, color: widget.event.category.color),
                  title: Text(
                    'Участники '
                    '(${widget.event.participants.length})',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  children: [
                    ...widget.event.participants.map(
                      (name) => ListTile(
                        leading: CircleAvatar(
                          backgroundColor:
                              widget.event.category.color.withOpacity(0.2),
                          child: Text(
                            name[0],
                            style: TextStyle(
                              color: widget.event.category.color,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        title: Text(name),
                      ),
                    ),
                    const SizedBox(height: 8),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _infoRow(IconData icon, String label, String value, Color color) {
    return Row(
      children: [
        Icon(icon, color: color, size: 22),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[500],
              ),
            ),
            Text(
              value,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

// ==============================
// ЭКРАН СТАТИСТИКИ
// ==============================

class StatisticsScreen extends StatelessWidget {
  const StatisticsScreen({super.key});

  Event? _getNearestEvent() {
    final now = DateTime.now();
    final futureEvents = events.where((e) => e.date.isAfter(now)).toList();
    if (futureEvents.isEmpty) return null;
    futureEvents.sort((a, b) => a.date.compareTo(b.date));
    return futureEvents.first;
  }

  List<Event> _getNextEvents() {
    final now = DateTime.now();
    final futureEvents = events.where((e) => e.date.isAfter(now)).toList();
    futureEvents.sort((a, b) => a.date.compareTo(b.date));
    return futureEvents.take(3).toList();
  }

  @override
  Widget build(BuildContext context) {
    final totalEvents = events.length;
    final nearestEvent = _getNearestEvent();
    final nextEvents = _getNextEvents();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Статистика'),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Общая статистика
            Card(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            Text(
                              '$totalEvents',
                              style: const TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                                color: Colors.deepPurple,
                              ),
                            ),
                            const Text(
                              'Всего событий',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            const Icon(Icons.calendar_today,
                                size: 32, color: Colors.deepPurple),
                            const SizedBox(height: 4),
                            Text(
                              nearestEvent != null
                                  ? '${nearestEvent.date.day}.${nearestEvent.date.month}'
                                  : 'Нет',
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const Text(
                              'Ближайшее',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Статистика по категориям
            const Text(
              'Категории',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            ...categories.map((category) {
              final count =
                  events.where((e) => e.category.name == category.name).length;
              final percentage = totalEvents > 0 ? count / totalEvents : 0.0;

              return Card(
                margin: const EdgeInsets.only(bottom: 12),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      // Круговой индикатор
                      SizedBox(
                        width: 60,
                        height: 60,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            CircularProgressIndicator(
                              value: percentage,
                              strokeWidth: 6,
                              color: category.color,
                              backgroundColor: Colors.grey[200],
                            ),
                            Text(
                              '$count',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 16),
                      // Информация о категории
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(category.icon,
                                    color: category.color, size: 20),
                                const SizedBox(width: 8),
                                Text(
                                  category.name,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            LinearProgressIndicator(
                              value: percentage,
                              backgroundColor: Colors.grey[200],
                              color: category.color,
                              minHeight: 8,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '${(percentage * 100).toInt()}% (${count} из $totalEvents)',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),

            const SizedBox(height: 20),

            // Ближайшие события
            if (nextEvents.isNotEmpty) ...[
              const Text(
                'Ближайшие события',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              ...nextEvents.map((event) => Card(
                    margin: const EdgeInsets.only(bottom: 12),
                    child: ExpansionTile(
                      leading: Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              event.category.color.withOpacity(0.7),
                              event.category.color.withOpacity(0.4),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Center(
                          child: Text(
                            event.emoji,
                            style: const TextStyle(fontSize: 24),
                          ),
                        ),
                      ),
                      title: Text(
                        event.title,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        '${event.date.day}.${event.date.month}.${event.date.year} '
                        'в ${event.time.hour}:${event.time.minute.toString().padLeft(2, '0')}',
                      ),
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(Icons.location_on,
                                      size: 16, color: Colors.grey[600]),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Text(
                                      event.location,
                                      style: const TextStyle(fontSize: 14),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  Icon(Icons.category,
                                      size: 16, color: Colors.grey[600]),
                                  const SizedBox(width: 8),
                                  Text(
                                    event.category.name,
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: event.category.color,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                              if (event.description.isNotEmpty) ...[
                                const SizedBox(height: 8),
                                Text(
                                  event.description,
                                  style: const TextStyle(fontSize: 14),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ],
                          ),
                        ),
                      ],
                    ),
                  )),
            ],
          ],
        ),
      ),
    );
  }
}
