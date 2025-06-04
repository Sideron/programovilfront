import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:programovilfront/pages/profileUser/profileUser_controller.dart';
import '../../components/review_item/review_item.dart';

class ProfileUserPage extends StatelessWidget {
  final ProfileUserController control = Get.put(ProfileUserController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                        label: Text(college.name),
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
              Obx(() => Wrap(
                    spacing: 8,
                    children: control.labels.map((label) {
                      return Chip(
                        label: Text(label),
                        backgroundColor: Colors.blue[50],
                        shape: StadiumBorder(),
                      );
                    }).toList(),
                  )),
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
                      return ReviewItem(review: rev);
                    }).toList(),
                  )),
              SizedBox(height: 80),
            ],
          ),
        ),
      ),
      bottomNavigationBar: RateTeacherButton(
        onPressed: () {
          print("Presionaste 'Calificar profesor");
        },
      ),
    );
  }

  Widget RateTeacherButton({required VoidCallback onPressed}) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          backgroundColor: const Color.fromARGB(255, 67, 191, 152),
          foregroundColor: Colors.white,
          minimumSize: Size(220, 50),
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
