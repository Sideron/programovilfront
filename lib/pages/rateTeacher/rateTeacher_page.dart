import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'rateTeacher_controller.dart';

class RateTeacherPage extends StatelessWidget {
  final RateTeacherController control = Get.put(RateTeacherController());

  @override
  Widget build(BuildContext context) {
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

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
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
                    children: List.generate(control.currentOptions.length, (index) {
                      final label = control.currentOptions[index];
                      final isSelected = control.selectedIndex.value == index;

                      return ListTile(
                        title: Text(label.name),
                        leading: label.imageUrl.isNotEmpty
                            ? Image.network(label.imageUrl, width: 24, height: 24)
                            : null,
                        tileColor: isSelected ? Colors.teal[100] : null,
                        onTap: () => control.selectOption(index),
                      );
                    }),
                  ),

                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    control.goToNextQuestion();
                  },
                  child: const Text("Siguiente"),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
