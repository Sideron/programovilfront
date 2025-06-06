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
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: 40),
                    Text(
                      group.text,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color:
                            Theme.of(context).colorScheme.onPrimaryFixedVariant,
                      ),
                    ),
                    const SizedBox(height: 24),
                    if (group.imageUrl.isNotEmpty)
                      Container(
                        width: 180,
                        height: 180,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.asset(
                            group.imageUrl,
                            fit: BoxFit.contain,
                            errorBuilder: (context, error, stackTrace) =>
                                const Icon(Icons.broken_image),
                          ),
                        ),
                      ),
                    const SizedBox(height: 32),
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
                        decoration: InputDecoration(
                          filled: true,
                          fillColor:
                              Theme.of(context).colorScheme.secondaryFixed,
                          hintText: 'Selecciona un curso',
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Theme.of(context).colorScheme.outline,
                              width: 1,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Theme.of(context).colorScheme.primary,
                              width: 1.2,
                            ),
                          ),
                        ),
                      ),
                    if (isComentario)
                      TextField(
                        controller: control.commentController,
                        maxLines: 4,
                        decoration: const InputDecoration(
                          hintText: 'Escribe tu comentario...',
                          filled: true,
                          fillColor: Colors.white,
                          border: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                        ),
                      ),
                    if (!isCurso && !isComentario)
                      isClaridad
                          ? Column(
                              children: List.generate(
                                  control.currentOptions.length, (index) {
                                final label = control.currentOptions[index];
                                final isSelected =
                                    control.selectedIndex.value == index;

                                return Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8),
                                  child: GestureDetector(
                                    onTap: () => control.selectOption(index),
                                    child: Container(
                                      width: 90,
                                      height: 90,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        color: isSelected
                                            ? Theme.of(context)
                                                .colorScheme
                                                .secondaryFixedDim
                                            : Colors.white,
                                        border: Border.all(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .secondaryFixedDim,
                                          width: 1.5,
                                        ),
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                      child: FittedBox(
                                        child: Text(
                                          label.name,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 28,
                                            fontWeight: FontWeight.bold,
                                            color: isSelected
                                                ? Theme.of(context)
                                                    .colorScheme
                                                    .onPrimaryContainer
                                                : Theme.of(context)
                                                    .colorScheme
                                                    .onPrimaryFixedVariant,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              }),
                            )
                          : Column(
                              children: List.generate(
                                  control.currentOptions.length, (index) {
                                final label = control.currentOptions[index];
                                final isSelected = control.selectedIndex.value == index;
                                return Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 6),
                                  child: GestureDetector(
                                    onTap: () => control.selectOption(index),
                                    child: Container(
                                      width: double.infinity,
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 16),
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        color: isSelected
                                            ? Theme.of(context)
                                                .colorScheme
                                                .secondaryFixedDim
                                            : Colors.white,
                                        border: Border.all(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .secondaryFixedDim,
                                          width: 1.5,
                                        ),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Text(
                                        label.name,
                                        style: TextStyle(
                                          color: isSelected
                                              ? Theme.of(context)
                                                  .colorScheme
                                                  .onPrimaryContainer
                                              : Theme.of(context)
                                                  .colorScheme
                                                  .onPrimaryFixedVariant,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              }),
                            ),
                    const SizedBox(height: 32),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: control.currentQuestionIndex.value > 0
                              ? () {
                                  control.currentQuestionIndex.value--;
                                  control.updateCurrentOptions();
                                }
                              : null,
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                Theme.of(context).colorScheme.secondaryFixed,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 40, vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: Text(
                            'Regresar',
                            style: TextStyle(
                                color: Theme.of(context)
                                    .colorScheme
                                    .onPrimaryFixedVariant),
                          ),
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
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                Theme.of(context).colorScheme.secondaryFixed,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 40, vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: Text(
                            control.currentQuestionIndex.value ==
                                    control.questions.length - 1
                                ? 'Finalizar'
                                : 'Siguiente',
                            style: TextStyle(
                                color: Theme.of(context)
                                    .colorScheme
                                    .onPrimaryFixedVariant),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
              Positioned(
                top: 8,
                right: 8,
                child: IconButton(
                  icon: const Icon(Icons.close, size: 28),
                  color: Theme.of(context).colorScheme.onPrimaryFixed,
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
