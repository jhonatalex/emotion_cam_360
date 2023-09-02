import 'package:emotion_cam_360/ui/widgets/appcolors.dart';
import 'package:emotion_cam_360/ui/widgets/responsive.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';

class PoliticsPage extends StatelessWidget {
  const PoliticsPage({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> politics = [
      "EMOTION CAM 360",
      "Fecha de entrada en vigor: 30-Ago-2023 \n\n Por favor, lee atentamente estos Términos y Condiciones de Uso antes de utilizar nuestra aplicación móvil EMOTION CAM 360 en plataformas Android y iOS. Al acceder y utilizar la Aplicación, aceptas cumplir con estos Términos. Si no estás de acuerdo con alguno de los términos aquí establecidos, te rogamos que no utilices la Aplicación.",
      "1. Uso de la Cámara y Recursos Multimedia",
      "La Aplicación tiene la funcionalidad de acceder a la cámara de tu dispositivo para grabar videos y capturar imágenes, así como seleccionar contenido multimedia de la galería y la biblioteca de música de tu dispositivo. Al utilizar esta funcionalidad, garantizas que tienes los derechos necesarios para acceder y utilizar dicho contenido, y aceptas no utilizar la Aplicación para fines ilegales o inapropiados.",
      "2. Almacenamiento en la Nube y Conexión a Internet",
      "La Aplicación utiliza la conexión a Internet para almacenar tus videos grabados en la nube. Aceptas que eres responsable de tu conexión a Internet y que cualquier costo asociado con el uso de datos es responsabilidad exclusivamente tuya. No garantizamos la disponibilidad continua o ininterrumpida de nuestros servicios en la nube y nos reservamos el derecho de modificar, suspender o cancelar dichos servicios en cualquier momento.",
      "3. Inicio de Sesión",
      "La Aplicación permite el inicio de sesión a través de varias opciones:"
          "\n\n a) Correo Electrónico y Contraseña: Si eliges esta opción, aceptas proporcionar información precisa y mantener la confidencialidad de tus credenciales. Eres el único responsable de cualquier actividad que ocurra en tu cuenta."
          "\n\n b) Número de Teléfono: Al proporcionar tu número de teléfono, otorgas permiso para que la Aplicación utilice dicho número con fines de autenticación y comunicación."
          "\n\n c) Cuenta de Google: Al optar por iniciar sesión con tu cuenta de Google, aceptas cumplir con los términos y condiciones de Google y otorgas permiso a la Aplicación para acceder a la información de tu cuenta de Google de acuerdo con nuestras políticas de privacidad.",
      "4. Cambios en la Aplicación y Términos",
      "Nos reservamos el derecho de modificar, suspender o discontinuar la aplicación en cualquier momento y sin previo aviso. También podemos modificar estos Términos y Condiciones ocasionalmente. Cualquier cambio se publicará en la aplicación, por lo que te recomendamos revisarlos regularmente. El uso continuado de la aplicación después de cualquier modificación constituirá tu aceptación de los nuevos términos.",
      "5. Limitación de Responsabilidad",
      "En la medida máxima permitida por la ley, [Nombre de la Empresa] no se hace responsable por cualquier daño directo, indirecto, incidental, consecuencial o especial que surja del uso o la imposibilidad de uso de la aplicación.",
      "6. Contacto",
      "Si tienes alguna pregunta sobre estos Términos y Condiciones, puedes ponerte en contacto con nosotros en la sección CONTÁCTANOS.",
      "Al utilizar EMOTION CAM 360, aceptas cumplir con estos Términos y Condiciones de Uso.",
      "Gracias por elegir nuestra aplicación."
          "\n\nAtentamente:"
          "\nEquipo de EMOTION CAM 360",
    ];

    return Scaffold(
        backgroundColor: AppColors.vulcan,
        appBar: AppBar(
          title: Text(
            "TÉRMINOS Y CONDICIONES",
            style: TextStyle(fontSize: sclW(context) * 5),
          ),
          centerTitle: true,
          backgroundColor: AppColors.violet,
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(
                    "assets/img/logo-emotion.png",
                    height: 50,
                  ),
                  TextButton.icon(
                    /* style: const ButtonStyle(
                        backgroundColor:
                            MaterialStatePropertyAll(AppColors.royalBlue)), */
                    onPressed: () {
                      Share.share(
                          'Maravillosa aventura! \nQuiero compartirla contigo... \n Visualiza mi video en: ',
                          subject: 'Mira lo que he hecho!');
                    },
                    icon: const Icon(
                      Icons.share,
                      color: AppColors.royalBlue,
                    ),
                    label: Text(
                      "Compartir",
                      style: TextStyle(
                          fontSize: sclH(context) * 2,
                          color: AppColors.royalBlue,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                child: ListView.builder(
                    itemCount: politics.length,
                    itemBuilder: (BuildContext, Index) {
                      return Index.isEven
                          ? Text(
                              politics[Index],
                              style: TextStyle(
                                  fontSize: sclH(context) * 2.8,
                                  color: AppColors.violet,
                                  fontWeight: FontWeight.bold,
                                  shadows: const [
                                    Shadow(
                                        color: Colors.white,
                                        offset: Offset(0.5, 0.5),
                                        blurRadius: 1)
                                  ]),
                            )
                          : Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                politics[Index],
                                style: TextStyle(
                                    fontSize: sclH(context) * 2.0,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                                textAlign: TextAlign.justify,
                              ),
                            );
                    }), /* ListView.builder(
                  children: [
                    Text(
                      "Importante",
                      style: TextStyle(
                          fontSize: sclH(context) * 2.5,
                          color: AppColors.royalBlue,
                          fontWeight: FontWeight.bold),
                    ),
                    const Text(
                        "Lorem Ipsum is simply dummy text of the printing and typesetting industry. heets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.\n"),
                    Text(
                      "Importante",
                      style: TextStyle(
                          fontSize: sclH(context) * 2.5,
                          color: AppColors.royalBlue,
                          fontWeight: FontWeight.bold),
                    ),
                    const Text(
                        "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum."),
                    const Text(
                        "\nLorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum."),
                    ListTile(
                      title: Text(
                        "A. iOS Terms & Conditions.",
                        style: TextStyle(
                            fontSize: sclH(context) * 2.5,
                            color: AppColors.royalBlue,
                            fontWeight: FontWeight.bold),
                      ),
                      trailing: const Icon(Icons.arrow_forward_ios),
                    ),
                    const Text(
                        "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum."),
                  ],
                ),*/
              ),
              TextButton(
                onPressed: () {
                  Get.back();
                },
                child: Text(
                  "Aceptar",
                  style: TextStyle(
                      fontSize: sclH(context) * 2.5,
                      color: AppColors.royalBlue,
                      fontWeight: FontWeight.bold),
                ),
              )
            ],
          ),
        ));
  }
}
