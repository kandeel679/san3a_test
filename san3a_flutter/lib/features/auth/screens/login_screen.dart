import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/shared_widgets.dart';
import '../../../core/utils/app_state.dart';

/// Mirrors RegisterScreen.kt
class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _phoneController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  AppButtonState _buttonState = AppButtonState.enable;

  void _sendOtp() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    setState(() => _buttonState = AppButtonState.loading);

    // Simulate OTP sending
    await Future.delayed(const Duration(seconds: 2));

    if (!mounted) return;
    setState(() => _buttonState = AppButtonState.enable);

    final phone = _phoneController.text.trim();
    AppStateProvider.of(context).savePhone(phone);
    context.push('/otp', extra: phone);
  }

  @override
  Widget build(BuildContext context) {
    final theme = San3aTheme.of(context);
    return Scaffold(
      backgroundColor: theme.colors.background.screen,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 40),
                Text(
                  'Welcome to San3a',
                  style: theme.textStyle.titleXLarge.copyWith(color: theme.colors.shade.primary),
                ),
                const SizedBox(height: 8),
                Text(
                  'Enter your phone number to get started',
                  style: theme.textStyle.bodyMediumRegular.copyWith(color: theme.colors.shade.secondary),
                ),
                const SizedBox(height: 40),
                AppTextField(
                  label: 'Phone Number',
                  hint: '+20 1XX XXX XXXX',
                  controller: _phoneController,
                  keyboardType: TextInputType.phone,
                  prefix: const Icon(Icons.phone_outlined),
                  validator: (value) {
                    if (value == null || value.isEmpty) return 'Phone number is required';
                    if (value.length < 10) return 'Invalid phone number';
                    return null;
                  },
                ),
                const SizedBox(height: 24),
                AppButton(
                  text: 'Send OTP',
                  state: _buttonState,
                  onPressed: _sendOtp,
                ),
                const Spacer(),
                Center(
                  child: Text(
                    'By continuing, you agree to our Terms of Service',
                    style: theme.textStyle.bodySmallRegular.copyWith(color: theme.colors.shade.tertiary),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Mirrors OTPRegisterScreen.kt
class OtpScreen extends StatefulWidget {
  final String phone;
  const OtpScreen({Key? key, required this.phone}) : super(key: key);

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final List<TextEditingController> _controllers = List.generate(4, (_) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(4, (_) => FocusNode());
  AppButtonState _buttonState = AppButtonState.disable;

  void _checkOtp() {
    final otp = _controllers.map((c) => c.text).join();
    setState(() {
      _buttonState = otp.length == 4 ? AppButtonState.enable : AppButtonState.disable;
    });
  }

  void _verifyOtp() async {
    setState(() => _buttonState = AppButtonState.loading);
    await Future.delayed(const Duration(seconds: 2));
    if (!mounted) return;

    // For demo purposes, any 4-digit code works
    final appState = AppStateProvider.of(context);
    appState.savePhone(widget.phone);
    context.go('/account_setup');
  }

  @override
  Widget build(BuildContext context) {
    final theme = San3aTheme.of(context);
    return Scaffold(
      backgroundColor: theme.colors.background.screen,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: theme.colors.shade.primary),
          onPressed: () => context.pop(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Verification', style: theme.textStyle.titleXLarge.copyWith(color: theme.colors.shade.primary)),
            const SizedBox(height: 8),
            Text(
              'Enter the 4-digit code sent to ${widget.phone}',
              style: theme.textStyle.bodyMediumRegular.copyWith(color: theme.colors.shade.secondary),
            ),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(4, (i) {
                return Container(
                  width: 56,
                  height: 56,
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                  child: TextField(
                    controller: _controllers[i],
                    focusNode: _focusNodes[i],
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                    maxLength: 1,
                    style: theme.textStyle.titleXLarge.copyWith(color: theme.colors.shade.primary),
                    decoration: InputDecoration(
                      counterText: '',
                      filled: true,
                      fillColor: theme.colors.background.card,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(theme.radius.large),
                        borderSide: BorderSide(color: theme.colors.stroke.primary),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(theme.radius.large),
                        borderSide: BorderSide(color: theme.colors.brand.primary, width: 2),
                      ),
                    ),
                    onChanged: (value) {
                      _checkOtp();
                      if (value.isNotEmpty && i < 3) {
                        _focusNodes[i + 1].requestFocus();
                      }
                    },
                  ),
                );
              }),
            ),
            const SizedBox(height: 40),
            AppButton(text: 'Verify', state: _buttonState, onPressed: _verifyOtp),
            const SizedBox(height: 24),
            Center(
              child: TextButton(
                onPressed: () {},
                child: Text('Resend Code', style: theme.textStyle.bodyMediumMedium.copyWith(color: theme.colors.brand.primary)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
