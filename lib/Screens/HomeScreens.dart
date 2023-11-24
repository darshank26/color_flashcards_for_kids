import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:launch_review/launch_review.dart';
import 'package:toggle_switch/toggle_switch.dart';

import '../AdHelper/adshelper.dart';
import '../utils/constants.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}


class _HomeScreenState extends State<HomeScreen> {

  final PageController _pageController = PageController();

  int _selectedIndex = 0; //New
  int _selectedIndexText = 0; //New

  bool toggle = true;

  late BannerAd _bannerAd;

  bool _isBannerAdReady = false;

  List<String> _colorName = [
    "Red", "Blue", "Yellow", "Green", "Orange", "Purple", "Pink", "Brown", "Black", "White",
    "Gray", "Silver", "Gold", "Turquoise", "Lavender", "Magenta", "Cyan", "Peach", "Indigo", "Maroon",
    "Teal", "Olive", "Coral", "Beige", "Aqua", "Salmon", "Periwinkle", "Chartreuse", "Khaki", "Mauve",
    "Turmeric", "Vermilion", "Slate", "Orchid", "Tangerine", "Crimson", "Mint", "Charcoal", "Apricot", "Cobalt",
    "Azure", "Ebony", "Topaz", "Lilac", "Brick", "Puce", "Amber", "Mahogany", "Celadon", "Ruby", "Sapphire",
    "Marigold", "Emerald", "Mulberry", "Sienna", "Rose", "Sky Blue", "Lemon Yellow", "Cinnamon", "Plum", "Pear",
    "Steel Blue", "Tawny", "Cerulean", "Ochre", "Violet", "Buttercup Yellow", "Bubblegum Pink", "Aqua Marine", "Lime Green",

  ];

  List<String> _colorCode = ['0xffFF0000', '0xff0000FF', '0xffFFFF00', '0xff008000', '0xffFFA500', '0xff800080', '0xffFFC0CB', '0xffA52A2A', '0xff000000', '0xffFFFFFF', '0xff808080', '0xffC0C0C0', '0xffFFD700', '0xff40E0D0', '0xffE6E6FA', '0xffFF00FF', '0xff00FFFF', '0xffFFDAB9', '0xff4B0082', '0xff800000', '0xff008080', '0xff808000', '0xffFF7F50', '0xffF5F5DC', '0xff00FFFF', '0xffFA8072', '0xffCCCCFF', '0xff7FFF00', '0xffF0E68C', '0xffE0B0FF', '0xffDAA520', '0xffE34234', '0xff708090', '0xffDA70D6', '0xffF28500', '0xffDC143C', '0xff00FF00', '0xff36454F', '0xffFBCEB1', '0xff0047AB', '0xff007FFF', '0xff555D50', '0xffFFC87C', '0xffC8A2C8', '0xff9C661F', '0xffCC8899', '0xffFFBF00', '0xffC04000', '0xffACE1AF', '0xffE0115F', '0xff0F52BA', '0xffEAA221', '0xff50C878', '0xffC54B8C', '0xff882D17', '0xffFF007F', '0xff87CEEB', '0xffFFF44F', '0xffD2691E', '0xff8E4585', '0xffD1E231', '0xff4682B4', '0xffCD5700', '0xff007BA7', '0xffCC7722', '0xff8F00FF', '0xffF3AD00', '0xffFF69B4', '0xff7FFFD4',];


  void toggleSwitch(int index) async {

    if (index == 0) {
      setState(() {
        toggle = true;

      });
    } else if (index == 1) {
      setState(() {
        toggle = false;

      });
    }
  }

  FlutterTts ftts = FlutterTts();
   late Timer _timer;
   var check_volume = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ftts.setLanguage('en');
    ftts.setSpeechRate(0.3);
     ftts.setVolume(1.0); //volume of speech
     ftts.setPitch(1);

    _bannerAd = BannerAd(
      adUnitId: AdHelper.bannerAdUnitIdOfHomeScreen,
      request: AdRequest(),
      size: AdSize.banner,
      listener: BannerAdListener(
        onAdLoaded: (_) {
          setState(() {
            _isBannerAdReady = true;
          });
        },
        onAdFailedToLoad: (ad, err) {
          print('Failed to load a banner ad: ${err.message}');
          _isBannerAdReady = false;
          ad.dispose();
        },
      ),
    );
    _bannerAd.load();
  }



  @override
  void dispose() {
    super.dispose();
    _bannerAd.dispose();
  }


  @override
  Widget build(BuildContext context) {
     return Scaffold(
      appBar: AppBar(
        actions: [

          GestureDetector(
            onTap: () {

              if (check_volume == true) {
                setState(() {

                  check_volume = false;

                });
              } else if (check_volume == false) {
                setState(() {

                  check_volume = true;

                });
              }

            },
            child:
            check_volume ?
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(Icons.volume_up,color: Colors.black45,size: 24,),
            )
                :
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(Icons.volume_off,color: Colors.black45,size: 24,),
            )

            ,
          ),

          GestureDetector(
              onTap: () {
                launchPlay();
              },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(FontAwesomeIcons.solidStar,color: Colors.black45,size: 18,),
            ),
          ),


        ],
        centerTitle: true,
        backgroundColor: kback,
        title: Text("Colors  For Kids",
          style: GoogleFonts.mochiyPopOne(textStyle: TextStyle(fontSize: 20,color: kprimarycolor,fontWeight: FontWeight.w600,letterSpacing: 0.5))
          ,),),
      body:  Padding(
        padding: const EdgeInsets.only(top:10.0,bottom: 50.0),
        child: Column(
          children: [

            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ToggleSwitch(
                  minWidth: 150.0,
                  cornerRadius: 20.0,
                  activeBgColors: [[kback], [kback]],
                  activeFgColor: kprimarycolor,
                  inactiveBgColor: Colors.grey.shade300,
                  inactiveFgColor: kprimarycolor,
                  initialLabelIndex: _selectedIndexText,
                  totalSwitches: 2,
                  fontSize: 20,
                  customTextStyles : [
                    GoogleFonts.mochiyPopOne(textStyle: TextStyle(fontSize: 14,color: kprimarycolor,fontWeight: FontWeight.w600,letterSpacing: 0.5)),
                    GoogleFonts.mochiyPopOne(textStyle: TextStyle(fontSize: 14,color: kprimarycolor,fontWeight: FontWeight.w600,letterSpacing: 0.5))
                  ],
                  icons: [
                    FontAwesomeIcons.eye,
                    FontAwesomeIcons.eyeLowVision

                  ],
                  labels: ['Show Text', 'Hide Text'],
                  radiusStyle: true,
                  onToggle: (index) {

                    _selectedIndexText = index!;

                    if (_selectedIndexText == 0) {
                      setState(() {
                        toggle = true;

                      });
                    } else if (_selectedIndexText == 1) {
                      setState(() {
                        toggle = false;

                      });
                    }

                    // toggleSwitch(index!);


                  },
                ),
              ),
            ),

            Expanded(
              flex: 9,
              child: Center(
                child: PageView.builder(
                  controller: _pageController,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: _colorName.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.all(10),
                      child: Card(
                        color: backcolor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        elevation: 1,
                        child: Center(
                          child:  Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              // Image.asset('assets/images/$index.png',
                              //   height: 300,
                              //   width: double.infinity,
                              //   alignment: Alignment.center,
                              //   fit: BoxFit.cover,
                              // ),

                              Padding(
                                padding: const EdgeInsets.only(top:15.0),
                                child: Container(
                                  height: 300,
                                  width: 300,
                                  alignment: Alignment.center,

                                child: Container(

                                    decoration: BoxDecoration(
                                      color: Color(int.parse(_colorCode.elementAt(index))),
                                        border: Border.all(color: Colors.black87,width:3),
                                        borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(20.0),
                                          bottomRight: Radius.circular(20.0),
                                          topLeft: Radius.circular(20.0),
                                          bottomLeft: Radius.circular(20.0),
                                        ))
                                )

                                  ,
                                ),
                              ),

                               toggle  ?  Text("${_colorName.elementAt(index)}",
                                style: GoogleFonts.mochiyPopOne(textStyle: TextStyle(fontSize: 38,color: kprimarycolor,fontWeight: FontWeight.w600,letterSpacing: 1,))
                                ,) : Text(""),

                              Padding(
                                padding: const EdgeInsets.only(top:10.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        if (_pageController.page!.round() > 0) {
                                          _pageController.previousPage(
                                            duration: Duration(milliseconds: 500),
                                            curve: Curves.easeInOut,
                                          );
                                          if(check_volume)
                                            {
                                              ftts.speak(_colorName.elementAt(index-1));
                                            }

/*
                                          print("####################"+_pageController.page!.round().toString() );
*/

                                        }
                                      },
                                      child: Card(
                                        color: kback,
                                        elevation: 1,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(100),
                                        ),
                                        child:  Container(
                                          height: 50,
                                          width: 60,
                                          child: Icon(
                                            Icons.arrow_back,
                                            size: 30,
                                            color: kprimarycolor,
                                          ),
                                        ),
                                      ),
                                    ) ,
                                    SizedBox(width: 20,),
                                    GestureDetector(
                                      onTap: () {

                                        if (check_volume == true) {
                                          setState(() {

                                            check_volume = false;

                                          });
                                        } else if (check_volume == false) {
                                          setState(() {

                                            check_volume = true;

                                          });
                                        }


                                        if(check_volume)
                                          {
                                            ftts.speak(_colorName.elementAt(index));
                                          }


                                        },
                                      child: Card(
                                        color: kback,
                                        elevation: 1,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(100),
                                        ),
                                        child:  Container(
                                          height: 80,
                                          width: 80,
                                          child:

                                          check_volume ? Icon(
                                            Icons.volume_up,
                                            color: kprimarycolor,
                                            size: 44,
                                          ) : Icon(
                                            Icons.volume_off,
                                            color: kprimarycolor,
                                            size: 44,
                                          ),


                                        ),
                                      ),
                                    ) ,
                                    SizedBox(width: 20,),
                                    GestureDetector(
                                      onTap: () {
                                        if (_pageController.page!.round() < _colorName.length - 1) {
                                          _pageController.nextPage(
                                            duration: Duration(milliseconds: 500),
                                            curve: Curves.easeInOut,
                                          );
                                          if(check_volume)
                                            {
                                              ftts.speak(_colorName.elementAt(index+1));
                                            }
                                          print("++++++"+index.toString());
                                        }
                                      },
                                      child: index != 68 ? Card(
                                        color: kback,
                                        elevation: 1,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(100),
                                        ),
                                        child:  Container(
                                          height: 50,
                                          width: 60,
                                          child: Icon(
                                            color: kprimarycolor,
                                            Icons.arrow_forward,
                                            size: 30,
                                          ),
                                        ),
                                      ) : Container(),
                                    ) ,

                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),

       // bottomNavigationBar: BottomNavigationBar(
       //   selectedItemColor: kback,
       //   currentIndex: _selectedIndex, //New
       //   onTap: _onItemTapped,
       //   items: const <BottomNavigationBarItem>[
       //     BottomNavigationBarItem(
       //       icon: Icon(Icons.home),
       //       label: 'Home',
       //     ),
       //     BottomNavigationBarItem(
       //       icon: Icon(Icons.phone_android),
       //       label: 'More Apps',
       //     ),
       //
       //   ],
       // ),

       bottomNavigationBar: Row(
         mainAxisAlignment: MainAxisAlignment.center,
         children: [
           if (_isBannerAdReady)
             Container(
               width: _bannerAd.size.width.toDouble(),
               height: _bannerAd.size.height.toDouble(),
               child: AdWidget(ad: _bannerAd),
             ),
         ],
       ),

    );


  }
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }



  void _modalBottomSheetMenu(){
    showModalBottomSheet(
        context: context,
        builder: (builder){
          return new Container(
            height: 350.0,
            color: Colors.transparent, //could change this to Color(0xFF737373),
            //so you don't have to change MaterialApp canvasColor
            child: new Container(
                decoration: new BoxDecoration(
                    color: Colors.white,
                    borderRadius: new BorderRadius.only(
                        topLeft: const Radius.circular(10.0),
                        topRight: const Radius.circular(10.0))),
                child: new Center(
                  child: new Text("This is a modal sheet"),
                )),
          );
        }
    );
  }


  void launchPlay() async {
    LaunchReview.launch(
      androidAppId: androidAppIdValue,
      iOSAppId: iOSAppIdValue,);
  }


}
