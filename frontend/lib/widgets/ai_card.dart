import 'package:flutter/material.dart';


class AiCard extends StatelessWidget {

  final String message;


  const AiCard({

    super.key,

    required this.message,

  });



  @override
  Widget build(BuildContext context) {


    return Container(

      width: double.infinity,

      padding: const EdgeInsets.all(20),


      decoration: BoxDecoration(


        borderRadius: BorderRadius.circular(25),


        gradient: const LinearGradient(

          colors: [

            Color(0xff42275a),

            Color(0xff734b6d),

          ],

          begin: Alignment.topLeft,

          end: Alignment.bottomRight,

        ),



        boxShadow: [

          BoxShadow(

            color: Colors.purpleAccent.withOpacity(0.35),

            blurRadius: 18,

            spreadRadius: 2,

          )

        ],


      ),



      child: Column(

        crossAxisAlignment: CrossAxisAlignment.start,


        children: [


          Row(

            children: [


              Container(

                padding: const EdgeInsets.all(12),


                decoration: BoxDecoration(

                  color: Colors.white.withOpacity(0.15),

                  shape: BoxShape.circle,

                ),


                child: const Icon(

                  Icons.smart_toy,

                  color: Colors.cyanAccent,

                  size: 30,

                ),

              ),



              const SizedBox(width: 15),



              const Text(

                "AI Smart Suggestion",

                style: TextStyle(

                  color: Colors.white,

                  fontSize: 18,

                  fontWeight: FontWeight.bold,

                ),

              ),

            ],

          ),



          const SizedBox(height: 18),



          Text(

            message,

            style: const TextStyle(

              color: Colors.white,

              fontSize: 16,

              height: 1.5,

            ),

          ),


        ],

      ),

    );

  }

}