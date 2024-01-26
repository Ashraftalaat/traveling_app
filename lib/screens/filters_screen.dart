import 'package:flutter/material.dart';
import '../widgets/app_drawer.dart';

class FiltersScreen extends StatefulWidget {
  static const screenRoute = '/filters';

//لازم ننشئ متغير جديد من نوع function  عشان methodاللي مررناها "_changeData" من صفحةmain.dart
  // الباني من فوق
  final Function saveFilters;

  final Map<String, bool> currentFilters;

  const FiltersScreen(this.saveFilters, this.currentFilters, {super.key});

  @override
  State<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
//var = bool = false or  true
// عملنا المتغيرات عشان المحول
// القيمة الاولية للمحول هتكون false
  var _summer = false;
  var _winter = false;
  var _family = false;

//بعد كدة المحول لو اتتغير  هيتم حفظ التغيير
  @override // توضع @override اذا لم يتم وضعها تلقائي قبلinitstate
  void initState() {
    _summer = widget.currentFilters['summer'] as bool;
    _winter = widget.currentFilters['winter'] as bool;
    _family = widget.currentFilters['family'] as bool;
    super.initState();
  }

  //widget  اعم واشمل
  //void Function(bool)?  =  Function الاصدار القديم
  Widget buildSwitchListTile(String title, String subtitle, var currentVale,
      void Function(bool)? updateValue) {
    return SwitchListTile(
      title: Text(title),
      //نص فرعي بيظهر تحت النص الرئيسي
      subtitle: Text(subtitle),
      value: currentVale,
      onChanged: updateValue,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('الفلترة'),
          //بتساعد علي اضافة عناصر علي الطرف الثاني من appBar
          actions: [
            //مثل اي زر لازم ننشاء method في نفس صفحة main.dart
            IconButton(
                onPressed: () {
                  //بالضغط عليها هيتم تفعيل الميثود_changefilters الموجودة في main.dart
                  final selectedFilters = {
                    //عبارة عن map
                    // القيمة الجديدة لازرار الفلاتر بفضل المتغيرات اللي عملناها فوق var _summer=false;
                    'summer': _summer,
                    'winter': _winter,
                    'family': _family,
                  };
                  //بدل ما نستدعي FiltersScreen.saveFilters نستخدم widgetلانها موجودة في نفس الملف
                  //وتم كتابتها لتمريرها داخلsave
                  widget.saveFilters(selectedFilters);
                },
                icon: const Icon(Icons.save))
          ],
        ),
        drawer: const AppDrawer(),
        body: Column(
          children: [
            //لكي يأخذ child كل المساحة المتوفرة
            Expanded(
              child: ListView(
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  //الزر  او   المحول  او  القاطع
                  buildSwitchListTile(
                    'الرحلات الصيفية فقط',
                    'اظهار الرحلات في فصل الصيف',
                    _summer,
                    (newValue) {
                      setState(
                        () {
                          _summer = newValue;
                        },
                      );
                    },
                  ),
                  buildSwitchListTile(
                    'الرحلات الشتوية فقط',
                    'اظهار الرحلات في فصل الشتاء',
                    _winter,
                    (newValue) {
                      setState(
                        () {
                          _winter = newValue;
                        },
                      );
                    },
                  ),
                  buildSwitchListTile(
                    'الرحلات العائلية فقط',
                    'اظهار الرحلات العائلية',
                    _family,
                    (newValue) {
                      setState(
                        () {
                          _family = newValue;
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
