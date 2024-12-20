import 'package:flutter/material.dart';
import 'package:my_pocket_wallet/animated_success_message.dart';
import 'package:my_pocket_wallet/CustomFunc/custom_button.dart';

// SendMoneyPage widget for the Send Money screen.
class SendMoneyPage extends StatefulWidget {
  const SendMoneyPage({super.key});

  @override
  _SendMoneyPageState createState() => _SendMoneyPageState();
}

class _SendMoneyPageState extends State<SendMoneyPage> {
  final _formKey = GlobalKey<FormState>(); // GlobalKey for form state management
  String recipient = '';  // Store the recipient's details (name or number).
  double amount = 0.0;     // Store the amount to send.
  String paymentMethod = 'Bank Account'; // Store the selected payment method "Bank account is a default value to avoid null".
  bool isFavorite = false; //Boolean to store if transaction is marked as favorite
  bool _showSuccessMessage = false;  //Boolean to show success message animation

  // Function to confirm the transaction and navigate to confirmation page.
  void _confirmTransaction() {
    if (_formKey.currentState!.validate()) { // Validates every form field
    setState(() {
        _showSuccessMessage = true; // Show the success message
      });

      // Optionally navigate after showing the success message
        Future.delayed(const Duration(seconds: 2), () {
          setState(() {
            _showSuccessMessage = false; // Hide the success message
          });

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TransactionConfirmationPage(
              recipient: recipient,
              amount: amount,
              paymentMethod: paymentMethod,
              isFavorite: isFavorite,
            ),
          ),
        );
      });
    } else {
      // Show an error if any field is empty.
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all fields')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Send Money')),  // AppBar with page title.
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (_showSuccessMessage)
                  const AnimatedSuccessMessage(), // Display success message if true
                const SizedBox(height: 16),

                //Recipient input field
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Recipient',
                    hintText: 'Enter recipient\'s name',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter recipient\'s name';
                    }
                    return null;
                  },
                  onChanged: (value) => recipient = value,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Amount',
                    hintText: 'Enter amount',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || double.tryParse(value) == null || double.tryParse(value)! <= 0) {
                      return 'Please enter a positive number';
                    }
                    return null;
                  },
                  onChanged: (value) => amount = double.tryParse(value) ?? 0.0,
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  decoration: const InputDecoration(
                    labelText: 'Payment Method',
                    border: OutlineInputBorder(),
                  ),
                  value: paymentMethod,
                  onChanged: (value) {
                    setState(() {
                      paymentMethod = value!;
                    });
                  },
                  items: const [
                    DropdownMenuItem(value: 'Bank Account', child: Text('Bank Account')),
                    DropdownMenuItem(value: 'Mobile Wallet', child: Text('Mobile Wallet')),
                  ],
                ),
                const SizedBox(height: 16),
                SwitchListTile(
                  title: const Text('Mark as Favorite'),
                  value: isFavorite,
                  onChanged: (bool value) {
                    setState(() {
                      isFavorite = value;
                    });
                  },
                ),
                const SizedBox(height: 16),
                CustomButton(
                  text: "Proceed to confirm",
                  onPressed: _confirmTransaction,
                  color: const Color.fromARGB(255, 76, 33, 135),
                  textStyle: const TextStyle(fontSize: 16, color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// TransactionConfirmationPage widget for displaying and confirming the transaction details.
class TransactionConfirmationPage extends StatelessWidget {
  final String recipient;
  final double amount;
  final String paymentMethod;
  final bool isFavorite; //Boolean to receive the favorite status.

  // Constructor to receive the transaction details.
  const TransactionConfirmationPage({
    Key? key,
    required this.recipient,
    required this.amount,
    required this.paymentMethod,
    this.isFavorite = false, //initializing isFavorite variable
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Confirm Transaction')),  // AppBar with page title.
      body: Padding(
        padding: const EdgeInsets.all(16.0),  // Padding around the content.
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,  // Align content to the left.
          children: [
            const Text('Transaction Details', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),  // Heading text.
            const SizedBox(height: 16),  // Spacer between heading and content.
            Text('Recipient: $recipient'),  // Display recipient info.
            Text('Amount: \$${amount.toStringAsFixed(2)}'),  // Display amount with two decimals.
            Text('Payment Method: $paymentMethod'),  // Display selected payment method.
            Text('Favorite: ${isFavorite ? "Yes" : "No"}'), //A display if the transaction is marked as favourite or not.
            const SizedBox(height: 20),  // Spacer before buttons.

            // Confirm Button to process the transaction
            ElevatedButton(
              onPressed: () {
                // Process the transaction (e.g., send request to backend).
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Transaction Successful')),  // Success message.
                );
                Navigator.popUntil(context, (route) => route.isFirst);  // Navigate back to the Dashboard.
              },
              child: const Text('Confirm and Send'),  // Button text.
            ),
            const SizedBox(height: 10),  // Spacer between buttons.

            // Cancel Button to go back to the Send Money page
            TextButton(
              onPressed: () {
                Navigator.pop(context);  // Go back to the Send Money page.
              },
              child: const Text('Cancel'),  // Button text.
            ),
          ],
        ),
      ),
    );
  }
}
