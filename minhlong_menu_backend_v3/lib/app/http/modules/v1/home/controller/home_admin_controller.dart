import 'dart:io';
import 'package:minhlong_menu_backend_v3/app/http/common/app_response.dart';
import 'package:minhlong_menu_backend_v3/app/http/modules/v1/food/repositories/food_repo.dart';
import 'package:minhlong_menu_backend_v3/app/http/modules/v1/order/models/order.dart';
import 'package:minhlong_menu_backend_v3/app/http/modules/v1/order/repositories/order_repo.dart';
import 'package:minhlong_menu_backend_v3/app/http/modules/v1/table/models/table.dart';
import 'package:minhlong_menu_backend_v3/app/http/modules/v1/table/repositories/table_repo.dart';
import 'package:vania/vania.dart';
import '../../../../common/const_res.dart';
import '../../category/models/categories.dart';
import '../../category/repositories/category_repo.dart';
import '../../food/models/foods.dart';

class HomeAdminController extends Controller {
  final CategoryRepo categoryRepo;
  final OrderRepo orderRepo;
  final FoodRepo foodRepo;
  final TableRepo tableRepo;

  HomeAdminController(
    this.categoryRepo,
    this.orderRepo,
    this.foodRepo,
    this.tableRepo,
  );

  Future<Response> index(Request request) async {
    int? userID = request.headers[ConstRes.userID] != null
        ? int.tryParse(request.headers[ConstRes.userID])
        : -1;
    try {
      var now = DateTime.now();

      // get today
      int dateRepresentation = now.year * 10000 + now.month * 100 + now.day;

      // get yesterday
      DateTime yesterday = now.subtract(Duration(days: 1));
      int dateRepresentationYesterday =
          yesterday.year * 10000 + yesterday.month * 100 + yesterday.day;

      print('today: $dateRepresentation');
      print('yesterday: $dateRepresentationYesterday');

      // get user id

      if (userID == null) {
        return AppResponse().error(
          statusCode: HttpStatus.unauthorized,
          message: 'unauthorized',
        );
      }

      // get today's revenue
      List<Map<String, dynamic>> ordersOnToday = [];
      ordersOnToday = await orderRepo.getOrdersCompleted(
          userID: userID, date: dateRepresentation);
      var revenueOnToday = ordersOnToday.fold<double>(
          0.0, (double total, order) => total + order['total_price']);

      // get yesterday's revenue
      List<Map<String, dynamic>> ordersOnYesterday = [];
      ordersOnYesterday = await orderRepo.getOrdersCompleted(
          userID: userID, date: dateRepresentationYesterday);
      var revenueOnYesterday = ordersOnYesterday.fold<double>(
          0.0, (double total, order) => total + order['total_price']);

      // get total revenue
      var orders = await orderRepo.getAllOrdersCompleted(userID: userID);
      var totalRevenue = orders.fold<double>(
          0.0, (double total, order) => total + order['total_price']);

      // get the number of categories
      var categoryCount = await categoryRepo.getCategoryCount(userID: userID);

      // Get the number of completed orders
      var orderCount = await orderRepo.getOrderSuccess();

      // get the number of foods
      var foodCount = await foodRepo.getTotalNumberOfFoods(userID: userID);

      // get the number of tables
      var tableCount = await tableRepo.getTableCount(userID: userID);

      return AppResponse().ok(
        statusCode: HttpStatus.ok,
        message: 'success',
        data: {
          'category_count': categoryCount,
          'order_count': orderCount.length,
          'food_count': foodCount,
          'table_count': tableCount,
          'revenue_on_today': revenueOnToday,
          'revenue_on_yesterday': revenueOnYesterday,
          'total_revenue': totalRevenue
        },
      );
    } catch (e) {
      print('get info error: $e');
      return AppResponse().error(
        statusCode: HttpStatus.internalServerError,
        message: 'connection error',
      );
    }
  }

// get the best selling food
  Future<Response> bestSellingFood() async {
    try {
      var userID = Auth().id();
      if (userID == null) {
        return AppResponse().error(
          statusCode: HttpStatus.unauthorized,
          message: 'unauthorized',
        );
      }

      var food = await foodRepo.getBestSellingFood(userID: userID);
      return AppResponse().ok(
        statusCode: HttpStatus.ok,
        message: 'success',
        data: food,
      );
    } catch (e) {
      return AppResponse().error(
        statusCode: HttpStatus.internalServerError,
        message: 'connection error',
      );
    }
  }

  // get revenue filter on date
  Future<Response> revenueFilterOnDate(Request request) async {
    int? userID = request.headers[ConstRes.userID] != null
        ? int.tryParse(request.headers[ConstRes.userID])
        : -1;
    var now = DateTime.now();
    var params = request.all();

    try {
      List<Map<String, dynamic>> responseData = [];
      if (userID == null) {
        return AppResponse().error(
          statusCode: HttpStatus.unauthorized,
          message: 'unauthorized',
        );
      }
      switch (params['type']) {
        case 'week':
          DateTime startOfWeek =
              getDate(now.subtract(Duration(days: now.weekday - 1)));
          DateTime endOfWeek =
              now.add(Duration(days: DateTime.daysPerWeek - now.weekday));

          int startOfWeekInt = startOfWeek.year * 10000 +
              startOfWeek.month * 100 +
              startOfWeek.day;
          int endOfWeekInt =
              endOfWeek.year * 10000 + endOfWeek.month * 100 + endOfWeek.day;
          print('startOfWeek: $startOfWeekInt');
          print('endOfWeek: $endOfWeekInt');

          var response = await orderRepo.getRevenueFiller(
            userID: userID,
            startDate: startOfWeekInt,
            endDate: endOfWeekInt,
          );
          List<dynamic> transactions = response;

          Map<String, double> totalByDay = {};

          for (var transaction in transactions) {
            String payedAt = transaction['payed_at'].substring(8, 10);
            double totalPrice = transaction['total_price'];

            if (totalByDay.containsKey(payedAt)) {
              totalByDay[payedAt] = totalByDay[payedAt]! + totalPrice;
            } else {
              totalByDay[payedAt] = totalPrice;
            }
          }

          totalByDay.forEach((key, value) {
            responseData.add({
              "total_price": value,
              "date": key,
            });
          });

          break;
        case 'month':
          DateTime firstDayOfMonth = DateTime(now.year, now.month, 1);
          DateTime lastDayOfMonth = DateTime(now.year, now.month + 1, 0);
          int firstDayOfMonthInt = firstDayOfMonth.year * 10000 +
              firstDayOfMonth.month * 100 +
              firstDayOfMonth.day;
          int lastDayOfMonthInt = lastDayOfMonth.year * 10000 +
              lastDayOfMonth.month * 100 +
              lastDayOfMonth.day;

          var response = await orderRepo.getRevenueFiller(
            userID: userID,
            startDate: firstDayOfMonthInt,
            endDate: lastDayOfMonthInt,
          );
          List<dynamic> transactions = response;
          Map<String, double> totalByDay = {};

          for (var transaction in transactions) {
            String payedAt = transaction['payed_at'].substring(8, 10);
            double totalPrice = transaction['total_price'];

            if (totalByDay.containsKey(payedAt)) {
              totalByDay[payedAt] = totalByDay[payedAt]! + totalPrice;
            } else {
              totalByDay[payedAt] = totalPrice;
            }
          }

          totalByDay.forEach((key, value) {
            responseData.add({
              "total_price": value,
              "date": key,
            });
          });
          break;
        case 'year':
          DateTime firstDayOfYear = DateTime(now.year, 1, 1);
          DateTime lastDayOfYear = DateTime(now.year + 1, 1, 1);
          int firstDayOfYearInt = firstDayOfYear.year * 10000 +
              firstDayOfYear.month * 100 +
              firstDayOfYear.day;
          int lastDayOfYearInt = lastDayOfYear.year * 10000 +
              lastDayOfYear.month * 100 +
              lastDayOfYear.day;
          print('firstDayOfYearInt: $firstDayOfYearInt');
          print('lastDayOfYearInt: $lastDayOfYearInt');
          var response = await orderRepo.getRevenueFiller(
            userID: userID,
            startDate: firstDayOfYearInt,
            endDate: lastDayOfYearInt,
          );
          List<dynamic> transactions = response;
          Map<String, double> totalByMonth = {};

          for (var transaction in transactions) {
            String payedAt = transaction['payed_at'].substring(5, 7);
            double totalPrice = transaction['total_price'];

            if (totalByMonth.containsKey(payedAt)) {
              totalByMonth[payedAt] = totalByMonth[payedAt]! + totalPrice;
            } else {
              totalByMonth[payedAt] = totalPrice;
            }
          }
          totalByMonth.forEach((key, value) {
            responseData.add({
              "total_price": value,
              "date": key,
            });
          });
          break;
        default:
      }

      return AppResponse().ok(
        statusCode: HttpStatus.ok,
        message: 'success',
        data: responseData,
      );
    } catch (e) {
      print('revenueFilterOnDate: $e');
      return AppResponse().error(
        statusCode: HttpStatus.internalServerError,
        message: 'connection error',
      );
    }
  }

  DateTime getDate(DateTime d) => DateTime(d.year, d.month, d.day);
}

final HomeAdminController homeAdminCtrl = HomeAdminController(
  CategoryRepo(Categories()),
  OrderRepo(Orders()),
  FoodRepo(Foods()),
  TableRepo(Tables()),
);
