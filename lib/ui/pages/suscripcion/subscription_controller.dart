import 'package:chalkdart/chalk.dart';
import 'package:chalkdart/chalk_x11.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emotion_cam_360/data/firebase_provider-db.dart';
import 'package:emotion_cam_360/entities/user.dart';
import 'package:emotion_cam_360/ui/routes/route_names.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart';
import 'package:emotion_cam_360/utils/globals.dart' as globals;
import 'package:mercado_pago_checkout/mercado_pago_checkout.dart';
import 'package:mercadopago_sdk/mercadopago_sdk.dart';

class SubscriptionController extends GetxController {
  static var publicKey = globals.mpPublicKeyTEST;
  String? emailUser = '';
  final provider = FirebaseProvider();
  var userCurrent;
  Rx<bool> isLoading = Rx(false);

  Rx<PaymentResult?> dataTransaccion = Rx(null);

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getUserCurrent();
  }

  Future<MyUser?> getUserCurrent() async {
    userCurrent = await provider.getMyUser2();
    return userCurrent;
  }

  setDate(DateTime newDate) async {
    var userCurrent = await provider.getMyUser2();
    userCurrent!.date = Timestamp.fromDate(newDate);
    provider.setSubscriptionDate(userCurrent);
  }

  DateTime updateDateLimit(int nDias) {
    Timestamp dateExpirationCurrent = userCurrent!.date;
    var dateCurrentToday = DateTime.now();

    // Convierte Timestamp a DateTime
    DateTime dateExpirationDateTime = dateExpirationCurrent.toDate();

    // Compara las fechas
    if (dateExpirationDateTime.isAfter(dateCurrentToday)) {
      dateExpirationDateTime =
          dateExpirationDateTime.add(Duration(days: nDias));
      print(chalk.white.bold("si es"));
    } else {
      print(chalk.white.bold("no es"));
      dateExpirationDateTime = dateCurrentToday.add(Duration(days: nDias));
    }

    return dateExpirationDateTime;
  }

  Future<void> initTransaction(price, dias, title) async {
    isLoading.value = true;

//MERCADO PAGO INIT
    initPreferencs(price, title).then((response) async {
      var preferenceID = response['response']['id'];

      try {
        //MERCADO PAGO CHECKOUT
        PaymentResult result =
            await MercadoPagoCheckout.startCheckout(publicKey, preferenceID);

        print(chalk.green.bold('Bien: ${result}'));
        isLoading.value = false;

        if (result.result != 'canceled') {
          dataTransaccion.value = result;

          if (result.status == 'approved') {
            setDate(updateDateLimit(dias));
          }

          //NAVEGAR PAGINA GRACIAS
          Get.offNamed(RouteNames.graciasPaymentPage, arguments: result);
        }
      } on PlatformException catch (e) {
        print(chalk.pink.bold('Exeption: ${e.toString()}'));
      }
    });
  }

//MERCADO PAGO PREFERENCES
  Future<Map<String, dynamic>> initPreferencs(price, title) async {
    var mp = MP(globals.mpClientId, globals.mpClientSecret);

    var preference = {
      "items": [
        {
          "title": title,
          "quantity": 1,
          "currency_id": "CLP",
          "unit_price": int.parse(price)
        }
      ],
      "payer": {"email": "${userCurrent!.email}"}
    };

    var result = await mp.createPreference(preference);

    return result;
  }
}
