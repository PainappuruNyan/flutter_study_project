import 'package:intl/intl.dart';

class DateParser{
  static String parseForGetRequest(DateTime original){
    return '${original.year}-${DateFormat('MM').format(original)}-${DateFormat('dd').format(original)}%20${DateFormat('hh').format(original)}%3A${DateFormat('mm').format(original)}';
  }
}

//'http://localhost:8080/workplace/allIsFreeByFloor?floorId=1&typeId=1&start=2022-12-13%2010%3A00&end=2022-12-13%2022%3A00&page=0&size=20'
