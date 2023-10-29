import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:voting_yuk/providers/deail_candidate.dart';

import '../utils/style.dart';

class DetailPaslon extends StatefulWidget {
  static const routeName = '/detail';
  final int id;
  const DetailPaslon({Key? key, required this.id}) : super(key: key);

  @override
  State<DetailPaslon> createState() => _DetailPaslonState();
}

class _DetailPaslonState extends State<DetailPaslon> {
  @override
  void initState() {
    Future.microtask(
      () => context.read<DetailCandidateProvider>().fetchData(widget.id),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(widget.id);
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
            color: fontColor,
          ),
        ),
        title: Text(
          "Detail Paslon",
          style: TextStyle(
            fontSize: 16.sp,
            color: fontColor,
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
        child: Consumer<DetailCandidateProvider>(
          builder: (context, detail, _) {
            if (detail.detailCandidateResult == DetailCandidateResult.loading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (detail.detailCandidateResult ==
                DetailCandidateResult.error) {
              return Center(
                child: Text(detail.errorMessage),
              );
            } else if (detail.detailCandidateResult ==
                DetailCandidateResult.success) {
              return Column(
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
                        child: Image.network(
                          detail.detailCandidate.data.photoChairman,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Container(
                        color: cardColor,
                        width: 131.w,
                        height: 173.h,
                        child: Image.network(
                          detail.detailCandidate.data.photoDeputyChairman,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Text(
                    detail.detailCandidate.data.chairman,
                    style: TextStyle(
                      fontFamily: bold,
                      fontSize: 16.sp,
                      color: fontColor,
                    ),
                  ),
                  Text(
                    detail.detailCandidate.data.deputyChairman,
                    style: TextStyle(
                      fontFamily: bold,
                      fontSize: 16.sp,
                      color: fontColor,
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
                      color: fontColor,
                    ),
                  ),
                  SizedBox(
                    height: 150.h,
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        var visi = detail.detailCandidate.data.visions[index];
                        return ListTile(
                          leading: Text(visi.sequence.toString()),
                          title: Text(visi.description),
                          minLeadingWidth: 10,
                        );
                      },
                      itemCount: detail.detailCandidate.data.visions.length,
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
                      color: fontColor,
                    ),
                  ),
                  SizedBox(
                    height: 150.h,
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        var misi = detail.detailCandidate.data.missions[index];
                        return ListTile(
                          leading: Text(misi.sequence.toString()),
                          title: Text(misi.description),
                          minLeadingWidth: 10,
                        );
                      },
                      itemCount: detail.detailCandidate.data.missions.length,
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
