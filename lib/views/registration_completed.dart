import 'package:flutter/material.dart';

class RegistrationCompleted extends StatelessWidget {
  const RegistrationCompleted({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/RegistrazioneCompletata.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.8,
            child: Row(
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xff157DB3),
                    minimumSize:
                        Size(MediaQuery.of(context).size.width * 0.9, 50),
                  ),
                  onPressed: () => Navigator.of(context).pushNamed("/accedi"),
                  child: Text("Accedi"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
