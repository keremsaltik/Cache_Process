import 'package:flutter/material.dart';
import 'package:phone_book/cache/mail_password_cache_manager.dart';
import 'package:phone_book/cache/mail_password_model.dart';
import 'package:phone_book/cache/shared_manager.dart';
import 'package:phone_book/view/home_page.dart';
import 'package:phone_book/view/login_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late final MailPasswordCacheManager mailPasswordCacheManager;

  List<MailPasswordModel> _users = [];

  Future<void> initializeAndGet() async {
    final SharedManager manager = SharedManager();
    await manager.init();
    mailPasswordCacheManager = MailPasswordCacheManager(sharedManager: manager);
    _users = mailPasswordCacheManager.getData() ?? [];
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initializeAndGet();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: true,
      ),
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.system,
      home: (_users.isEmpty ? LoginPage() : HomePage()),
    );
  }
}
