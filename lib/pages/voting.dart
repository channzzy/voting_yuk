import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:voting_yuk/pages/dashboard.dart';
import 'package:voting_yuk/providers/vote.dart';

import '../providers/candidates.dart';
import '../utils/style.dart';

class VotingPage extends StatefulWidget {
  const VotingPage({Key? key}) : super(key: key);

  @override
  State<VotingPage> createState() => _VotingPageState();
}

class _VotingPageState extends State<VotingPage> {
  late int candidateId;
  final TextEditingController _nisController = TextEditingController();

  @override
  void initState() {
    Future.microtask(
      () => context.read<CandidatesProvider>().fetchData(),
    );
    super.initState();
  }

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
                child: Consumer<CandidatesProvider>(
                  builder: (context, provider, _) {
                    if (provider.candidateResult == CandidatesResult.loading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (provider.candidateResult ==
                            CandidatesResult.noData ||
                        provider.candidateResult == CandidatesResult.error) {
                      return DropdownSearch<Map<String, dynamic>>(
                        popupProps: PopupProps.menu(
                          constraints: BoxConstraints(maxHeight: 180.h),
                        ),
                        items: const [],
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
                      );
                    } else if (provider.candidateResult ==
                        CandidatesResult.hasData) {
                      return DropdownSearch<Map<String, dynamic>>(
                        popupProps: PopupProps.menu(
                          constraints: BoxConstraints(maxHeight: 180.h),
                        ),
                        items: provider.candidateList,
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
                        onChanged: (selectedItem) {
                          candidateId = selectedItem?['id'];
                        },
                        dropdownBuilder: (context, item) {
                          if (item != null) {
                            String chairman = item['chairman'] ?? '';
                            String deputyChairman =
                                item['deputy_chairman'] ?? '';
                            if (chairman.isNotEmpty &&
                                deputyChairman.isNotEmpty) {
                              return Text("$chairman & $deputyChairman");
                            } else if (chairman.isNotEmpty) {
                              return Text(chairman);
                            } else if (deputyChairman.isNotEmpty) {
                              return Text(deputyChairman);
                            }
                          }
                          return const Text('');
                        },
                        itemAsString: (item) =>
                            item['chairman'] + " & " + item['deputy_chairman'],
                        validator: (value) {
                          if (value == null) {
                            return "Tidak Boleh Kosong !";
                          }
                          return null;
                        },
                      );
                    } else {
                      return const Text('');
                    }
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
                controller: _nisController,
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
              Consumer<VoteProvider>(
                builder: (context, send, _) {
                  if (send.voteResult == VoteResult.loading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    return ElevatedButton(
                      onPressed: () async {
                        if (formKey.currentState!.validate()) {
                          await send.sendVote(_nisController.text, candidateId);
                          if (send.voteResult == VoteResult.error) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                backgroundColor: Colors.red,
                                content: Text(
                                  'Gagal karena ${send.errorMessage}',
                                  style: const TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                                duration: const Duration(seconds: 5),
                              ),
                            );
                          } else if (send.voteResult == VoteResult.success) {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return Dashboard();
                                },
                              ),
                            );
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                backgroundColor: accentColor,
                                content: Text(
                                  'Voting Berhasil Dikirim',
                                  style: const TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                                duration: const Duration(seconds: 5),
                              ),
                            );
                          }
                        }
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
                        'Kirim Voting',
                      ),
                    );
                  }
                },
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
