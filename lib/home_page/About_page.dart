import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffE20736),
        title: const Text(
          'About',
          style: TextStyle(
              fontSize: 22, fontWeight: FontWeight.w700, color: Colors.white),
        ),
      ),
      backgroundColor: Colors.white,
      body: const Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'About',
              style: TextStyle(fontSize: 29, fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: 30,
            ),
            SizedBox(
              width: 400,
              child: Text(
                  'After the state bifurcation, the state of Andhra Pradeshconsists of the 13 districts namely, Srikakulam, Vizianagaram, Visakhapatnam, East Godavari,West Godavari, Krishna, Guntur, Prakasam, SPS Nellore,Chittoor, Anantapur, Kurnool and YSR Kadapa with14 corporations and 96 municipalities & Nagar Panchayats.'),
            ),
            SizedBox(
              height: 10,
            ),
            SizedBox(
              width: 400,
              child: Text(
                  'The Directorate of Municipal Administration (DMA) is the apex authority of Municipal Administration Department of Government of Andhra Pradesh (GoAP), which provides guidance to Municipal Corporations and Municipalities in performing their day to day activities in adherence to the policies, procedures and guidelines provided by Municipal Administration and Urban Development Department to achieve effective civic administration. The Directorate is headed by the Director of Municipal Administration(DMA).'),
            )
          ],
        ),
      ),
    );
  }
}
