import 'package:flutter/material.dart';
import 'package:se_project/features/customer/other-services/services-service.dart';
import 'package:se_project/populate_data_firestore.dart';
// import 'package:se_project/services/firestore_service.dart';

class BookingScreen extends StatefulWidget {
  final String serviceName;
  BookingScreen({required this.serviceName});

  @override
  _BookingScreenState createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  final _formKey = GlobalKey<FormState>();
  final OtherService otherService = OtherService();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController contactController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController detailsController = TextEditingController();

  void bookNow() async {
    if (_formKey.currentState!.validate()) {
      try {
        await otherService.bookService(
          serviceName: widget.serviceName,
          customerName: nameController.text.trim(),
          contact: contactController.text.trim(),
          date: dateController.text.trim(),
          additionalDetails: detailsController.text.trim(),
        );

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Booking Successful!")),
        );
        Navigator.pop(context); // Go back after booking
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Booking Failed! Try Again.")),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Book ${widget.serviceName}")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: nameController,
                decoration: InputDecoration(labelText: "Full Name"),
                validator: (value) => value!.isEmpty ? "Enter your name" : null,
              ),
              TextFormField(
                controller: contactController,
                decoration: InputDecoration(labelText: "Contact Number"),
                keyboardType: TextInputType.phone,
                validator: (value) => value!.isEmpty ? "Enter your contact" : null,
              ),
              TextFormField(
                controller: dateController,
                decoration: InputDecoration(labelText: "Booking Date"),
                validator: (value) => value!.isEmpty ? "Enter booking date" : null,
              ),
              TextFormField(
                controller: detailsController,
                decoration: InputDecoration(labelText: "Additional Details"),
                maxLines: 3,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: bookNow,
                child: Text("Book Now"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
