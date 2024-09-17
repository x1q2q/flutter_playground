import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AnimatedBtn extends StatefulWidget {
  const AnimatedBtn({super.key});

  @override
  State<AnimatedBtn> createState() => _AnimatedBtnState();
}

class _AnimatedBtnState extends State<AnimatedBtn> {
  bool isTapped = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.redAccent,
          title: const Text('Selamat Datang'),
          systemOverlayStyle: SystemUiOverlayStyle.light
              .copyWith(systemNavigationBarColor: Colors.blueGrey[50]),
        ),
        body: SafeArea(
          child: Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              GestureDetector(
                onTapUp: (v) {
                  setState(() {
                    isTapped = false;
                  });
                },
                onTapDown: (v) {
                  setState(() {
                    isTapped = true;
                  });
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 500),
                  child: Container(
                    height: isTapped == false ? 60 : 55,
                    width: isTapped == false ? 90 : 85,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(12)),
                      color: Colors.yellow.shade300,
                      border: Border.all(color: Colors.black, width: 2),
                    ),
                    child: Center(
                      child: Text(
                        "Click",
                        style: TextStyle(
                          fontSize: isTapped == false ? 18 : 16,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          )),
        ));
  }
}
