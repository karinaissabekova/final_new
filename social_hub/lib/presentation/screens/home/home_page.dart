import 'package:flutter/material.dart';
import 'package:social_hub/lang.dart';

import '../../../core/app_settings.dart';
import '../../../main.dart';

import '../feed/feed_screen.dart';
import '../create/create_screen.dart';
import '../profile/profile_screen.dart';
import '../explore/explore_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int index = 0;

  final screens = [
    const FeedScreen(),
    CreateScreen(),
    const ExploreScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          index == 0
              ? AppLang.t("feed")
              : index == 1
                  ? AppLang.t("create")
                  : index == 2
                      ? AppLang.t("explore")
                      : AppLang.t("profile"),
        ),
        actions: [
          /// 🌍 LANGUAGE
          PopupMenuButton<String>(
            icon: const Icon(Icons.language),
            onSelected: (value) {
              AppSettings.lang = value;
              MyApp.rebuild(context); // 🔥 фикс языка
            },
            itemBuilder: (_) => const [
              PopupMenuItem(value: "en", child: Text("EN")),
              PopupMenuItem(value: "ru", child: Text("RU")),
              PopupMenuItem(value: "kz", child: Text("KZ")),
            ],
          ),

          /// 🌙 THEME
          IconButton(
            icon: Icon(
              AppSettings.isDark
                  ? Icons.dark_mode
                  : Icons.light_mode,
            ),
            onPressed: () {
              AppSettings.isDark = !AppSettings.isDark;
              MyApp.rebuild(context); // 🔥 фикс темы
            },
          ),
        ],
      ),

      body: screens[index],

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: index,
        onTap: (value) => setState(() => index = value),

        /// 🔥 ВАЖНО ДЛЯ ВИДИМОСТИ
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,

        backgroundColor: Theme.of(context).scaffoldBackgroundColor,

        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.home),
            label: AppLang.t("feed"),
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.add),
            label: AppLang.t("create"),
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.explore),
            label: AppLang.t("explore"),
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.person),
            label: AppLang.t("profile"),
          ),
        ],
      ),
    );
  }
}