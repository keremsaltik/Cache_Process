import 'package:flutter/material.dart';
import 'package:phone_book/cache/mail_password_cache_manager.dart';
import 'package:phone_book/cache/mail_password_model.dart';
import 'package:phone_book/cache/shared_manager.dart';
import 'package:phone_book/view/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _ContactHomePageState();
}

class _ContactHomePageState extends State<LoginPage> {
  GlobalKey<FormState> _key = GlobalKey();
  late final MailPasswordCacheManager dataCacheManager;
  TextEditingController _titleText = TextEditingController();
  TextEditingController _bodyText = TextEditingController();
  late String _titleTextString;
  late String _bodyTextString;

  late bool remember = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initialize();
  }

  //Managers has been defined for process on data(s).
  Future<void> initialize() async {
    final SharedManager manager = SharedManager();
    await manager.init();
    dataCacheManager = MailPasswordCacheManager(sharedManager: manager);
  }

  //This function provide save items with parameters via managers
  Future<void> saveItems(String _title, String _text) async {
    final MailPasswordModel note =
        MailPasswordModel(mail: _title, password: _text);
    await dataCacheManager.saveData([note]);
    setState(() {});
  }

  //For checkbox control. If chechkbox be active, this function will be running
  void rememberMe() {
    setState(() {
      remember = !remember;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Form(
          key: _key,
          //Automatically executes validators
          autovalidateMode: AutovalidateMode.always,
          child: Column(
            children: [
              Text(
                'Log In',
                style: TextStyle(fontSize: 30),
              ),
              Padding(padding: EdgeInsets.only(top: 185)),
              TextFormFieldWidget(
                controller: _titleText,
                hintText: 'Mail',
                inputType: TextInputType.emailAddress,
              ),
              Padding(padding: EdgeInsets.only(top: 20)),
              TextFormFieldWidget(
                controller: _bodyText,
                hintText: 'Password',
                isObscure: true,
                inputType: TextInputType.visiblePassword,
              ),
              Padding(padding: EdgeInsets.only(top: 10)),
              Row(
                children: [
                  Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: checkboxRemember()),
                  Text('Remember Me')
                ],
              ),
              Padding(padding: EdgeInsets.only(top: 20)),
              SizedBox(
                width: 125,
                child: FloatingActionButton(
                  elevation: 5,
                  backgroundColor: Color.fromARGB(255, 17, 219, 226),
                  child: Text(
                    'Log in',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () async {
                    //Checks if the form is valid before proceeding with an action.
                    if (_key.currentState?.validate() ?? false) {
                      /*If checkbox active (so remember(variable) equals to true) datas will save with values of controllers and saveItems function. 
                    But if one of textformfield is null, will be nothing*/
                      if (remember == true) {
                        _titleTextString = _titleText.text;
                        _bodyTextString = _bodyText.text;
                        await saveItems(_titleTextString, _bodyTextString);
                      } else {
                        _titleText.clear();
                        _bodyText.clear();
                        dataCacheManager.clearMailAndPassword();
                        //If remember me button deactive the values must be null.
                        //Because if old user info keep in the local when press the log in button,
                        //they will be show. This isn't  logical
                        //So datas will be delete.
                      }

                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HomePage(),
                          ));
                    }
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Checkbox checkboxRemember() {
    return Checkbox(
      checkColor: Colors.white, // İç tiki beyaz yapar
      activeColor: Colors.blue, // Seçildiğinde içi mavi yapar
      value: remember,
      onChanged: (value) {
        rememberMe();
      },
    );
  }
}

class TextFormFieldWidget extends StatelessWidget {
  const TextFormFieldWidget({
    super.key,
    required TextEditingController controller,
    required this.hintText,
    this.isObscure,
    required this.inputType,
  }) : _controller = controller;

  final TextEditingController _controller;
  final String hintText;
  final bool? isObscure;
  final TextInputType inputType;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.9,
      child: TextFormField(
        keyboardType: inputType,
        cursorColor: Colors.blue,
        obscureText: isObscure ?? false,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.all(20),
            hintText: hintText,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(
                  color: Colors.lightBlue,
                ))),
        controller: _controller,
        validator: (value) {
          return FormFieldValidator().isNotEmpty(value);
        },
      ),
    );
  }
}

class FormFieldValidator {
  String? isNotEmpty(String? data) {
    return (data?.isNotEmpty ?? false)
        ? null
        : ValidatorMessage._notEmptyMessage;
  }
}

class ValidatorMessage {
  static const String _notEmptyMessage = "This field can not be null";
}
