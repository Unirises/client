import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/book_cubit.dart';
import '../models/Payment.dart';

class PaymentSelectionButton extends StatelessWidget {
  const PaymentSelectionButton({
    Key key,
    this.typeOfPayment,
    this.icon,
    this.type,
  }) : super(key: key);

  final PaymentEnum typeOfPayment;
  final Widget icon;
  final String type;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookCubit, BookState>(
      builder: (context, state) {
        return Stack(
          children: [
            GestureDetector(
              onTap: () {
                context.bloc<BookCubit>().paymentChanged(typeOfPayment);
              },
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: state.payment.value == typeOfPayment
                              ? Colors.orange.withAlpha(75)
                              : Colors.white,
                          border: state.payment.value == typeOfPayment
                              ? Border.all(
                                  width: 2.0,
                                  color: Theme.of(context).primaryColor)
                              : null,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.25),
                              spreadRadius: 1,
                              blurRadius: 3,
                              offset: const Offset(0, 2),
                            ),
                          ],
                          borderRadius:
                              const BorderRadius.all(Radius.circular(5))),
                      width: double.infinity,
                      height: double.infinity,
                      child: Row(
                        children: [
                          Expanded(
                            child: icon,
                          ),
                          Expanded(
                            child: Text(type),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            state.payment.value == typeOfPayment
                ? Positioned(
                    top: -2.5,
                    right: -2.5,
                    child: Icon(
                      Icons.check_circle_rounded,
                      color: Theme.of(context).primaryColor,
                    ),
                  )
                : Container(),
          ],
        );
      },
    );
  }
}
