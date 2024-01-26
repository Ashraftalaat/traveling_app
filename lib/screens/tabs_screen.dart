import 'package:flutter/material.dart';
import '../models/trip.dart';
import '../widgets/app_drawer.dart';
import '../screens/categories_screen.dart';
import '../screens/favorites_screen.dart';

class TabsScreen extends StatefulWidget {
  final List<Trip> favoriteScreen;

  const TabsScreen(this.favoriteScreen, {super.key});

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  // هذه الميثود تستخدم فقط داخل الملف الخاص فلازم "-" ولاتستخدم في اي صفحة اخري
  //بهذه الطريقة ربطنا بين الشاشات(التصنيفات والمفضلة)
  void _selectScreen(int index) {
    //وبسبب setstate استخدمنا SFL
    setState(() {
      _selectedScreenIndex = index;
    });
  }

  int _selectedScreenIndex = 0;
//final يعني مش هنغيرها في المستقبل
//object في حالة عدم معرفة نوع value
// dynamic بدل object في التحديث الجديد
  late List<Map<String, dynamic>> _screens;
//بهذه الطريقة مررنا tabsScreen الي favoriteScreen
  @override
  void initState() {
    _screens = [
      {
        'Screen': const CategoriesScreen(),
        'Title': 'تصنيفات الرحلات',
      },
      {
        'Screen': FavoritesScreen(widget.favoriteScreen),
        'Title': 'الرحلات المفضلة',
      },
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_screens[_selectedScreenIndex]['Title']),
      ),
      //لاضافة قائمة السحب
      drawer: const AppDrawer(),
      body: _screens[_selectedScreenIndex]['Screen'],
      //لاضافة TabBarفي نهاية الشاشة
      bottomNavigationBar: BottomNavigationBar(
        //للتنقل بي التابث
        onTap: _selectScreen,
        //لون التاب بار بالاسفل مثل اللون الاساسي المحدد في main.dart
        backgroundColor: Theme.of(context).primaryColor,
        //لون Item
        selectedItemColor: Theme.of(context).colorScheme.secondary,
        //يعني الزر الغير مفعل باللون الابيض
        unselectedItemColor: Colors.white,
        // body بتبلغه باي Tab واقفه
        currentIndex: _selectedScreenIndex,

        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.dashboard), label: 'التصنيفات'),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: 'المفضلة'),
        ],
      ),
    );
  }
}

// هذا المجرب سابقا
//import 'package:flutter/material.dart';
//import '../screens/favorites_screen.dart';
//import '../screens/categories_screen.dart';

//class TabsScreen extends StatelessWidget {
// const TabsScreen({super.key});

//@override
// Widget build(BuildContext context) {
//#اذا كان tab في اعلي الشاشة
// return DefaultTabController(
//#عدد الضفحات
// length: 2,
//child: Scaffold(
// appBar: AppBar(
//   title: const Text('دليل السياحي'),
//#ممكن نحط بادنج  نغير لون نعمل حاجات كتير بواسطة tapBar
// bottom: const TabBar(
//  tabs: [
//   Tab(
//   icon: Icon(Icons.dashboard),
//   text: 'التصنيفات',
//  ),
//   Tab(
//   icon: Icon(Icons.star),
//  text: 'المفضلة',
// ),
// ],
// ),
// ),
//#لعرض tap الذي قمنا باختياره
//  body: const TabBarView(
//  children: [
//     CategoriesScreen(),
//     FavoritesScreen(),
//   ],
//    ),
//  ),
//  );
//  }
//}
