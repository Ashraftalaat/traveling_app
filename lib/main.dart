import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import './app_data.dart';
import './models/trip.dart';
import './screens/filters_screen.dart';
import './screens/tabs_screen.dart';
import './screens/trip_detail_screen.dart';
import './screens/category_trips_screen.dart';

//هنا بستخدم main.dart لادارة كافة التطبيق

void main() {
  runApp(const MyApp());
}

// تم تحويلهاstf وذلك بسبب الفلترة والتغيير الذي سوف يحدث
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> _filters = {
    // الوضع الطبيعي اول مايشتغل الجهاز false
    'summer': false,
    'winter': false,
    'family': false,
  };

  List<Trip> _availableTrips = Trips_data;
  final List<Trip> _favoriteTrips = [];

  get categoryId => null;

  get categoryTitle => null;

  //هذه هي method لصفحة الفلترة
  void _changeFilters(Map<String, bool> filterData) {
    setState(() {
      _filters = filterData;
      //where عشان فلترة الرحلات
      _availableTrips = Trips_data.where((trip) {
        //فحص ازرار الفلترة لعرض الرحلات الخاصة بها من خلال if
        //يعني اذا تم تشغيل زر الرحلات الصيفية والضغط عليها والاجابة نعم"== true و"&&"هنفحص الرحلات في الصيف كانت "!="لاتساوي true
        //وكانت الاجابتين نعم هنعمل return ومش هنشغلهfalse لهذه الرحلة
        if (_filters['summer'] == true && trip.isInSummer != true) {
          return false;
        }
        if (_filters['winter'] == true && trip.isInWinter != true) {
          return false;
        }
        if (_filters['family'] == true && trip.isForFamilies != true) {
          return false;
        }
        return true;
      }).toList();
    });
  }

// void يعنى مش هتخرج حاجة
  void _manageFavorite(String tripId) {
    //indexWhereهتفحص اذا كان عنصر محدد جزء من هذه list"favoriteTrips"
    //اي من خلال هذا السطر سوف اعرف هل هذه الرحلة موجودة في المفضلة سابقا "اي تم اضافتها"ام لا
    final existingIndex =
        _favoriteTrips.indexWhere((trip) => trip.id == tripId);
    //existingIndex >= 0 يعني الرحلة موجودة في المفضلة
    if (existingIndex >= 0) {
      setState(() {
        //هياخذ رقم هذه الرحلة ويحذفها من قائمة المفضلة
        //تم يعيد بناء التطبيق من اول بفضل setState
        _favoriteTrips.removeAt(existingIndex);
      });
      //اذا لم نجد الرحلة في المفضلة هنقوم باضافتها
    } else {
      setState(() {
        _favoriteTrips.add(Trips_data.firstWhere((trip) => trip.id == tripId));
      });
    }
  }

  bool _isFavorite(String id) {
    //ببحث عن الرحلة اللي ليهاid واذا تم ايحاده هيتوقف عن البحث في باقي الرحلات
    return _favoriteTrips.any((trip) => trip.id == id);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('ar', 'AE'), // English
      ],
      title: 'Travel App',
      theme: ThemeData(
          // instead accent colorاللون التانوى للتطبيق
          colorScheme:
              ColorScheme.fromSwatch().copyWith(secondary: Colors.amber),
          // اللون الاساسي للتطبيق
          primarySwatch: Colors.blue,
          fontFamily: 'ElMessiri',
          textTheme: ThemeData.light().textTheme.copyWith(
                // instead headline5
                headlineSmall: const TextStyle(
                  color: Colors.blue,
                  fontSize: 24,
                  fontFamily: 'ElMessiri',
                  fontWeight: FontWeight.bold,
                ),
                // instead headline6
                titleLarge: const TextStyle(
                  color: Colors.white,
                  fontSize: 26,
                  fontFamily: 'ElMessiri',
                  fontWeight: FontWeight.bold,
                ),
              )),
      //المسار الاولي
      initialRoute: '/',
      // home: const CategoriesScreen(),

      //بتوضع هنا كل الشاشات
      routes: {
        //يوجد مسار افتراضي داخل الروت '/' وهو للصفحة الرئيسية بدل الهوم
        //ولازم البلدير فينكشن وهو (ctx)=> وبعديه الصفحة الرئيسية
        //صفحة favorite جزء منTabsScreen لذلك لم يتم اضافة route ليها
        '/': (ctx) => TabsScreen(_favoriteTrips),
        //  "ممكن نسميها اي اسم احر هذا هو "مفتاح النص
        //'/category-trips'هنستبدل هذا الاسم"مفتاح النص" بال static const في صفحةtrips
        CategoryTripsScreen.screenRoute: (ctx) => CategoryTripsScreen(
              categoryId: categoryId,
              categoryTitle: categoryTitle,
              availableTrips: _availableTrips,
            ),
        TripDetailScreen.screenRoute: (ctx) =>
            TripDetailScreen(_manageFavorite, _isFavorite),
        //بوضع ميثود _changeFilters بهذه الطريقة يعني بنمرره لصفحة الفلتر سكرين
        FiltersScreen.screenRoute: (ctx) =>
            FiltersScreen(_changeFilters, _filters),
      },
    );
  }
}
