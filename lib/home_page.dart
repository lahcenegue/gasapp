import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:url_launcher/url_launcher.dart';
import 'constants/constants.dart';
import 'gaz_request.dart';
import 'model/home_viewmodel.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  HomeViewModel hvm = HomeViewModel();
  @override
  void initState() {
    hvm.fetchAds();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    hvm.addListener(() {
      setState(() {});
    });
    return Scaffold(
      body: SafeArea(
        child: hvm.listAds == null
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                width: MediaQuery.of(context).size.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      'assets/images/logo.svg',
                      height: MediaQuery.of(context).size.width * 0.55,
                    ),
                    const SizedBox(height: 40),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: kMainColor,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 30, vertical: 8),
                          textStyle: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w600,
                          )),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const GazRequest(),
                          ),
                        );
                      },
                      child: const Text(
                        'إضغط هنا لطلب الغاز',
                      ),
                    ),
                    const SizedBox(height: 80),
                    GestureDetector(
                      onTap: _launchURL,
                      child: Image.network(hvm.listAds![0].adsImage),
                    ),
                  ],
                ),
              ),
      ),
    );
  }

  _launchURL() async {
    String url = hvm.listAds![0].link;
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      debugPrint('Could not launch $url');
    }
  }
}
