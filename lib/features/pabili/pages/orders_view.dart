import 'package:flutter/material.dart';

import '../../../core/models/Request.dart';

class OrdersView extends StatelessWidget {
  final Request request;
  OrdersView(this.request);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Text(
                'Order Summary',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 26,
                  color: Colors.grey,
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return ListTile(
                    leading:
                        Text('${request.data['orders'][index]['quantity']}x'),
                    title: Text('${request.data['orders'][index]['name']}'),
                    subtitle: Text(
                        '${request.data['orders'][index]['size'] != '0g' ? 'Size: ' + request.data['orders'][index]['size'] : ''}'),
                    trailing: Text(
                        '${request.data['orders'][index]['quantity'] * request.data['orders'][index]['price']}'),
                  );
                },
                itemCount: request.data['orders'].length,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 16,
                top: 16,
              ),
              child: Text(
                'Payment Details',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 26,
                  color: Colors.grey,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Subtotal',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text('PHP ${request.data['subtotal'] ?? 0}')
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Delivery Fee',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text('PHP ${request.data['fee']}')
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                          'PHP ${request.data['fee'] + request.data['subtotal']}')
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }
}
