import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/style.dart';

class DetailPaslon extends StatefulWidget {
  static const routeName = '/detail';
  const DetailPaslon({Key? key}) : super(key: key);

  @override
  State<DetailPaslon> createState() => _DetailPaslonState();
}

class _DetailPaslonState extends State<DetailPaslon> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: primaryColor,
          ),
        ),
        title: Text(
          "Detail Paslon",
          style: TextStyle(
            fontSize: 16.sp,
            color: const Color(0xFF393E46),
            fontFamily: bold,
          ),
        ),
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarBrightness: Brightness.dark,
          statusBarIconBrightness: Brightness.dark,
          statusBarColor: Colors.transparent,
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  color: cardColor,
                  width: 131.w,
                  height: 173.h,
                ),
                Container(
                  color: cardColor,
                  width: 131.w,
                  height: 173.h,
                ),
              ],
            ),
            SizedBox(
              height: 10.h,
            ),
            Text(
              'Chandra Ardiansyah',
              style: TextStyle(
                fontFamily: bold,
                fontSize: 16.sp,
                color: primaryColor,
              ),
            ),
            Text(
              'M.Rizky Firdaus',
              style: TextStyle(
                fontFamily: bold,
                fontSize: 16.sp,
                color: primaryColor,
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            Text(
              'Paslon Ini Memiliki Visi :',
              style: TextStyle(
                fontFamily: medium,
                fontSize: 14.sp,
                color: primaryColor,
              ),
            ),
            Text(
              '"Membangun Sekolah yang Berkualitas, Inspiratif, dan Harmonis Melalui Partisipasi Aktif Siswa."',
              style: TextStyle(
                fontFamily: medium,
                fontSize: 14.sp,
                color: primaryColor,
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            Text(
              'Paslon Ini Memiliki Misi :',
              style: TextStyle(
                fontFamily: medium,
                fontSize: 14.sp,
                color: primaryColor,
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Text("${index + 1}."),
                    title: const Text('Membangun'),
                    minLeadingWidth: 10,
                  );
                },
                itemCount: 3,
              ),
            )
          ],
        ),
      ),
    );
  }
}
