# Descripción del Aplicativo Móvil

El aplicativo móvil "ProfeStats" está diseñado como un sistema interactivo de preguntas y respuestas orientado a calificar a los profesores de manera positiva. Los estudiantes podrán responder a una serie de preguntas rápidas y sencillas que evaluarán aspectos como claridad al explicar, puntualidad, actitud en clase y dominio del tema. Las respuestas estarán enfocadas en destacar las fortalezas del docente, fomentando una retroalimentación constructiva y motivadora.

Al finalizar la evaluación, el aplicativo permitirá al usuario dejar un comentario adicional para el profesor, el cual será presentado de forma respetuosa y con un enfoque positivo. Esta herramienta busca fortalecer la relación entre docentes y estudiantes, promover buenas prácticas docentes y contribuir al mejoramiento continuo en el ámbito educativo a través de la retroalimentación positiva.

- [Configuración del Ambiente de Desarrollo](#configuracion-del-ambiente-de-desarrollo)
- [Diagrama de despliegue](#diagrama-de-despliegue)
- [Requerimientos no Funcionales](#requerimientos-no-funcionales)
- [Requerimientos Funcionales](#requerimientos-funcionales)
- [Diagrama de Casos de Uso](#diagrama-de-casos-de-uso)
- [Diagrama Relacional](#diagrama-relacional)
- [Diagrama de Clases](#diagrama-de-clases)
- [Mockups](#mockups)

## Configuracion del Ambiente de Desarrollo

Paso a paso que se usará en el proyecto.

![Android Studio](https://storage.googleapis.com/gweb-developer-goog-blog-assets/images/Android-Studio-banner_1.original.png)
_<b>Figura 1:</b> Descripción de Android Studio_

<b>Android Studio</b> es el entorno de desarrollo oficial para crear aplicaciones Android. Ofrece un editor de código inteligente, diseño visual de interfaces, emuladores de dispositivos y un sistema de compilación basado en Gradle.

Este se estará usando con el objetivo de emular el dispositivo movil desde el cual podremos probar nuestra aplicación sin necesidad de exportarla. Ademas, al momento de exportar la aplicación este nos podrá proveer con los SDK necesarios para poder hacerlo.

![Flutter](https://css-tricks.com/wp-content/uploads/2022/08/flutter-clouds.jpg)
_<b>Figura 2:</b> Descripción de Flutter_

<b>Flutter</b> es un framework de desarrollo de código abierto creado por Google para construir aplicaciones nativas multiplataforma (Android, iOS, web y escritorio) usando un solo código base. Utiliza el lenguaje <b>Dart</b> y destaca por su alta velocidad, su sistema de widgets personalizables y su enfoque en un rendimiento similar al nativo.

Este nos permitirá desarrollar la parte del cliente de la aplicación de manera práctica adaptado para dispositivos Android como iOS.

![Ruby On Rails](https://miro.medium.com/v2/resize:fit:1000/1*lEXUSkEm6M6kIHmKP9HtWg.png)
_<b>Figura 3:</b> Descripción de Ruby_

<b>Ruby on Rails</b> es un framework de desarrollo web basado en el lenguaje Ruby. Facilita la creación de aplicaciones web siguiendo el modelo MVC (Modelo-Vista-Controlador) y promueve el desarrollo rápido mediante convenciones y buenas prácticas.

Usaremos Ruby on Rails para la parte del servidor, creando una API REST que permita a la aplicación móvil Android consultar, enviar y actualizar información. Rails se encargaría de procesar las solicitudes del teléfono, gestionar la lógica de negocio y comunicarse con la base de datos.

![Ruby On Rails](https://miro.medium.com/v2/resize:fit:1200/1*fMPUMki182HzyVZvo_awDw.png)
_<b>Figura 4:</b> Descripción de SQLite_

<b>SQLite</b> es un motor de base de datos relacional, ligero y autónomo, que almacena los datos en un único archivo local. Funciona sin necesidad de un servidor y es ampliamente utilizado en diversos tipos de aplicaciones donde se requiere una gestión sencilla y eficiente de datos.

Usaremos este motor en el mismo servidor para almacenar los datos tanto de nuestra aplicación como de los usuario que se registren.

## Diagrama de despliegue

![Diagrama de Despliegue](https://www.plantuml.com/plantuml/png/POyxJWD138RxESMlQQX2GqU14Xu51IXASW7lsXkDc1alyuWI8Gx4ERWOiwi04ZIM9N_VRtkP2wLIWpVvnSMH4WMm35HzsScnhBpRno2ne6z5aZ4NU5RMRAAomEx4VtuC6XMho4aTMxmPe4MwWVe2kngzwwbt6l6a1-SjA2DC7OsZUJVddAsaWsDDsDJkz2zZ_OXrqa7oREV6_fgtb0MjkQUY-QyvMvVSOVlgNP6hsUTkijiZTnhbw5h9ndwVPB5OtC1EEook9oJN8FDErxx8s3niT-Oydr7kVa1V22ViAoKc-0RpT9GnIubSW_y2)

_<b>Figura 5:</b> Diagrama de depliegue_

La arquitectura física de la aplicación móvil de evaluación de profesores, donde la aplicación instalada en un teléfono Android consume los servicios REST proporcionados por un servidor Ruby que ejecuta la API Profes. Esta API se encarga de procesar las solicitudes enviadas desde la app, gestionar la lógica de negocio y realizar operaciones de consulta y almacenamiento de datos en una base de datos local Profe.db basada en SQLite3, asegurando una comunicación eficiente entre los componentes.

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

A continuación se presentarán los requerimientos funcionales para la arquitectura descrita en el diagrama anterior visto. Coonsiderando que se usará Flutter para el desarrollo del proyecto.

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

## Diagrama de Casos de Uso

![Diagrama de Casos de Uso](imgs/Diagrama%20de%20Casos%20de%20Uso.jpg)

_<b>Figura 6:</b> Diagrama de Casos de uso_

El diagrama de casos de uso representa las principales funcionalidades de la aplicación "ProfeStats" de evaluación positiva de profesores. En él, el usuario puede registrarse, iniciar sesión, buscar profesores, consultar el perfil de un profesor y calificarlo mediante una encuesta basada en criterios de puntualidad, claridad y dominio de la materia. Por otro lado, el administrador tiene acceso a funcionalidades específicas para administrar profesores y gestionar calificaciones y comentarios.

## Diagrama Relacional

![Diagrama Relacional](imgs/DiagERD.png)

_<b>Figura 7:</b> Diagrama Relacional_

Este diagrama muestra la estructura de base de datos que soportará la aplicación. Define cómo se almacenan y relacionan los datos de usuarios, profesores, cursos, reseñas y niveles de satisfacción. Cada tabla representa una entidad clave como los usuarios o profesores, y las líneas indican las relaciones entre ellas, principalmente usando llaves foráneas (FK). Esto permitirá que la app registre evaluaciones positivas de profesores de manera organizada, asocie comentarios, calificaciones y cursos, y relacione cada evaluación con etiquetas y niveles de satisfacción.

## Diagrama de Clases

![Diagrama Relacional](imgs/DiagramaClasesPM.png)
_<b>Figura 8:</b> Diagrama de Clases_

Este diagrama describe la estructura lógica y funcional de la aplicación desde el punto de vista de la programación. Define clases como el Usuario, Administrador, Profesor y Calificacion, etc. Estas clases están junto con sus respectivos atributos y métodos. También se muestran las relaciones entre las clases como por ejemplo:
Un Usuario puede hacer múltiples Calificaciones y un Profesor puede recibir varias Calificaciones.

## Mockups

|                                                                                                                                                              Mockup                                                                                                                                                              | Descripción                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| :------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------: | :------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
|                                                                                                                        **Pantalla de Registro (Sign In)**<br> <img src="/mockup/Log_In.png" width="150"/>                                                                                                                        | La pantalla de **Registro** permite a nuevos usuarios crear una cuenta en _ProfeStats_. <br><br>Incluye los siguientes campos:<br>- **Correo electrónico**: Campo para ingresar un correo válido.<br>- **Contraseña**: Campo para definir una contraseña segura.<br>- **Confirmar contraseña**: Campo para confirmar la contraseña ingresada.<br><br>Además, cuenta con un botón **Registrarse** para completar el proceso de creación de cuenta.                                                                                                                                                                                                                                                 |
|                                                                                                                    **Pantalla de Inicio de Sesión (Log In)** <br> <img src="mockup/Sign_In.png" width="150"/>                                                                                                                    | La pantalla de **Inicio de Sesión** permite a los usuarios existentes ingresar a su cuenta en _ProfeStats_. <br><br>Incluye los siguientes campos:<br>- **Correo electrónico**: Campo para ingresar el correo registrado.<br>- **Contraseña**: Campo para ingresar la contraseña correspondiente.<br><br>Cuenta con un botón **Iniciar Sesión** para acceder a la aplicación.                                                                                                                                                                                                                                                                                                                     |
|                                                           **Página Principal - Buscar Universidades o Profesores** <br> <img src="mockup/Pagina_Principal(Buscar_profesor).png" width="150"/><img src="mockup/Pagina_Principal(Buscar_universidad).png" width="150"/>                                                            | La **Página Principal** permite al usuario buscar universidades o profesores para calificarlos o consultar sus evaluaciones. <br><br>Incluye:<br>- **Barra de búsqueda**: Permite buscar universidades o profesores por nombre.<br>- **Tabs "Universidades" y "Profesores"**: Cambian la vista para mostrar ya sea una lista de universidades o de profesores destacados.<br>- **Listado de resultados**: Muestra nombres, fotos y número de calificaciones de cada universidad o profesor.<br><br>También incorpora un **menú de navegación inferior** con accesos rápidos.                                                                                                                      |
|                                                   **Página de Universidad - Buscar Profesores o Curso** <br> <img src="mockup/Buscar_en_universidad_seleccionada(Profesores).png" width="150"/> <img src="mockup/Buscar_en_universidad_seleccionada(Cursos).png" width="150"/>                                                   | Al seleccionar una universidad, se muestra la **Página de Detalle de Universidad** enfocada en profesores. <br><br>Incluye:<br>- **Nombre y logo de la universidad** en la parte superior.<br>- **Barra de búsqueda**: Para buscar profesores o cursos dentro de esa universidad.<br>- **Tabs "Profesores" y "Cursos"**: Permiten alternar entre profesores y los cursos disponibles.<br> - **Listado de profesores** mostrando nombre, foto y número de calificaciones.<br> - **Listado de cursos** ofrecidos, cada uno representado con un ícono de color.                                                                                                                                      |
|                                                                                                                   **Profesores por curso** <br> <img src="/mockup/Elegir_profesor_por_curso.png" width="150"/>                                                                                                                   | Al seleccionar un curso, el usuario es redirigido a esta interfaz que muestra una **lista de profesores** que han impartido ese curso. <br>Cada profesor está identificado por su **foto de perfil**, **nombre** y el **número de calificaciones** recibidas.                                                                                                                                                                                                                                                                                                                                                                                                                                     |
|                                                                                                                           **Perfil de Alumno** <br> <img src="mockup/Alumno_perfil.png" width="150"/>                                                                                                                            | Muestra la página de **perfil del alumno** donde se puede ver:<br>- **Foto, nombre y universidad** del alumno.<br>- **Historial de calificaciones** que el alumno ha realizado.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   |
|                                                                                                                           **Perfil de Profesor** <br> <img src="mockup/Profe_perfil.png" width="150"/>                                                                                                                           | Vista del **perfil de un profesor**, donde se puede consultar:<br>- **Foto, nombre y universidad** donde enseña.<br>- **Etiquetas** que describen características del profesor, **obtenidas a partir de las calificaciones de los alumnos** (por ejemplo: "Organizado", "Práctico", "Dinámico").<br>- **Sección de reseñas**, donde los alumnos han dejado comentarios breves acompañados de **íconos** relacionados con la calificación otorgada.<br>Al **presionar sobre una reseña**, se muestra un **resumen detallado** de la calificación dada.<br>- **Botón para calificar al profesor**.                                                                                                  |
| **Proceso de Calificación de Profesor** <br> <img src="mockup/Calificar_de_forma_interactiva-1.png" width="100"/> <img src="mockup/Calificar_de_forma_interactiva-2.png" width="100"/> <img src="mockup/Calificar_de_forma_interactiva-4.png" width="100"/> <img src="mockup/Calificar_de_forma_interactiva-3.png" width="100"/> | El flujo para calificar a un profesor se compone de varias pantallas secuenciales:<br><br>**1. Elige el curso**<br>El usuario selecciona el curso en el que tuvo al profesor a calificar.<br><br>**2. Claridad de la explicación**<br>Pregunta al usuario "¿Qué tan claro explica el profesor?" con opciones como:<br>- Muy claro<br>- Claro<br>- Algo claro<br>- Un poco claro<br><br>**3. Calificación general**<br>Pregunta "En general, ¿qué calificación le darías al profesor?" con opciones de:<br>- Excelente<br>- Buena<br>- Regular<br>- Mala<br><br>**4. Añadir un comentario (opcional)**<br>Permite escribir una reseña adicional sobre el profesor antes de enviar la calificación. |

Vista completa del Mockup: https://www.figma.com/design/5XnSycx9FiWNkJUkTclBnf/Interfaces?node-id=0-1&p=f&t=reZS3X4rwvd8olXb-0
