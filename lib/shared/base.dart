// import 'package:flutter/material.dart';
// import 'package:preggo/services/auth.dart';
// import 'package:preggo/shared/settingsform.dart';
// import 'menu.dart';
// import 'package:flutter/services.dart';

// class BaseScaffold extends StatelessWidget {
//   final Widget scaffoldBody;

//   BaseScaffold({required this.scaffoldBody});

//   @override
//   Widget build(BuildContext context) {
//     // void _showSettingsPanel() {
//     //   showModalBottomSheet(
//     //       context: context,
//     //       builder: (context) {
//     //         return Container(
//     //           padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
//     //           child: SettingsForm(),
//     //         );
//     //       });
//     // }

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Childing"),
//         actions: [
//           IconButton(
//               icon: const Icon(
//                 Icons.settings,
//               ),
//               onPressed: () => _showSettingsPanel()),
//           IconButton(
//             icon: const Icon(
//               Icons.logout,
//             ),
//             onPressed: () {
//               AuthService().signOut();
//             },
//           ),
//         ],
//       ),
//       drawer: MenuBase(),
//       body: scaffoldBody,
//     );
//   }
// }
