import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travel_thinking_app/common/utils/event_bus.dart';
import 'package:travel_thinking_app/presentation/views/home/home.dart';
import 'package:travel_thinking_app/widgets/navigation_bar/index.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
    required this.title,
    required this.navigatorKey,
  });
  final String title;
  final GlobalKey<NavigatorState> navigatorKey;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _page = 0;
  // ignore: prefer_final_fields
  GlobalKey<CurvedNavigationBarState> _bottomNavigationKey =
      GlobalKey<CurvedNavigationBarState>();

  final EventBus? eventBus = EventBus.getInstance();

  @override
  void initState() {
    super.initState();

    // NOTE: 未授权事件监听
    eventBus?.addEventListener(EventBusType.unAuthorized, () {
      widget.navigatorKey.currentState?.pushNamed('/login');
    });
    // NOTE: 退出登录事件监听
    eventBus?.addEventListener(EventBusType.logout, () {
      widget.navigatorKey.currentState?.pushNamed('/login');
    });

    // NOTE: 无权限事件监听
    eventBus?.addEventListener(EventBusType.forbidden, () {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('您没有权限访问该资源, 请联系管理员'),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          margin: EdgeInsets.only(
            bottom: MediaQuery.of(context).size.height - 130,
            right: 20,
            left: 20,
          ),
        ),
      );
    });

    _isAvailableToken();
  }

  void _isAvailableToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    // NOTE: 未登录跳转到登录页
    if (prefs.getString('access_token') == null) {
      widget.navigatorKey.currentState?.pushReplacementNamed('/login');
    }
  }

  @override
  void dispose() {
    eventBus?.removeEventListener(EventBusType.unAuthorized);
    eventBus?.removeEventListener(EventBusType.logout);
    eventBus?.removeEventListener(EventBusType.forbidden);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(title: Text(widget.title)),
      bottomNavigationBar: CurvedNavigationBar(
        key: _bottomNavigationKey,
        index: 0,
        items: <Widget>[
          Icon(
            CupertinoIcons.home,
            size: _page == 0 ? 40 : 30,
            color: _page == 0 ? Colors.white : Colors.black54,
          ),
          Icon(
            CupertinoIcons.bell,
            size: _page == 1 ? 40 : 30,
            color: _page == 1 ? Colors.white : Colors.black54,
          ),
          Icon(
            CupertinoIcons.calendar_today,
            size: _page == 2 ? 40 : 30,
            color: _page == 2 ? Colors.white : Colors.black54,
          ),
          Icon(
            CupertinoIcons.person_2_square_stack,
            size: _page == 3 ? 40 : 30,
            color: _page == 3 ? Colors.white : Colors.black54,
          ),
          Icon(
            CupertinoIcons.person_fill,
            size: _page == 4 ? 40 : 30,
            color: _page == 4 ? Colors.white : Colors.black54,
          ),
        ],
        color: Color.fromRGBO(255, 255, 255, 0.6),
        buttonBackgroundColor: Color.fromRGBO(255, 167, 38, 0.1),
        backgroundColor: Color.fromRGBO(255, 167, 38, .85),
        animationCurve: Curves.easeInOut,
        animationDuration: Duration(milliseconds: 600),
        onTap: (index) {
          setState(() {
            _page = index;
          });
        },
        letIndexChange: (index) => true,
      ),
      body: SafeArea(child: Home()),
    );
  }
}
