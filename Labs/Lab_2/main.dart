import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

// ================== MY APP ==================
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isDark = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Мой профиль',
      theme: _isDark
          ? ThemeData.dark()
          : ThemeData(
              colorScheme: ColorScheme.fromSeed(
                seedColor: Colors.deepPurple,
              ),
            ),
      home: MainScreen(
        onToggleTheme: () {
          setState(() {
            _isDark = !_isDark;
          });
        },
      ),
    );
  }
}

// ================== MAIN SCREEN ==================
class MainScreen extends StatefulWidget {
  final VoidCallback? onToggleTheme;

  const MainScreen({super.key, this.onToggleTheme});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  late final List<Widget> _screens = [
    ProfileScreen(onToggleTheme: widget.onToggleTheme),
    const GalleryScreen(),
    const ContactsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Профиль',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.photo),
            label: 'Галерея',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.contacts),
            label: 'Контакты',
          ),
        ],
      ),
    );
  }
}

// ================== PROFILE ==================
class ProfileScreen extends StatefulWidget {
  final VoidCallback? onToggleTheme;

  const ProfileScreen({super.key, this.onToggleTheme});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  int _likes = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Мой профиль'),
        actions: [
          IconButton(
            icon: const Icon(Icons.brightness_6),
            onPressed: widget.onToggleTheme,
          ),
          IconButton(
            icon: const Icon(Icons.info_outline),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AboutScreen(),
                ),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              const CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(
                    'https://cdn-icons-png.flaticon.com/512/3106/3106773.png'),
              ),
              const SizedBox(height: 16),
              const Text(
                'Артем',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Text('artem@mai.ru'),
              const SizedBox(height: 16),
              const Card(
                child: ListTile(
                  leading: Icon(Icons.phone),
                  title: Text('+7 912 345-67-89'),
                ),
              ),
              const Card(
                child: ListTile(
                  leading: Icon(Icons.school),
                  title: Text('НГУЭУ'),
                ),
              ),
              const SizedBox(height: 16),
              Wrap(
                spacing: 8,
                children: const [
                  Chip(label: Text('Спорт')),
                  Chip(label: Text('Фитнес')),
                  Chip(label: Text('Активный отдых')),
                ],
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton.icon(
                    onPressed: () {
                      setState(() {
                        _likes++;
                      });
                    },
                    icon: const Icon(Icons.favorite),
                    label: Text('$_likes'),
                  ),
                  OutlinedButton.icon(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Сообщение отправлено!'),
                        ),
                      );
                    },
                    icon: const Icon(Icons.message),
                    label: const Text('Написать'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ================== GALLERY ==================
class GalleryScreen extends StatelessWidget {
  const GalleryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final images =
        List.generate(9, (index) => 'https://picsum.photos/200?random=$index');

    return Scaffold(
      appBar: AppBar(title: const Text('Галерея')),
      body: GridView.count(
        crossAxisCount: 3,
        children: images
            .map((url) => Padding(
                  padding: const EdgeInsets.all(4),
                  child: Image.network(url, fit: BoxFit.cover),
                ))
            .toList(),
      ),
    );
  }
}

// ================== CONTACTS ==================
class ContactsScreen extends StatelessWidget {
  const ContactsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final contacts = [
      'Алексей',
      'Мария',
      'Дмитрий',
      'Ольга',
      'Сергей',
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Контакты')),
      body: ListView.builder(
        itemCount: contacts.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: const Icon(Icons.person),
            title: Text(contacts[index]),
          );
        },
      ),
    );
  }
}

// ================== ABOUT ==================
class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('О приложении')),
      body: const Padding(
        padding: EdgeInsets.all(16),
        child: Text(
          'Это учебное Flutter приложение.',
        ),
      ),
    );
  }
}
