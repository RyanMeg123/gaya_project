import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Content extends StatelessWidget {
  const Content({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: 393,
          height: 1222,
          child: Stack(
            children: [
              Positioned(
                left: 0,
                top: 0,
                child: SizedBox(
                  width: 377,
                  height: 404,
                  child: Stack(
                    children: [
                      Positioned(
                        left: 0,
                        top: 0,
                        child: Container(
                          width: 377,
                          height: 404,
                          decoration:
                              const BoxDecoration(color: Color(0xFFC4C4C4)),
                        ),
                      ),
                      Positioned(
                        left: 0,
                        top: 0,
                        child: SizedBox(
                          width: 377,
                          height: 404,
                          child: Stack(
                            children: [
                              Positioned(
                                left: 0,
                                top: 0,
                                child: Container(
                                  width: 377,
                                  height: 404,
                                  decoration: const BoxDecoration(
                                      color: Color(0xFFC4C4C4)),
                                ),
                              ),
                              Positioned(
                                left: -1,
                                top: -14,
                                child: Container(
                                  width: 378,
                                  height: 473,
                                  decoration: const BoxDecoration(
                                    image: DecorationImage(
                                      image: NetworkImage(
                                          "https://via.placeholder.com/378x473"),
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 145,
                top: 347,
                child: SizedBox(
                  width: 88,
                  height: 4,
                  child: Stack(
                    children: [
                      Positioned(
                        left: 0,
                        top: 0,
                        child: Container(
                          width: 12,
                          height: 4,
                          decoration: ShapeDecoration(
                            color: const Color(0x35585858),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 16,
                        top: 0,
                        child: Container(
                          width: 24,
                          height: 4,
                          decoration: ShapeDecoration(
                            color: const Color(0xFF2B39B8),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 44,
                        top: 0,
                        child: Container(
                          width: 12,
                          height: 4,
                          decoration: ShapeDecoration(
                            color: const Color(0x35585858),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 60,
                        top: 0,
                        child: Container(
                          width: 12,
                          height: 4,
                          decoration: ShapeDecoration(
                            color: const Color(0x35585858),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 76,
                        top: 0,
                        child: Container(
                          width: 12,
                          height: 4,
                          decoration: ShapeDecoration(
                            color: const Color(0x35585858),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 1,
                top: 366,
                child: SizedBox(
                  width: 392,
                  height: 856,
                  child: Stack(
                    children: [
                      Positioned(
                        left: 1,
                        top: 0,
                        child: Container(
                          width: 375,
                          height: 856,
                          decoration: const ShapeDecoration(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(34),
                                topRight: Radius.circular(34),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 288,
                        top: 53,
                        child: SizedBox(
                          width: 58,
                          height: 58,
                          child: Stack(
                            children: [
                              Positioned(
                                left: 15,
                                top: 15,
                                child: Container(
                                  width: 28,
                                  height: 28,
                                  padding: const EdgeInsets.all(3),
                                  clipBehavior: Clip.antiAlias,
                                  decoration: const BoxDecoration(),
                                  child: const Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        left: 158,
                        top: 12,
                        child: Container(
                          width: 61,
                          height: 6,
                          decoration: ShapeDecoration(
                            color: const Color(0xFFDDDDDD),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 0,
                        top: 331,
                        child: SizedBox(
                          width: 392,
                          height: 115,
                          child: Stack(
                            children: [
                              Positioned(
                                left: 0,
                                top: 0,
                                child: Container(
                                  width: 375,
                                  height: 115,
                                  decoration:
                                      const BoxDecoration(color: Colors.white),
                                ),
                              ),
                              Positioned(
                                left: 0,
                                top: 0,
                                child: Container(
                                  width: 375,
                                  height: 1,
                                  decoration: const BoxDecoration(
                                      color: Color(0xFFEFEFEF)),
                                ),
                              ),
                              const Positioned(
                                left: 28,
                                top: 20,
                                child: Text(
                                  'Variant',
                                  style: TextStyle(
                                    color: Color(0xFF4D4D4D),
                                    fontSize: 16,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w600,
                                    height: 0.08,
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 112,
                                top: 54,
                                child: SizedBox(
                                  width: 84,
                                  height: 38,
                                  child: Stack(
                                    children: [
                                      Positioned(
                                        left: 0,
                                        top: 0,
                                        child: Container(
                                          width: 84,
                                          height: 38,
                                          decoration: ShapeDecoration(
                                            color: const Color(0xFFD1D5FF),
                                            shape: RoundedRectangleBorder(
                                              side: const BorderSide(
                                                  width: 1,
                                                  color: Color(0xFF2B39B8)),
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                          ),
                                        ),
                                      ),
                                      const Positioned(
                                        left: 13,
                                        top: 9,
                                        child: Text(
                                          'Medium',
                                          style: TextStyle(
                                            color: Color(0xFF2B39B8),
                                            fontSize: 14,
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w400,
                                            height: 0.10,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 290,
                                top: 54,
                                child: SizedBox(
                                  width: 102,
                                  height: 38,
                                  child: Stack(
                                    children: [
                                      Positioned(
                                        left: 0,
                                        top: 0,
                                        child: Container(
                                          width: 102,
                                          height: 38,
                                          decoration: ShapeDecoration(
                                            shape: RoundedRectangleBorder(
                                              side: const BorderSide(
                                                  width: 1,
                                                  color: Color(0xFF2B39B8)),
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                          ),
                                        ),
                                      ),
                                      const Positioned(
                                        left: 18,
                                        top: 9,
                                        child: Text(
                                          'Extra large',
                                          style: TextStyle(
                                            color: Color(0xFF2B39B8),
                                            fontSize: 14,
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w400,
                                            height: 0.10,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 28,
                                top: 54,
                                child: SizedBox(
                                  width: 74,
                                  height: 38,
                                  child: Stack(
                                    children: [
                                      Positioned(
                                        left: 0,
                                        top: 0,
                                        child: Container(
                                          width: 74,
                                          height: 38,
                                          decoration: ShapeDecoration(
                                            shape: RoundedRectangleBorder(
                                              side: const BorderSide(
                                                  width: 1,
                                                  color: Color(0xFF2B39B8)),
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                          ),
                                        ),
                                      ),
                                      const Positioned(
                                        left: 18,
                                        top: 9,
                                        child: Text(
                                          'Small',
                                          style: TextStyle(
                                            color: Color(0xFF2B39B8),
                                            fontSize: 14,
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w400,
                                            height: 0.10,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 206,
                                top: 54,
                                child: SizedBox(
                                  width: 74,
                                  height: 38,
                                  child: Stack(
                                    children: [
                                      Positioned(
                                        left: 0,
                                        top: 0,
                                        child: Container(
                                          width: 74,
                                          height: 38,
                                          decoration: ShapeDecoration(
                                            color: const Color(0xFFEAEAEA),
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8)),
                                          ),
                                        ),
                                      ),
                                      const Positioned(
                                        left: 18,
                                        top: 9,
                                        child: Text(
                                          'Large',
                                          style: TextStyle(
                                            color: Color(0xFF9B9B9B),
                                            fontSize: 14,
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w400,
                                            height: 0.10,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        left: 0,
                        top: 446,
                        child: SizedBox(
                          width: 375,
                          height: 162,
                          child: Stack(
                            children: [
                              Positioned(
                                left: 0,
                                top: 0,
                                child: Container(
                                  width: 375,
                                  height: 115,
                                  decoration:
                                      const BoxDecoration(color: Colors.white),
                                ),
                              ),
                              Positioned(
                                left: 0,
                                top: 0,
                                child: Container(
                                  width: 375,
                                  height: 1,
                                  decoration: const BoxDecoration(
                                      color: Color(0xFFEFEFEF)),
                                ),
                              ),
                              const Positioned(
                                left: 28,
                                top: 58,
                                child: SizedBox(
                                  width: 319,
                                  height: 20,
                                  child: Stack(
                                    children: [
                                      Positioned(
                                        left: 0,
                                        top: 0,
                                        child: Text(
                                          'Brand',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 14,
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w400,
                                            height: 0.10,
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        left: 239,
                                        top: 0,
                                        child: Text(
                                          'Naiki Shoes',
                                          textAlign: TextAlign.right,
                                          style: TextStyle(
                                            color: Color(0xFF777777),
                                            fontSize: 14,
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w400,
                                            height: 0.10,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const Positioned(
                                left: 28,
                                top: 86,
                                child: SizedBox(
                                  width: 319,
                                  height: 20,
                                  child: Stack(
                                    children: [
                                      Positioned(
                                        left: 0,
                                        top: 0,
                                        child: Text(
                                          'Weight',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 14,
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w400,
                                            height: 0.10,
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        left: 278,
                                        top: 0,
                                        child: Text(
                                          '260gr',
                                          textAlign: TextAlign.right,
                                          style: TextStyle(
                                            color: Color(0xFF777777),
                                            fontSize: 14,
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w400,
                                            height: 0.10,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const Positioned(
                                left: 28,
                                top: 114,
                                child: SizedBox(
                                  width: 319,
                                  height: 20,
                                  child: Stack(
                                    children: [
                                      Positioned(
                                        left: 0,
                                        top: 0,
                                        child: Text(
                                          'Condition',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 14,
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w400,
                                            height: 0.10,
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        left: 288,
                                        top: 0,
                                        child: Text(
                                          'NEW',
                                          textAlign: TextAlign.right,
                                          style: TextStyle(
                                            color: Color(0xFF777777),
                                            fontSize: 14,
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w400,
                                            height: 0.10,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const Positioned(
                                left: 28,
                                top: 142,
                                child: SizedBox(
                                  width: 319,
                                  height: 20,
                                  child: Stack(
                                    children: [
                                      Positioned(
                                        left: 0,
                                        top: 0,
                                        child: Text(
                                          'Category',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 14,
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w400,
                                            height: 0.10,
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        left: 243,
                                        top: 0,
                                        child: Text(
                                          'Men Shoes',
                                          textAlign: TextAlign.right,
                                          style: TextStyle(
                                            color: Color(0xFF2B39B8),
                                            fontSize: 14,
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w400,
                                            height: 0.10,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const Positioned(
                                left: 28,
                                top: 20,
                                child: Text(
                                  'Specifications',
                                  style: TextStyle(
                                    color: Color(0xFF4D4D4D),
                                    fontSize: 16,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w600,
                                    height: 0.08,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        left: 28,
                        top: 49,
                        child: SizedBox(
                          width: 319,
                          height: 262,
                          child: Stack(
                            children: [
                              Positioned(
                                left: 0,
                                top: 94,
                                child: SizedBox(
                                  width: 156,
                                  height: 25,
                                  child: Stack(
                                    children: [
                                      const Positioned(
                                        left: 0,
                                        top: 2,
                                        child: Text(
                                          '\$158.2',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 20,
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w600,
                                            height: 0.05,
                                            letterSpacing: -0.24,
                                          ),
                                        ),
                                      ),
                                      const Positioned(
                                        left: 72,
                                        top: 2,
                                        child: Text(
                                          '\$170',
                                          style: TextStyle(
                                            color: Color(0xFF777777),
                                            fontSize: 14,
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w500,
                                            // textDecoration: TextDecoration.lineThrough,
                                            height: 0,
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        left: 115,
                                        top: 0,
                                        child: SizedBox(
                                          width: 41,
                                          height: 25,
                                          child: Stack(
                                            children: [
                                              Positioned(
                                                left: 0,
                                                top: 0,
                                                child: Container(
                                                  width: 41,
                                                  height: 25,
                                                  decoration: ShapeDecoration(
                                                    color:
                                                        const Color(0xFFE83737),
                                                    shape:
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        3)),
                                                  ),
                                                ),
                                              ),
                                              const Positioned(
                                                left: 7,
                                                top: 3,
                                                child: Text(
                                                  '15%',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 14,
                                                    fontFamily: 'Poppins',
                                                    fontWeight: FontWeight.w500,
                                                    height: 0,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 261,
                                top: 94,
                                child: SizedBox(
                                  width: 57,
                                  height: 24,
                                  child: Stack(
                                    children: [
                                      Positioned(
                                        left: 0,
                                        top: 0,
                                        child: Container(
                                          width: 24,
                                          height: 24,
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 2.01, vertical: 2),
                                          clipBehavior: Clip.antiAlias,
                                          decoration: const BoxDecoration(),
                                          child: const Row(
                                            mainAxisSize: MainAxisSize.min,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [],
                                          ),
                                        ),
                                      ),
                                      const Positioned(
                                        left: 32,
                                        top: 0,
                                        child: Text(
                                          '4.6',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 16,
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w600,
                                            height: 0,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 0,
                                top: 241,
                                child: SizedBox(
                                  width: 234,
                                  height: 21,
                                  child: Stack(
                                    children: [
                                      Positioned(
                                        left: 0,
                                        top: 0,
                                        child: SizedBox(
                                          width: 104,
                                          height: 21,
                                          child: Stack(
                                            children: [
                                              const Positioned(
                                                left: 23,
                                                top: 0,
                                                child: Text(
                                                  '567 Viewed',
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 14,
                                                    fontFamily: 'Poppins',
                                                    fontWeight: FontWeight.w400,
                                                    height: 0,
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                left: 0,
                                                top: 3,
                                                child: Container(
                                                  width: 16,
                                                  height: 16,
                                                  clipBehavior: Clip.antiAlias,
                                                  decoration:
                                                      const BoxDecoration(),
                                                  child: const Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      const Positioned(
                                        left: 135,
                                        top: 0,
                                        child: SizedBox(
                                          width: 99,
                                          height: 21,
                                          child: Stack(
                                            children: [
                                              Positioned(
                                                left: 27,
                                                top: 0,
                                                child: Text(
                                                  '36k Saved',
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 14,
                                                    fontFamily: 'Poppins',
                                                    fontWeight: FontWeight.w400,
                                                    height: 0,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const Positioned(
                                left: 0,
                                top: 0,
                                child: SizedBox(
                                  width: 252,
                                  child: Text(
                                    'Naiki White Pro Sneakers',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 24,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w500,
                                      height: 0.06,
                                      letterSpacing: -0.24,
                                    ),
                                  ),
                                ),
                              ),
                              const Positioned(
                                left: 0,
                                top: 152,
                                child: SizedBox(
                                  width: 319,
                                  child: Text(
                                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et',
                                    style: TextStyle(
                                      color: Color(0xFF4D4D4D),
                                      fontSize: 14,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w400,
                                      height: 0.10,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
