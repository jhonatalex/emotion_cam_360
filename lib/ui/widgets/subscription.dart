import 'package:chalkdart/chalk.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emotion_cam_360/data/firebase_provider-db.dart';
import 'package:emotion_cam_360/entities/user.dart';

DateTime _savedDate = DateTime.now();
DateTime _endDate = DateTime.now();
final provider = FirebaseProvider();
late var userCurrent;
Future<MyUser?> getUserCurrent() async {
  return userCurrent;
}

Future<DateTime> getDateSaved() async {
  userCurrent = await provider.getMyUser2();
// esta va a ser la fecha tomada desde firebase como string
//se convierte en DataTime para poder hacer funciones
  _savedDate = userCurrent!.date.toDate();
  print(chalk.white.bold("valor: ${_savedDate}"));
//formatear fecha
//DateTime fecha2 = DateTime.parse('2023-07-20 00:10:00Z');
  return _savedDate;
}

setDate(DateTime newDate) async {
  print(chalk.white.bold("guardando... $newDate"));
  var userCurrent = await provider.getMyUser2();
  userCurrent!.date = Timestamp.fromDate(newDate);
  provider.setSubscriptionDate(userCurrent);
}

DateTime dateSaved() {
  return _savedDate;
}

DateTime dateLimit(int nDias) {
  _endDate = _savedDate.add(Duration(days: nDias));
  print(chalk.white.bold("Fecha Actual: ${DateTime.now()}"));
  print(chalk.white.bold("Nueva Fecha de Vencimiento: $_endDate"));
  return _endDate;
}

int diasRestantes() {
  Duration _diastotales = _savedDate.difference(DateTime.now());
  print(chalk.white.bold('Dias Restantes: ${_diastotales.inDays}'));
  return _diastotales.inDays;
}

//Función para formatear la fecha
// created by David Reyes jajaj
formatDatatime(DateTime DateTime) {
  String dia = DateTime.day < 10 ? '0${DateTime.day}' : '${DateTime.day}';
  String mes = DateTime.month < 10 ? '0${DateTime.month}' : '${DateTime.month}';
  int ano = DateTime.year;
  String hora = DateTime.hour < 10 ? '0${DateTime.hour}' : '${DateTime.hour}';
  String min =
      DateTime.minute < 10 ? '0${DateTime.minute}' : '${DateTime.minute}';
  String seg =
      DateTime.second < 10 ? '0${DateTime.second}' : '${DateTime.second}';
  return "$dia/$mes/$ano - $hora:$min";
}
