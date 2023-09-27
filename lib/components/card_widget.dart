import 'package:flutter/material.dart';

class CardWidget extends StatefulWidget {
  final String title;
  double data;
  final Color color;
  final bool mini;

  CardWidget({
    super.key,
    required this.title,
    this.data = 0,
    this.color = Colors.orangeAccent,
    this.mini = false,
  });

  @override
  State<CardWidget> createState() => _CardState();
}

class _CardState extends State<CardWidget> {
  List<Icon> icons = [
    const Icon(Icons.wallet),
    const Icon(Icons.money),
    const Icon(Icons.attach_money)
  ];

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: widget.mini ? 110.0 : 150.0,
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0), color: widget.color),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.title,
                  style: const TextStyle(color: Colors.white, fontSize: 25),
                ),
                Text(
                  "\$${widget.data}",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            icons[0],
          ],
        ),
      ),
    );
  }
}
