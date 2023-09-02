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
 String? _platformVersion = 'Unknown';

static var publicKey = globals.mpPublicKeyTEST;
String? emailUser = '';
final provider = FirebaseProvider();
late var userCurrent;


Rx<PaymentResult?> dataTransaccion = Rx(null);


  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getUserCurrent();
    
  }


Future<MyUser?> getUserCurrent() async {
  return userCurrent;
}


setDate(DateTime newDate) async {

  var userCurrent = await provider.getMyUser2();
  userCurrent!.date = Timestamp.fromDate(newDate);
  provider.setSubscriptionDate(userCurrent);
  //LOGICA DESLOGUEAR
  //await authClass.logout();
  //Get.find<AuthController>().signOut();
  //Get.offAllNamed(RouteNames.signIn);
}

verifyDate(){

}



DateTime updateDateLimit(int nDias) {


  return DateTime.now().add(Duration(days: nDias));
}


 Future<void>  initTransaction(price,dias,title) async {

  initPreferencs(price,title).then((response) async {

    if(response!=null){

       print(chalk.white.bold('Dias Restantes: ${response.toString()}'));
      var preferenceID = response['response']['id'];


      try{

        PaymentResult result = await MercadoPagoCheckout.startCheckout(publicKey,preferenceID);
  
          print(chalk.green.bold('Bien: ${result}'));

          if(result.result!='canceled'){
            dataTransaccion.value = result;

            if(result.status=='approved'){
            setDate(updateDateLimit(dias));
            }

            Get.offNamed(RouteNames.graciasPaymentPage, arguments: result);
            
          }

      }
      on PlatformException catch (e){

       print(chalk.pink.bold('Exeption: ${e.toString()}'));
      }



    }
  });

}



Future<Map<String, dynamic>> initPreferencs(price,title) async {
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
        "payer":{"name":"jhoana", "email":"jhoanajerez@gmail.com"}
    };

    var result = await mp.createPreference(preference);

    return result;
}























}
