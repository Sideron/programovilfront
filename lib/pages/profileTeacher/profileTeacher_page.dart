import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:programovilfront/routes/app_routes.dart';
import '../../components/review_item/review_item.dart';
import 'package:programovilfront/pages/profileTeacher/profileTeacher_controller.dart';

class ProfileTeacherPage extends StatelessWidget {
  final int idTeacher;

  ProfileTeacherPage({super.key, required this.idTeacher});

  late final ProfileTeacherController control =
      Get.put(ProfileTeacherController(idTeacher), tag: 'profile_$idTeacher');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(0, 255, 255, 255),
        scrolledUnderElevation: 0,
        toolbarHeight: 40,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, size: 35),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  imageProfile(),
                  SizedBox(width: 24),
                  Expanded(
                    child: Obx(() => Text(
                          control.name.value,
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        )),
                  ),
                ],
              ),
              SizedBox(height: 24),
              Text(
                "Universidad",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              SizedBox(height: 8),
              Obx(() => Wrap(
                    spacing: 8,
                    children: control.colleges.map((college) {
                      return ChoiceChip(
                        label: Text(college['name']),
                        selected: control.selectCollege.value == college,
                        onSelected: (_) =>
                            control.selectCollege.value = college,
                        shape: StadiumBorder(),
                      );
                    }).toList(),
                  )),
              SizedBox(height: 8),
              Text(
                "Categorías",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              SizedBox(height: 8),
              Obx(() => Align(
                    alignment: Alignment.centerRight,
                    child: TextButton.icon(
                      onPressed: () {
                        control.showAllLabels
                            .toggle(); // cambia entre true y false
                      },
                      icon: Icon(
                        control.showAllLabels.value
                            ? Icons.expand_less
                            : Icons.expand_more,
                      ),
                      label: Text(
                        control.showAllLabels.value
                            ? "Ocultar"
                            : "Mostrar todas",
                      ),
                    ),
                  )),
              Obx(() {
                final displayedLabels = control.showAllLabels.value
                    ? control.labels
                    : control.labels.take(6).toList();

                return Wrap(
                  spacing: 8,
                  children: displayedLabels.map((label) {
                    return Chip(
                      label: Text('${label.name} (${label.usageCount ?? 0})'),
                      backgroundColor: Colors.blue[50],
                      shape: StadiumBorder(),
                    );
                  }).toList(),
                );
              }),
              SizedBox(height: 8),
              Divider(
                color: Theme.of(context).colorScheme.primary,
                thickness: 1,
              ),
              Text(
                "Reseñas",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.secondaryContainer,
                ),
              ),
              Obx(() => Column(
                    children: control.reviews.map((rev) {
                      return ReviewItem(
                        review: rev,
                        showCourse: false,
                      );
                    }).toList(),
                  )),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: RateTeacherButton(
          onPressed: () async {
            final result =
                await AppRoutes.goToRateTeacherPage(context, idTeacher);
            if (result == true) {
              await control.reloadProfile();
            }
          },
        ),
      ),
    );
  }

  Widget RateTeacherButton({required VoidCallback onPressed}) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, bottom: 4, top: 4),
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          backgroundColor: const Color.fromARGB(255, 67, 191, 152),
          foregroundColor: Colors.white,
          minimumSize: Size(220, 55),
        ),
        child: const Text(
          'Calificar profesor',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }

  Widget imageProfile() {
    return Obx(() => Container(
          width: 140,
          height: 140,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 6,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: ClipOval(
            child: Image.asset(
              control.image.value.isNotEmpty
                  ? control.image.value
                  : 'assets/images/profileDefault.png',
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Text('Error al cargar la imagen');
              },
            ),
          ),
        ));
  }
}
