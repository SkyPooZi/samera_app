class ApiEndPoint {
  static const String baseUrl = 'https://story-api.dicoding.dev/v1';

  static const String baseUrlRegister = '$baseUrl/register';
  static const String baseUrlLogin = '$baseUrl/login';

  static const String baseUrlStory = '$baseUrl/stories';
  static const String baseUrlAddNewStoryGuest = '$baseUrlStory/guest';

  static const String baseUrlNotification = '$baseUrl/notifications/subscribe';
}
