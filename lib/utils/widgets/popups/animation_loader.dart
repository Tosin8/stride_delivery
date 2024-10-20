// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class BAnimationLoaderWidget extends StatelessWidget {
  BAnimationLoaderWidget({
    super.key,
    required this.animation,
    this.showAction = false,
    this.actionText,
    this.onActionPressed, required String text,
  });

     String text = 'Please wait...'; 
    final String animation; 
    final bool showAction; 
    final String? actionText; 
    final VoidCallback? onActionPressed;
  @override
  Widget build(BuildContext context) {

   
       
    return Center( 
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset(animation, width: MediaQuery.of(context).size.width * 0.8), 
          // display lottie animaiton
         // const SizedBox(height: BSizes.defaultSpace,), 
          Text(
            text,
             style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w400),
          textAlign: TextAlign.center, ), 
    
          // const SizedBox(
          //   height: BSizes.defaultSpace,), 
    
          showAction ?
           SizedBox(
            width: 250, 
          child: OutlinedButton(
            onPressed: onActionPressed,
             style: OutlinedButton.styleFrom(backgroundColor: Colors.black),
    
            child: Text(actionText!,
             style: Theme.of(context).textTheme.bodyMedium!.apply(color: Colors.white)
             ),
             )
           ): const SizedBox()
          
        ],
      ),
    );
  }
}
