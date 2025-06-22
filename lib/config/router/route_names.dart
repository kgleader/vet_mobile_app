// Бул файл колдонмодогу бардык каттамдардын (routes) аталыштарын туруктуу саптар (constants) катары аныктайт.
class RouteNames {
  static const String splash = '/splash';
  static const String login = '/login';
  static const String register = '/register';
  static const String forgotPassword = '/forgotPassword';
  static const String menu = '/menu';
  static const String about = '/menu/about';
  static const String feed = '/menu/feed';
  static const String diseases = '/menu/diseases'; 
  static const String insemination = '/menu/insemination';
  static const String cattle = '/menu/cattle';
  static const String goats = '/menu/goats';
  static const String horses = '/menu/horses';
  static const String chicken = '/chicken';
  static const String sheepFeeding = 'feeding';  // Used in nested routes, don't change to full path
  static const String sheepDiseases = 'diseases';  // Used in nested routes, don't change to full path
  static const String sheepInsemination = 'insemination';  // Used in nested routes, don't change to full path
  static const String horseFeeding = '/horse-feeding';
  static const String horseDiseases = '/horse-diseases';
  static const String horseInsemination = '/horse-insemination';

  static const String chickenScreen = '/menu/chicken';

  static const String profile = '/profile';
  static const String resetPassword = '/resetPassword';
  static const String settings = '/settings';
  static const String editProfileScreen = '/editProfileScreen';
  static const String news = '/news';
  static const String newsDetail = 'news_detail'; // Added for the news detail route name
  static const String topicDetail = '/topicDetail';
  static const String home = '/menu';  
  static const String vetList = '/vetList';
  static const String vetMessage = '/vet-message';
  static const String vetInfo = '/vetInfo';
  static const String vetMessageSuccess = '/vet-message-success';
  static const String vetMessageFailure = '/vet-message-failure';
  static const String cattleFeed = '/cattle_feed'; // Мурунку
  static const String cattleDiseases = '/cattle_diseases'; // Мурунку
  static const String cattleInsemination = '/cattle_insemination'; // Мурунку
  static const String chickenFeeding = 'chicken_feeding';
  static const String chickenDiseases = 'chicken_diseases'; 
}
