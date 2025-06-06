import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:programovilfront/routes/app_routes.dart';
import 'rateTeacher_controller.dart';

class RateTeacherPage extends StatelessWidget {
  final int idTeacher;

  RateTeacherPage({required this.idTeacher, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final RateTeacherController control =
        Get.put(RateTeacherController(idTeacher: idTeacher));

    return Scaffold(
      body: SafeArea(
        child: Obx(() {
          if (control.questions.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          final group = control.currentQuestion;
          final isCurso = group.name.toLowerCase() == 'curso';
          final isComentario = group.name.toLowerCase() == 'comentario';
          final isClaridad = group.name.toLowerCase() == 'claridad';

          return Stack(
            children: [
              SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    const SizedBox(
                        height: 40), // espacio para el botón de cerrar

                    Text(
                      group.text,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 20),
                    ),
                    const SizedBox(height: 16),

                    if (!isClaridad && group.imageUrl.isNotEmpty)
                      Image.network(
                        group.imageUrl,
                        width: 200,
                        errorBuilder: (context, error, stackTrace) =>
                            const Icon(Icons.broken_image),
                      ),

                    const SizedBox(height: 16),

                    if (isCurso)
                      DropdownButtonFormField<String>(
                        value: control.selectedCourse.value,
                        items: control.courseOptions
                            .map((course) => DropdownMenuItem(
                                  value: course,
                                  child: Text(course),
                                ))
                            .toList(),
                        onChanged: (value) {
                          control.selectedCourse.value = value!;
                        },
                      ),

                    if (isComentario)
                      TextField(
                        controller: control.commentController,
                        maxLines: 5,
                        decoration: const InputDecoration(
                          hintText: 'Escribe tu comentario...',
                        ),
                      ),

                    if (!isCurso && !isComentario)
                      Column(
                        children: List.generate(control.currentOptions.length,
                            (index) {
                          final label = control.currentOptions[index];
                          final isSelected =
                              control.selectedIndex.value == index;

                          return ListTile(
                            title: Text(label.name),
                            leading: label.imageUrl.isNotEmpty
                                ? Image.network(label.imageUrl,
                                    width: 24, height: 24)
                                : null,
                            tileColor: isSelected ? Colors.teal[100] : null,
                            onTap: () => control.selectOption(index),
                          );
                        }),
                      ),

                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          onPressed: control.currentQuestionIndex.value > 0
                              ? () {
                                  control.currentQuestionIndex.value--;
                                  control.updateCurrentOptions();
                                }
                              : null,
                          child: const Text('Regresar'),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            if (control.currentQuestionIndex.value ==
                                control.questions.length - 1) {
                              AppRoutes.goToProfileTeacher(context, idTeacher);
                            } else {
                              control.goToNextQuestion();
                            }
                          },
                          child: Text(
                            control.currentQuestionIndex.value ==
                                    control.questions.length - 1
                                ? 'Finalizar'
                                : 'Siguiente',
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Botón de cerrar
              Positioned(
                top: 8,
                right: 8,
                child: IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () {
                    AppRoutes.goToProfileTeacher(context, idTeacher);
                  },
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
