import 'package:flutter/material.dart';
import 'package:my_apps/screens/location.dart';


class GroceryLoginScreen2 extends StatefulWidget {
  const GroceryLoginScreen2({super.key});

  @override
  State<GroceryLoginScreen2> createState() => _GroceryLoginScreen2State();
}

class _GroceryLoginScreen2State extends State<GroceryLoginScreen2> {
  final TextEditingController phoneController = TextEditingController(text: "+880");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back_ios),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              const SizedBox(height: 10),
              const Text('Enter your mobile number', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
              const SizedBox(height: 30),
              const Text('Mobile Number', style: TextStyle(fontSize: 14, color: Colors.grey)),
              const SizedBox(height: 10),
              Row(
                children: [
                  Image.asset('images/flag.png', width: 32, height: 22),
                  const SizedBox(width: 8),
                  Container(height: 24, width: 1, color: Colors.grey.shade300),
                  const SizedBox(width: 8),
                  Expanded(
                    child: TextField(
                      controller: phoneController,
                      keyboardType: TextInputType.phone,
                      decoration: const InputDecoration(
                        hintText: 'Enter mobile number',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  Container(
                    decoration: const BoxDecoration(
                      color: Colors.green,
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.arrow_forward, color: Colors.white),
                      onPressed: () {
                         Navigator.push(
                        context,
                       MaterialPageRoute(builder: (context) => const Location()),
  );
                        
                        
                      },
                    ),
                  ),
                ],
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}


  
