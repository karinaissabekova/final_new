import 'package:social_hub/core/app_settings.dart';

class AppLang {
  static String get lang => AppSettings.lang;

  static String t(String key) {
    final map = {
      "en": {
        "feed": "Feed",
        "create": "Create",
        "explore": "Explore",
        "profile": "Profile",
        "post": "Post",
        "write": "Write something...",
        "no_posts": "No posts yet 😢",
        "email": "Email",
        "password": "Password",
        "login": "Login",
        "register": "Register",
      },
      "ru": {
        "feed": "Лента",
        "create": "Создать",
        "explore": "Обзор",
        "profile": "Профиль",
        "post": "Пост",
        "write": "Напишите что-нибудь...",
        "no_posts": "Постов пока нет 😢",
        "email": "Почта",
        "password": "Пароль",
        "login": "Войти",
        "register": "Регистрация",
      },
      "kz": {
        "feed": "Жаңалықтар",
        "create": "Қосу",
        "explore": "Шолу",
        "profile": "Профиль",
        "post": "Жариялау",
        "write": "Бір нәрсе жазыңыз...",
        "no_posts": "Посттар жоқ 😢",
        "email": "Пошта",
        "password": "Құпия сөз",
        "login": "Кіру",
        "register": "Тіркелу",
      },
    };

    return map[lang]?[key] ?? key;
  }
}
