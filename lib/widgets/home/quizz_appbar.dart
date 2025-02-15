import 'package:flutter/material.dart';

PreferredSizeWidget quizzAppBar(BuildContext context, double progress, int life) {
  return PreferredSize(
    preferredSize: const Size.fromHeight(60),
    child: AppBar(
      scrolledUnderElevation: 0,
      backgroundColor: Colors.white,
      elevation: 0,
      automaticallyImplyLeading: false, 
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween, 
        children: [
     
          // IconButton(
          //   icon: Image.asset('assets/icons/x.png', width: 24, height: 24),
          //   onPressed: () => Navigator.pop(context),
          // ),

 
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: LinearProgressIndicator(
                  value: 0.4,
                  minHeight: 14,
                  backgroundColor: const Color(0xffE5E5E5),
                  borderRadius: BorderRadius.circular(12),
                  
                  valueColor: const AlwaysStoppedAnimation<Color>(Color(0xff0088FF)), 
                ),
              ),
            ),
          ),

     
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: const Color(0xffFFF0F2),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 6,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              children: [
                // Image.asset('assets/icons/heartIcon.png', width: 16, height: 16),
                const SizedBox(width: 4),
                Text(
                  life.toString(),
                  style: const TextStyle(
                    fontSize: 14,
                    fontFamily: 'Circular Std',
                    fontWeight: FontWeight.w700,
                    color: Color(0xffE52A47),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      centerTitle: true, 
    ),
  );
}