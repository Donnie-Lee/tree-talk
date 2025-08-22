import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../theme/app_colors.dart';
import '../routes/app_routes.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _codeController = TextEditingController();
  bool _obscurePassword = true;
  bool _isLoading = false;
  int _countdown = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _codeController.dispose();
    super.dispose();
  }

  void _sendCode() async {
    if (_phoneController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('请输入手机号')),
      );
      return;
    }

    setState(() {
      _countdown = 60;
    });

    // 模拟倒计时
    for (int i = 60; i > 0; i--) {
      await Future.delayed(const Duration(seconds: 1));
      if (mounted) {
        setState(() {
          _countdown = i - 1;
        });
      }
    }
  }

  void _login() async {
    setState(() => _isLoading = true);

    // 模拟登录过程
    await Future.delayed(const Duration(seconds: 2));

    if (mounted) {
      setState(() => _isLoading = false);
      AppRoutes.navigateToAndRemoveUntil(context, AppRoutes.main);
    }
  }

  void _thirdPartyLogin(String platform) async {
    setState(() => _isLoading = true);

    // 模拟第三方登录
    await Future.delayed(const Duration(seconds: 2));

    if (mounted) {
      setState(() => _isLoading = false);
      AppRoutes.navigateToAndRemoveUntil(context, AppRoutes.main);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryDark,
      body: SafeArea(
        child: Stack(
          children: [
            // 背景渐变
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    AppColors.primaryDark,
                    AppColors.primary,
                    AppColors.primaryLight,
                  ],
                ),
              ),
            ),

            // 内容区域
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 60),

                    // Logo和标题
                    Column(
                      children: [
                        Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            color: AppColors.accent.withOpacity(0.2),
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.accentGlow,
                                blurRadius: 20,
                                spreadRadius: 5,
                              ),
                            ],
                          ),
                          child: Icon(
                            Icons.forest,
                            size: 40,
                            color: AppColors.accent,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          '心语 TreeTalk',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '记录心情，疗愈心灵',
                          style: TextStyle(
                            fontSize: 16,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 48),

                    // 登录方式切换Tab
                    Container(
                      decoration: BoxDecoration(
                        color: AppColors.glassBg,
                        borderRadius: BorderRadius.circular(25),
                        border: Border.all(
                          color: AppColors.glassBorder,
                          width: 1,
                        ),
                      ),
                      child: TabBar(
                        controller: _tabController,
                        indicator: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              AppColors.accent,
                              AppColors.neonOrange,
                            ],
                          ),
                          borderRadius: BorderRadius.circular(25),
                        ),
                        indicatorSize: TabBarIndicatorSize.tab,
                        labelColor: AppColors.textPrimary,
                        dividerColor: Colors.transparent,
                        unselectedLabelColor: AppColors.textSecondary,
                        tabs: const [
                          Tab(text: '手机验证码'),
                          Tab(text: '密码登录'),
                        ],
                      ),
                    ),

                    const SizedBox(height: 32),

                    // 表单区域
                    SizedBox(
                      height: 300,
                      child: TabBarView(
                        controller: _tabController,
                        children: [
                          // 手机验证码登录
                          _buildCodeLoginForm(),
                          // 密码登录
                          _buildPasswordLoginForm(),
                        ],
                      ),
                    ),

                    const SizedBox(height: 32),



                  ],
                ),
              ),
            ),
            // 第三方登录
            Positioned(
              left: 32.0,
              right: 32.0,
              bottom: 20,
              child:   Column(
                children: [
                  // 登录按钮
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: _isLoading ? null : _login,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.accent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(28),
                        ),
                        elevation: 8,
                        shadowColor: AppColors.accentGlow,
                      ),
                      child: _isLoading
                          ? const CircularProgressIndicator(color: Colors.white)
                          : const Text(
                        '登录',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    '或使用以下方式登录',
                    style: TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildThirdPartyButton(
                        Icons.wechat,
                        Colors.green,
                        '微信',
                            () => _thirdPartyLogin('wechat'),
                      ),
                      const SizedBox(width: 24),
                      _buildThirdPartyButton(
                        Icons.chat,
                        Colors.blue,
                        'QQ',
                            () => _thirdPartyLogin('qq'),
                      ),
                      const SizedBox(width: 24),
                      _buildThirdPartyButton(
                        Icons.music_note,
                        Colors.black,
                        '抖音',
                            () => _thirdPartyLogin('douyin'),
                      ),
                    ],
                  ),
                ],
              ),)
          ],
        ),
      ),
    );
  }

  Widget _buildCodeLoginForm() {
    return Column(
      children: [
        _buildTextField(
          controller: _phoneController,
          hintText: '请输入手机号',
          prefixIcon: Icons.phone_android,
          keyboardType: TextInputType.phone,
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: _buildTextField(
                controller: _codeController,
                hintText: '请输入验证码',
                prefixIcon: Icons.verified_user,
                keyboardType: TextInputType.number,
              ),
            ),
            const SizedBox(width: 12),
            SizedBox(
              width: 120,
              child: TextButton(
                onPressed: _countdown > 0 ? null : _sendCode,
                style: TextButton.styleFrom(
                  backgroundColor: AppColors.accent.withOpacity(0.2),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: Text(
                  _countdown > 0 ? '${_countdown}s' : '获取验证码',
                  style: TextStyle(
                    color: _countdown > 0
                        ? AppColors.textSecondary
                        : AppColors.accent,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildPasswordLoginForm() {
    return Column(
      children: [
        _buildTextField(
          controller: _phoneController,
          hintText: '请输入手机号/邮箱',
          prefixIcon: Icons.person,
          keyboardType: TextInputType.emailAddress,
        ),
        const SizedBox(height: 16),
        _buildTextField(
          controller: _passwordController,
          hintText: '请输入密码',
          prefixIcon: Icons.lock,
          obscureText: _obscurePassword,
          suffixIcon: IconButton(
            icon: Icon(
              _obscurePassword ? Icons.visibility_off : Icons.visibility,
              color: AppColors.textSecondary,
            ),
            onPressed: () {
              setState(() {
                _obscurePassword = !_obscurePassword;
              });
            },
          ),
        ),
        const SizedBox(height: 8),
        Align(
          alignment: Alignment.centerRight,
          child: TextButton(
            onPressed: () {
              // 忘记密码
            },
            child: Text(
              '忘记密码？',
              style: TextStyle(color: AppColors.textSecondary),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    required IconData prefixIcon,
    TextInputType? keyboardType,
    bool obscureText = false,
    Widget? suffixIcon,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.glassBg,
        borderRadius: BorderRadius.circular(25),
        border: Border.all(
          color: AppColors.glassBorder,
          width: 1,
        ),
      ),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        obscureText: obscureText,
        style: const TextStyle(color: AppColors.textPrimary),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(color: AppColors.textSecondary.withOpacity(0.7)),
          prefixIcon: Icon(prefixIcon, color: AppColors.textSecondary),
          suffixIcon: suffixIcon,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 16,
          ),
        ),
      ),
    );
  }

  Widget _buildThirdPartyButton(
    IconData icon,
    Color color,
    String label,
    VoidCallback onPressed,
  ) {
    return Column(
      children: [
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: AppColors.glassBg,
            shape: BoxShape.circle,
            border: Border.all(
              color: AppColors.glassBorder,
              width: 1,
            ),
          ),
          child: IconButton(
            icon: Icon(icon, color: color, size: 30),
            onPressed: onPressed,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            color: AppColors.textSecondary,
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}