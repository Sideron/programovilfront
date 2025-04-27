# Descripción del Aplicativo Móvil

Este aplicativo móvil está diseñado como un sistema interactivo de preguntas y respuestas orientado a calificar a los profesores de manera positiva. Los estudiantes podrán responder a una serie de preguntas rápidas y sencillas que evaluarán aspectos como claridad al explicar, puntualidad, actitud en clase y dominio del tema. Las respuestas estarán enfocadas en destacar las fortalezas del docente, fomentando una retroalimentación constructiva y motivadora.

Al finalizar la evaluación, el aplicativo permitirá al usuario dejar un comentario adicional para el profesor, el cual será presentado de forma respetuosa y con un enfoque positivo. Esta herramienta busca fortalecer la relación entre docentes y estudiantes, promover buenas prácticas docentes y contribuir al mejoramiento continuo en el ámbito educativo a través de la retroalimentación positiva.


- [Configuración del Ambiente de Desarrollo](#configuracion-del-ambiente-de-desarrollo)
- [Diagrama de despliegue](#diagrama-de-despliegue)
- [Requerimientos no Funcionales](#requerimientos-no-funcionales)
- [Diagrama de Claes](#diagrama-de-clases)


## Configuracion del Ambiente de Desarrollo

Paso a paso que se usará en el proyecto.


![Android Studio](imgs/Android.webp)
*<b>Figura 1:</b> Instalación de Android Studio*

## Diagrama de despliegue

![Diagrama de Despliegue](https://www.plantuml.com/plantuml/png/PP6zJYin48LxFyMHcrIvpUqeK9QV8aKW8f6ePzUpaONNizYp8GJnG3m7BqQyIeWKkf7yVMVcoBEib7JeWialFlQKg8FZbeQWQzvf5VmcTXmL3KVbPCm43-8acoYEOTSSlhzQYO8gkYJUMNmOW9BwbXg5hVhW6sgyH2nawuC5PNHbehutd-QOi_1DaYojejeFYV-aBETO9cavZtxcj3sxDvGPX-6ELFAbELh_N8tLQ_3A_qVVrMTxIP43dhc6ut1S8kaoPbxAjxGleAMCld1lFEPCS2kHTruYPsDFtIocqslOSgh5LK7oqF5ukc-yP3pThzRc-3wYhlu5WnBUiHaeEK8umAvqC_QqzYByiLQEdD18-IfA_i3EEBgX2py0)

*<b>Figura 2:</b> Diagrama de depliegue*
La arquitectura física del sistema móvil. En él se muestra cómo la aplicación móvil, instalada en un teléfono Android, consume los servicios REST proporcionados por una API desplegada en Microsoft Azure. Esta API gestiona las solicitudes tanto desde la app como desde un panel web utilizado por los profesores para visualizar comentarios. Además, la API se conecta a una base de datos SQLite3 donde se consultan y almacenan las calificaciones y opiniones emitidas por los estudiantes.

## Requerimientos No Funcionales

A continuación se presentarán los requerimientos no funcionales para la arquitectura descrita en el diagrama anterior visto. Coonsiderando que se usará Flutter para el desarrollo del proyecto.

### 1. Rendimiento
La aplicación debe iniciar en menos de 3 segundos en dispositivos Android con al menos 2GB de RAM.

### 2. Compatibilidad multiplataforma:
La app desarrollada en Flutter debe ser compatible tanto con Android como con iOS, sin pérdida de funcionalidades o experiencia de usuario.

### 3. Disponibilidad:
El sistema backend desplegado en Azure debe estar disponible el 99.9% del tiempo, permitiendo el acceso constante a la API.

### 4. Escalabilidad:
El sistema debe ser capaz de manejar al menos 1,000 usuarios simultáneos sin pérdida significativa de rendimiento.

### 5. Seguridad:
Toda comunicación entre la app móvil, el panel web y la API debe realizarse mediante el protocolo HTTPS para proteger la información.

### 6. Usabilidad:
La interfaz móvil debe ser intuitiva y estar diseñada con prácticas de UX modernas, facilitando su uso a estudiantes sin capacitación previa.

### 7. Almacenamiento local temporal:
La aplicación debe poder guardar las respuestas de forma local en caso de pérdida de conexión, y sincronizarlas cuando se recupere el acceso a internet.

### 8.Consumo eficiente de recursos:
La aplicación debe minimizar el uso de batería y memoria, asegurando que no consuma más del 5% de recursos en segundo plano.



## Requerimientos Funcionales

A continuación se presentarán los requerimientos no funcionales para la arquitectura descrita en el diagrama anterior visto. Coonsiderando que se usará Flutter para el desarrollo del proyecto.

### 1. Registro de Usuario
 -El usuario podrá registrarse en el sistema proporcionando los datos requeridos (nombre, correo electrónico, contraseña).
 

### 2. Inicio de Sesión:
-Los usuarios deberán iniciar sesión con sus credenciales (correo electrónico y contraseña) para acceder al sistema.

### 3. Búsqueda de Profesor:
-Los usuarios podrán buscar profesores en el sistema utilizando filtros como nombre, materia, universidad.

### 4. Perfil del Profesor:
-Los usuarios podrán acceder al perfil de un profesor para ver más detalles, incluyendo las reseñas anteriores, materias que enseña, etc. 

### 5. Calificación de Profesor:
-Los estudiantes podrán calificar a los profesores en diferentes criterios mediante una encuesta sencilla que calculara la puntualidad, claridad, y dominio de la materia.

### 6. Administrar Profesores:
-Los administradores podrán gestionar los datos de los profesores, editando sus perfiles, actualizando información y gestionando sus calificaciones

### 7. Administrar Calificaciones:
-Los administradores tendrán la capacidad de supervisar y gestionar las calificaciones y comentarios dados por los estudiantes.




## Diagrama de clases
