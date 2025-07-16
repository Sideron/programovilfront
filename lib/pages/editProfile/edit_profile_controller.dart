import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:programovilfront/models/colleges.dart';

class EditProfileController extends GetxController {
  final formKey = GlobalKey<FormState>();

  final nombreController = TextEditingController();
  final correoController = TextEditingController();

  final universidades = <College>[
    College(collegeId: 1, name: 'Universidad de Lima', imageUrl: 'abc'),
    College(collegeId: 2, name: 'PUCP', imageUrl: 'abc'),
    College(collegeId: 3, name: 'UNI', imageUrl: 'abc'),
  ].obs;

  final universidadSeleccionada = Rxn<College>();

  void onUniversidadChanged(College? nueva) {
    universidadSeleccionada.value = nueva;
  }

  void guardar() {
    if (formKey.currentState?.validate() ?? false) {
      final nombre = nombreController.text;
      final correo = correoController.text;
      final universidad = universidadSeleccionada.value;

      // Aquí puedes llamar a tu servicio/API para guardar la info
      print('Nombre: $nombre');
      print('Correo: $correo');
      print('Universidad: ${universidad?.name}');

      Get.snackbar('Éxito', 'Perfil actualizado correctamente',
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  @override
  void onClose() {
    nombreController.dispose();
    correoController.dispose();
    super.onClose();
  }
}
