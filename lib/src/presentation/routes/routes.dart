
import '../administration/create_office_1/create_office_1.dart';
import '../administration/office_details/office_details.dart';
import '../administration/office_list/office_list.dart';
import '../administration/user_list/user_list.dart';
import '../booking/booking_details/booking_detail_screen.dart';
import '../booking/booking_list/booking_list_screen.dart';
import '../booking/create_booking_1/create_booking_1.dart';
import '../booking/create_booking_2/booking_create_2.dart';
import '../booking/create_booking_3/booking_create_3.dart';
import '../faq/faq.dart';
import '../feedback/feedback.dart';
import '../log_in/log_in/log_in_screen.dart';
import '../profile/profile_screen.dart';
import '../teams/team_create/team_create_screen.dart';
import '../teams/team_details/team_details_screen.dart';
import '../teams/team_list/team_list_screen.dart';
import '../teams/teammate_list/teammate_list.dart';

class Routes{
  static const String profile = ProfileScreen.routeName;
  static const String booking_list = BookingListScreen.routeName;
  static const String team_list = TeamListScreen.routeName;
  static const String login = LoginScreen.routeName;
  static const String booking_details = BookingDetailScreen.routeName;
  static const String create_office_1 = CreateOffice1.routeName;
  static const String booking_create_2 = BookingCreate2Screen.routeName;
  static const String team_create_screen = TeamCreateScreen.routeName;
  static const String team_details_screen = TeamDetailsScreen.routeName;
  static const String booking_create_3 = BookingCreate3Screen.routeName;
  static const String teammate_list = TeamMateList.routeName;
  static const String booking_create_1 = CreateBooking1.routeName;
  static const String user_list = UserList.routeName;
  static const String faq = FaqScreen.routeName;
  static const String admin_office_list = OfficeListScreen.routeName;
  static const String office_details_screen = OfficeDetailsScreen.routeName;
  static const String feedback = FeedbackScreen.routeName;
}
