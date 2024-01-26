import 'package:flutter/material.dart';
import 'package:traveling_app/app_data.dart';

class TripDetailScreen extends StatelessWidget {
//عند استخدام void نستخدم function لتمرير البيانات
  final Function manageFavorite;
  final Function isFavorite;

  const TripDetailScreen(this.manageFavorite, this.isFavorite, {super.key});

  static const screenRoute = '/trip-detail';

  Widget buildSectionTitle(BuildContext context, String titleText) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      alignment: Alignment.topRight,
      child: Text(
        titleText,
        style: Theme.of(context).textTheme.headlineSmall,
      ),
    );
  }

  Widget buildListViewContainer(Widget child) {
    return Container(
      //لعمل حواف نص دائرية ولونها رمادى وبوكس لونه ابيض
      decoration: BoxDecoration(
          border: Border.all(color: const Color.fromARGB(255, 204, 17, 17)),
          color: Colors.white,
          borderRadius: BorderRadius.circular(10)),
      height: 200,
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    final tripId = ModalRoute.of(context)!.settings.arguments as String;
    //firstwhere لاستخدام عنصر واحد فقط من الداتا الموجودة في trip
    //trip.id في صفحة app_data  لازم تساوى المتغر الجديد اللي انشانا هنا وهو tripId
    final selectedTrip = Trips_data.firstWhere((trip) => trip.id == tripId);

    return Scaffold(
      appBar: AppBar(
        //{}استخدمناها بعد$ للاننا عايزين title فقط
        title: Text('${selectedTrip.title}!'),
      ),
      //هذه الودجت لعمل سكرول
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 300,
              width: double.infinity,
              //fit: BoxFit.coverلكي تغطي حجم الصورة كل المساحة المتوفرة
              child: Image.network(
                selectedTrip.imageurl,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            //بذلك استدعينا الميثود اللي عملناها فوق
            buildSectionTitle(context, 'الانشطة'),
            //عايزين لستة الانشطة  واذا حطناها مباشرة بدون كونتينر سوف يحدث خطاء
            buildListViewContainer(
              ListView.builder(
                itemCount: selectedTrip.activities.length,
                //=>هذا السهم يغنينا عن فتح اقواس وعمل return
                //الكارد مميزاته بيعطي ظل وحواف مدورة بدون بادنج
                //دائما نستخد بداخله  listTile
                itemBuilder: (ctx, index) => Card(
                  elevation: 0.3,
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    child: Text(selectedTrip.activities[index]),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            buildSectionTitle(context, 'البرنامج اليومي'),
            buildListViewContainer(
              ListView.builder(
                itemCount: selectedTrip.program.length,
                itemBuilder: (ctx, index) => Column(
                  children: [
                    //listTile تحتوي علي قسمين علي اليمين وعلي اليسار
                    //leading اليسار -----trailing  اليمين
                    //في المنتصف من فوق  title-----ومن تحت  subbtitle
                    //وبيحط مسافات داخلية بادينج
                    //وبيحط مسافات بين leading   و   title
                    ListTile(
                      //القسم اليميني
                      //بنعمل بها دائرة ونضع بها صورة او نص circleAvater
                      leading: CircleAvatar(
                        //index بتبتدي من اليوم صفر ومفيش اليوم صفر فهنزود واحد
                        child: Text('يوم${index + 1}'),
                      ),
                      title: Text(selectedTrip.program[index]),
                    ),
                    //لعمل خط رفيع
                    const Divider(),
                  ],
                ),
              ),
            ),
            const SizedBox(),
          ],
        ),
      ),
      //لحذف صفحة والرجوع للخلف"زر الحذف"
      floatingActionButton: FloatingActionButton(
        onPressed: () => manageFavorite(tripId),
        //() {
        //#للرجوع للخلفpop
        //  Navigator.of(context).pop(tripId);
        //  },
        child: Icon(isFavorite(tripId) ? Icons.star : Icons.star_border),
      ),
    );
  }
}
