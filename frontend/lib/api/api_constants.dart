class ApiConstants {
  static const String baseUrl = "http://192.168.1.2:5000/api";

  // Auth

  static const String register = "$baseUrl/auth/register";

  static const String login = "$baseUrl/auth/login";

  // Expense

  static const String expenses = "/expenses";

  // Income

  static const String income = "/incomes";

  // Budget

  static const String budget = "/budgets";

  // Analytics

  static const String analytics = "$baseUrl/analytics";

  // Notification

  static const String notification = "$baseUrl/notifications";

  // Dashboard

  static const String dashboard = "$baseUrl/dashboard";
}
