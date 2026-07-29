import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // ---- Core accent gradient (same 3 stops used everywhere already) ----
  static const Color accentLight = Color(0xffC084FC);
  static const Color accentMid = Color(0xffA855F7);
  static const Color accentDark = Color(0xff6D28D9);

  static const List<Color> accentGradient = [
    accentLight,
    accentMid,
    accentDark,
  ];

  static const LinearGradient accentLinearGradient = LinearGradient(
    colors: accentGradient,
  );

  // ---- Glass surfaces ----
  static const Color glassFill = Color(0x14FFFFFF); // white @ ~0.08
  static const Color glassFillHover = Color(0x24FFFFFF); // white @ ~0.14
  static const Color glassBorder = Color(0x26FFFFFF); // white @ ~0.15
  static const Color glassBorderHover = Color(0x59FFFFFF); // white @ ~0.35

  // ---- Text ----
  static const Color textPrimary = Colors.white;
  static const Color textSecondary = Colors.white70;
  static const Color textMuted = Colors.white38;

  // ---- Status / misc ----
  static const Color destructive = Color(0xffFF8A8A);
  static const Color glowPurple = Color(0xffA855F7);

  // ---- Found in main.dart ----
  static const Color badgePurple = Colors.purple; // YC pill + HoverAvatar border
  static const Color fabGlow = Color.fromARGB(255, 163, 141, 167); // ScrollProgressFAB glow
  static const Color ringAccent = Colors.purpleAccent; // progress ring sweep gradient

  // ---- Found in main.dart (round 2) ----
  static const Color badgeBg = glassBorder; // white @ 0.15 — badge pill background (reused)
  static const Color subtitleText = Color(0xBFFFFFFF); // white @ 0.75 — hero subtitle & badge label
  static const Color sectionLabel = Color(0x99FFFFFF); // white @ 0.6 — "WORK WITH TOP TALENTS"
  static const Color buttonFg = Colors.black; // "See open roles" button text

  static const Color cardGradientStart = Color(0x1FFFFFFF); // white @ 0.12
  static const Color cardGradientEnd = Color(0x08FFFFFF); // white @ 0.03
  static const Color cardBorder = Color(0x1AFFFFFF); // white @ 0.1
  static const Color cardBorderHover = Color(0x4DFFFFFF); // white @ 0.3
  static const Color cardShadowHover = Color(0x40000000); // black @ 0.25
  static const Color cardShadowNormal = Color(0x0D000000); // black @ 0.05

  static const Color avatarShadow = Color(0x4D000000); // black @ 0.3

  static const Color fabCoreGradientStart = Color(0x38FFFFFF); // white @ 0.22
  static const Color fabCoreGradientEnd = Color(0x0FFFFFFF); // white @ 0.06
  // FAB core border reuses glassBorderHover (white @ 0.35)
  // Progress ring track reuses glassBorder (white @ 0.15)

// ---- Found in register.dart ----
  static const Color inputFill = Color(0x0DFFFFFF); // white @ 0.05 — text field fill
 

}