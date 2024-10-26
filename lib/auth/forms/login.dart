

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:local_auth/local_auth.dart';  // Biometric authentication package
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:stride_delivery/auth/controllers/login_c.dart';

import '../../utils/validators/validations.dart';
import 'forgotpwd.dart';

// Secure Storage instance
const storage = FlutterSecureStorage();

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final LocalAuthentication auth = LocalAuthentication();
  bool isFingerIdEnabled = false; // To track if Finger ID is enabled

  @override
  void initState() {
    super.initState();
    _loadFingerprintPreference(); // Load fingerprint preference from secure storage
  }

  // Load fingerprint preference
  Future<void> _loadFingerprintPreference() async {
    String? fingerprintEnabled = await storage.read(key: 'fingerId');
    setState(() {
      isFingerIdEnabled = fingerprintEnabled == 'true' ? true : false;
    });
  }

  // Authenticate using Fingerprint
  Future<void> _authenticateWithFingerprint() async {
    bool authenticated = false;
    try {
      authenticated = await auth.authenticate(
        localizedReason: 'Please authenticate to login',
        options: const AuthenticationOptions(
          useErrorDialogs: true,
          stickyAuth: true,
        ),
      );
    } catch (e) {
      // Handle errors here (e.g., no fingerprint sensors, etc.)
      print("Fingerprint Authentication Error: $e");
    }

    if (authenticated) {
      _loginSuccess(); // Proceed to login if authenticated
    }
  }

  // Simulate a successful login after fingerprint authentication
  void _loginSuccess() {
    // Proceed with your login logic here
    Get.snackbar("Login", "Fingerprint authentication successful!",
        snackPosition: SnackPosition.BOTTOM);
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());

    return LayoutBuilder(
      builder: (context, constraints) {
        double width = constraints.maxWidth;
        double height = constraints.maxHeight;

        return ScreenUtilInit(
          designSize: const Size(360, 690), // Base size for responsiveness
          builder: (context, child) {
            return SafeArea(
              child: Scaffold(
                body: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: height * 0.1, // Responsive vertical padding
                      horizontal: width * 0.1, // Responsive horizontal padding
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              'Stride',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 30.sp, // Responsive font size
                                fontFamily: 'Maturascript',
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10.h), // Scaled height
                        Text(
                          'Sign In',
                          style: TextStyle(
                              fontSize: 24.sp, // Responsive font size
                              fontWeight: FontWeight.w500,
                              color: Colors.black),
                        ),
                        SizedBox(height: 10.h),
                        Text(
                          'Kindly sign in to your account',
                          style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w400),
                        ),
                        SizedBox(height: 20.h),
                        Form(
                          key: controller.loginFormKey,
                          child: Column(
                            children: [
                              TextFormField(
                                controller: controller.email,
                                validator: (value) => BValidator.validateEmail(value),
                                keyboardType: TextInputType.emailAddress,
                                textInputAction: TextInputAction.next,
                                decoration: InputDecoration(
                                  prefixIcon: Icon(Iconsax.direct_right, size: 24.r), // Scaled icon size
                                  hintText: 'example@host.com',
                                  hintStyle: TextStyle(color: Colors.grey, fontSize: 14.sp),
                                  labelText: 'Email',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(10.r)),
                                  ),
                                ),
                              ),
                              SizedBox(height: 20.h),
                              Obx(
                                () => TextFormField(
                                  controller: controller.password,
                                  validator: (value) => BValidator.validatePassword(value),
                                  textInputAction: TextInputAction.done,
                                  keyboardType: TextInputType.visiblePassword,
                                  obscureText: controller.hidePassword.value,
                                  decoration: InputDecoration(
                                    labelText: 'Password',
                                    prefixIcon: Icon(Iconsax.password_check, size: 24.r),
                                    suffixIcon: IconButton(
                                      onPressed: () => controller.hidePassword.value = !controller.hidePassword.value,
                                      icon: Icon(controller.hidePassword.value
                                          ? Iconsax.eye_slash
                                          : Iconsax.eye, size: 24.r),
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(10.r)),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 20.h),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Obx(() => Checkbox(
                                        value: controller.rememberMe.value,
                                        onChanged: (value) => controller.rememberMe.value = value!,
                                      )),
                                      Text('Remember Me', style: TextStyle(fontSize: 14.sp)),
                                    ],
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Get.to(() => const Forgotpwd());
                                    },
                                    child: Text('Forget Password?', style: TextStyle(fontSize: 14.sp)),
                                  ),
                                ],
                              ),
                              SizedBox(height: 20.h),
                              GestureDetector(
                                onTap: () => controller.emailAndPasswordSignIn(),
                                child: Container(
                                  height: 50.h,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: Colors.black,
                                    borderRadius: BorderRadius.circular(10.r),
                                  ),
                                  child: Align(
                                    child: Text(
                                      'Sign In',
                                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.w400, fontSize: 20.sp),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 20.h),
                             
                              // Fingerprint login option
                              if (isFingerIdEnabled)
                                Column(
                                  children: [
                                    SizedBox(height: 20.h),
                                    GestureDetector(
                                      onTap: _authenticateWithFingerprint,
                                      child: Column(
                                        children: [
                                          Icon(Icons.fingerprint, size: 40.r, color: Colors.black),
                                          SizedBox(height: 10.h),
                                          Text(
                                            'Use Fingerprint to Sign In',
                                            style: TextStyle(fontSize: 10.sp, fontWeight: FontWeight.w500),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
