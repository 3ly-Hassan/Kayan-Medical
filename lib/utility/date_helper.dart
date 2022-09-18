import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

class DateHelper {
  static String getTheArabicDay(DateTime date) {
    final theDay = _getTheDayHelper(DateFormat.EEEE().format(date));
    final theDate = DateFormat.yMd().format(date);
    final theTime = DateFormat.jm().format(date);
    debugPrint('$theTime $theDate $theDay');
    return '$theDay $theDate $theTime';
  }

//   static String _getTheMonthHelper(String weekDay) {
//     switch (weekDay) {
//       case 'Jan':
//         {
//           return 'يناير';
//         }
//       case 'Feb':
//         {
//           return 'فبراير';
//         }
//       case 'Mar':
//         {
//           return 'مارس';
//         }
//       case 'Apr':
//         {
//           return 'ابريل';
//         }
//       case 'May':
//         {
//           return 'مايو';
//         }
//       case 'Jun':
//         {
//           return 'يونيو';
//         }
//       case 'Jul':
//         {
//           return 'يوليو';
//         }
//       case 'Aug':
//         {
//           return 'اغسطس';
//         }
//       case 'Sep':
//         {
//           return 'سبتمبر';
//         }
//       case 'Oct':
//         {
//           return 'اكتوبر';
//         }
//       case 'Nov':
//         {
//           return 'نوفمبر';
//         }
//       case 'Dec':
//         {
//           return 'ديسمبر';
//         }

//       default:
//         {
//           return 'غير معروف';
//         }
//     }
//   }

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
