import 'package:flutter/material.dart';
import 'package:phone_book/cache/mail_password_cache_manager.dart';
import 'package:phone_book/cache/mail_password_model.dart';
import 'package:phone_book/cache/shared_manager.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final MailPasswordCacheManager mailPasswordCacheManager;
  List<MailPasswordModel> _users = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initializeAndGet();
  }

  //Defined this function for initialize managers and get data(s).
  //It provide save data(s) in array
  Future<void> initializeAndGet() async {
    final SharedManager manager = SharedManager();
    await manager.init();
    mailPasswordCacheManager = MailPasswordCacheManager(sharedManager: manager);
    _users = mailPasswordCacheManager.getData() ?? [];
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Welcome"),
      ),
      body: Center(
        child: Card(
          shadowColor: Colors.white,
          color: Color.fromARGB(255, 191, 219, 241),
          child: Container(
            width: MediaQuery.of(context).size.width * 0.65,
            height: MediaQuery.of(context).size.height * 0.1,
            child: Column(children: [
              Padding(padding: EdgeInsets.only(top: 15)),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildTextRow('Mail: ', _users[0].mail.toString()),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildTextRow('Password: ', _users[0].password.toString()),
                ],
              )
            ]),
          ),
        ),
      ),
    );
  }

  Widget _buildTextRow(String label, String data) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          label,
          style: TextStyle(color: Color.fromARGB(255, 71, 90, 99)),
        ),
        Text(
          data,
          style: TextStyle(color: Color.fromARGB(255, 71, 90, 99)),
        ),
      ],
    );
  }
}
