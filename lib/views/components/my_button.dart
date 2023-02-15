import 'package:flutter/material.dart';
import 'package:service_center/utils/constants.dart';

class MyButton extends StatelessWidget {
  final onTap;
  final String buttonName;
  final bool isLoading;
  const MyButton({
    Key? key,
    this.onTap,
    required this.buttonName,
    this.isLoading = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          onTap();
        },
        child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: primaryColor,
              boxShadow: const [
                BoxShadow(
                  color: Color.fromARGB(255, 176, 173, 173),
                ),
              ],
            ),
            width: 400,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Text(buttonName,
                    style: const TextStyle(
                      color: backgroundColor,
                      fontSize: 20,
                    )),
              ),
            )),
      ),
    );
  }
}
