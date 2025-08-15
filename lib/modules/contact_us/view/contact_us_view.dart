import 'package:flutter/material.dart';
import 'package:tracking_system_app/style/app_var.dart';
import 'package:tracking_system_app/style/values_manager.dart';

class ContactView extends StatelessWidget {
  const ContactView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            IconButton(
              icon: Icon(
                Icons.arrow_back,
                size: AppSizeW.s24,
                color: const Color(0xFF0E1A13),
              ),
              onPressed: () => Navigator.pop(context),
            ),
            Center(
              child: Text(
                'Contact Us',
                style: TextStyle(
                  color: const Color(0xFF0E1A13),
                  fontSize: AppSizeSp.s18,
                  fontWeight: FontWeight.bold,
                  height: 1.0,
                  letterSpacing: -0.015,
                ),
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: AppSizeW.s16),
            child: Column(
              children: [
                SizedBox(height: AppSizeH.s20),
                Container(
                  margin: EdgeInsets.only(bottom: AppSizeH.s16),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE8F2EC),
                    borderRadius: BorderRadius.circular(AppSizeR.s12),
                  ),
                  child: TextField(
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.all(AppSizeW.s16),
                      hintText: 'Your Name',
                      hintStyle: TextStyle(
                        color: AppVar.primary,
                        fontSize: AppSizeSp.s16,
                      ),
                    ),
                  ),
                ),

                Container(
                  height: AppSizeH.s56,
                  margin: EdgeInsets.only(bottom: AppSizeH.s16),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE8F2EC),
                    borderRadius: BorderRadius.circular(AppSizeR.s12),
                  ),
                  child: TextField(
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.all(AppSizeW.s16),
                      hintText: 'Your Email',
                      hintStyle: TextStyle(
                        color: AppVar.primary,
                        fontSize: AppSizeSp.s16,
                      ),
                    ),
                  ),
                ),

                // Message field
                Container(
                  height: AppSizeH.s144,
                  margin: EdgeInsets.only(bottom: AppSizeH.s16),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE8F2EC),
                    borderRadius: BorderRadius.circular(AppSizeR.s12),
                  ),
                  child: TextField(
                    maxLines: null,
                    expands: true,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.all(AppSizeW.s16),
                      hintText: 'Your Message',
                      hintStyle: TextStyle(
                        color: AppVar.primary,
                        fontSize: AppSizeSp.s16,
                      ),
                    ),
                  ),
                ),

                SizedBox(
                  width: double.infinity,
                  height: AppSizeH.s40,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF38E07B),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(AppSizeR.s12),
                      ),
                    ),
                    onPressed: () {
                    },
                    child: Text(
                      'Submit',
                      style: TextStyle(
                        color: const Color(0xFF0E1A13),
                        fontSize: AppSizeSp.s14,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.015,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
