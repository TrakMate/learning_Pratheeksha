// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:landpage/src/ui/dashboard.dart';
// // import 'src/ui/dashboard.dart' show kAccentGradient;

// class ApplyButton extends StatelessWidget {
//   final bool isApplied;
//   final VoidCallback onPressed;

//   const ApplyButton({
//     super.key,
//     required this.isApplied,
//     required this.onPressed,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: 42,
//       child: Container(
//         padding: const EdgeInsets.all(1.5),
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(13),
//           gradient:
//               isApplied ? null : LinearGradient(colors: kAccentGradient),
//           color: isApplied ? Colors.white.withOpacity(0.1) : null,
//         ),
//         child: ElevatedButton(
//           onPressed: isApplied ? null : onPressed,
//           style: ElevatedButton.styleFrom(
//             elevation: 0,
//             disabledBackgroundColor: Colors.transparent,
//             backgroundColor: Colors.white.withOpacity(0.15),
//             foregroundColor: Colors.white,
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(11.5),
//             ),
//           ),
//           child: Text(
//             isApplied ? "Applied ✓" : "Apply",
//             style: GoogleFonts.poppins(
//               fontSize: 13,
//               fontWeight: FontWeight.w500,
//               color: isApplied
//                   ? Colors.white.withOpacity(0.6)
//                   : Colors.white,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }