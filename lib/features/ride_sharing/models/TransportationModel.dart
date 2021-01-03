import 'package:meta/meta.dart';

import 'Transportation.dart';

class TransportationModel {
  TransportationModel({
    @required this.name,
    @required this.imagePath,
    @required this.type,
  });

  final String name;
  final String imagePath;
  final TransportationEnum type;
}

List<TransportationModel> transportationModels = [
  TransportationModel(
    name: 'Motorcycle',
    imagePath: 'assets/rideshare/motorcycle.png',
    type: TransportationEnum.motorcycle,
  ),
  TransportationModel(
    name: 'Sedan & SUV',
    imagePath: 'assets/rideshare/car-2-seater.png',
    type: TransportationEnum.car2Seater,
  ),
  TransportationModel(
    name: 'Mini Van or MPV',
    imagePath: 'assets/rideshare/car-4-seater.png',
    type: TransportationEnum.car4Seater,
  ),
  TransportationModel(
    name: 'Van',
    imagePath: 'assets/rideshare/van.png',
    type: TransportationEnum.car7Seater,
  ),
];
