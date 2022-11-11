import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class TimeZoneHelper {
  TimeZoneHelper() {
    setup();
  }

  void setup() async {
    tz.initializeTimeZones();
    var timezoneLocation = tz.getLocation('Asia/Jakarta');
    tz.setLocalLocation(timezoneLocation);
  }
}
