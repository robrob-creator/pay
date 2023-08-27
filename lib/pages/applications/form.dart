import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:kyogojo_pay/models/request_model.dart';
import 'package:kyogojo_pay/providers/request_provider.dart';
import 'package:provider/provider.dart';

class CustomDialog extends HookWidget {
  const CustomDialog({Key? key, required this.data}) : super(key: key);
  final RequestModel data;

  @override
  Widget build(BuildContext context) {
    final _formKey = useState(GlobalKey<FormState>());
    final requestProvider = Provider.of<RequestProvider>(context);
    final field1Value = useState('');
    final field2Value = useState('');

    return Dialog(
      child: SizedBox(
        width: 300,
        child: Form(
          key: _formKey.value,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Payment Form",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
                TextFormField(
                  onChanged: (value) {
                    field1Value.value = value;
                  },
                  validator: (value) {
                    if (value?.isEmpty == true) {
                      return 'OR Number is required';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    labelText: 'OR Number',
                  ),
                ),
                TextFormField(
                  onChanged: (value) {
                    field2Value.value = value;
                  },
                  validator: (value) {
                    if (value?.isEmpty == true) {
                      return 'Amount is required';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    labelText: 'Amount',
                  ),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Color(0xFFB82832)),
                  ),
                  onPressed: () async {
                    if (_formKey.value.currentState?.validate() == true) {
                      // Perform actions with the form values
                      await requestProvider.paymentRequest({
                        "method": "cash",
                        "amount": int.parse(field2Value.value),
                        "orNumber": field1Value.value,
                        "remarks": "string",
                        "userId": "string",
                        "date": DateTime.now().toIso8601String()
                      }, data.id ?? '');
                      await requestProvider.getRequests({"status": "Approved"});
                      if (context.mounted) {
                        Navigator.of(context).pop(); // Close the dialog
                      }
                    }
                  },
                  child: const Text('Submit'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
