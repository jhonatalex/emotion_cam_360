import 'package:flutter/cupertino.dart';

sclH(context) {
  var sclH = MediaQuery.of(context).size.height / 100;
  return sclH;
}

sclW(context) {
  var sclW = MediaQuery.of(context).size.width / 100;
  return sclW;
}

aspR(context) {
  var aspR = MediaQuery.of(context).size.aspectRatio;
  return aspR;
}

ori(context) {
  var ori = MediaQuery.of(context).orientation;
  return ori;
}
