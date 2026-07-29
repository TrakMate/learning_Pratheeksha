// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:landpage/dashboard.dart
import 'package:landpage/src/forms/register.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Image.asset(
                'assets/images/logo.png',
                height: 30,
                width: 28,
                fit: BoxFit.contain,
              ),
              const SizedBox(width: 8),
              Text(
                "ARTISAN",
                style: GoogleFonts.syne(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                ),
              ),
            ],
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [

              NavTextItem(
                title: "Jobs",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const Placeholder(),
                    ),
                  );
                },
              ),

              NavTextItem(
                title: "Companies",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const Placeholder(),
                    ),
                  );
                },
              ),

              NavTextItem(
                title: "About Us",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const Placeholder(),
                    ),
                  );
                },
              ),

              const SizedBox(width: 350),

              Row(
                children: [

                  NavTextItem(
                    title: "Contact Us",
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const Placeholder(),
                        ),
                      );
                    },
                  ),

                  // NavTextItem(
                  //   title: "Login",
                  //   onTap: () {
                  //     Navigator.push(
                  //       context,
                  //       MaterialPageRoute(
                  //         builder: (_) => const Placeholder(),
                  //       ),
                  //     );
                  //   },
                  // ),

                  const SizedBox(width: 13),

                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const RegisterApp(),
                        ),
                      );


// final user = FirebaseAuth.instance.currentUser;

//   if (user != null) {
//     await user.reload(); // refresh session, in case it's stale
//   }

//   final freshUser = FirebaseAuth.instance.currentUser;

//   if (freshUser != null && freshUser.emailVerified) {
//     // Already logged in and verified -> go straight to Dashboard
//     Navigator.push(
//       context,
//       MaterialPageRoute(builder: (context) => const DashboardPage()),
//     );
//   } else {
//     // Not logged in -> show login/register screen
//     Navigator.push(
//       context,
//       MaterialPageRoute(builder: (context) => const RegisterApp()),
//     );
//   }





                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.white,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: const [
                          Text(
                            "Login ",
                            style: TextStyle(color: Colors.white),
                          ),
                          Icon(
                            Icons.arrow_forward,
                            size: 14,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(width: 12),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}




class NavTextItem extends StatefulWidget {
  final String title;
  final VoidCallback? onTap;

  const NavTextItem({
    super.key,
    required this.title,
    this.onTap,
  });

  @override
  State<NavTextItem> createState() => _NavTextItemState();
}

class _NavTextItemState extends State<NavTextItem> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: (_) => setState(() => isHovered = true),
        onExit: (_) => setState(() => isHovered = false),
        child: GestureDetector(
          onTap: widget.onTap,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                widget.title,
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 3),
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeOut,
                height: 1.5,
                width: isHovered ? 35 : 0,
                color: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}