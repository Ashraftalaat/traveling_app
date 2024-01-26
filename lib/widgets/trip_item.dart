import 'package:flutter/material.dart';
import 'package:traveling_app/models/trip.dart';
import '../screens/trip_detail_screen.dart';

class TripItem extends StatelessWidget {
  const TripItem({
    super.key,
    required this.title,
    required this.imageurl,
    required this.duration,
    required this.tripType,
    required this.season,
    required this.id,
    //  required this.removeItem
  });

  final String id;
  final String title;
  final String imageurl;
  final String duration;
  final String tripType;
  final String season;
  // final Function removeItem;

  String? get seasonText {
    if (season.toString() == Season.winter.toString()) {
      return 'شتاء';
    }
    if (season.toString() == Season.spring.toString()) {
      return 'ربيع';
    }
    if (season.toString() == Season.summer.toString()) {
      return 'صيف';
    }
    if (season.toString() == Season.autumn.toString()) {
      return 'خريف';
    }
    return null;

    //switch (season) {
    //case Season.winter.toString():
    //return 'شتاء';
    //      break;
    //  case Season.spring:
    //  return 'ربيع';
    //     break;
    // case Season.summer:
    // return 'صيف';
//        break;
    //    case Season.autumn:
    //    return 'خريق';
    //  break;
    // default:
    // return 'غير معروف';
    // }
  }

  String? get tripTypeText {
    if (tripType.toString() == TripType.exploration.toString()) {
      return 'استكشاف';
    }
    if (tripType.toString() == TripType.recovery.toString()) {
      return 'نقاهة';
    }
    if (tripType.toString() == TripType.activities.toString()) {
      return 'انشطة';
    }
    if (tripType.toString() == TripType.therapy.toString()) {
      return 'معالجة';
    }
    return null;
  }

  void selecTtrip(BuildContext context) {
    Navigator.of(context)
        //pushNamed بتعمل تشغيل Future اللي بتساعدنا في تحديد function في المستقبل لتساعدنا في تنفيذ بعض الامور
        .pushNamed(TripDetailScreen.screenRoute, arguments: id)
        //مش هينفذ غير في المستقبل عند العودة مرة اخري "Future"بعد عمل pop وحذف الصفحة من خلال صفحة trip_detail
        .then(
      (result) {
        //result  لاتساوي  null
        if (result != null) {
          // removeItem(result);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    //inkwell لعمل صورة قابلة للضغط وظل خفيف عند الضغط
    return InkWell(
      //ontap لفتح صفحة التفاصيل بتاعة كل رحلة
      //=> لتمرير البيانات
      onTap: () => selecTtrip(context),
      //لعمل بطاقة
      child: Card(
        //لعمل مستطيل بزواية دائرية
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        //لتغيير درجة الظل خلف البطاقة
        elevation: 7,
        //مسافات خارجية متساوية من كل الاتجاهات
        margin: const EdgeInsets.all(10),
        child: Column(
          children: [
            //لوضع اكثر من عنصر فوق بعض علي شكل طبقات ثلاثي الابعاد
            Stack(
              children: [
                //لقص زواية الصورة حتي تصبح مثل زواية الكارد دائرية
                ClipRRect(
                  //لجعل الزواية العلوية فقط الدائرية
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                  ),
                  child: Image.network(
                    imageurl,
                    //ارتفاع عشان متطلعش الصورة اكبر من هذه القيمة
                    height: 200,
                    //عشان تاخذ كل العرض المتوفر للصورة
                    width: double.infinity,
                    //عشان تغطي الصورة كل المساحة ولاتتغير حسب النسبة لعرض وارتفاع الصورة
                    fit: BoxFit.cover,
                  ),
                ),
                Container(
                  height: 200,
                  alignment: Alignment.bottomRight,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                  //لتغيير درجة الشفافية للكونتينر اللي فوق مثلا اعلي من الاسفل
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      //نقطة بداية اللون المتدرج
                      begin: Alignment.topCenter,
                      //نهاية تدرج اللون
                      end: Alignment.bottomCenter,
                      //[] لللاستة
                      colors: [
                        Colors.black.withOpacity(0),
                        Colors.black.withOpacity(0.8)
                      ],
                      //يعني درجة الشفافية هتبدأ بعد 60 من الكونتينر حتي نهايته
                      stops: const [0.6, 1],
                    ),
                  ),
                  child: Text(
                    title,
                    //استدعينا من ملف main.dart نفس texttheme بنفس اللون والخط
                    style: Theme.of(context).textTheme.titleLarge,
                    //حتي لايتعدي العنوان بطاقة الكونتنر إذاكان طويل والزيادة تختفي تدريجيا
                    overflow: TextOverflow.fade,
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                //لعمل مسافات متساوية
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    children: [
                      const Icon(
                        //للتقويم
                        Icons.today,
                        color: Color.fromARGB(255, 240, 178, 6),
                      ),
                      const SizedBox(
                        width: 6,
                      ),
                      //$لاستدعاء قيمة duration
                      Text('$duration ايام'),
                    ],
                  ),
                  Row(
                    children: [
                      const Icon(
                        //للتقويم
                        Icons.wb_sunny,
                        color: Color.fromARGB(255, 240, 178, 6),
                      ),
                      const SizedBox(
                        width: 6,
                      ),
                      //$لاستدعاء قيمة duration
                      Text(seasonText!),
                    ],
                  ),
                  Row(
                    children: [
                      const Icon(
                        //للتقويم
                        Icons.family_restroom,
                        color: Color.fromARGB(255, 240, 178, 6),
                      ),
                      const SizedBox(
                        width: 6,
                      ),
                      //$لاستدعاء قيمة duration
                      Text(tripTypeText!),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
