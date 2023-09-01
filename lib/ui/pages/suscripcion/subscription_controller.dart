import 'package:chalkdart/chalk.dart';
import 'package:emotion_cam_360/data/firebase_provider-db.dart';
import 'package:emotion_cam_360/entities/user.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart';
import 'package:emotion_cam_360/utils/globals.dart' as globals;
import 'package:mercado_pago_checkout/mercado_pago_checkout.dart';
import 'package:mercadopago_sdk/mercadopago_sdk.dart';





class SubscriptionController extends GetxController {
 String? _platformVersion = 'Unknown';

static var publicKey = globals.mpPublicKey;
String? emailUser = '';
final provider = FirebaseProvider();
late var userCurrent;

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
        "payer":{"name":"Jhonatan", "email":"jhonatanmejias@gmail.com"}
    };

    var result = await mp.createPreference(preference);

    return result;
}




 Future<void>  initTransaction(price) async {

  print(chalk.white.bold("Entro a metodoo"));

  initPreferencs(price).then((response) async {

    if(response!=null){

      print ("RESULTADO:  ${response.toString()}");


      var preferenceID = response['response']['id'];


      try{

        PaymentResult result = await MercadoPagoCheckout.startCheckout(publicKey,preferenceID);
        print(result.toString());


      }
      on PlatformException catch (e){

        print(e.message);
      }



    }
  });

}





















}
