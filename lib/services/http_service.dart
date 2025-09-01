import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HttpService {
  // 创建单例实例
  static final HttpService _instance = HttpService._internal();
  factory HttpService() => _instance;
  
  // Dio实例
  late final Dio _dio;
  
  // 基础URL
  static const String baseUrl = 'http://localhost:8080/api';
  
  // SharedPreferences实例
  late final SharedPreferences _prefs;
  
  // token键名
  static const String _tokenKey = 'auth_token';
  
  HttpService._internal() {
    // 初始化Dio
    _dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
        sendTimeout: const Duration(seconds: 10),
        contentType: 'application/json',
        responseType: ResponseType.json,
      ),
    );
    
    // 添加请求拦截器
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          // 可以在这里添加token等认证信息
          // options.headers['Authorization'] = 'Bearer $token';
          print('请求URL: ${options.uri}');
          print('请求参数: ${options.data}');
          return handler.next(options);
        },
        onResponse: (response, handler) {
          print('响应数据: ${response.data}');
          return handler.next(response);
        },
        onError: (DioException e, handler) {
          print('请求错误: ${e.message}');
          // 可以在这里统一处理错误
          return handler.next(e);
        },
      ),
    );
  }
  
  // 设置认证token
  void setToken(String token) {
    _dio.options.headers['Authorization'] = 'Bearer $token';
    // 保存token到本地
    _prefs.setString(_tokenKey, token);
  }
  
  // 移除认证token
  void removeToken() {
    _dio.options.headers.remove('Authorization');
    // 从本地删除token
    _prefs.remove(_tokenKey);
  }
  
  // GET请求
  Future<Response> get(
    String path,
    {
      Map<String, dynamic>? queryParameters,
      Options? options,
      CancelToken? cancelToken,
      ProgressCallback? onReceiveProgress,
    }
  ) async {
    try {
      final response = await _dio.get(
        path,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }
  
  // 初始化SharedPreferences
  static Future<HttpService> initialize() async {
    final instance = HttpService();
    instance._prefs = await SharedPreferences.getInstance();
    
    // 加载已保存的token
    final savedToken = instance.getSavedToken();
    if (savedToken != null) {
      instance.setToken(savedToken);
    }
    
    return instance;
  }
  
  // 获取已保存的token
  String? getSavedToken() {
    return _prefs.getString(_tokenKey);
  }
  
  // POST请求
  Future<Response> post(
    String path,
    {
      dynamic data,
      Map<String, dynamic>? queryParameters,
      Options? options,
      CancelToken? cancelToken,
      ProgressCallback? onSendProgress,
      ProgressCallback? onReceiveProgress,
    }
  ) async {
    try {
      final response = await _dio.post(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }
  
  // PUT请求
  Future<Response> put(
    String path,
    {
      dynamic data,
      Map<String, dynamic>? queryParameters,
      Options? options,
      CancelToken? cancelToken,
      ProgressCallback? onSendProgress,
      ProgressCallback? onReceiveProgress,
    }
  ) async {
    try {
      final response = await _dio.put(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }
  
  // DELETE请求
  Future<Response> delete(
    String path,
    {
      dynamic data,
      Map<String, dynamic>? queryParameters,
      Options? options,
      CancelToken? cancelToken,
    }
  ) async {
    try {
      final response = await _dio.delete(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
      return response;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }
  
  // 上传文件
  Future<Response> uploadFile(
    String path,
    String filePath,
    {
      String fileName = 'file',
      String fileKey = 'file',
      Map<String, dynamic>? queryParameters,
      Map<String, dynamic>? formData,
      Options? options,
      CancelToken? cancelToken,
      ProgressCallback? onSendProgress,
    }
  ) async {
    try {
      final FormData data = FormData.fromMap({
        ...?formData,
        fileKey: await MultipartFile.fromFile(
          filePath,
          filename: fileName,
        ),
      });
      
      final response = await _dio.post(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
      );
      return response;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }
  
  // 处理错误
  Exception _handleError(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return Exception('网络连接超时，请检查网络设置');
      case DioExceptionType.badResponse:
        switch (e.response?.statusCode) {
          case 400:
            return Exception('请求错误，请检查请求参数');
          case 401:
            return Exception('未授权，请重新登录');
          case 403:
            return Exception('拒绝访问');
          case 404:
            return Exception('请求的资源不存在');
          case 500:
            return Exception('服务器内部错误');
          default:
            return Exception('HTTP错误: ${e.response?.statusCode}');
        }
      case DioExceptionType.cancel:
        return Exception('请求已取消');
      case DioExceptionType.unknown:
        return Exception('未知错误，请检查网络连接');
      default:
        return Exception('请求失败');
    }
  }
}