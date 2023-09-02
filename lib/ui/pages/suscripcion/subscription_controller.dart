import 'package:chalkdart/chalk.dart';
import 'package:chalkdart/chalk_x11.dart';
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
    

  }


Future<MyUser?> getUserCurrent() async {
  return userCurrent;
}









Future<Map<String, dynamic>> initPreferencs( price) async {

var mp = MP(globals.mpClientId, globals.mpClientSecret);



    var preference = {
        "items": [
            {
                "title": "Test",
                "quantity": 1,
                "currency_id": "CLP",
                "unit_price": 1000
            }
        ],
        "payer":{"name":"jhoana", "email":"jhoanajerez@gmail.com"}
    };

    var result = await mp.createPreference(preference);

    return result;
}




 Future<void>  initTransaction(price) async {

  initPreferencs(price).then((response) async {

    if(response!=null){

       print(chalk.white.bold('Dias Restantes: ${response.toString()}'));
      var preferenceID = response['response']['id'];


      try{

        PaymentResult result = await MercadoPagoCheckout.startCheckout(publicKey,preferenceID);
  

          print(chalk.green.bold('Bien: ${result}'));

          if(result.result!='canceled'){
            dataTransaccion.value = result ;
            Get.offNamed(RouteNames.graciasPaymentPage, arguments: result);
            
          }

      }
      on PlatformException catch (e){

       print(chalk.pink.bold('Exeption: ${e.toString()}'));
      }



    }
  });

}





















}
