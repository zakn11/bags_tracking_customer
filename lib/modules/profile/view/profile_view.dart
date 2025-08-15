import 'package:flutter/material.dart';
import 'package:tracking_system_app/modules/contact_us/view/contact_us_view.dart';
import 'package:tracking_system_app/modules/home/view/home_view.dart';
import 'package:tracking_system_app/style/app_var.dart';
import 'package:tracking_system_app/style/values_manager.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppVar.primary,
        title: Center(
          child: Text(
            'Profile',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: AppSizeSp.s18,
              fontWeight: FontWeight.bold,
              letterSpacing: 1,
              color: AppVar.seconndTextColor,
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          ClipPath(
            clipper: WaveClipper(),
            child: Container(
              height: AppSizeH.s35,
              color: AppVar.primary,
            ),
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: AppSizeH.s20),
                Padding(
                  padding: EdgeInsets.all(AppSizeW.s15),
                  child: Column(
                    children: [
                      Container(
                        width: AppSizeW.s128,
                        height: AppSizeW.s128,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: AssetImage('assets/images/user.png'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(height: AppSizeH.s16),
                      Text(
                        'Zakaria Al-Nabulsi',
                        style: TextStyle(
                          color: const Color(0xFF101914),
                          fontSize: AppSizeSp.s22,
                          fontWeight: FontWeight.bold,
                          height: 1.0,
                          letterSpacing: -0.015,
                        ),
                      ),
                      SizedBox(height: AppSizeH.s4),
                      Text(
                        'Customer',
                        style: TextStyle(
                          color: const Color(0xFF5A8C6E),
                          fontSize: AppSizeSp.s16,
                          fontWeight: FontWeight.normal,
                          height: 1.0,
                        ),
                      ),
                    ],
                  ),
                ),

                // Account section
                Padding(
                  padding: EdgeInsets.only(
                      left: AppSizeW.s15,
                      right: AppSizeW.s15,
                      top: AppSizeH.s15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Account',
                        style: TextStyle(
                          color: const Color(0xFF101914),
                          fontSize: AppSizeSp.s18,
                          fontWeight: FontWeight.bold,
                          height: 1.0,
                          letterSpacing: -0.015,
                        ),
                      ),
                      SizedBox(height: AppSizeH.s10),
                      _buildInfoItem(
                        icon: Icons.phone,
                        title: 'Phone',
                        value: '+963 969830277',
                      ),
                      _buildInfoItem(
                        icon: Icons.email,
                        title: 'Email',
                        value: 'zakariana2003@gmail.com',
                      ),
                      _buildInfoItem(
                        icon: Icons.location_on,
                        title: 'Address',
                        value: 'Damascus- mohajiren',
                      ),
                      _buildInfoItem(
                        icon: Icons.business,
                        title: 'Area',
                        value: 'Medan',
                      ),
                      _buildInfoItem(
                        icon: Icons.directions_car,
                        title: 'Driver',
                        value: 'Kinan Shagowi',
                      ),
                    ],
                  ),
                ),

                // Subscription section
                Padding(
                  padding: EdgeInsets.only(
                      left: AppSizeW.s16,
                      right: AppSizeW.s16,
                      top: AppSizeH.s16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Subscription',
                        style: TextStyle(
                          fontSize: AppSizeSp.s18,
                          fontWeight: FontWeight.bold,
                          height: AppSizeH.s1,
                          letterSpacing: -0.015,
                        ),
                      ),
                      _buildInfoItem(
                        icon: Icons.calendar_today,
                        title: 'Start Date',
                        value: '01/01/2023',
                      ),
                      _buildInfoItem(
                        icon: Icons.calendar_today,
                        title: 'Expiry Date',
                        value: '12/31/2023',
                      ),
                      _buildInfoItem(
                        icon: Icons.check_circle,
                        title: 'Status',
                        value: 'Active',
                      ),
                      // Contact Us button
                      Padding(
                        padding: EdgeInsets.all(AppSizeW.s16),
                        child: SizedBox(
                          width: double.infinity,
                          height: AppSizeH.s40,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF38E07B),
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(AppSizeR.s12),
                              ),
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const ContactView()),
                              );
                            },
                            child: Text(
                              'Contact Us',
                              style: TextStyle(
                                color: const Color(0xFF0E1A13),
                                fontSize: AppSizeSp.s14,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 0.015,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoItem({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Container(
      height: AppSizeH.s72,
      padding: EdgeInsets.symmetric(vertical: AppSizeH.s8),
      child: Row(
        children: [
          Container(
            width: AppSizeW.s48,
            height: AppSizeW.s48,
            decoration: BoxDecoration(
              color: const Color(0xFFE9F1EC),
              borderRadius: BorderRadius.circular(AppSizeR.s12),
            ),
            child: Icon(
              icon,
              size: AppSizeW.s24,
            ),
          ),
          SizedBox(width: AppSizeW.s16),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: AppSizeSp.s16,
                    fontWeight: FontWeight.w500,
                    height: 1.0,
                  ),
                ),
                SizedBox(height: AppSizeH.s4),
                Text(
                  value,
                  style: TextStyle(
                    color: const Color(0xFF5A8C6E),
                    fontSize: AppSizeSp.s12,
                    fontWeight: FontWeight.normal,
                    height: 1.0,
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
