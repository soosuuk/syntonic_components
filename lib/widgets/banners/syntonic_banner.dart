// import 'package:syntonic_components/widgets/sample_banner_view_model.dart';
// import 'package:syntonic_components/widgets/texts/body_1_text.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
//
// class BannerWidget extends StatelessWidget {
//   final SampleBannerViewModel model;
//   final String bannerText;
//   final String buttonText1;
//   final String buttonText2;
//
//   BannerWidget({
//     required this.model,
//     required this.bannerText,
//     required this.buttonText1,
//     required this.buttonText2
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         color: Colors.white,
//         boxShadow: [
//           BoxShadow(
//             offset: Offset(0, 10),
//             blurRadius: 5,
//             color: Colors.grey,
//           ),
//         ],
//       ),
//       child: Column(
//         children: <Widget>[
//           if(model.getShowBanner == true)
//             MaterialBanner(
//               padding: const EdgeInsets.all(20),
//               content: Body1Text(text: bannerText,),
//               actions: <Widget>[
//                 TextButton(
//                   child: Text(buttonText1),
//                   onPressed: () {
//                     model.hideBanner(false);
//                   },
//                 ),
//                 TextButton(
//                   child: Text(buttonText2),
//                   onPressed: () {
//                     model.hideBanner(false);
//                   },
//                 ),
//               ],
//             )
//         ],
//       ),
//     );
//   }
// }