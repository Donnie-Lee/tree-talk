class ApiResponse<T> {
  // 状态码
  final int code;
  
  // 消息
  final String message;
  
  // 数据
  final T? data;
  
  // 是否成功
  final bool success;
  
  // 构造函数
  const ApiResponse({
    required this.code,
    required this.message,
    this.data,
    required this.success,
  });
  
  // 从JSON创建实例
  factory ApiResponse.fromJson(
    Map<String, dynamic> json,
    T Function(dynamic data) fromJsonT,
  ) {
    return ApiResponse<T>(
      code: json['code'] ?? 0,
      message: json['message'] ?? '',
      data: json.containsKey('data') && json['data'] != null
          ? fromJsonT(json['data'])
          : null,
      success: json['success'] ?? false,
    );
  }
  
  // 创建成功响应
  factory ApiResponse.success({
    int code = 200,
    String message = 'success',
    T? data,
  }) {
    return ApiResponse<T>(
      code: code,
      message: message,
      data: data,
      success: true,
    );
  }
  
  // 创建失败响应
  factory ApiResponse.failure({
    int code = -1,
    String message = '失败',
    T? data,
  }) {
    return ApiResponse<T>(
      code: code,
      message: message,
      data: data,
      success: false,
    );
  }
  
  // 转换为JSON
  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'message': message,
      'data': data,
      'success': success,
    };
  }
  
  @override
  String toString() {
    return 'ApiResponse(code: $code, message: $message, data: $data, success: $success)';
  }
}

// 分页响应模型
class PagedResponse<T> {
  // 当前页码
  final int page;
  
  // 每页数量
  final int pageSize;
  
  // 总条数
  final int total;
  
  // 总页数
  final int totalPages;
  
  // 数据列表
  final List<T> list;
  
  // 是否有下一页
  bool get hasNextPage => page < totalPages;
  
  // 是否有上一页
  bool get hasPrevPage => page > 1;
  
  // 构造函数
  const PagedResponse({
    required this.page,
    required this.pageSize,
    required this.total,
    required this.totalPages,
    required this.list,
  });
  
  // 从JSON创建实例
  factory PagedResponse.fromJson(
    Map<String, dynamic> json,
    T Function(dynamic data) fromJsonT,
  ) {
    final list = (json['list'] as List<dynamic>? ?? [])
        .map((item) => fromJsonT(item))
        .toList();
    
    return PagedResponse<T>(
      page: json['page'] ?? 1,
      pageSize: json['pageSize'] ?? 20,
      total: json['total'] ?? 0,
      totalPages: json['totalPages'] ?? 0,
      list: list,
    );
  }
  
  // 转换为JSON
  Map<String, dynamic> toJson() {
    return {
      'page': page,
      'pageSize': pageSize,
      'total': total,
      'totalPages': totalPages,
      'list': list,
    };
  }
  
  @override
  String toString() {
    return 'PagedResponse(page: $page, pageSize: $pageSize, total: $total, totalPages: $totalPages, list: $list)';
  }
}