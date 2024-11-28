import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FormCommon extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController? passwordConfirmController;

  const FormCommon({
    super.key,
    required this.formKey,
    required this.emailController,
    required this.passwordController,
    this.passwordConfirmController,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
        key: formKey,
        child: Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text('Email',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      fontSize: 14.sp,
                      color: const Color.fromRGBO(138, 138, 138, 1))),
            ],
          ),
          SizedBox(height: 12.h),
          SizedBox(
            height: 54.h,
            child: TextFormField(
              controller: emailController,
              decoration: InputDecoration(
                  labelText: 'Email',
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(18.r)),
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: const Color.fromRGBO(43, 57, 185, 1),
                          width: 2.w),
                      borderRadius: BorderRadius.all(Radius.circular(18.r)))),
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your email';
                }
                // } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                //   return 'Please enter a vaild email';
                // }
                return null;
              },
            ),
          ),
          SizedBox(
            height: 20.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text('Password',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      fontSize: 14.sp,
                      color: const Color.fromRGBO(138, 138, 138, 1))),
            ],
          ),
          SizedBox(height: 12.h),
          SizedBox(
            height: 54.h,
            child: TextFormField(
              controller: passwordController,
              decoration: const InputDecoration(
                  labelText: 'Password',
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(18)),
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Color.fromRGBO(43, 57, 185, 1), width: 2),
                      borderRadius: BorderRadius.all(Radius.circular(18)))),
              obscureText: true,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your password';
                } else if (value.length < 6) {
                  return 'Password must be at least 6 characters long';
                }
                return null;
              },
            ),
          ),
          if (passwordConfirmController != null) ...[
            SizedBox(
              height: 20.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text('Password',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        fontSize: 14.sp,
                        color: const Color.fromRGBO(138, 138, 138, 1))),
              ],
            ),
            SizedBox(height: 12.h),
            SizedBox(
              height: 54.h,
              child: TextFormField(
                controller: passwordConfirmController,
                decoration: InputDecoration(
                    hintText: 'Type password here',
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(18)),
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: const Color.fromRGBO(43, 57, 185, 1),
                            width: 2.w),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(18)))),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  } else if (value.length < 6) {
                    return 'Password must be at least 6 characters long';
                  }
                  return null;
                },
              ),
            )
          ],
        ]));
  }
}
