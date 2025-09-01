import 'package:dio/dio.dart';
import 'package:tree_talk/models/api_response.dart';
import '../models/mood_record.dart';
import '../models/user_profile.dart';
import 'http_service.dart';

class ApiService {
  // 使用单例模式
  static final ApiService _instance = ApiService._internal();

  factory ApiService() => _instance;

  // HTTP服务实例
  final HttpService _httpService = HttpService();

  ApiService._internal();

  // ========================= 用户相关API =========================

  // 用户登录
  Future<ApiResponse<String>> login(
    String username,
    String password,
    String loginType,
  ) async {
    return await _httpService
        .post(
          '/app/account/login',
          data: {
            'username': username,
            'password': password,
            'loginType': loginType,
          },
        )
        .then((response) {
          if (response.data['success']) {
            // 登录成功后设置token
            final token = response.data['data'];
            if (token != null && token is String && token.isNotEmpty) {
              _httpService.setToken(token);
            }
            return ApiResponse.success(data: token);
          } else {
            return ApiResponse.failure(
              code: response.data['code'],
              message: response.data['message'],
            );
          }
        });
  }

  // 获取手机验证码
  Future<ApiResponse> checkCode(String username, String sceneCode) async {
    return await _httpService
        .post(
          '/common/smsCheckCode',
          data: {'username': username, 'sceneCode': sceneCode},
        )
        .then((response) {
          if (response.data['success']) {
            return ApiResponse.success();
          } else {
            return ApiResponse.failure(
              code: response.data['code'],
              message: response.data['message'],
            );
          }
        });
  }

  // 用户注册
  Future<Response> register(
    String email,
    String password,
    String username,
  ) async {
    return await _httpService.post(
      '/auth/register',
      data: {'email': email, 'password': password, 'username': username},
    );
  }

  // 获取用户信息
  Future<ApiResponse<UserProfile>> profile() async {
    return await _httpService.get('/app/account/current').then((response) {
      if (response.data['success']) {
        return ApiResponse.success(
          data: UserProfile.fromMap(response.data['data']),
        );
      } else {
        return ApiResponse.failure(
          code: response.data['code'],
          message: response.data['message'],
        );
      }
    });
  }

  // 更新用户信息
  Future<Response> updateUserInfo(Map<String, dynamic> userData) async {
    return await _httpService.put('/user/info', data: userData);
  }

  // ======================== 情绪记录相关API ========================

  // 获取所有情绪记录
  Future<Response> getAllMoodRecords() async {
    return await _httpService.get('/mood-records');
  }

  // 获取特定日期的情绪记录
  Future<Response> getMoodRecordByDate(DateTime date) async {
    final dateString = date.toIso8601String().split('T')[0]; // YYYY-MM-DD格式
    return await _httpService.get('/mood-records/date/$dateString');
  }

  // 获取指定日期范围内的情绪记录
  Future<Response> getMoodRecordsByDateRange(
    DateTime startDate,
    DateTime endDate,
  ) async {
    final startDateString = startDate.toIso8601String().split('T')[0];
    final endDateString = endDate.toIso8601String().split('T')[0];
    return await _httpService.get(
      '/mood-records/range',
      queryParameters: {'start': startDateString, 'end': endDateString},
    );
  }

  // 添加新的情绪记录
  Future<Response> addMoodRecord(MoodRecord record) async {
    return await _httpService.post('/mood-records', data: record.toMap());
  }

  // 更新情绪记录
  Future<Response> updateMoodRecord(int id, MoodRecord record) async {
    return await _httpService.put('/mood-records/$id', data: record.toMap());
  }

  // 删除情绪记录
  Future<Response> deleteMoodRecord(int id) async {
    return await _httpService.delete('/mood-records/$id');
  }

  // ======================== 冥想相关API ========================

  // 获取冥想列表
  Future<Response> getMeditationList({int page = 1, int pageSize = 20}) async {
    return await _httpService.get(
      '/meditations',
      queryParameters: {'page': page, 'pageSize': pageSize},
    );
  }

  // 获取冥想详情
  Future<Response> getMeditationDetail(int id) async {
    return await _httpService.get('/meditations/$id');
  }

  // 获取冥想分类
  Future<Response> getMeditationCategories() async {
    return await _httpService.get('/meditations/categories');
  }

  // 记录冥想播放
  Future<Response> recordMeditationPlay(int id) async {
    return await _httpService.post('/meditations/$id/play');
  }

  // ======================== 树洞相关API ========================

  // 获取树洞列表
  Future<Response> getTreeHoleList({int page = 1, int pageSize = 20}) async {
    return await _httpService.get(
      '/tree-hole',
      queryParameters: {'page': page, 'pageSize': pageSize},
    );
  }

  // 发布树洞
  Future<Response> publishTreeHole(String content) async {
    return await _httpService.post('/tree-hole', data: {'content': content});
  }

  // 给树洞点亮星光
  Future<Response> starTreeHole(int id, {String? message}) async {
    return await _httpService.post(
      '/tree-hole/$id/star',
      data: message != null ? {'message': message} : {},
    );
  }

  // ======================== 订阅相关API ========================

  // 获取订阅信息
  Future<Response> getSubscriptionInfo() async {
    return await _httpService.get('/subscription');
  }

  // 购买订阅
  Future<Response> purchaseSubscription(int planId) async {
    return await _httpService.post(
      '/subscription/purchase',
      data: {'planId': planId},
    );
  }

  // ======================== 情绪分析相关API ========================

  // 获取情绪统计
  Future<Response> getMoodStatistics() async {
    return await _httpService.get('/mood-records/statistics');
  }

  // 获取情绪趋势
  Future<Response> getMoodTrend({String period = 'week'}) async {
    return await _httpService.get(
      '/mood-records/trend',
      queryParameters: {'period': period}, // 'week', 'month', 'year'
    );
  }

  // ======================== AI聊天相关API ========================

  // 发送AI聊天消息
  Future<Response> sendAiChatMessage(String message) async {
    return await _httpService.post('/ai-chat', data: {'message': message});
  }

  // 获取聊天历史
  Future<Response> getChatHistory({int limit = 50}) async {
    return await _httpService.get(
      '/ai-chat/history',
      queryParameters: {'limit': limit},
    );
  }

  // ======================== 设置相关API ========================

  // 获取用户设置
  Future<Response> getUserSettings() async {
    return await _httpService.get('/user/settings');
  }

  // 更新用户设置
  Future<Response> updateUserSettings(Map<String, dynamic> settings) async {
    return await _httpService.put('/user/settings', data: settings);
  }

  // ======================== 通用方法 ========================

  // 设置认证token
  void setToken(String token) {
    _httpService.setToken(token);
  }

  // 移除认证token
  void removeToken() {
    _httpService.removeToken();
  }
}
