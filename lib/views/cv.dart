import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:getx/themes/colors.dart';
import 'package:getx/themes/fonts.dart';
import 'package:screenshot/screenshot.dart';

class CV extends StatefulWidget {
  const CV({Key? key}) : super(key: key);

  @override
  State<CV> createState() => _CVState();
}

class _CVState extends State<CV> {
  ScreenshotController screenshotController = ScreenshotController();
  // List<String> tools = [
  //   "VS Code",
  //   "Trello",
  //   "Mongo Compas",
  //   "PHP",
  //   "PHP/CI3",
  //   "Go",
  //   "Go/Gin-Gonic",
  //   "Postman",
  //   "JS",
  //   "JS/jQuery",
  //   "JS/AJAX",
  //   "JS/ReactJs",
  //   "XCode",
  //   "MacOS",
  //   "Linux",
  //   "Windows",
  //   "MySQL",
  //   "PostgreSQL",
  //   "MongoDB",
  //   "Dart",
  //   "Flutter",
  //   "Firebase",
  //   "Agora",
  // ];
  // Widget point(String text) {
  //   return Row(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       const Padding(
  //         padding: EdgeInsets.fromLTRB(0, 3, 3, 3),
  //         child: Icon(Icons.circle, size: 3),
  //       ),
  //       Expanded(
  //         child: Text(
  //           text,
  //           style: microRegular,
  //         ),
  //       )
  //     ],
  //   );
  // }
  // Widget portfolio(String text) {
  //   return Container(
  //     decoration: BoxDecoration(
  //       borderRadius: BorderRadius.circular(2),
  //       border: Border.all(width: .5, color: primaryWater),
  //     ),
  //     child: Padding(
  //       padding: const EdgeInsets.all(1),
  //       child: Text(
  //         text,
  //         style: microRegular.copyWith(
  //           color: primaryWater,
  //           fontSize: 4,
  //         ),
  //       ),
  //     ),
  //   );
  // }
  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     backgroundColor: Colors.white,
  //     body: SafeArea(
  //       child: Padding(
  //         padding: const EdgeInsets.all(16),
  //         child: Column(
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: [
  //             const SizedBox(height: 110),
  //             Row(
  //               children: [
  //                 const CircleAvatar(
  //                   backgroundImage: AssetImage("assets/png/alfan.png"),
  //                   radius: 25,
  //                 ),
  //                 const SizedBox(width: 5),
  //                 Column(
  //                   crossAxisAlignment: CrossAxisAlignment.start,
  //                   mainAxisAlignment: MainAxisAlignment.center,
  //                   children: [
  //                     Text(
  //                       'Muazharin Alfan',
  //                       style: subtitleSemiBold.copyWith(color: primaryWater),
  //                     ),
  //                     Text(
  //                       'Software Engineer',
  //                       style: microRegular.copyWith(),
  //                     ),
  //                     Text(
  //                       'East Jakarta, Jakarta, Indonesia',
  //                       style: microRegular.copyWith(),
  //                     ),
  //                   ],
  //                 ),
  //                 const Spacer(),
  //                 Column(
  //                   crossAxisAlignment: CrossAxisAlignment.end,
  //                   mainAxisAlignment: MainAxisAlignment.center,
  //                   children: [
  //                     Row(
  //                       crossAxisAlignment: CrossAxisAlignment.start,
  //                       mainAxisSize: MainAxisSize.min,
  //                       children: [
  //                         Text("+62 822 4330 9590", style: microRegular),
  //                         const SizedBox(width: 4),
  //                         SvgPicture.asset(
  //                           "assets/svg/icon_phone.svg",
  //                           width: 6,
  //                           height: 6,
  //                         ),
  //                       ],
  //                     ),
  //                     Row(
  //                       crossAxisAlignment: CrossAxisAlignment.start,
  //                       mainAxisSize: MainAxisSize.min,
  //                       children: [
  //                         Text("alfanmuazharin@gmail.com", style: microRegular),
  //                         const SizedBox(width: 4),
  //                         SvgPicture.asset(
  //                           "assets/svg/icon_email.svg",
  //                           width: 6,
  //                           height: 6,
  //                         ),
  //                       ],
  //                     ),
  //                     Row(
  //                       crossAxisAlignment: CrossAxisAlignment.start,
  //                       mainAxisSize: MainAxisSize.min,
  //                       children: [
  //                         Text("Muazharin Alfan", style: microRegular),
  //                         const SizedBox(width: 4),
  //                         SvgPicture.asset(
  //                           "assets/svg/icon_linkedin.svg",
  //                           width: 6,
  //                           height: 6,
  //                         ),
  //                       ],
  //                     ),
  //                     Row(
  //                       crossAxisAlignment: CrossAxisAlignment.start,
  //                       mainAxisSize: MainAxisSize.min,
  //                       children: [
  //                         Text("muazharin", style: microRegular),
  //                         const SizedBox(width: 4),
  //                         SvgPicture.asset(
  //                           "assets/svg/icon_github.svg",
  //                           width: 6,
  //                           height: 6,
  //                         ),
  //                       ],
  //                     ),
  //                   ],
  //                 ),
  //               ],
  //             ),
  //             const Divider(color: primaryWater),
  //             Row(
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               children: [
  //                 Expanded(
  //                   flex: 1,
  //                   child: Column(
  //                     crossAxisAlignment: CrossAxisAlignment.start,
  //                     children: [
  //                       Text(
  //                         "Profile",
  //                         style: microSemiBold.copyWith(
  //                           color: primaryWater.withOpacity(.5),
  //                         ),
  //                       ),
  //                       Text(
  //                         "I enjoy developing myself. Often learns new things independently and shares information with others. Easy to make friends with anyone and active in several communities.",
  //                         style: microRegular,
  //                       ),
  //                       const SizedBox(height: 4),
  //                       Text(
  //                         "Education",
  //                         style: microSemiBold.copyWith(
  //                           color: primaryWater.withOpacity(.5),
  //                         ),
  //                       ),
  //                       Text(
  //                         "Bachelor's Degree in Informatics Engineering,\nHalu Oleo University, Kendari, Southeast Sulawesi\nThe Best Graduate of Engineering Faculty (July - October 2019)\nAugust 2015 - October 2019\nGPA . 3.57",
  //                         style: microRegular,
  //                       ),
  //                       const SizedBox(height: 4),
  //                       Text(
  //                         "Experience",
  //                         style: microSemiBold.copyWith(
  //                           color: primaryWater.withOpacity(.5),
  //                         ),
  //                       ),
  //                       Text(
  //                         "Software Engineering - PT. Bestari Aditama Persada",
  //                         style: microSemiBold.copyWith(
  //                           color: primaryWater,
  //                         ),
  //                       ),
  //                       Text(
  //                         "January 2021 - Present",
  //                         style: microRegular,
  //                       ),
  //                       const SizedBox(height: 2),
  //                       Text(
  //                         "Write program code for each assigned project according to the business flow and design that has been defined. Build the application to the server and publish them to playstore and appstore.",
  //                         style: microRegular,
  //                       ),
  //                       const SizedBox(height: 2),
  //                       Text(
  //                         "Some of the projects I've worked on :",
  //                         style: microRegular,
  //                       ),
  //                       point(
  //                           "Digital cooperative (e-commerce, cooperative activities, PPOB, QRIS, OTP, etc) uses NodeJs, ExpressJs, Flutter, Laravel - as Mobile Developer"),
  //                       point(
  //                           "Employee Attendance uses Gin Gonic (Go), Flutter, ReactJs - as Backend Developer"),
  //                       point(
  //                           "Quotation App uses Codeigniter 3 (PHP), jQuery, AJAX - as Fullstack Developer"),
  //                       point(
  //                           "Company Profile uses ReactJs - as Frontend Developer"),
  //                       point(
  //                           "Health App for Immigrants uses Flutter, NodeJs, ReactJs, Socket IO, Agora - as Mobile Developer"),
  //                       point("Etc"),
  //                       const SizedBox(height: 4),
  //                       Text(
  //                         "Fullstack Developer - PT. Mulia Sawit Agro Lestari",
  //                         style: microSemiBold.copyWith(
  //                           color: primaryWater,
  //                         ),
  //                       ),
  //                       Text(
  //                         "May 2020 - January 2021",
  //                         style: microRegular,
  //                       ),
  //                       const SizedBox(height: 2),
  //                       Text(
  //                         "Create applications for internal companies. Maintain and update existing application features",
  //                         style: microRegular,
  //                       ),
  //                       const SizedBox(height: 2),
  //                       Text(
  //                         "Some of the projects I've worked on :",
  //                         style: microRegular,
  //                       ),
  //                       point(
  //                           "Digital Logistics uses Codeigniter 3 (PHP), jQuery, AJAX"),
  //                       point(
  //                           "Employee Attendance for WFH uses Codeigniter 3 (PHP), jQuery, AJAX, Google Maps API"),
  //                       point("Etc"),
  //                       const SizedBox(height: 4),
  //                       Text(
  //                         "Founder/Fullstack Developer - CV. CodeXV",
  //                         style: microSemiBold.copyWith(
  //                           color: primaryWater,
  //                         ),
  //                       ),
  //                       Text(
  //                         "October 2018 - November 2019",
  //                         style: microRegular,
  //                       ),
  //                       const SizedBox(height: 2),
  //                       Text(
  //                         "This is company we created with friends. Finding and working on projects as a team.",
  //                         style: microRegular,
  //                       ),
  //                       const SizedBox(height: 2),
  //                       Text(
  //                         "Some of the projects I've worked on :",
  //                         style: microRegular,
  //                       ),
  //                       point(
  //                           "Digital Attendance of Seminar Participants uses Java Android, Codeigniter 3 (PHP)"),
  //                       point(
  //                           "Periodic Sallary Increase uses Codeigniter 3 (PHP)"),
  //                       point("Etc"),
  //                     ],
  //                   ),
  //                 ),
  //                 const SizedBox(width: 4),
  //                 Expanded(
  //                   flex: 1,
  //                   child: Column(
  //                     crossAxisAlignment: CrossAxisAlignment.start,
  //                     children: [
  //                       Text(
  //                         "Portfolio",
  //                         style: microSemiBold.copyWith(
  //                           color: primaryWater.withOpacity(.5),
  //                         ),
  //                       ),
  //                       const SizedBox(height: 1),
  //                       portfolio("github.com/muazharin/our_wallet_mobile"),
  //                       const SizedBox(height: 1),
  //                       portfolio("github.com/muazharin/our_wallet_mobile_go"),
  //                       const SizedBox(height: 1),
  //                       portfolio(
  //                           "play.google.com/store/apps/details?id=com.nasaridigital.nadiconvensional"),
  //                       const SizedBox(height: 1),
  //                       portfolio(
  //                           "itunes.apple.com/id/app/nadi-nasari-digital/id1585106169?l=id"),
  //                       const SizedBox(height: 1),
  //                       portfolio(
  //                           "play.google.com/store/apps/details?id=com.first.zidtime"),
  //                       const SizedBox(height: 1),
  //                       portfolio(
  //                           "play.google.com/store/apps/details?id=com.bestada.doctor_migrant_user"),
  //                       const SizedBox(height: 1),
  //                       portfolio(
  //                           "play.google.com/store/apps/details?id=com.bestada.doctormigrant_doctors"),
  //                       const SizedBox(height: 4),
  //                       Text(
  //                         "Courses",
  //                         style: microSemiBold.copyWith(
  //                           color: primaryWater.withOpacity(.5),
  //                         ),
  //                       ),
  //                       Text(
  //                         "Udemy",
  //                         style: microSemiBold.copyWith(color: primaryWater),
  //                       ),
  //                       Text(
  //                         "Pemrograman Golang : Pemula sampai Mahir",
  //                         style: microRegular.copyWith(
  //                           fontStyle: FontStyle.italic,
  //                         ),
  //                       ),
  //                       Text(
  //                         "Build With Angga",
  //                         style: microSemiBold.copyWith(color: primaryWater),
  //                       ),
  //                       Text(
  //                         "Fullstack Laravel Flutter 2021: Building E-commerse And Chat Apps",
  //                         style: microRegular.copyWith(
  //                           fontStyle: FontStyle.italic,
  //                         ),
  //                       ),
  //                       const SizedBox(height: 4),
  //                       Text(
  //                         "Specialities",
  //                         style: microSemiBold.copyWith(
  //                           color: primaryWater.withOpacity(.5),
  //                         ),
  //                       ),
  //                       Text("Backend Development", style: microRegular),
  //                       Text("Mobile Development", style: microRegular),
  //                       Text("Problem Solving", style: microRegular),
  //                       const SizedBox(height: 4),
  //                       Text(
  //                         "Tools and Technologies",
  //                         style: microSemiBold.copyWith(
  //                           color: primaryWater.withOpacity(.5),
  //                         ),
  //                       ),
  //                       const SizedBox(height: 2),
  //                       Wrap(
  //                         children: tools.map<Widget>((e) {
  //                           return Padding(
  //                             padding: const EdgeInsets.fromLTRB(0, 0, 1, 1),
  //                             child: portfolio(e),
  //                           );
  //                         }).toList(),
  //                       ),
  //                       const SizedBox(height: 4),
  //                       Text(
  //                         "Others",
  //                         style: microSemiBold.copyWith(
  //                           color: primaryWater.withOpacity(.5),
  //                         ),
  //                       ),
  //                       Text("Public Speaking", style: microRegular),
  //                       Text("Teaching", style: microRegular),
  //                     ],
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }

  Widget point({String? no, String? title, String? subtitle, String? type}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height: 25,
          width: 25,
          decoration: BoxDecoration(
            color: const Color(0xffcccdcf),
            borderRadius: BorderRadius.circular(25),
            border: Border.all(color: Colors.white, width: 2),
          ),
          child: Center(
            child: CircleAvatar(
              child: type == "no"
                  ? const Icon(
                      Icons.pin_drop_outlined,
                      size: 10,
                      color: grayscaleCharcoal,
                    )
                  : SvgPicture.asset(
                      no!,
                      width: 9,
                      height: 9,
                    ),
              backgroundColor: Colors.white,
              radius: 7.5,
            ),
          ),
        ),
        const SizedBox(width: 4),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              title != null
                  ? Text(
                      title,
                      style: smallSemiBold.copyWith(
                        color: Colors.white,
                        // fontSize: 8,
                      ),
                    )
                  : const SizedBox(),
              Text(
                subtitle ?? "Pasar Rebo, Jakarta Timur, DKI Jakarta",
                style: smallRegular.copyWith(fontSize: 8),
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget photo(Size s) {
    return Stack(
      children: [
        Image.asset(
          "assets/png/alfan.png",
          height: 218,
          fit: BoxFit.cover,
        ),
        Padding(
          padding: const EdgeInsets.only(
            top: 202,
            left: 6,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              point(
                no: "01",
                title: "ADDRESS TO",
                type: "no",
                subtitle: "Pasar Rebo, East Jakarta, DKI Jakarta",
              ),
              point(
                no: "assets/svg/icon_phone.svg",
                type: "svg",
                subtitle: "+62 822 4330 9590",
              ),
              const SizedBox(height: 2),
              point(
                no: "assets/svg/icon_email.svg",
                type: "svg",
                subtitle: "alfanmuazharin@ gmail.com",
              ),
              const SizedBox(height: 2),
              point(
                no: "assets/svg/icon_linkedin.svg",
                type: "svg",
                subtitle: "Muazharin Alfan",
              ),
              const SizedBox(height: 2),
              point(
                no: "assets/svg/icon_github.svg",
                type: "svg",
                subtitle: "muazharin",
              ),
              const SizedBox(height: 8),
              Text("SKILLS", style: smallSemiBold),
              const SizedBox(height: 8),
              RichText(
                text: TextSpan(
                  style: smallRegular.copyWith(fontSize: 8),
                  children: [
                    TextSpan(
                      text: "Software: ",
                      style: smallSemiBold.copyWith(fontSize: 8),
                    ),
                    const TextSpan(
                        text: "VS Code, Trello, Mongo Compas, Postman, XCode"),
                  ],
                ),
              ),
              RichText(
                text: TextSpan(
                  style: smallRegular.copyWith(fontSize: 8),
                  children: [
                    TextSpan(
                      text: "Programming Languages: ",
                      style: smallSemiBold.copyWith(fontSize: 8),
                    ),
                    const TextSpan(text: "PHP, JS, Go, Dart-Flutter"),
                  ],
                ),
              ),
              RichText(
                text: TextSpan(
                  style: smallRegular.copyWith(fontSize: 8),
                  children: [
                    TextSpan(
                      text: "Speaking: ",
                      style: smallSemiBold.copyWith(fontSize: 8),
                    ),
                    const TextSpan(text: "Public Speaking, Teaching"),
                  ],
                ),
              ),
              RichText(
                text: TextSpan(
                  style: smallRegular.copyWith(fontSize: 8),
                  children: [
                    TextSpan(
                      text: "Languages: ",
                      style: smallSemiBold.copyWith(fontSize: 8),
                    ),
                    const TextSpan(
                      text: "Indonesian (Active), English (Passive)",
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget workExperience({String? desc, String? address}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.circle_outlined,
            color: Color(0xffddb222),
            size: 14,
          ),
          const SizedBox(width: 4),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  desc ?? "",
                  style: smallRegular.copyWith(fontSize: 8),
                ),
                Text(
                  address ?? "",
                  style: smallRegular.copyWith(
                    fontSize: 8,
                    color: grayscaleCharcoalLightest,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size s = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Colors.white,
          child: Stack(
            children: [
              Column(
                children: [
                  const SizedBox(height: 110),
                  Expanded(
                    flex: 1,
                    child: Container(
                      color: const Color(0xff292734),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Container(
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 110, 16, 0),
                child: Row(
                  children: [
                    // Left
                    Expanded(
                      flex: 3,
                      child: Stack(
                        children: [
                          Column(
                            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  const Spacer(),
                                  Container(
                                    color: const Color(0xffddb222),
                                    height: 117,
                                    width: 58,
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 16, 16, 0),
                            child: photo(s),
                          ),
                        ],
                      ),
                    ),
                    // Right
                    Expanded(
                      flex: 4,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(16, 16, 0, 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "ABOUT ME",
                              style:
                                  smallSemiBold.copyWith(color: Colors.white),
                            ),
                            Text(
                              "I enjoy developing myself. Often learns new things independently and shares information with others. Easy to make friends with anyone and active in several communities.",
                              style: smallRegular.copyWith(
                                fontSize: 8,
                                color: Colors.white,
                              ),
                              textAlign: TextAlign.justify,
                            ),
                            const SizedBox(height: 120),
                            Text(
                              "WORK EXPERIENCES",
                              style: smallSemiBold,
                            ),
                            const SizedBox(height: 8),
                            workExperience(
                              desc: "Software Engineer",
                              address:
                                  "PT. Bestari Aditama Persada\n( January 2021 - Present )",
                            ),
                            workExperience(
                              desc: "Fullstack Developer",
                              address:
                                  "PT. Mulia Sawit Agro Lestari\n( May 2020 - January 2021 )",
                            ),
                            workExperience(
                              desc: "Founder/Fullstack Developer",
                              address:
                                  "CV. CodeXV\n( October 2018 - November 2019 )",
                            ),
                            const SizedBox(height: 8),
                            Text(
                              "EDUCATION",
                              style: smallSemiBold,
                            ),
                            const SizedBox(height: 8),
                            RichText(
                              text: TextSpan(
                                style: smallRegular.copyWith(fontSize: 8),
                                children: [
                                  const TextSpan(
                                    text:
                                        "Bachelor's Degree of Informatics Engineering in ",
                                  ),
                                  TextSpan(
                                    text:
                                        "Halu Oleo University, \nKendari, Southeast Sulawesi\n",
                                    style: smallSemiBold.copyWith(
                                      fontSize: 8,
                                      // color: const Color(0xffddb222),
                                    ),
                                  ),
                                  TextSpan(
                                    text:
                                        "The Best Graduate of Engineering Faculty ( July - October 2019 )\nAugust 2015 - October 2019\nGPA . 3.57",
                                    style: smallRegular.copyWith(
                                        fontSize: 8,
                                        color: grayscaleCharcoalLightest),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(
                  108,
                  248,
                  0,
                  0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "MUAZHARIN",
                      style: smallSemiBold.copyWith(
                        color: const Color(0xffddb222),
                      ),
                    ),
                    RichText(
                      text: TextSpan(
                        style: titleBold.copyWith(
                          color: const Color(0xffddb222),
                        ),
                        children: [
                          const TextSpan(text: "ALFAN"),
                          TextSpan(
                            text: "\t\t\tSoftware Engineer",
                            style: smallRegular,
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
