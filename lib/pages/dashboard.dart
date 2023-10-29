import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:voting_yuk/pages/detail.dart';
import 'package:voting_yuk/pages/information.dart';
import 'package:voting_yuk/pages/voting.dart';
import 'package:voting_yuk/providers/candidates.dart';
import 'package:voting_yuk/utils/style.dart';

class Dashboard extends StatefulWidget {
  static const routeName = "/dashboard";
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  void initState() {
    Future.microtask(
      () => context.read<CandidatesProvider>().fetchData(),
    );
    super.initState();
  }

  final int itemCount = 3;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        elevation: 0,
        leading: Container(
          padding: EdgeInsets.all(5.w),
          margin: EdgeInsets.only(top: 6.w, left: 10.w, bottom: 6.w),
          width: 49.w,
          height: 49.h,
          decoration: BoxDecoration(
            color: cardColor,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Image.asset(
            'assets/images/logo.png',
          ),
        ),
        title: Text(
          "E-VOTE",
          style: TextStyle(
            fontSize: 20.sp,
            color: const Color(0xFF393E46),
            fontFamily: bold,
          ),
        ),
        actions: [
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const Information(),
                ),
              );
            },
            child: CircleAvatar(
              backgroundColor: Colors.transparent,
              child: SvgPicture.string(svgInfo),
            ),
          ),
          InkWell(
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text(
                      'Konfirmasi Keluar',
                      style: TextStyle(
                        fontSize: 16.sp,
                      ),
                    ),
                    content: Text(
                      'Apakah Anda Yakin Ingin Keluar ?',
                      style: TextStyle(fontSize: 13.sp),
                    ),
                    actions: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            child: Text(
                              'Batal',
                              style: TextStyle(
                                fontSize: 13.sp,
                              ),
                            ),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                          TextButton(
                            child: Text(
                              'Keluar',
                              style: TextStyle(
                                fontSize: 13.sp,
                              ),
                            ),
                            onPressed: () {
                              SystemNavigator.pop();
                            },
                          ),
                        ],
                      )
                    ],
                  );
                },
              );
            },
            child: CircleAvatar(
              backgroundColor: Colors.transparent,
              child: SvgPicture.string(svgLogout),
            ),
          ),
          SizedBox(
            width: 10.w,
          )
        ],
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarBrightness: Brightness.dark,
          statusBarIconBrightness: Brightness.dark,
          statusBarColor: Colors.transparent,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(
          left: 15.w,
          right: 15.w,
          top: 20.w,
          bottom: 10.w,
        ),
        child: Consumer<CandidatesProvider>(
          builder: (context, provider, _) {
            if (provider.candidateResult == CandidatesResult.loading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (provider.candidateResult == CandidatesResult.noData) {
              return Center(
                child: Text(provider.errorMessage),
              );
            } else if (provider.candidateResult == CandidatesResult.error) {
              return Center(
                child: Text(provider.errorMessage),
              );
            } else if (provider.candidateResult == CandidatesResult.hasData) {
              return Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(20.w),
                    decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(15.w),
                    ),
                    width: double.infinity,
                    height: 112,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Gunakan hak pilih anda dengan bijak",
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontFamily: bold,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          "dan pertimbangkan calon dengan",
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontFamily: bold,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          "cermat",
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontFamily: bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Expanded(
                    child: ListView.separated(
                      itemBuilder: (context, index) {
                        var candidate = provider.candidate.data[index];
                        return Column(
                          children: [
                            Stack(
                              alignment: Alignment.bottomCenter,
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    vertical: 10.w,
                                    horizontal: 20.w,
                                  ),
                                  width: double.infinity,
                                  height: 283.h,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFEAEAEA),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        color: cardColor,
                                        width: 115.w,
                                        height: 137.h,
                                        child: Image.network(
                                          candidate.photoChairman,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      Container(
                                        color: cardColor,
                                        width: 115.w,
                                        height: 137.h,
                                        child: Image.network(
                                          candidate.photoDeputyChairman,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.all(15.w),
                                  width: double.infinity,
                                  height: 120.h,
                                  decoration: BoxDecoration(
                                    color: primaryColor,
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(0),
                                      topRight: Radius.circular(0),
                                      bottomLeft: Radius.circular(15),
                                      bottomRight: Radius.circular(15),
                                    ),
                                  ),
                                  child: Column(
                                    children: [
                                      Text(
                                        candidate.chairman,
                                        style: TextStyle(
                                          fontFamily: bold,
                                          fontSize: 16.sp,
                                          color: Colors.white,
                                        ),
                                      ),
                                      Text(
                                        candidate.deputyChairman,
                                        style: TextStyle(
                                          fontFamily: bold,
                                          fontSize: 16.sp,
                                          color: Colors.white,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10.h,
                                      ),
                                      ElevatedButton(
                                        onPressed: () {
                                          Navigator.pushNamed(
                                            context,
                                            DetailPaslon.routeName,
                                            arguments: candidate.id,
                                          );
                                        },
                                        style: ElevatedButton.styleFrom(
                                          textStyle: TextStyle(
                                            fontSize: 14.sp,
                                            color: Colors.white,
                                          ),
                                          fixedSize: Size(188.w, 32.h),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                        ),
                                        child: const Text(
                                          'Detail Paslon',
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            Visibility(
                              visible:
                                  index == provider.candidate.data.length - 1
                                      ? true
                                      : false,
                              child: ElevatedButton(
                                onPressed: () {
                                  provider.candidate.canVote == true
                                      ? Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const VotingPage(),
                                          ),
                                        )
                                      : showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: Text(
                                                'Jadwal Voting Belum Dimulai',
                                                style: TextStyle(
                                                  fontSize: 16.sp,
                                                ),
                                              ),
                                              content: Text(
                                                'Silahkan tunggu sesuai dengan jadwal yang disediakan !',
                                                style:
                                                    TextStyle(fontSize: 13.sp),
                                              ),
                                              actions: <Widget>[
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    TextButton(
                                                      child: Text(
                                                        'Ok',
                                                        style: TextStyle(
                                                          fontSize: 13.sp,
                                                        ),
                                                      ),
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                      },
                                                    ),
                                                  ],
                                                )
                                              ],
                                            );
                                          },
                                        );
                                },
                                style: ElevatedButton.styleFrom(
                                  textStyle: TextStyle(
                                    fontSize: 14.sp,
                                    color: Colors.white,
                                  ),
                                  fixedSize: Size(330.w, 40.h),
                                  backgroundColor:
                                      provider.candidate.canVote == true
                                          ? accentColor
                                          : accentColor.withOpacity(0.5),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                child: const Text(
                                  'Voting Sekarang',
                                ),
                              ),
                            )
                          ],
                        );
                      },
                      separatorBuilder: (context, index) {
                        return SizedBox(
                          height: 10.h,
                        );
                      },
                      itemCount: provider.candidate.data.length,
                    ),
                  ),
                ],
              );
            } else {
              return const Text('');
            }
          },
        ),
      ),
    );
  }
}
