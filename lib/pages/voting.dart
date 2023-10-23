import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/style.dart';

class VotingPage extends StatefulWidget {
  const VotingPage({Key? key}) : super(key: key);

  @override
  State<VotingPage> createState() => _VotingPageState();
}

class _VotingPageState extends State<VotingPage> {
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        toolbarHeight: 10.w,
        backgroundColor: backgroundColor,
        elevation: 0,
        automaticallyImplyLeading: false,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarBrightness: Brightness.dark,
          statusBarIconBrightness: Brightness.dark,
          statusBarColor: Colors.transparent,
        ),
      ),
      body: Form(
        key: formKey,
        child: Container(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Silahkan Pilih Ketua & Wakil Osis',
                style: TextStyle(
                  fontFamily: bold,
                  fontSize: 16.sp,
                  color: primaryColor,
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: DropdownSearch<Map<String, dynamic>>(
                  popupProps: PopupProps.menu(
                    constraints: BoxConstraints(maxHeight: 180.h),
                    // showSearchBox: true,
                  ),
                  items: [],
                  // selectedItem: selectedCompetency,
                  dropdownDecoratorProps: DropDownDecoratorProps(
                    dropdownSearchDecoration: InputDecoration(
                      fillColor: const Color(0xFFEAEAEA),
                      filled: true,
                      border: InputBorder.none,
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                          color: Colors.red,
                          width: 1,
                        ),
                      ),
                    ),
                  ),

                  validator: (value) {
                    if (value == null) {
                      return "Tidak Boleh Kosong !";
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(
                height: 15.h,
              ),
              Text(
                'Masukan NIS',
                style: TextStyle(
                  fontFamily: bold,
                  fontSize: 16.sp,
                  color: primaryColor,
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Tidak Boleh Kosong !';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.w),
                  filled: true,
                  fillColor: const Color(0xFFEAEAEA),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                      color: Colors.red,
                      width: 1,
                    ),
                  ),
                ),
                keyboardType: TextInputType.number,
              ),
              SizedBox(
                height: 10.h,
              ),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  textStyle: TextStyle(
                    fontSize: 14.sp,
                    color: Colors.white,
                  ),
                  fixedSize: Size(330.w, 40.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  'Kirim Voting',
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  textStyle: TextStyle(
                    fontSize: 14.sp,
                    color: Colors.white,
                  ),
                  fixedSize: Size(330.w, 40.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  'Batal',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
