import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

class DateHelper {
  static void getTheArabicDay(DateTime date) {
    debugPrint(_getTheDayHelper(DateFormat.EEEE().format(date)));
    //_getTheDayHelper(DateFormat.EEEE(date));
  }

  static String _getTheDayHelper(String weekDay) {
    switch (weekDay) {
      case 'Sunday':
        {
          return 'الاحد';
        }
      case 'Monday':
        {
          return 'الاثنين';
        }
      case 'Tuesday':
        {
          return 'الثلاثاء';
        }
      case 'Wednesday':
        {
          return 'الاربعاء';
        }
      case 'Thursday':
        {
          return 'الخميس';
        }
      case 'Friday':
        {
          return 'الجمعة';
        }
      case 'Saturday':
        {
          return 'السبت';
        }

      default:
        {
          return 'غير معروف';
        }
    }
  }
}
