import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:programovilfront/pages/profileUser/profileUser_controller.dart';
import 'package:programovilfront/routes/app_routes.dart';
import '../../components/review_item/review_item.dart';

class ProfileUserPage extends StatelessWidget {
  final ProfileUserController control = Get.put(ProfileUserController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 34),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  imageProfile(),
                  SizedBox(width: 24),
                  Expanded(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Obx(() => Text(
                                control.name.value,
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                              )),
                          Obx(() => Text(
                                control.email.value,
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.normal,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                              )),
                          Obx(() => Text(
                                control.college.value,
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.normal,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                              )),
                          SizedBox(height: 16),
                          EditProfileButton(onPressed: () {
                            Navigator.pushNamed(context, AppRoutes.editProfile)
                                .then((_) {
                              control
                                  .loadUserProfile(); // <-- Recarga los datos al volver
                            });
                          }),
                        ]),
                  ),
                ],
              ),
              SizedBox(height: 8),
              Divider(
                color: Theme.of(context).colorScheme.primary,
                thickness: 1,
              ),
              Text(
                "Historial de calificaciones",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.secondaryContainer,
                ),
              ),
              Obx(() => Column(
                    children: control.reviews.map((rev) {
                      return ReviewItem(
                          review: rev, showComment: false, showEmoji: false);
                    }).toList(),
                  )),
              SizedBox(height: 80),
            ],
          ),
        ),
      ),
    );
  }

  Widget EditProfileButton({required VoidCallback onPressed}) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          backgroundColor: const Color.fromARGB(255, 67, 191, 152),
          foregroundColor: Colors.white,
          minimumSize: Size(180, 10),
        ),
        child: const Text(
          'Editar',
          style: TextStyle(fontSize: 16),
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
