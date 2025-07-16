import 'package:flutter/material.dart';
import 'package:programovilfront/components/alerts/alert_message_box.dart';
import 'package:programovilfront/components/alerts/error_message_box.dart';
import 'package:programovilfront/models/colleges.dart';
import 'package:programovilfront/pages/editProfile/edit_profile_controller.dart';
import 'package:get/get.dart';

class EditProfilePage extends StatelessWidget {
  const EditProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final EditProfileController _controller = Get.put(EditProfileController());
    return Scaffold(
      appBar: AppBar(title: const Text('Editar Perfil')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _controller.formKey,
          child: Column(
            children: [
              // Nombre
              TextFormField(
                controller: _controller.nombreController,
                decoration: const InputDecoration(labelText: 'Nombre'),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Ingrese su nombre' : null,
              ),

              // Correo
              TextFormField(
                controller: _controller.correoController,
                decoration:
                    const InputDecoration(labelText: 'Correo electrónico'),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty)
                    return 'Ingrese su correo';
                  if (!value.contains('@')) return 'Correo no válido';
                  return null;
                },
              ),

              // Universidad
              DropdownButtonFormField<College>(
                decoration: const InputDecoration(labelText: 'Universidad'),
                value: _controller.universidadSeleccionada.value,
                items: _controller.universidades.map((uni) {
                  return DropdownMenuItem(
                    value: uni,
                    child: Text(
                      uni.name.length > 35
                          ? '${uni.name.substring(0, 35)}...'
                          : uni.name,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      softWrap: false,
                    ),
                  );
                }).toList(),
                onChanged: _controller.onUniversidadChanged,
                validator: (value) =>
                    value == null ? 'Seleccione una universidad' : null,
              ),

              const SizedBox(height: 12),

              _controller.errorMessage.value == ''
                  ? Container()
                  : ErrorMessageBox(_controller.errorMessage.value),

              const SizedBox(height: 12),

              // Botón Guardar
              ElevatedButton(
                onPressed: _controller.guardar,
                child: const Text('Guardar'),
              ),
              const SizedBox(height: 12),
              _controller.alertMessage.value == ''
                  ? Container()
                  : AlertMessageBox(_controller.alertMessage.value),
            ],
          ),
        ),
      ),
    );
  }
}
