// import 'dart:async';
// import 'dart:ui';
// import 'package:flutter/material.dart';


// void showToast(
//   BuildContext context,
//   String message, {
//   Color color = const Color(0xffA855F7),
// }) {
//   final overlay = Overlay.of(context);

//   late OverlayEntry entry;

//   entry = OverlayEntry(
//     builder: (_) => Positioned(
//       top: 30,
//       right: 25,
//       child: Material(
//         color: Colors.transparent,
//         child: TweenAnimationBuilder<Offset>(
//           duration: const Duration(milliseconds: 300),
//           tween: Tween(
//             begin: const Offset(1.2, 0),
//             end: Offset.zero,
//           ),
//           builder: (context, offset, child) {
//             return Transform.translate(
//               offset: Offset(offset.dx * 250, 0),
//               child: child,
//             );
//           },
//           child: ClipRRect(
//             borderRadius: BorderRadius.circular(16),
//             child: BackdropFilter(
//               filter: ImageFilter.blur(
//                 sigmaX: 12,
//                 sigmaY: 12,
//               ),
//               child: Container(
//                 constraints: const BoxConstraints(maxWidth: 320),
//                 padding: const EdgeInsets.symmetric(
//                   horizontal: 18,
//                   vertical: 14,
//                 ),
//                 decoration: BoxDecoration(
//                   color: Colors.white.withOpacity(.12),
//                   borderRadius: BorderRadius.circular(16),
//                   border: Border.all(
//                     color: color,
//                     width: 1.2,
//                   ),
//                 ),
//                 child: Row(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     Icon(
//                       Icons.info_outline,
//                       color: color,
//                     ),
//                     const SizedBox(width: 12),
//                     Flexible(
//                       child: Text(
//                         message,
//                         style: const TextStyle(
//                           color: Colors.white,
//                           fontSize: 14,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     ),
//   );

//   overlay.insert(entry);

//   Timer(const Duration(seconds: 3), () {
//     entry.remove();
//   });
// }


import 'package:flutter/material.dart';

void showSnackBar(
  BuildContext context,
  String message, {
  Color color = const Color(0xffA855F7),
}) {
  ScaffoldMessenger.of(context).hideCurrentSnackBar();

  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      duration: const Duration(seconds: 1),
      backgroundColor: const Color(0xFF1F1F1F),
      content: Row(
        children: [
          Icon(
            Icons.info_outline,
            color: color,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              message,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}