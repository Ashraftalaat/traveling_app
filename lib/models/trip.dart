//enumمثل الكلاس لية متغير لازم نعطي له اسم
//يجب ملاحظة اول حرف من enum صغير
// القيمة الفعلية المخزنة خلف لاستى enumهي اعداد فلازم نحطها داخل get لتحويلها اللي string
enum Season {
  winter,
  spring,
  summer,
  autumn,
}

enum TripType {
  exploration,
  recovery,
  activities,
  therapy,
}

class Trip {
  final String id;
  final List<String> categories;
  final String title;
  final String imageurl;
  final List<String> activities;
  final List<String> program;
  final int duration;
  final Season season;
  final TripType tripType;
  final bool isInSummer;
  final bool isInWinter;
  final bool isForFamilies;

  Trip(
      {required this.id,
      required this.categories,
      required this.title,
      required this.imageurl,
      required this.activities,
      required this.program,
      required this.duration,
      required this.season,
      required this.tripType,
      required this.isInSummer,
      required this.isInWinter,
      required this.isForFamilies});
}
