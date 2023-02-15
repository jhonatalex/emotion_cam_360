import 'package:chalkdart/chalk.dart';
import 'package:emotion_cam_360/ui/widgets/appcolors.dart';
import 'package:emotion_cam_360/ui/widgets/background_gradient.dart';
import 'package:emotion_cam_360/ui/widgets/responsive.dart';
import 'package:emotion_cam_360/ui/widgets/subscription.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

final ScrollController _controller = ScrollController();

class SubscriptionPage extends StatefulWidget {
  @override
  State<SubscriptionPage> createState() => _SubscriptionPageState();
}

class _SubscriptionPageState extends State<SubscriptionPage> {
  @override
  void initState() {
    super.initState();

    getDateSaved();
  }

  @override
  Widget build(BuildContext context) {
    double xOffset = 200;
    double yOffset = 500;
    final left1 = sclW(context) * 15;
    final top1 = sclH(context) * 5;
    final left2 = sclW(context) * 10;
    final top2 = sclH(context) * 65;
    final left3 = sclW(context) * 55;
    final top3 = sclH(context) * 65;
    return Stack(
      children: [
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
                icon: Icon(
                  Icons.info_outline,
                  color: diasRestantes() > 3 ? Colors.green : Colors.orange,
                ),
                onPressed: () {
                  String date = "";
                  int dias = 0;
                  setState(
                    () {
                      date = formatDatatime(updateDateLimit(0));
                      dias = diasRestantes();
                    },
                  );
                  //dialog con GetX
                  Get.defaultDialog(
                    backgroundColor: AppColors.vulcan,
                    radius: 10.0,
                    contentPadding: const EdgeInsets.all(20.0),
                    title: 'Información de Subscripción',
                    titleStyle: TextStyle(color: AppColors.royalBlue),
                    middleText: 'Fecha de Vencimiento: $date  \n' +
                        'Días Restantes: $dias',
                    middleTextStyle: TextStyle(fontSize: sclH(context) * 3),
                    textConfirm: 'Okay',
                    confirm: OutlinedButton.icon(
                      onPressed: () => Get.back(),
                      icon: const Icon(
                        Icons.check,
                        color: AppColors.violet,
                      ),
                      label: const Text(
                        'Listo',
                        style: TextStyle(color: AppColors.violet),
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
          body: ListView(
            scrollDirection: Axis.vertical,
            controller: _controller,
            children: [
              /* 
              Text("Fecha de Vencimiento: $date",
                  style: TextStyle(
                      color: AppColors.royalBlue, fontSize: sclW(context) * 6)),
              Text("Días Restantes: $dias",
                  style: TextStyle(
                      color: AppColors.royalBlue, fontSize: sclW(context) * 6)),
               */
              AnimatedContainer(
                duration: Duration(seconds: 1),
                transform: Matrix4.translationValues(0, 0, 0)..scale(01.0),
                child: SubscriptionCard(
                    context, "Standard", "semanal", 0, "28.00", 7),
              ),
              AnimatedContainer(
                duration: Duration(seconds: 1),
                //transform: Matrix4.translationValues(left2, top2, 0)..scale(0.5),
                child: SubscriptionCard(
                    context, "Basic", "mensual", 20, "89.60", 30),
              ),
              AnimatedContainer(
                duration: Duration(seconds: 1),
                // transform: Matrix4.translationValues(left3, top3, 0)..scale(0.5),
                child: SubscriptionCard(
                    context, "Ultimate", "anual", 60, "582.40", 365),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget SubscriptionCard(context, String _title, String timeSubs, int _desc,
      String _precio, int ndia) {
    return Container(
      width: sclW(context) * 70,
      height: sclW(context) * 100,
      margin: EdgeInsets.symmetric(
          vertical: sclW(context) * 5, horizontal: sclW(context) * 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(80),
          bottomRight: Radius.circular(80),
        ),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(5.0),
            child: Text(
              _title,
              style: TextStyle(
                  color: AppColors.royalBlue, fontSize: sclW(context) * 6),
            ),
          ),
          Container(
            width: sclW(context) * 62,
            height: sclW(context) * 80,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(80),
                bottomRight: Radius.circular(80),
              ),
              color: AppColors.royalBlue,
            ),
            margin: EdgeInsets.only(
              left: sclW(context) * 5,
            ),
            padding: EdgeInsets.all(
              sclW(context) * 2,
            ),
            child: Column(
              children: [
                ListTile(
                  trailing: const Icon(Icons.check_circle_outline),
                  title: Text(
                    "Subscripción $timeSubs",
                    style: TextStyle(fontSize: sclW(context) * 4),
                  ),
                ),
                ListTile(
                  leading: const Icon(Icons.check_circle_outline),
                  title: Text(
                    "Eventos ilimitados",
                    style: TextStyle(fontSize: sclW(context) * 3.5),
                  ),
                ),
                ListTile(
                  leading: const Icon(Icons.check_circle_outline),
                  title: Text(
                    "Uso iliitado de la cuenta en diferentes dispositivos",
                    style: TextStyle(fontSize: sclW(context) * 3.5),
                  ),
                ),
                ListTile(
                  leading: const Icon(Icons.check_circle_outline),
                  title: Text(
                    "Almacenamiento en la nube por 30 días",
                    style: TextStyle(fontSize: sclW(context) * 3.5),
                  ),
                ),
                ListTile(
                  leading: const Icon(Icons.check_circle_outline),
                  title: Text(
                    "Ahorro del $_desc%",
                    style: TextStyle(fontSize: sclW(context) * 3.5),
                  ),
                ),
                Spacer(),
                CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.white,
                  child: Icon(
                    Icons.home,
                    size: 35,
                  ),
                  foregroundColor: AppColors.violet,
                )
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(
              left: sclW(context) * 3,
            ),
            child: ElevatedButton(
              onPressed: () {
                print(chalk.white.bold("añadir $ndia dias"));
                int iDiasRestantes = diasRestantes();
                String sDateSaved = formatDatatime(dateSaved());
                String sDateLimit = formatDatatime(updateDateLimit(ndia));
                Get.defaultDialog(
                  backgroundColor: AppColors.vulcan,
                  radius: 10.0,
                  contentPadding: const EdgeInsets.all(20.0),
                  title: 'Realizar pago',
                  titleStyle: TextStyle(
                    color: AppColors.royalBlue,
                  ),
                  middleText: 'Días Restantes: $iDiasRestantes \n\n' +
                      'Despues de realizar el pago añadiremos $ndia dias  \n\n' +
                      'Fecha de Vencimiento actual: \n $sDateSaved \n\n' +
                      'Nueva Fecha de Vencimiento: \n $sDateLimit \n\n' +
                      'Precio: \$ $_precio',
                  middleTextStyle: TextStyle(fontSize: sclH(context) * 2.5),
                  textConfirm: 'Okay',
                  confirm: ElevatedButton.icon(
                    onPressed: () {
                      setDate(updateDateLimit(ndia));
                    },
                    icon: const Icon(
                      Icons.check,
                      //color: AppColors.violet,
                    ),
                    label: const Text(
                      'Continuar',
                      //style: TextStyle(color: AppColors.violet),
                    ),
                  ),
                  cancel: ElevatedButton.icon(
                    onPressed: () => Get.back(),
                    icon: Icon(
                      Icons.cancel,
                      //color: AppColors.violet,
                    ),
                    label: Text(
                      "Cancelar",
                      //style: TextStyle(color: AppColors.violet),
                    ),
                  ),
                );
              },
              child: Text(
                "\$ $_precio",
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
