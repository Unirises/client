import 'package:client/core/client_bloc/client_bloc.dart';
import 'package:client/features/parcel/bloc/parcel_bloc.dart';
import 'package:client/features/parcel/presentation/pages/parcel_initial_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PabiliMainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ParcelBloc, ParcelState>(
      builder: (context, state) {
        if (state is ParcelLoadFailure) {
          return Center(
            child: Text(
                'There was a trouble processing parcel data. Please try again.'),
          );
        } else if (state is ParcelLoadSuccess) {
          return BlocBuilder<ClientBloc, ClientState>(
            builder: (context, clientState) {
              if (clientState is ClientLoaded) {
                if (clientState.client.status == 'idle') {
                  return ParcelInitialPage();
                } else if (clientState.client.status == 'requesting') {
                  // TODO: Show requesting
                  return Text('requesting');
                } else if (clientState.client.status == 'transit') {
                } else if (clientState.client.status == 'cancelled') {}
              }
              return Center(
                child: CircularProgressIndicator(),
              );
            },
          );
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
