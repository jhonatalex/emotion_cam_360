import 'package:chalkdart/chalk.dart';

// esta va a ser la fecha tomada desde firebase como string
String stringFechaGuardada = '2023-03-20 10:10:00Z';
//se convierte en DataTime para poder hacer funciones
DateTime fechaGuardada = DateTime.parse(stringFechaGuardada);

//formatear fecha
//DateTime fecha2 = DateTime.parse('2023-07-20 00:10:00Z');

DateTime _startDate = DateTime.now();
DateTime _endDate = DateTime.now();

String dateLimit(int nDias) {
  _endDate = _endDate.add(Duration(days: nDias));
  print(chalk.white.bold("Fecha Actual: ${DateTime.now()}"));
  print(chalk.white.bold("Fecha de Vencimiento: $_endDate"));
  return formatDatatime(_endDate);
}

int diasRestantes() {
  Duration _diastotales = _endDate.difference(_startDate);
  print(chalk.white.bold('Dias Restantes: ${_diastotales.inDays}'));
  return _diastotales.inDays;
}

//Función para formatear la fecha
// created by David Reyes jajaj
formatDatatime(DateTime DateTime) {
  String dia = DateTime.day < 10 ? '0${DateTime.day}' : '${DateTime.day}';
  String mes = DateTime.month < 10 ? '0${DateTime.month}' : '${DateTime.month}';
  int ano = DateTime.year;
  int hora = DateTime.hour;
  String seg =
      DateTime.second < 10 ? '0${DateTime.second}' : '${DateTime.second}';
  return "$dia/$mes/$ano - $hora:$seg";
}
