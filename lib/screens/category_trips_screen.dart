import 'package:flutter/material.dart';
import '../models/trip.dart';
import '../widgets/trip_item.dart';

//تم تحويل stl الي stf  وذلك لان الصفحة هتتغير وتنقص رحلة في حالة حذفها من صفحة تفاصيل الرحلة
class CategoryTripsScreen extends StatefulWidget {
  const CategoryTripsScreen({
    super.key,
    required categoryId,
    required categoryTitle,
    required this.availableTrips,

    //required this.categoryId,
    // required this.categoryTitle
  });
  // final String categoryId;
  //final String categoryTitle;

  //هذه الطريقة حتي لايتعطل التطبيق لو نقص حرف من الاسم في الكتابة
  static const screenRoute = '/category-trips';

  final List<Trip> availableTrips;

  @override
  State<CategoryTripsScreen> createState() => _CategoryTripsScreenState();
}

class _CategoryTripsScreenState extends State<CategoryTripsScreen> {
  late String? categoryTitle;
  late List<Trip> displayTrips;

  @override
  void initState() {
    //كانت ممكن تشتغل بدل  didChangeDependencies لو مفيش context
    super.initState();
  }

//وذلك لانinitState بتشتغل قبل context فبتعمل  error وذلك لانها غير متوفرةفلازم نستخدم did..
  @override
  void didChangeDependencies() {
    //من خلال widget modalRoute نحصل علي المعلومات من اي صفحة تم تحميلها هنا
    final routeArguments =
        //<قيمة المفتاح,المفتاح>
        ModalRoute.of(context)!.settings.arguments as Map<String, String>;
    final categoryId = routeArguments['id'];
    //تم ازالة final لانها ستتغري بعدين
    categoryTitle = routeArguments['title']!;
    //لعمل تصفية للملفات من خلال هذا الميثود where
    // وهنعمل له لاستة من خلال tolist
    displayTrips = widget.availableTrips.where((trip) {
      //يعني categoryId الموجودة بداخلcategories اللي تبع trip
      return trip.categories.contains(categoryId);
    }).toList();
    super.didChangeDependencies();
  }

  void _removeTrip(String tripId) {
    setState(() {
      //هنعمل استدعاء displayTrips التي بداخلها Trips_data اللي معمول لها التصفية
      //واذا كان trip.id الموجود بداخل الرحلة = tripId  وبالتالي سوف يتم حذف الرحلة"المتغير اللي فوق"
      //وسوف يتحدث من خلال setState الموجودة بداخل stF
      displayTrips.removeWhere((trip) => trip.id == tripId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(categoryTitle!),
        ),
        //مميزات builder بيعرض العناصر بس اللي ظاهرة علي الشاشة اما اللي في الاسفل بيبقي مخفي حتي النزول
        //وبنحصل منه علي لاستة
        body: ListView.builder(
          itemBuilder: (ctx, index) {
            //[index]لكل عنصر وداخل اقواس مربعة
            // return Text(filterdTrips[index].title);
            return TripItem(
              id: displayTrips[index].id,
              title: displayTrips[index].title,
              imageurl: displayTrips[index].imageurl,
              duration: displayTrips[index].duration.toString(),
              tripType: displayTrips[index].tripType.toString(),
              season: displayTrips[index].season.toString(),
              //  removeItem: _removeTrip,
            );
          },
          //هنحصل علي عدد الرحلات الموجودين بكل تصنيف بعد ماعملت فلترة من خلالwhere
          itemCount: displayTrips.length,
        ));
  }
}
