import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../login/presentation/pages/login_page.dart';
import '../../../sign_up/presentation/pages/sign_up_page.dart';

class OnboardingPage extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => OnboardingPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          OnboardingItems(),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: OnboardingActionScreen(),
          ),
        ],
      ),
    );
  }
}

class OnboardingItems extends StatefulWidget {
  @override
  _OnboardingItemsState createState() => _OnboardingItemsState();
}

class _OnboardingItemsState extends State<OnboardingItems> {
  final _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(children: [
        Expanded(
          flex: 2,
          child: Padding(
            padding: const EdgeInsets.only(top: 24),
            child: Container(
                child: Image.asset(
              'assets/brand/logo_horizontal.jpg',
              fit: BoxFit.fill,
            )),
          ),
        ),
        Expanded(
          flex: 9,
          child: Theme(
            data: Theme.of(context).copyWith(splashColor: Colors.transparent),
            child: PageView(
              controller: _pageController,
              children: [
                const OnboardingItemTemplate(
                  asset: 'anywhere',
                  title: 'Anytime, Anywhere and on time',
                  description: 'We bring it to you, wherever you are.',
                ),
                const OnboardingItemTemplate(
                  asset: 'time_management',
                  title: 'Time-saver',
                  description: 'Save time, we do the job for you.',
                ),
                const OnboardingItemTemplate(
                  asset: 'driver',
                  title: 'Safe and sound package',
                  description:
                      'Your package is in good hands, we care for your needs.',
                )
              ],
            ),
          ),
        ),
        Expanded(
          child: SmoothPageIndicator(
            controller: _pageController,
            count: 3,
            effect: const WormEffect(
              activeDotColor: Color(0xffed1c24),
              dotHeight: 8,
              dotWidth: 8,
              spacing: 10,
            ), // your preferred effect
          ),
        ),
        Expanded(
          flex: 2,
          child: Container(),
        ),
      ]),
    );
  }
}

class OnboardingActionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    primary: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.of(context).push<void>(LoginPage.route());
                  },
                  child: const Text(
                    'Sign In',
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: MaterialButton(
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  color: const Color(0xffed1c24),
                  onPressed: () {
                    Navigator.of(context).push<void>(SignUpPage.route());
                  },
                  child: const Text(
                    'Get Started',
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                        fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
          Container(
            child: Text.rich(
              TextSpan(
                  text: 'By continuing, you agree to our ',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                  children: <TextSpan>[
                    TextSpan(
                        text: 'Terms of Service',
                        style: TextStyle(
                          color: Colors.black,
                          decoration: TextDecoration.underline,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () async =>
                              launch('https://jgexpress.com.ph/tos')),
                    TextSpan(
                        text: ' and ',
                        style: TextStyle(color: Colors.black),
                        children: <TextSpan>[
                          TextSpan(
                              text: 'Privacy Policy',
                              style: TextStyle(
                                  color: Colors.black,
                                  decoration: TextDecoration.underline),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () async =>
                                    launch('https://jgexpress.com.ph/policy'))
                        ])
                  ]),
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 12),
            ),
          )
        ],
      ),
    );
  }
}

class OnboardingItemTemplate extends StatelessWidget {
  const OnboardingItemTemplate({
    Key? key,
    required this.asset,
    required this.title,
    required this.description,
  }) : super(key: key);

  final String asset;
  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Expanded(
            flex: 3,
            child: Image.asset('assets/onboarding/$asset.png'),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Text(title.toUpperCase(),
                        style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            color: Color(0xffed1c24),
                            fontSize: 18)),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 64,
                    ),
                    child: Text(description,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 15.5,
                            color: Color(0xff858585))),
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
