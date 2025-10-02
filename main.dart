
import 'package:flutter/material.dart';

void main() {
  runApp(TikTokCoinsApp());
}

class TikTokCoinsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TikTok Coins Demo',
      theme: ThemeData(primarySwatch: Colors.pink),
      home: CoinRechargePage(),
    );
  }
}

class CoinRechargePage extends StatefulWidget {
  @override
  _CoinRechargePageState createState() => _CoinRechargePageState();
}

class _CoinRechargePageState extends State<CoinRechargePage> {
  String username = "";
  int? selectedCoins;
  bool processing = false;
  bool completed = false;

  final List<Map<String, dynamic>> coinPackages = [
    {"coins": 70, "price": 0.60},
    {"coins": 700, "price": 6.00},
    {"coins": 3500, "price": 30.00},
    {"coins": 17500, "price": 150.00},
    {"coins": 99999, "price": 857.13},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Recharge TikTok Coins")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Enter TikTok Username:"),
            TextField(
              onChanged: (value) => setState(() => username = value),
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "@username",
              ),
            ),
            SizedBox(height: 20),
            Text("Select Coin Package:"),
            Expanded(
              child: ListView.builder(
                itemCount: coinPackages.length,
                itemBuilder: (context, index) {
                  final pkg = coinPackages[index];
                  return ListTile(
                    title: Text("${pkg['coins']} Coins"),
                    subtitle: Text("\$${pkg['price']}"),
                    trailing: Radio<int>(
                      value: pkg['coins'],
                      groupValue: selectedCoins,
                      onChanged: (val) {
                        setState(() {
                          selectedCoins = val;
                        });
                      },
                    ),
                  );
                },
              ),
            ),
            if (!processing && !completed)
              ElevatedButton(
                onPressed: selectedCoins == null || username.isEmpty
                    ? null
                    : () {
                        setState(() {
                          processing = true;
                        });
                        Future.delayed(Duration(seconds: 2), () {
                          setState(() {
                            processing = false;
                            completed = true;
                          });
                        });
                      },
                child: Text("Recharge"),
              ),
            if (processing)
              Center(child: CircularProgressIndicator()),
            if (completed)
              AlertDialog(
                title: Text("Payment Completed ✅"),
                content: Text("You recharged $selectedCoins coins."),
                actions: [
                  TextButton(
                    onPressed: () {
                      setState(() {
                        completed = false;
                        username = "";
                        selectedCoins = null;
                      });
                    },
                    child: Text("Go Back"),
                  ),
                ],
              )
          ],
        ),
      ),
    );
  }
}
