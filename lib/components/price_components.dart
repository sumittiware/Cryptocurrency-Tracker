import 'dart:convert';

import 'package:crypto_app/style/colors.dart';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class PriceComponent extends StatefulWidget {
  final double initialPrice;
  final double changes;
  final String coinId;

  const PriceComponent({
    super.key,
    required this.initialPrice,
    required this.coinId,
    required this.changes,
  });

  @override
  State<PriceComponent> createState() => _PriceComponentState();
}

class _PriceComponentState extends State<PriceComponent> {
  final _colorUtils = ColorUtils();
  late WebSocketChannel channel;
  late double lastPrice;
  late double currentPrice;

  @override
  void initState() {
    super.initState();
    lastPrice = widget.initialPrice;
    currentPrice = widget.initialPrice;
    channel = WebSocketChannel.connect(
      Uri.parse("wss://ws.coincap.io/prices?assets=${widget.coinId}"),
    );
  }

  @override
  void dispose() {
    channel.sink.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: channel.stream,
      builder: (context, snapshot) {
        late Widget child;

        if (snapshot.connectionState == ConnectionState.waiting ||
            snapshot.hasError) {
          child = Text(
            "\$ $lastPrice",
            style: _getHeadlingStyle(),
          );
        }
        lastPrice = currentPrice;
        if (snapshot.hasData) {
          final data = json.decode(snapshot.data);
          currentPrice = double.parse(data[widget.coinId]) ?? currentPrice;
        }
        child = Text(
          "\$ $currentPrice",
          style: _getHeadlingStyle(),
        );

        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: child,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "${(currentPrice - lastPrice) < 0 ? "" : "+"} ${(currentPrice - lastPrice).toStringAsPrecision(2)}",
                  style: _getChangeStyle(),
                ),
                Text(
                  " | ",
                  style: TextStyle(
                    color: _colorUtils.text3,
                    fontSize: 18,
                  ),
                ),
                Text(
                  "${widget.changes < 0 ? "-" : "+"} ${widget.changes.toStringAsPrecision(2)}",
                  style: _getChangeStyle(
                    restrictNeg: widget.changes < 0,
                    restrictPos: widget.changes > 0,
                  ),
                ),
              ],
            )
          ],
        );
      },
    );
  }

  _getHeadlingStyle() {
    return currentPrice >= lastPrice
        ? TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w700,
            color: Colors.green,
          )
        : TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w700,
            color: Colors.red,
          );
  }

  _getChangeStyle({
    bool restrictPos = false,
    bool restrictNeg = false,
  }) {
    if (restrictPos) {
      return TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: Colors.green,
      );
    }
    if (restrictNeg) {
      return TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: Colors.red,
      );
    }
    return currentPrice >= lastPrice
        ? TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.green,
          )
        : TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.red,
          );
  }
}
