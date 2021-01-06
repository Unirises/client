  num computeFare(String type, num distance, bool isAddtlStop) {
    var baseFare = 0;
    var addtlStop = 0;
    var perKm;
    switch (type) {
      case 'motorcycle':
        baseFare = 50;
        addtlStop = 40;
        perKm = 7;
        break;
      case 'car2Seater':
        baseFare = 175;
        addtlStop = 45;
        perKm = 20;
        break;
      case 'car4Seater':
        baseFare = 350;
        addtlStop = 50;
        perKm = 25;
        break;
      case 'car7Seater':
        baseFare = 460;
        addtlStop = 50;
        perKm = 30;
        break;
    }
    return baseFare +
        (perKm * (distance / 1000)) +
        (isAddtlStop ? addtlStop : 0);
  }