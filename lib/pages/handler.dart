import 'package:flutter/material.dart';
// import 'package:flutter_theme_firebase_template/styles.dart';
import 'login.dart';
import 'signup.dart';

class PageHandler extends ChangeNotifier {
  static const EXTERN = "extern";
  static const OVERVIEW = "overview";
  static const CALENDAR = "calendar";
  static const SETTINGS = "settings";
  static const ACCOUNT = "account";

  bool loggedIn = false;
  // maybe some user id for crud on his acc

  var form;

  String _currentPage = EXTERN;
  int _subpage = 0;

  String get page => _currentPage;
  int get subpage => _subpage;

  void loginUser(String email, String password) async {
    /*  // String det = await auth.saveLogin(email, password);
    String det = await auth.AuthMethods().loginUser(email: email, password: password);
    print(det);
    if (det == "success") {
    loggedIn = true;
    _currentPage = OVERVIEW;
    notifyListeners();
    }  */
    print("loginUser was called with {email}, {password}");
  }

  void toPage(String page) {
    _currentPage = page;
    notifyListeners();
  }

  void toSubpage(int subpage) {
    _subpage = subpage;
    notifyListeners();
  }

  List<Widget> buildActions() {
    //ThemeManager _themeManager) {
    if (!this.loggedIn) {
      return [];
    }
    return [
      IconButton(onPressed: () => {}, icon: Icon(Icons.calendar_month)),
      Expanded(child: Container()),
      IconButton(
        onPressed: () => this.toPage(PageHandler.SETTINGS),
        icon: Icon(Icons.settings),
      ),
      IconButton(
        onPressed: () => this.toPage(PageHandler.ACCOUNT),
        icon: Icon(Icons.account_box),
      ),
      IconButton(onPressed: () => this.toPage(page), icon: Icon(Icons.logout)),
      // IconButton(
      //   onPressed: () =>
      //       {_themeManager.toggleTheme(!_themeManager.isDarkMode()), notifyListeners() },
      //   icon: _themeManager.isDarkMode()
      //       ? Icon(Icons.dark_mode_rounded)
      //       : Icon(Icons.light_mode_rounded),
      // )
    ];
  }

  Widget buildBody() {
    //ThemeManager _themeManager) {
    Widget result = Container();
    switch (_currentPage) {
      case PageHandler.EXTERN:
        switch (subpage) {
          case 1:
            form = SignupForm();
            result = Signup(
              form: form,
              handler: this,
            );
            break;
          default:
            form = LoginForm();
            result = Login(
              form: form,
              handler: this,
            );
        }
        break;
      case PageHandler.OVERVIEW:
        result = Row(children: [
          Text("Hey"),
          SizedBox(
            width: 170,
            height: 60,
          ),
          Card(
            child: Text("Hey!"),
          ),
        ]);
    }
    return result;
  }
}
