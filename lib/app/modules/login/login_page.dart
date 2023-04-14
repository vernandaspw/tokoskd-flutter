import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tokoskd/app/core/theme/tema.dart';

import 'login_controller.dart';

class LoginPage extends GetView<LoginController> {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (MediaQuery.of(context).size.width >= 600.0) {
      return Scaffold(
        body: Container(
          margin: const EdgeInsets.all(0),
          padding: EdgeInsets.symmetric(horizontal: Get.width / 2.8),
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color.fromARGB(255, 13, 255, 0),
                Color.fromARGB(255, 0, 191, 255),
              ],
            ),
          ),
          child: ListView(
            children: [
              Obx(() => Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 150,
                            ),
                            const Text(
                              "Login | Masuk",
                              style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                            Tema.enter15,
                            TextField(
                              controller: controller.urlC,
                              // keyboardType: TextInputType.phone,
                              decoration: InputDecoration(
                                errorText: controller.validateUrl,
                                errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: const BorderSide(
                                      width: 1, color: Colors.red),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: const BorderSide(
                                      width: 1, color: Colors.red),
                                ),
                                prefixIcon: const Icon(
                                  Icons.link,
                                  color: Colors.black,
                                ),
                                fillColor: Colors.white,
                                filled: true,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: BorderSide.none,
                                ),
                                hintText: 'masukan ip address',
                                isDense: true,
                                contentPadding: const EdgeInsets.symmetric(
                                  vertical: 14,
                                  horizontal: 20,
                                ),
                              ),
                            ),
                            Tema.enter8,
                            TextField(
                              controller: controller.phoneC,
                              keyboardType: TextInputType.phone,
                              decoration: InputDecoration(
                                errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: const BorderSide(
                                      width: 1, color: Colors.red),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: const BorderSide(
                                      width: 1, color: Colors.red),
                                ),
                                errorText: controller.validatePhone,
                                prefixIcon: const Icon(
                                  Icons.person,
                                  color: Colors.black,
                                ),
                                fillColor: Colors.white,
                                filled: true,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: BorderSide.none,
                                ),
                                hintText: 'No hp',
                                isDense: true,
                                contentPadding: const EdgeInsets.symmetric(
                                  vertical: 14,
                                  horizontal: 20,
                                ),
                              ),
                            ),
                            Tema.enter8,
                            TextField(
                              controller: controller.passC,
                              obscureText: controller.hidden.isFalse,
                              decoration: InputDecoration(
                                errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: const BorderSide(
                                      width: 1, color: Colors.red),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: const BorderSide(
                                      width: 1, color: Colors.red),
                                ),
                                errorText: controller.validatePassword,
                                suffixIcon: IconButton(
                                  onPressed: () => controller.hidden.toggle(),
                                  icon: controller.hidden.isTrue
                                      ? const Icon(Icons.remove_red_eye)
                                      : const Icon(
                                          Icons.remove_red_eye_outlined),
                                ),
                                prefixIcon: const Icon(
                                  Icons.key,
                                  color: Colors.black,
                                ),
                                fillColor: Colors.white,
                                filled: true,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: BorderSide.none,
                                ),
                                hintText: 'Password',
                                isDense: true,
                                contentPadding: const EdgeInsets.symmetric(
                                  vertical: 14,
                                  horizontal: 20,
                                ),
                              ),
                            ),
                            Tema.enter8,
                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.end,
                            //   children: [
                            //     GestureDetector(
                            //       onTap: () {
                            //         Get.toNamed('/daftar');
                            //       },
                            //       child: const Text(
                            //         'Lupa password?',
                            //         style: TextStyle(
                            //             color: Colors.white,
                            //             fontWeight: FontWeight.bold),
                            //       ),
                            //     ),
                            //     Tema.enter8,
                            //   ],
                            // ),
                            Tema.enter15,
                            controller.isLoading.value == true
                                ? const Center(
                                    child: CircularProgressIndicator(
                                        color: Colors.white),
                                  )
                                : ElevatedButton(
                                    onPressed: () => controller.login(
                                        controller.phoneC.text,
                                        controller.passC.text,
                                        controller.urlC.text),
                                    style: ElevatedButton.styleFrom(
                                      elevation: 10,
                                      backgroundColor: Colors.white,
                                      minimumSize: const Size.fromHeight(46),
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                      ),
                                    ),
                                    child: const Text(
                                      "Masuk",
                                      style: TextStyle(color: Colors.green),
                                    ),
                                  ),
                          ],
                        ),
                      ),
                    ),
                  )),
              // Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.center,
              //     children: [
              //       const Text(
              //         'Tidak memiliki akun?',
              //         style: TextStyle(color: Colors.white),
              //       ),
              //       SizedBox(
              //         width: 5,
              //         child: Container(),
              //       ),
              //       GestureDetector(
              //         onTap: () {
              //           Get.toNamed('/daftar');
              //         },
              //         child: const Text(
              //           'Daftar',
              //           style: TextStyle(
              //               color: Colors.white, fontWeight: FontWeight.bold),
              //         ),
              //       )
              //     ],
              //   ),
              // ),
            ],
          ),
        ),
      );
    } else {
      // ukuran HP
      return Scaffold(
        body: Container(
          margin: const EdgeInsets.all(0),
          // padding: EdgeInsets.symmetric(horizontal: Get.width / 2.8),
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color.fromARGB(255, 13, 255, 0),
                Color.fromARGB(255, 0, 191, 255),
              ],
            ),
          ),
          child: ListView(
            children: [
              Obx(() => Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 150,
                            ),
                            const Text(
                              "Login | Masuk",
                              style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                            Tema.enter15,
                            TextField(
                              controller: controller.urlC,
                              // keyboardType: TextInputType.phone,
                              decoration: InputDecoration(
                                errorText: controller.validateUrl,
                                errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: const BorderSide(
                                      width: 1, color: Colors.red),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: const BorderSide(
                                      width: 1, color: Colors.red),
                                ),
                                prefixIcon: const Icon(
                                  Icons.link,
                                  color: Colors.black,
                                ),
                                fillColor: Colors.white,
                                filled: true,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: BorderSide.none,
                                ),
                                hintText: 'masukan ip address',
                                isDense: true,
                                contentPadding: const EdgeInsets.symmetric(
                                  vertical: 14,
                                  horizontal: 20,
                                ),
                              ),
                            ),
                            Tema.enter8,
                            TextField(
                              controller: controller.phoneC,
                              keyboardType: TextInputType.phone,
                              decoration: InputDecoration(
                                errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: const BorderSide(
                                      width: 1, color: Colors.red),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: const BorderSide(
                                      width: 1, color: Colors.red),
                                ),
                                errorText: controller.validatePhone,
                                prefixIcon: const Icon(
                                  Icons.person,
                                  color: Colors.black,
                                ),
                                fillColor: Colors.white,
                                filled: true,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: BorderSide.none,
                                ),
                                hintText: 'No hp',
                                isDense: true,
                                contentPadding: const EdgeInsets.symmetric(
                                  vertical: 14,
                                  horizontal: 20,
                                ),
                              ),
                            ),
                            Tema.enter8,
                            TextField(
                              controller: controller.passC,
                              obscureText: controller.hidden.isFalse,
                              decoration: InputDecoration(
                                errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: const BorderSide(
                                      width: 1, color: Colors.red),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: const BorderSide(
                                      width: 1, color: Colors.red),
                                ),
                                errorText: controller.validatePassword,
                                suffixIcon: IconButton(
                                  onPressed: () => controller.hidden.toggle(),
                                  icon: controller.hidden.isTrue
                                      ? const Icon(Icons.remove_red_eye)
                                      : const Icon(
                                          Icons.remove_red_eye_outlined),
                                ),
                                prefixIcon: const Icon(
                                  Icons.key,
                                  color: Colors.black,
                                ),
                                fillColor: Colors.white,
                                filled: true,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: BorderSide.none,
                                ),
                                hintText: 'Password',
                                isDense: true,
                                contentPadding: const EdgeInsets.symmetric(
                                  vertical: 14,
                                  horizontal: 20,
                                ),
                              ),
                            ),
                            Tema.enter8,
                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.end,
                            //   children: [
                            //     GestureDetector(
                            //       onTap: () {
                            //         Get.toNamed('/daftar');
                            //       },
                            //       child: const Text(
                            //         'Lupa password?',
                            //         style: TextStyle(
                            //             color: Colors.white,
                            //             fontWeight: FontWeight.bold),
                            //       ),
                            //     ),
                            //     Tema.enter8,
                            //   ],
                            // ),
                            Tema.enter15,
                            controller.isLoading.value == true
                                ? const Center(
                                    child: CircularProgressIndicator(
                                        color: Colors.white),
                                  )
                                : ElevatedButton(
                                    onPressed: () => controller.login(
                                        controller.phoneC.text,
                                        controller.passC.text,
                                        controller.urlC.text),
                                    style: ElevatedButton.styleFrom(
                                      elevation: 10,
                                      backgroundColor: Colors.white,
                                      minimumSize: const Size.fromHeight(46),
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                      ),
                                    ),
                                    child: const Text(
                                      "Masuk",
                                      style: TextStyle(color: Colors.green),
                                    ),
                                  ),
                          ],
                        ),
                      ),
                    ),
                  )),
              // Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.center,
              //     children: [
              //       const Text(
              //         'Tidak memiliki akun?',
              //         style: TextStyle(color: Colors.white),
              //       ),
              //       SizedBox(
              //         width: 5,
              //         child: Container(),
              //       ),
              //       GestureDetector(
              //         onTap: () {
              //           Get.toNamed('/daftar');
              //         },
              //         child: const Text(
              //           'Daftar',
              //           style: TextStyle(
              //               color: Colors.white, fontWeight: FontWeight.bold),
              //         ),
              //       )
              //     ],
              //   ),
              // ),
            ],
          ),
        ),
      );
    }
  }
}
