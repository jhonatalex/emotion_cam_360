// ignore_for_file: unused_local_variable
import 'package:emotion_cam_360/controllers/event_controller.dart';
import 'package:emotion_cam_360/ui/pages/suscripcion/subscription_controller.dart';
import 'package:emotion_cam_360/ui/routes/route_names.dart';
import 'package:emotion_cam_360/ui/widgets/appcolors.dart';
import 'package:emotion_cam_360/ui/widgets/background_gradient.dart';
import 'package:emotion_cam_360/ui/widgets/responsive.dart';
import 'package:emotion_cam_360/ui/pages/suscripcion/subscription.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

final ScrollController _controller = ScrollController();

class GraciasPage extends StatefulWidget {
  const GraciasPage({super.key});

  @override
  State<GraciasPage> createState() => _GraciasPageState();
}

class _GraciasPageState extends State<GraciasPage> {
  @override
  void initState() {
    super.initState();
    Get.find<EventController>().getAllSuscripcionesController();

    getDateSaved();
    getEmailCurrentUser();
  }

  final _evenController = Get.find<EventController>();
  final _subscriptionController = Get.find<SubscriptionController>();

  String? emailUser = '';

  bool actualizado = false;
  void getEmailCurrentUser() async {
    emailUser = await authClass.getEmailToken();
    if (emailUser!.isNotEmpty && actualizado == false) {
      actualizado = true;
      print("Usuario: $emailUser ");
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    /* double xOffset = 200;
    double yOffset = 500;
    final left1 = sclW(context) * 15;
    final top1 = sclH(context) * 5;
    final left2 = sclW(context) * 10;
    final top2 = sclH(context) * 65;
    final left3 = sclW(context) * 55;
    final top3 = sclH(context) * 65; */
    return Obx(() {
      var items = _evenController.suscripciones;
      var dataPayment = _subscriptionController.dataTransaccion.value;

      return Stack(children: [
        BackgroundGradient(context),
        Scaffold(
            //extendBodyBehindAppBar: true,
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              title: Text(
                "SUBSCRIPCIONES",
                style: TextStyle(fontSize: sclW(context) * 5),
              ),
              centerTitle: true,
              actions: [
                IconButton(
                  icon: const Icon(
                    Icons.info_outline,
                    // color: diasRestantes() > 3 ? Colors.green : Colors.orange,
                  ),
                  onPressed: () async {
                    String date = "";
                    int dias = 0;
                    date = formatDatatime(dateSaved());
                    dias = await diasRestantes();
                    setState(
                      () {},
                    );
                    //dialog con GetX
                    Get.defaultDialog(
                      backgroundColor: AppColors.vulcan,
                      radius: 10.0,
                      contentPadding: const EdgeInsets.all(20.0),
                      title: 'Información de Subscripción',
                      titleStyle: const TextStyle(color: AppColors.royalBlue),
                      middleText: 'Fecha de Vencimiento: $date  \n'
                          'Días Restantes: $dias',
                      middleTextStyle: TextStyle(fontSize: sclH(context) * 3),
                      textConfirm: 'Okay',
                      confirm: ElevatedButton(
                        onPressed: () => Get.back(),
                        child: const Text(
                          'Aceptar',
                        ),
                      ),
                      /* cancel: OutlinedButton.icon(
                            onPressed: () {},
                            icon: Icon(Icons.cancel),
                            label: Text("cancelar"),
                          ), */
                    );
                  },
                ),
              ],
            ),
            body: Column(
              children: [
                Wrap(
                  alignment: WrapAlignment.center,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    if (emailUser != '')
                      Text(
                        emailUser! /* == null
                            ? ''
                            : emailUser!.length >=
                                    18 //evitar que se desborde hacia right
                                ? '${emailUser!.substring(0, 18)}...'
                                : '$emailUser' */
                        ,
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: sclH(context) * 2.5),
                      ),
                    TextButton.icon(
                      icon: Icon(
                        emailUser == null
                            ? Icons.login_outlined
                            : Icons.logout_outlined,
                        size: sclH(context) * 2.5,
                        color: Colors.white,
                      ),
                      label: Text(
                        emailUser == null ? 'Iniciar sesión' : 'Cerrar Sesión',
                        style: TextStyle(
                          fontSize: sclH(context) * 2,
                          color: Colors.white,
                        ),
                      ),
                      onPressed: () async {
                        await authClass.logout();
                        //Get.find<AuthController>().signOut();
                        Get.offAllNamed(RouteNames.signIn);
                      },
                    ),
                  ],
                ),
                Expanded(
                    child: AnimatedContainer(
                  duration: const Duration(seconds: 1),
                  child: SubscriptionCard(dataPayment, context),
                )),
              ],
            ))
      ]);
    });
  }

  getTextStatus(dataPayment) {
    List<String> text = [];
    switch (dataPayment.status) {
      case 'approved':
        text.add('Pago Exitoso');
        text.add('Ya puede Seguir Disfrutando');
        text.add('assets/img/bien.png');
        break;

      case 'in_process':
        text.add('Pago en Proceso');
        text.add('Se esta verificando su pago');
        text.add('assets/img/intermedio.png');
        break;

      default:
        text.add('Pago Rechazado');
        text.add('Favor reintente su pago');
        text.add('assets/img/mal.png');
    }
    return text;
  }

  Widget SubscriptionCard(dataPayment, context) {
    return Container(
      //width: sclW(context) * 70,
      height: sclH(context) * 64,
      margin: EdgeInsets.symmetric(
          vertical: sclW(context) * 15, horizontal: sclW(context) * 8),
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(
            Radius.circular(35),
          ),
          color: AppColors.vulcan,
          boxShadow: [
            BoxShadow(
                color: AppColors.vulcan.withOpacity(.5),
                offset: const Offset(-10, 10),
                blurRadius: 10),
          ]),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            getTextStatus(dataPayment)[2],
            height: sclH(context) * 15,
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: sclH(context) * 0.5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(vertical: sclH(context) * 0.5),
                  child: Text(
                    getTextStatus(dataPayment)[0],
                    style: TextStyle(
                        color: AppColors.white, fontSize: sclW(context) * 6),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: sclH(context) * 0.5),
                  child: Text(
                    getTextStatus(dataPayment)[1],
                    style: TextStyle(
                        color: AppColors.white, fontSize: sclW(context) * 5),
                  ),
                )
              ],
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ListTile(
                  leading: const Icon(Icons.check_circle_outline),
                  title: Row(
                    children: [
                      Text(
                        "ESTADO:  ",
                        style: TextStyle(fontSize: sclW(context) * 4),
                      ),
                      Text(
                        dataPayment.statusDetail,
                        style: TextStyle(fontSize: sclW(context) * 4),
                      )
                    ],
                  ),
                ),
                ListTile(
                  leading: const Icon(Icons.check_circle_outline),
                  title: Row(
                    children: [
                      Text(
                        "METODO DE PAGO:  ",
                        style: TextStyle(fontSize: sclW(context) * 4),
                      ),
                      Text(
                        dataPayment.paymentMethodId,
                        style: TextStyle(fontSize: sclW(context) * 4),
                      )
                    ],
                  ),
                ),
                ListTile(
                  leading: const Icon(Icons.check_circle_outline),
                  title: Row(
                    children: [
                      Text(
                        "TIPO DE PAGO:  ",
                        style: TextStyle(fontSize: sclW(context) * 4),
                      ),
                      Text(
                        dataPayment.paymentTypeId,
                        style: TextStyle(fontSize: sclW(context) * 4),
                      )
                    ],
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: () => Get.offNamed(RouteNames.home),
                  icon: CircleAvatar(
                    radius: sclH(context) * 2,
                    backgroundColor: Colors.white,
                    foregroundColor: AppColors.violet,
                    child: Icon(
                      Icons.home,
                      size: sclH(context) * 3,
                    ),
                  ),
                  label: const Text(
                    "Ir Home",
                    style: TextStyle(color: AppColors.white),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
