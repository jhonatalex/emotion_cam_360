import 'package:chalkdart/chalk.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart';
import 'package:emotion_cam_360/utils/globals.dart' as globals;
import 'package:mercado_pago_checkout/mercado_pago_checkout.dart';
import 'package:mercadopago_sdk/mercadopago_sdk.dart';





class SubscriptionController extends GetxController {
 String? _platformVersion = 'Unknown';

static var publicKey = globals.mpPublicKey;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    
    
  }



 Future<void>  initTransaction(price) async {

  print(chalk.white.bold("Entro a metdoo"));

  initPreferencs(price).then((response) async {

    if(response!=null){

      print ("RESULTADO:  ${response.toString()}");


      var preferenceID = response['responde']['id'];


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
        ]
    };

    var result = await mp.createPreference(preference);

    return result;
}



















}
