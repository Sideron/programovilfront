import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:programovilfront/models/colleges.dart';
import 'package:programovilfront/services/college_service.dart';
import 'package:programovilfront/services/user_services.dart';

class EditProfileController extends GetxController {
  final String nombreInicial;
  final String correoInicial;

  EditProfileController(
      {required this.nombreInicial, required this.correoInicial});
  final _userService = UserService();
  final CollegeService _collegeService = CollegeService();
  final formKey = GlobalKey<FormState>();

  final nombreController = TextEditingController();
  final correoController = TextEditingController();

  final universidades = <College>[].obs;

  final universidadSeleccionada = Rxn<College>();

  RxString errorMessage = ''.obs;
  RxString alertMessage = ''.obs;

  void onUniversidadChanged(College? nueva) {
    universidadSeleccionada.value = nueva;
  }

  Future<void> cargarUniversidades() async {
    try {
      final lista = await _collegeService.loadCollegessFromJsonAsMap();
      universidades.assignAll(lista);
    } catch (e) {
      print('Error al cargar universidades: $e');
      Get.snackbar('Error', 'No se pudieron cargar las universidades');
    }
  }

  Future<void> guardar() async {
    if (formKey.currentState?.validate() ?? false) {
      final nombre = nombreController.text;
      final correo = correoController.text;
      final universidad = universidadSeleccionada.value;

      if (universidad == null) {
        Get.snackbar('Error', 'Debes seleccionar una universidad');
        return;
      }

      final success = await _userService.editProfile(
        username: nombre,
        email: correo,
        collegeId: universidad.collegeId,
      );

      if (!success) {
        _setErrorMessage('Error, no se puedo editar la informacion');
      } else {
        _setAlertMessage('Cambios guardados!');
      }
    }
  }

  void _setErrorMessage(String message) {
    errorMessage.value = message;
    alertMessage.value = '';
  }

  void _setAlertMessage(String message) {
    errorMessage.value = '';
    alertMessage.value = message;
    Future.delayed(Duration(seconds: 10), () {
      alertMessage.value = '';
    });
  }

  @override
  void onInit() {
    super.onInit();
    nombreController.text = nombreInicial;
    correoController.text = correoInicial;
    cargarUniversidades();
  }

  @override
  void onClose() {
    nombreController.dispose();
    correoController.dispose();
    super.onClose();
  }
}
