import 'package:alisons_task/constents/api_const.dart';
import 'package:alisons_task/screens/view_model/home_provider.dart';
import 'package:alisons_task/widgets/refracted_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    final homePro = Provider.of<HomeProvider>(context, listen: false);
    homePro.getHomeData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Image.asset(
          'assets/images/Logo 2.png',
        ),
        actions: List.generate(
          3,
          (index) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: Image.asset(index == 0
                  ? 'assets/images/Vector.png'
                  : index == 1
                      ? 'assets/images/Group.png'
                      : 'assets/images/Vector (1).png'),
            );
          },
        ),
      ),
      body: Consumer<HomeProvider>(builder: (context, homePro, _) {
        return homePro.homeData != null
            ? SingleChildScrollView(
                child: Column(
                  children: [
                    Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        Image.network(ApiConst.bannerUrl +
                            homePro.homeData!.banner1!.first.image!),
                        Padding(
                          padding: const EdgeInsets.only(right: 10, bottom: 10),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 25),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.white),
                              borderRadius: BorderRadius.circular(
                                30.r,
                              ),
                            ),
                            child: const RefractedTextWidget(
                              text: 'Shop Now',
                              textSize: 12,
                              textColor: Colors.white,
                            ),
                          ),
                        )
                      ],
                    ),
                    const CustomHeaderWidget(),
                    SizedBox(
                      height: 150.h,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          final data = homePro.homeData?.bestSeller?[index];
                          return Padding(
                            padding: EdgeInsets.only(left: 10.w),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20.r),
                              child: Image.network(
                                ApiConst.productImageUrl + data!.image!,
                                width: 120.w,
                                fit: BoxFit.fill,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    const CustomHeaderWidget(
                      mainText: 'Suggested For You',
                    ),
                    SizedBox(
                      height: 230.h,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          final data = homePro.homeData?.bestSeller?[index];
                          return Padding(
                            padding: EdgeInsets.only(left: 10.w),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Stack(
                                  alignment: Alignment.topRight,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(20.r),
                                      child: Image.network(
                                        ApiConst.productImageUrl + data!.image!,
                                        width: 160.w,
                                        height: 170.h,
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: Image.asset(
                                          'assets/images/Group.png'),
                                    ),
                                  ],
                                ),
                                const Padding(
                                  padding: EdgeInsets.only(top: 10),
                                  child: RefractedTextWidget(
                                    text: 'Pennyblack Brown Black',
                                    isSubText: true,
                                    textSize: 10,
                                  ),
                                ),
                                const RefractedTextWidget(
                                  text: 'OMR 75.000',
                                  isSubText: true,
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              )
            : const Center(child: CircularProgressIndicator());
      }),
    );
  }
}

class CustomHeaderWidget extends StatelessWidget {
  const CustomHeaderWidget({
    super.key,
    this.mainText,
  });

  final String? mainText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          RefractedTextWidget(text: mainText ?? 'Our Brands'),
          const RefractedTextWidget(
            text: 'View All',
            textSize: 14,
            decoration: TextDecoration.underline,
            textColor: Color(0xff411E4A),
          )
        ],
      ),
    );
  }
}
