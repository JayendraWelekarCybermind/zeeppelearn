import 'dart:math';
import 'package:flutter/material.dart';
import 'package:zeppe_learn/components/common/appButton.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});
  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  // List<CardData> cards = CardData.getCard();
    List<Widget> cardWidgets = [];
  double angle = 0; // Track card rotation
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      cardWidgets = [
        cardOne(removeCard),
        cardTwo(removeCard),
        cardThree(removeCard),
      ];
    });
  }

  void removeCard() {
    if (cardWidgets.isNotEmpty) {
      setState(() {
        Widget temp = cardWidgets[0];
        cardWidgets.add(temp);
        cardWidgets.removeAt(0); // ✅ Removes the top card
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.white),
      child: Container(
        decoration: BoxDecoration(color: Colors.black.withAlpha(102)),
        child: Stack(
            alignment: Alignment.bottomCenter,
            children: cardWidgets
                .toList()
                .asMap()
                .entries
                .map((entry) { // Adjust vertical position
                  return cardTemplate(entry.value, entry.key);
                })
                .toList()
                .reversed
                .toList() // Reverse to ensure first card is on top
            ),
      ),
    );
  }

Widget cardTemplate(Widget card, int index) => Positioned(
  child: Padding(
    padding: EdgeInsets.only(left: index * 10, right: index*10, bottom: index*20),
    child: Container(
      height: 700,
      alignment: index == 0 ? Alignment.bottomCenter : Alignment.topCenter,
      child: cardContent(card, index),
    )
  )
);

  Widget cardContent(Widget card, int index) {
  if (index == 0) {
    return card; // ✅ Show content for top card
  } else {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 700,
      decoration: BoxDecoration(
        color: Colors.grey[ log(index*50).toInt() *100], // ✅ Keeps background white
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(color: Colors.black26, blurRadius: 10)
        ],
      ),
    ); // ✅ Empty container for back cards
  }
}

  
static Widget cardOne(removeCard) => Container(
          // key: ValueKey(index),
          // width: MediaQuery.of(context).size.width,
          height: 700,
          decoration: BoxDecoration(
            color: Colors.white,
            image: DecorationImage(
              image: AssetImage('assets/images/dotBg.png'),
              alignment: Alignment.topCenter,
            ),
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(color: Colors.black26, blurRadius: 10)
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Stack(
              children: [
                Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 130,
                        width: 130,
                        child: Image.asset('assets/images/blue_fire.png'),
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "0",
                            style: TextStyle(
                              fontFamily: 'Roboto',
                              fontSize: 60,
                              fontWeight: FontWeight.w800, // Increased weight to w900
                              color: Color(0xff003059),
                              decoration: TextDecoration.none,
                            ),
                          ),
                          Image.asset(
                            'assets/images/thunder.png',
                            height: 50,
                          )
                        ],
                      ),
                      Column(
                        children: [
                          Text("Day Streak",
                              style: TextStyle(
                                  color: Color(0xff003059),
                                  fontSize: 20,
                                  fontFamily: 'Circular Std',
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 20 * (-1 / 100),
                                  decoration: TextDecoration.none)),
                          Text("Your streak is shinig!✨Let's keep it going!",
                              style: TextStyle(
                                  height: 3,
                                  color: Color(0xff61788D),
                                  fontSize: 15,
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: 15 * (-2 / 100),
                                  decoration: TextDecoration.none)),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 0.0, right: 0.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            _buildStreakDay("S"),
                            _buildStreakDay("M"),
                            _buildStreakDay("T"),
                            _buildStreakDay("W"),
                            _buildStreakDay("T"),
                            _buildStreakDay("F"),
                            _buildStreakDay("S"),
                          ],
                        ),
                      )
                    ],
                  )
                ),
                Positioned(
                    bottom: 10,
                    left: 0,
                    right: 0,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            AppButton(
                              fontWeight: FontWeight.w500,
                              letterSpacing: -2,
                              textContent: '',
                              buttonWidth: 56,
                              textColor: Colors.black,
                              buttonColor: Color(0xffEBF1F5),
                              borderColor: Color(0xffD6E0E7),
                              borderWidth: 6,
                              innerImage: 'assets/images/share.png',
                              onPressed: () {
                              },
                            ),
                            SizedBox(width: 10,),
                            Expanded(
                              child: AppButton(
                                fontWeight: FontWeight.w500,
                                letterSpacing: -2,
                                textContent: 'Continue',
                                buttonWidth: 262,
                                textColor: Colors.white,
                                buttonColor: Color(0xff0088FF),
                                borderColor: Color(0xff0061B5),
                                borderWidth: 6,
                                onPressed: () {
                                  removeCard();
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                      
                    )
              ],
            ),
          ),
        );
    

static Widget cardTwo(removeCard) => Container(
          // width: MediaQuery.of(context).size.width,
          height: 700,
          decoration: BoxDecoration(
            color: Colors.white,
             image:DecorationImage(
              image: AssetImage('assets/images/dotBg.png'),
              alignment: Alignment.topCenter,
            ) ,
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(color: Colors.black26, blurRadius: 10)
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Stack(
              children: [
                Container(
                  child:  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 130,
                        width: 130,
                        child: Image.asset('assets/images/frog.png'),
                      ),
                      SizedBox(height: 30),
                      Column(
                        children: [
                          Text("Lesson Completed! Urahhh!",
                              style: TextStyle(
                                  color: Color(0xff003059),
                                  fontSize: 20,
                                  fontFamily: 'Circular Std',
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 25 * (-1 / 100),
                                  decoration: TextDecoration.none)),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 90.0, right: 90.0, top: 15),
                            child: Text(
                                "Great job! You're one step closer to mastering this topic",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    // height: 3,
            
                                    color: Color(0xff61788D),
                                    fontSize: 14,
                                    fontFamily: 'Roboto',
                                    fontWeight: FontWeight.w500,
                                    letterSpacing: 14 * (-2 / 100),
                                    decoration: TextDecoration.none)),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 40,
                      ),

                      Container(
                          child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(child:  Container(
                              child: Stack(
                              children: [
                                Container(
                                    height: 80,
                                    decoration: BoxDecoration(
                                      color: Color(0xffFDD649),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(2.0),
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(top: 2.0, bottom: 2.0),
                                            child: Text(
                                              "Accuracy",
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 13,
                                                fontFamily: 'Inter Display',
                                                fontWeight: FontWeight.w500,
                                                letterSpacing: 13 * (-2 / 100),
                                                decoration: TextDecoration.none,
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: Container(
                                                alignment: Alignment.center,
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(10),
                                                  color: Colors.white,
                                                ),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    Image.asset(
                                                      'assets/images/target.png',
                                                      height: 21,
                                                      width: 21,
                                                    ),
                                                    SizedBox(
                                                      width: 5,
                                                    ),
                                                    Text(
                                                      '85%',
                                                      style: TextStyle(
                                                          fontFamily: 'Circular Std',
                                                          fontWeight: FontWeight.w700,
                                                          fontSize: 20,
                                                          letterSpacing: 20 * (-2 / 100),
                                                          color: Colors.black,
                                                          decoration: TextDecoration.none),
                                                    )
                                                  ],
                                                )),
                                          )
                                        ],
                                      ),
                                    )),
                              ],
                            )),
                           ),
                            SizedBox(width: 8,),
                            Expanded(child: Container(
                                child: Stack(
                              children: [
                                Container(
                                    height: 80,
                                    decoration: BoxDecoration(
                                      color: Color(0xff87D23C),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(2.0),
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(top: 2.0, bottom: 2.0),
                                            child: Text(
                                              "XP Points",
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 13,
                                                fontFamily: 'Inter Display',
                                                fontWeight: FontWeight.w500,
                                                letterSpacing: 13 * (-2 / 100),
                                                decoration: TextDecoration.none,
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: Container(
                                                alignment: Alignment.center,
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(10),
                                                  color: Colors.white,
                                                ),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    Image.asset(
                                                      'assets/images/green_thunder.png',
                                                      height: 21,
                                                      width: 21,
                                                    ),
                                                    SizedBox(
                                                      width: 5,
                                                    ),
                                                    Text(
                                                      '54',
                                                      style: TextStyle(
                                                          fontFamily: 'Circular Std',
                                                          fontWeight: FontWeight.w700,
                                                          fontSize: 20,
                                                          letterSpacing: 20 * (-2 / 100),
                                                          color: Colors.black,
                                                          decoration: TextDecoration.none),
                                                    )
                                                  ],
                                                )),
                                          )
                                        ],
                                      ),
                                    )),
                              ],
                            )),
                            ),
                            SizedBox(width: 8,),
                            Expanded(child: Container(
                                child: Stack(
                              children: [
                                Container(
                                    height: 80,
                                    decoration: BoxDecoration(
                                      color: Color(0xff9C63FF),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(2.0),
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(top: 2.0, bottom: 2.0),
                                            child: Text(
                                              "Time Spent",
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 13,
                                                fontFamily: 'Inter Display',
                                                fontWeight: FontWeight.w500,
                                                letterSpacing: 13 * (-2 / 100),
                                                decoration: TextDecoration.none,
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: Container(
                                                alignment: Alignment.center,
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(10),
                                                  color: Colors.white,
                                                ),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    Image.asset(
                                                      'assets/images/watch.png',
                                                      height: 21,
                                                      width: 21,
                                                    ),
                                                    SizedBox(
                                                      width: 5,
                                                    ),
                                                    Text(
                                                      '2:11',
                                                      style: TextStyle(
                                                          fontFamily: 'Circular Std',
                                                          fontWeight: FontWeight.w700,
                                                          fontSize: 20,
                                                          letterSpacing: 20 * (-2 / 100),
                                                          color: Colors.black,
                                                          decoration: TextDecoration.none),
                                                    )
                                                  ],
                                                )),
                                          )
                                        ],
                                      ),
                                    )),
                              ],
                            ))
                         ),
                        
                          ],
                        )),
                      
                    ],
                  ),  
                ),
                Positioned(
                    bottom: 10,
                    left: 0,
                    right: 0,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            AppButton(
                              fontWeight: FontWeight.w500,
                              letterSpacing: -2,
                              textContent: '',
                              buttonWidth: 56,
                              textColor: Colors.black,
                              buttonColor: Color(0xffEBF1F5),
                              borderColor: Color(0xffD6E0E7),
                              borderWidth: 6,
                              innerImage: 'assets/images/share.png',
                              onPressed: () {
                              },
                            ),
                            SizedBox(width: 10,),
                            Expanded(
                              child: AppButton(
                                fontWeight: FontWeight.w500,
                                letterSpacing: -2,
                                textContent: 'Continue',
                                buttonWidth: 262,
                                textColor: Colors.white,
                                buttonColor: Color(0xff0088FF),
                                borderColor: Color(0xff0061B5),
                                borderWidth: 6,
                                onPressed: () {
                                  removeCard();
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                      
                    )
              ],
            ),
          ),
        );
      
static Widget cardThree(removeCard) => Container(
          // width: MediaQuery.of(context).size.width,
          height: 554,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(color: Colors.black26, blurRadius: 10)
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                Transform.translate(
                  offset: Offset(0, -82),
                  child: Container(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 163,
                          width: 183,
                          child: Image.asset(
                                  'assets/images/badge.png',
                                  width: 130, // Adjust width as needed
                                ),
                        ),
                        SizedBox(height: 30,),
                        Column(
                            children: [
                              Text("Congratulations!\nYou've Earned a Badge!", 
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                  fontFamily: "Circular Std",
                                  letterSpacing: 20 * (-0.01),
                                  color: Colors.black,
                                  decoration: TextDecoration.none
                                ),
                              ),
                              SizedBox(height: 40),
                              Container(
                                child: Container(
                                  height: 93,
                                  decoration: BoxDecoration(
                                    color: Color(0xff87D23C),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Stack(
                                    children: [
                                      Positioned(
                                        top:-20,
                                        left: 100,
                                        child: Transform.rotate(
                                          alignment: Alignment.topCenter,
                                          angle: 25 * 3.14159265358979323846 / 180,
                                          child: Row(
                                            children: [
                                              Container(
                                                height: 131,
                                                width: 18,
                                                color: Colors.white.withAlpha(59),
                                              ),
                                              SizedBox(width: 4,),
                                              Container(
                                                height: 131,
                                                width: 6,
                                                color: Colors.white.withAlpha(59),
                                              )
                                            ],
                                          ),
                                        ) 
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.all(4.0),
                                              child: Text("Master of Basics",
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontFamily: "Inter Display",
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w700,
                                                  letterSpacing: 14 * (-0.02),
                                                  decoration: TextDecoration.none
                                                )
                                              ),
                                            ),
                                            Container(
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius.circular(10)
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets.all(10.0),
                                                child: Padding(
                                                  padding: const EdgeInsets.only(left: 12, right: 12),
                                                  child: Text(
                                                    "Awarded for completing Lesson 1 with exceptional focus and determination.",
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      fontSize: 13,
                                                      fontWeight: FontWeight.w400,
                                                      fontFamily: "Circular Std",
                                                      letterSpacing: 13 * (-0.02),
                                                      color: Colors.black,
                                                      decoration: TextDecoration.none
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                    bottom: 10,
                    left: 0,
                    right: 0,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: AppButton(
                              fontWeight: FontWeight.w500,
                              letterSpacing: -2,
                              textContent: 'Share',
                              buttonWidth: 56,
                              textColor: Colors.black,
                              buttonColor: Color(0xffEBF1F5),
                              borderColor: Color(0xffD6E0E7),
                              borderWidth: 6,
                              innerImage: 'assets/images/share.png',
                              onPressed: () {
                              },
                            ),
                          ),
                          SizedBox(width: 10,),
                          Expanded(
                            child: AppButton(
                              fontWeight: FontWeight.w500,
                              letterSpacing: -2,
                              textContent: 'Continue',
                              buttonWidth: 262,
                              textColor: Colors.white,
                              buttonColor: Color(0xff0088FF),
                              borderColor: Color(0xff0061B5),
                              borderWidth: 6,
                              onPressed: () {
                                removeCard();
                              },
                            ),
                          ),
                        ],
                      ),
                    ))
              ],
            ),
          ),
        );
     
     
}

Widget _buildStreakDay(content) => Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                content,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontFamily: 'Inter Display',
                                    letterSpacing: 14*0.03,
                                    fontWeight: FontWeight.w500,
                                    decoration: TextDecoration.none),
                              ),
                              Image.asset(
                                "assets/images/tick.png",
                                height: 40,
                              )
                            ],
                          );

// class _carddOne extends StatelessWidget {
//   const _carddOne({
//     super.key,
//     required this.offset,
//     required this.scale,
//     required this.index,
//   });

//   final double offset;
//   final double scale;
//   final int index;

//   @override
//   Widget build(BuildContext context) {
//     return Positioned(
//       bottom: offset, // Stack cards downward
//       child: Transform.scale(
//         scale: scale, // Make each card slightly smaller
//         child: Container(
//           key: ValueKey(index),
//           width: MediaQuery.of(context).size.width,
//           height: 700,
//           decoration: BoxDecoration(
//             color: Colors.white,
//             image: DecorationImage(
//               image: AssetImage('assets/images/dotBg.png'),
//               alignment: Alignment.topCenter,
//             ),
//             borderRadius: BorderRadius.circular(24),
//             boxShadow: [
//               BoxShadow(color: Colors.black26, blurRadius: 10)
//             ],
//           ),
//           child: Stack(
//             children: [
//               Container(
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     SizedBox(
//                       height: 130,
//                       width: 130,
//                       child: Image.asset('assets/images/blue_fire.png'),
//                     ),
//                     SizedBox(height: 10),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Text(
//                           index.toString(),
//                           style: TextStyle(
//                             fontFamily: 'Roboto',
//                             fontSize: 60,
//                             fontWeight: FontWeight.w800, // Increased weight to w900
//                             color: Color(0xff003059),
//                             decoration: TextDecoration.none,
//                           ),
//                         ),
//                         Image.asset(
//                           'assets/images/thunder.png',
//                           height: 50,
//                         )
//                       ],
//                     ),
//                     Column(
//                       children: [
//                         Text("Day Streak",
//                             style: TextStyle(
//                                 color: Color(0xff003059),
//                                 fontSize: 25,
//                                 fontFamily: 'Circular Std',
//                                 fontWeight: FontWeight.w600,
//                                 letterSpacing: 25 * (-1 / 100),
//                                 decoration: TextDecoration.none)),
//                         Text("Your streak is shinig!✨Let's keep it going!",
//                             style: TextStyle(
//                                 height: 3,
//                                 color: Color(0xff61788D),
//                                 fontSize: 15,
//                                 fontFamily: 'Roboto',
//                                 fontWeight: FontWeight.w500,
//                                 letterSpacing: 15 * (-2 / 100),
//                                 decoration: TextDecoration.none)),
//                       ],
//                     ),
//                     SizedBox(
//                       height: 20,
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.only(left: 20.0, right: 20.0),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                         children: [
//                           _buildStreakDay("S"),
//                           _buildStreakDay("M"),
//                           _buildStreakDay("T"),
//                           _buildStreakDay("W"),
//                           _buildStreakDay("T"),
//                           _buildStreakDay("F"),
//                           _buildStreakDay("S"),
//                         ],
//                       ),
//                     )
//                   ],
//                 )
//               ),
//               Positioned(
//                   bottom: 10,
//                   left: 10,
//                   right: 10,
//                   child: Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                       children: [
//                         AppButton(
//                           fontWeight: FontWeight.w500,
//                           letterSpacing: -2,
//                           textContent: '',
//                           buttonWidth: 56,
//                           textColor: Colors.black,
//                           buttonColor: Color(0xffEBF1F5),
//                           borderColor: Color(0xffD6E0E7),
//                           borderWidth: 6,
//                           innerImage: 'assets/images/share.png',
//                           onPressed: () {
//                             "HELLO");print(
//                           },
//                         ),
//                         AppButton(
//                           fontWeight: FontWeight.w500,
//                           letterSpacing: -2,
//                           textContent: 'Continue',
//                           buttonWidth: 262,
//                           textColor: Colors.white,
//                           buttonColor: Colors.blue,
//                           borderColor: Color(0xff0061B5),
//                           borderWidth: 6,
//                           onPressed: () {
//                             print("HELLO");
//                           },
//                         ),
//                       ],
//                     ),
//                   ))
//             ],
//           ),
//         ),
    
//       ),
//     );
//   }
// }

// class _carddTwo extends StatelessWidget {
//   const _carddTwo({
//     super.key,
//     required this.offset,
//     required this.scale,
//     required this.index,
//   });

//   final double offset;
//   final double scale;
//   final int index;

//   @override
//   Widget build(BuildContext context) {
//     return Positioned(
//       bottom: offset, // Stack cards downward
//       child: Transform.scale(
//         scale: scale, // Make each card slightly smaller
//         child: Container(
//           key: ValueKey(index),
//           width: MediaQuery.of(context).size.width,
//           height: 700,
//           decoration: BoxDecoration(
//             color: index==0 ? Colors.white : Colors.grey[(index) * 200],
//              image: index == 0 ? DecorationImage(
//               image: AssetImage('assets/images/dotBg.png'),
//               alignment: Alignment.topCenter,
//             ) : null,
//             borderRadius: BorderRadius.circular(24),
//             boxShadow: [
//               BoxShadow(color: Colors.black26, blurRadius: 10)
//             ],
//           ),
//           child: Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Stack(
//               children: [
//                 Container(
//                   child:  Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       SizedBox(
//                         height: 130,
//                         width: 130,
//                         child: Image.asset('assets/images/frog.png'),
//                       ),
//                       SizedBox(height: 30),
//                       Column(
//                         children: [
//                           Text("Lesson Completed! Urahhh!",
//                               style: TextStyle(
//                                   color: Color(0xff003059),
//                                   fontSize: 20,
//                                   fontFamily: 'Circular Std',
//                                   fontWeight: FontWeight.w600,
//                                   letterSpacing: 25 * (-1 / 100),
//                                   decoration: TextDecoration.none)),
//                           Padding(
//                             padding:
//                                 const EdgeInsets.only(left: 90.0, right: 90.0, top: 15),
//                             child: Text(
//                                 "Great job! You're one step closer to mastering this topic",
//                                 textAlign: TextAlign.center,
//                                 style: TextStyle(
//                                     // height: 3,
            
//                                     color: Color(0xff61788D),
//                                     fontSize: 14,
//                                     fontFamily: 'Roboto',
//                                     fontWeight: FontWeight.w500,
//                                     letterSpacing: 14 * (-2 / 100),
//                                     decoration: TextDecoration.none)),
//                           ),
//                         ],
//                       ),
//                       SizedBox(
//                         height: 40,
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.only(left: 8.0, right: 8.0),
//                         child: Container(
//                           child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                           children: [
//                             Expanded(child:  Container(
//                               child: Stack(
//                               children: [
//                                 Container(
//                                     height: 80,
//                                     decoration: BoxDecoration(
//                                       color: Color(0xffFDD649),
//                                       borderRadius: BorderRadius.circular(10),
//                                     ),
//                                     child: Padding(
//                                       padding: const EdgeInsets.all(2.0),
//                                       child: Column(
//                                         children: [
//                                           Padding(
//                                             padding: const EdgeInsets.all(2.0),
//                                             child: Text(
//                                               "Accuracy",
//                                               style: TextStyle(
//                                                 color: Colors.black,
//                                                 fontSize: 13,
//                                                 fontFamily: 'Inter Display',
//                                                 fontWeight: FontWeight.w500,
//                                                 letterSpacing: 13 * (-2 / 100),
//                                                 decoration: TextDecoration.none,
//                                               ),
//                                             ),
//                                           ),
//                                           Expanded(
//                                             child: Container(
//                                                 alignment: Alignment.center,
//                                                 decoration: BoxDecoration(
//                                                   borderRadius: BorderRadius.circular(10),
//                                                   color: Colors.white,
//                                                 ),
//                                                 child: Row(
//                                                   mainAxisAlignment: MainAxisAlignment.center,
//                                                   children: [
//                                                     Image.asset(
//                                                       'assets/images/target.png',
//                                                       height: 21,
//                                                       width: 21,
//                                                     ),
//                                                     SizedBox(
//                                                       width: 5,
//                                                     ),
//                                                     Text(
//                                                       '85%',
//                                                       style: TextStyle(
//                                                           fontFamily: 'Circular Std',
//                                                           fontWeight: FontWeight.w700,
//                                                           fontSize: 20,
//                                                           letterSpacing: 20 * (-2 / 100),
//                                                           color: Colors.black,
//                                                           decoration: TextDecoration.none),
//                                                     )
//                                                   ],
//                                                 )),
//                                           )
//                                         ],
//                                       ),
//                                     )),
//                               ],
//                             )),
//                            ),
//                             SizedBox(width: 8,),
//                             Expanded(child: Container(
//                                 child: Stack(
//                               children: [
//                                 Container(
//                                     height: 80,
//                                     decoration: BoxDecoration(
//                                       color: Color(0xff87D23C),
//                                       borderRadius: BorderRadius.circular(10),
//                                     ),
//                                     child: Padding(
//                                       padding: const EdgeInsets.all(2.0),
//                                       child: Column(
//                                         children: [
//                                           Padding(
//                                             padding: const EdgeInsets.all(2.0),
//                                             child: Text(
//                                               "XP Points",
//                                               style: TextStyle(
//                                                 color: Colors.black,
//                                                 fontSize: 13,
//                                                 fontFamily: 'Inter Display',
//                                                 fontWeight: FontWeight.w500,
//                                                 letterSpacing: 13 * (-2 / 100),
//                                                 decoration: TextDecoration.none,
//                                               ),
//                                             ),
//                                           ),
//                                           Expanded(
//                                             child: Container(
//                                                 alignment: Alignment.center,
//                                                 decoration: BoxDecoration(
//                                                   borderRadius: BorderRadius.circular(10),
//                                                   color: Colors.white,
//                                                 ),
//                                                 child: Row(
//                                                   mainAxisAlignment: MainAxisAlignment.center,
//                                                   children: [
//                                                     Image.asset(
//                                                       'assets/images/green_thunder.png',
//                                                       height: 21,
//                                                       width: 21,
//                                                     ),
//                                                     SizedBox(
//                                                       width: 5,
//                                                     ),
//                                                     Text(
//                                                       '54',
//                                                       style: TextStyle(
//                                                           fontFamily: 'Circular Std',
//                                                           fontWeight: FontWeight.w700,
//                                                           fontSize: 20,
//                                                           letterSpacing: 20 * (-2 / 100),
//                                                           color: Colors.black,
//                                                           decoration: TextDecoration.none),
//                                                     )
//                                                   ],
//                                                 )),
//                                           )
//                                         ],
//                                       ),
//                                     )),
//                               ],
//                             )),
//                             ),
//                             SizedBox(width: 8,),
//                             Expanded(child: Container(
//                                 child: Stack(
//                               children: [
//                                 Container(
//                                     height: 80,
//                                     decoration: BoxDecoration(
//                                       color: Color(0xff9C63FF),
//                                       borderRadius: BorderRadius.circular(10),
//                                     ),
//                                     child: Padding(
//                                       padding: const EdgeInsets.all(2.0),
//                                       child: Column(
//                                         children: [
//                                           Padding(
//                                             padding: const EdgeInsets.all(2.0),
//                                             child: Text(
//                                               "Time Spent",
//                                               style: TextStyle(
//                                                 color: Colors.black,
//                                                 fontSize: 13,
//                                                 fontFamily: 'Inter Display',
//                                                 fontWeight: FontWeight.w500,
//                                                 letterSpacing: 13 * (-2 / 100),
//                                                 decoration: TextDecoration.none,
//                                               ),
//                                             ),
//                                           ),
//                                           Expanded(
//                                             child: Container(
//                                                 alignment: Alignment.center,
//                                                 decoration: BoxDecoration(
//                                                   borderRadius: BorderRadius.circular(10),
//                                                   color: Colors.white,
//                                                 ),
//                                                 child: Row(
//                                                   mainAxisAlignment: MainAxisAlignment.center,
//                                                   children: [
//                                                     Image.asset(
//                                                       'assets/images/watch.png',
//                                                       height: 21,
//                                                       width: 21,
//                                                     ),
//                                                     SizedBox(
//                                                       width: 5,
//                                                     ),
//                                                     Text(
//                                                       '2:11',
//                                                       style: TextStyle(
//                                                           fontFamily: 'Circular Std',
//                                                           fontWeight: FontWeight.w700,
//                                                           fontSize: 20,
//                                                           letterSpacing: 20 * (-2 / 100),
//                                                           color: Colors.black,
//                                                           decoration: TextDecoration.none),
//                                                     )
//                                                   ],
//                                                 )),
//                                           )
//                                         ],
//                                       ),
//                                     )),
//                               ],
//                             ))
//                          ),
                        
//                           ],
//                         )),
//                       )
//                     ],
//                   ),  
//                 ),
//                 Positioned(
//                     bottom: 10,
//                     left: 10,
//                     right: 10,
//                     child: Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           AppButton(
//                             fontWeight: FontWeight.w500,
//                             letterSpacing: -2,
//                             textContent: '',
//                             buttonWidth: 56,
//                             textColor: Colors.black,
//                             buttonColor: Color(0xffEBF1F5),
//                             borderColor: Color(0xffD6E0E7),
//                             borderWidth: 6,
//                             innerImage: 'assets/images/share.png',
//                             onPressed: () {
//                               print("HELLO");
//                             },
//                           ),
//                           AppButton(
//                             fontWeight: FontWeight.w500,
//                             letterSpacing: -2,
//                             textContent: 'Continue',
//                             buttonWidth: 262,
//                             textColor: Colors.white,
//                             buttonColor: Colors.blue,
//                             borderColor: Color(0xff0061B5),
//                             borderWidth: 6,
//                             onPressed: () {
//                               print("HELLO");
//                             },
//                           ),
//                         ],
//                       ),
//                     ))
//               ],
//             ),
//           ),
//         ),
      
      
//       ),
//     );
//   }
// }

// class _carddThree extends StatelessWidget {
//   const _carddThree({
//     super.key,
//     required this.offset,
//     required this.scale,
//     required this.index,
//   });

//   final double offset;
//   final double scale;
//   final int index;

//   @override
//   Widget build(BuildContext context) {
//     return Positioned(
//       bottom: offset, // Stack cards downward
//       child: Transform.scale(
//         scale: scale, // Make each card slightly smaller
//         child: Container(
//           key: ValueKey(index),
//           width: MediaQuery.of(context).size.width,
//           height: 554,
//           decoration: BoxDecoration(
//             color: index==0 ? Colors.white : Colors.grey[(index) * 200],
//             borderRadius: BorderRadius.circular(24),
//             boxShadow: [
//               BoxShadow(color: Colors.black26, blurRadius: 10)
//             ],
//           ),
//           child: Stack(
//             alignment: Alignment.topCenter,
//             children: [
//               Transform.translate(
//                 offset: Offset(0, -68),
//                 child: Container(
//                   child: Column(
//                     children: [
//                       SizedBox(
//                         height: 163,
//                         width: 183,
//                         child: Image.asset(
//                                 'assets/images/badge.png',
//                                 width: 130, // Adjust width as needed
//                               ),
//                       ),
//                       SizedBox(height: 30,),
//                       Padding(
//                         padding: const EdgeInsets.only(left: 8.0, right: 8.0),
//                         child: Column(
//                           children: [
//                             Text("Congratulations!\nYou've Earned a Badge!", 
//                               textAlign: TextAlign.center,
//                               style: TextStyle(
//                                 fontSize: 20,
//                                 fontWeight: FontWeight.w700,
//                                 fontFamily: "Circular Std",
//                                 letterSpacing: 20 * (-0.01),
//                                 color: Colors.black,
//                                 decoration: TextDecoration.none
//                               ),
//                             ),
//                             SizedBox(height: 40),
//                             Container(
//                               child: Container(
//                                 height: 93,
//                                 decoration: BoxDecoration(
//                                   color: Color(0xff87D23C),
//                                   borderRadius: BorderRadius.circular(10),
//                                 ),
//                                 child: Stack(
//                                   children: [
//                                     Positioned(
//                                       top:-20,
//                                       left: 100,
//                                       child: Transform.rotate(
//                                         alignment: Alignment.topCenter,
//                                         angle: 25 * 3.14159265358979323846 / 180,
//                                         child: Row(
//                                           children: [
//                                             Container(
//                                               height: 131,
//                                               width: 18,
//                                               color: Colors.white.withAlpha(59),
//                                             ),
//                                             SizedBox(width: 4,),
//                                             Container(
//                                               height: 131,
//                                               width: 6,
//                                               color: Colors.white.withAlpha(59),
//                                             )
//                                           ],
//                                         ),
//                                       ) 
//                                     ),
//                                     Padding(
//                                       padding: const EdgeInsets.all(4.0),
//                                       child: Column(
//                                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                         children: [
//                                           Padding(
//                                             padding: const EdgeInsets.all(4.0),
//                                             child: Text("Master of Basics",
//                                               style: TextStyle(
//                                                 color: Colors.black,
//                                                 fontFamily: "Inter Display",
//                                                 fontSize: 14,
//                                                 fontWeight: FontWeight.w700,
//                                                 letterSpacing: 14 * (-0.02),
//                                                 decoration: TextDecoration.none
//                                               )
//                                             ),
//                                           ),
//                                           Container(
//                                             decoration: BoxDecoration(
//                                               color: Colors.white,
//                                               borderRadius: BorderRadius.circular(10)
//                                             ),
//                                             child: Padding(
//                                               padding: const EdgeInsets.all(10.0),
//                                               child: Padding(
//                                                 padding: const EdgeInsets.only(left: 12, right: 12),
//                                                 child: Text(
//                                                   "Awarded for completing Lesson 1 with exceptional focus and determination.",
//                                                   textAlign: TextAlign.center,
//                                                   style: TextStyle(
//                                                     fontSize: 13,
//                                                     fontWeight: FontWeight.w400,
//                                                     fontFamily: "Circular Std",
//                                                     letterSpacing: 13 * (-0.02),
//                                                     color: Colors.black,
//                                                     decoration: TextDecoration.none
//                                                   ),
//                                                 ),
//                                               ),
//                                             ),
//                                           )
//                                         ],
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             )
//                           ],
//                         ),
//                       )
//                     ],
//                   ),
//                 ),
//               ),
//               Positioned(
//                   bottom: 10,
//                   left: 10,
//                   right: 10,
//                   child: Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Expanded(
//                           child: AppButton(
//                             fontWeight: FontWeight.w500,
//                             letterSpacing: -2,
//                             textContent: 'Share',
//                             buttonWidth: 56,
//                             textColor: Colors.black,
//                             buttonColor: Color(0xffEBF1F5),
//                             borderColor: Color(0xffD6E0E7),
//                             borderWidth: 6,
//                             innerImage: 'assets/images/share.png',
//                             onPressed: () {
//                               print("HELLO");
//                             },
//                           ),
//                         ),
//                         SizedBox(width: 10,),
//                         Expanded(
//                           child: AppButton(
//                             fontWeight: FontWeight.w500,
//                             letterSpacing: -2,
//                             textContent: 'Continue',
//                             buttonWidth: 262,
//                             textColor: Colors.white,
//                             buttonColor: Colors.blue,
//                             borderColor: Color(0xff0061B5),
//                             borderWidth: 6,
//                             onPressed: () {
//                               print("HELLO");
//                             },
//                           ),
//                         ),
//                       ],
//                     ),
//                   ))
//             ],
//           ),
//         ),
     
     
//       ),
//     );
//   }
// }

