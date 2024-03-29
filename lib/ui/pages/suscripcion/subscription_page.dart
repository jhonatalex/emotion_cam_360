import 'package:chalkdart/chalk.dart';
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

class SubscriptionPage extends StatefulWidget {
  const SubscriptionPage({super.key});

  @override
  State<SubscriptionPage> createState() => _SubscriptionPageState();
}

class _SubscriptionPageState extends State<SubscriptionPage> {
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
      var isloading = _subscriptionController.isLoading.value;

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
                        emailUser!
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
                  child: ListView.builder(
                      itemCount: items.length,
                      itemBuilder: (context, index) {
                        final item = items[index];
                        print(chalk.white.bold(item.dias));
                        return AnimatedContainer(
                          duration: const Duration(seconds: 1),
                          //transform: Matrix4.translationValues(left2, top2, 0)..scale(0.5),
                          child: subscriptionCard(
                            context,
                            item.name,
                            item.typeDate,
                            item.featureOne,
                            item.featureTwo,
                            item.featureThree,
                            item.saving,
                            item.price.toString(),
                            item.dias,
                            isloading,
                          ),
                        );
                      }),
                ),
              ],
            )

  

            )
      ]);
    });
  }

  Widget subscriptionCard(
      context,
      String title,
      String timeSubs,
      String feature1,
      String feature2,
      String feature3,
      int desc,
      String precio,
      int ndia,
      bool isloading) {
    return Container(
      //width: sclW(context) * 70,
      height: sclH(context) * 64,
      margin: EdgeInsets.symmetric(
          vertical: sclW(context) * 5, horizontal: sclW(context) * 15),
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
          Container(
            padding: EdgeInsets.symmetric(vertical: sclH(context) * 1.5),
            child: Text(
              title,
              style: TextStyle(
                  color: AppColors.white, fontSize: sclW(context) * 6),
            ),
          ),
          Container(
            width: sclW(context) * 62,
            height: sclH(context) * 48,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(35),
              ),
              color: AppColors.royalBlue,
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ListTile(
                    title: Text(
                      "Subscripción $timeSubs",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: sclW(context) * 4,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  ListTile(
                    leading: const Icon(Icons.check_circle_outline),
                    title: Text(
                      feature1,
                      style: TextStyle(fontSize: sclW(context) * 4),
                    ),
                  ),
                  ListTile(
                    leading: const Icon(Icons.check_circle_outline),
                    title: Text(
                      feature2,
                      style: TextStyle(fontSize: sclW(context) * 4),
                    ),
                  ),
                  ListTile(
                    leading: const Icon(Icons.check_circle_outline),
                    title: Text(
                      feature3,
                      style: TextStyle(fontSize: sclW(context) * 4),
                    ),
                  ),
                  ListTile(
                    leading: const Icon(Icons.check_circle_outline),
                    title: Text(
                      "Ahorro del $desc%",
                      style: TextStyle(fontSize: sclW(context) * 4),
                    ),
                  ),
                  ListTile(
                    leading: const Icon(Icons.price_change_outlined),
                    title: Text(
                      "\$ $precio CLP",
                      style: TextStyle(fontSize: sclW(context) * 4),
                    ),
                  ),

                  /* Spacer(),
                  CircleAvatar(
                    radius: sclH(context) * 4,
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.home,
                      size: sclH(context) * 5,
                    ),
                    foregroundColor: AppColors.violet,
                  ) */
                ],
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.all(2),
            child: ElevatedButton(
              onPressed: () async {

                int iDiasRestantes = await diasRestantes();
                String sDateSaved = formatDatatime(dateSaved());
                String sDateLimit = formatDatatime(_subscriptionController.updateDateLimit(ndia));

                
                Get.defaultDialog(
                  backgroundColor: AppColors.vulcan,
                  radius: 10.0,
                  contentPadding: const EdgeInsets.all(20.0),
                  title: 'Realizar pago',
                  titleStyle: const TextStyle(
                    color: AppColors.royalBlue,
                  ),
                  middleText:
                      'Días Restantes: $iDiasRestantes \n\nDespues de realizar el pago añadiremos $ndia dias  \n\nFecha de Vencimiento actual: \n $sDateSaved \n\nNueva Fecha de Vencimiento: \n $sDateLimit \n\nPrecio: \$ $precio',
                  middleTextStyle: TextStyle(fontSize: sclH(context) * 2.5),
                  textConfirm: 'Okay',
                  confirm: Column(
                    children: [
                    
                          ElevatedButton.icon(
                            onPressed: () {
                              _subscriptionController.initTransaction(precio, ndia, timeSubs );
                            },
                            icon: const Icon(
                              Icons.check,
                              //color: AppColors.violet,
                            ),
                            label:  isloading
                                ? const CircularProgressIndicator()
                                :  const Text(
                              'Pagar',
                              //style: TextStyle(color: AppColors.violet),
                            ),
                          ),
                    ],
                  ),
                  cancel: ElevatedButton.icon(
                    onPressed: () => Get.back(),
                    icon: const Icon(
                      Icons.cancel,
                      //color: AppColors.violet,
                    ),
                    label: const Text(
                      "Cancelar",
                      //style: TextStyle(color: AppColors.violet),
                    ),
                  ),
                );
              },
              child: Text(
                "Pagar",
                style: TextStyle(
                  fontSize: sclW(context) * 5,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
