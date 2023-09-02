import 'package:equatable/equatable.dart';

class Suscripcion extends Equatable {
  final String name;
  final String typeDate;
  final String featureOne;
  final String featureTwo;
  final String featureThree;
  final String legal;
  final int saving;
  final int price;
  final int dias;

  const Suscripcion(this.name, this.typeDate, this.featureOne, this.featureTwo,
      this.featureThree, this.legal, this.saving, this.price, this.dias);
  @override
  List<Object?> get props => [name];

  Map<String, Object?> toFirebaseMap({String? newdate}) {
    return <String, Object?>{
      'name': name,
      'typeDate': typeDate,
      'featureOne': featureOne,
      'featureTwo': featureTwo,
      'featureThree': featureThree,
      'legal': legal,
      'saving': saving,
      'price': price,
      'dias': dias,
    };
  }

  Suscripcion.fromFirebaseMap(Map<String, Object?> data)
      : name = data['name'] as String,
        typeDate = data['typeDate'] as String,
        featureOne = data['featureOne'] as String,
        featureTwo = data['featureTwo'] as String,
        featureThree = data['featureThree'] as String,
        legal = data['legal'] as String,
        saving = data['saving'] as int,
        price = data['price'] as int,
        dias = data['dias'] as int;
}
