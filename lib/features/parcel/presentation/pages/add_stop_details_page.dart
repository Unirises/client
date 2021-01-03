import 'dart:math';

import 'package:client/features/parcel/built_models/location.dart';
import 'package:client/features/parcel/models/Stop.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:google_map_location_picker/google_map_location_picker.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AddStopDetailsPage extends StatefulWidget {
  final LocationResult location;
  final Function(Stop) onSubmitFinished;
  final VoidCallback onCancelled;
  final bool isPickup;

  const AddStopDetailsPage({
    Key key,
    @required this.location,
    @required this.onSubmitFinished,
    this.onCancelled,
    this.isPickup,
  }) : super(key: key);

  @override
  _AddStopDetailsPageState createState() => _AddStopDetailsPageState();
}

class _AddStopDetailsPageState extends State<AddStopDetailsPage> {
  final _formKey = GlobalKey<FormState>();
  final _floorController = TextEditingController();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _weightController = TextEditingController();
  String typeOfParcel;

  @override
  void initState() {
    _floorController.text = '';
    _nameController.text = '';
    _phoneController.text = '';
    typeOfParcel = 'Documents';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.location.address),
        leading: CloseButton(
          onPressed: widget.onCancelled,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(bottom: 18.0),
        child: Column(
          children: [
            Expanded(
                child: GoogleMap(
              liteModeEnabled: true,
              initialCameraPosition:
                  CameraPosition(target: widget.location.latLng, zoom: 18),
              markers: {
                Marker(
                  markerId: MarkerId('point'),
                  position: widget.location.latLng,
                )
              },
            )),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _floorController,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter the floor and house number.';
                        }
                        return null;
                      },
                      onEditingComplete: () =>
                          FocusScope.of(context).nextFocus(),
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        labelText: 'Building, Floor and House number',
                        prefixIcon: const Icon(Icons.person_outline),
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: _nameController,
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter the contact name.';
                              }
                              return null;
                            },
                            onEditingComplete: () =>
                                FocusScope.of(context).nextFocus(),
                            keyboardType: TextInputType.name,
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                              labelText: 'Contact Name',
                              prefixIcon: const Icon(Icons.person_outline),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Expanded(
                          child: TextFormField(
                            controller: _phoneController,
                            validator: (value) {
                              final RegExp _phoneRegExp =
                                  RegExp(r'^(09|\+639)\d{9}$');

                              if (value.isEmpty) {
                                return 'Please enter the contact number.';
                              } else if (!_phoneRegExp.hasMatch(value)) {
                                return 'Please enter a valid phone number.';
                              }
                              return null;
                            },
                            onEditingComplete: () =>
                                FocusScope.of(context).nextFocus(),
                            keyboardType: TextInputType.phone,
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                              labelText: 'Contact Number',
                              hintText: '+639#########',
                              prefixIcon: const Icon(Icons.phone),
                            ),
                          ),
                        ),
                      ],
                    ),
                    (!widget.isPickup)
                        ? Column(
                            children: [
                              DropdownButton<String>(
                                value: typeOfParcel,
                                icon: Icon(Icons.arrow_downward),
                                iconSize: 24,
                                elevation: 16,
                                underline: Container(
                                  height: 2,
                                  color: Theme.of(context).primaryColor,
                                ),
                                isExpanded: true,
                                onChanged: (String newValue) {
                                  setState(() {
                                    typeOfParcel = newValue;
                                  });
                                },
                                items: <String>[
                                  'Documents',
                                  'Food',
                                  'Boxed Fragile Item',
                                  'Groceries',
                                  'Flowers'
                                ].map<DropdownMenuItem<String>>((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                              ),
                              TextFormField(
                                controller: _weightController,
                                validator: (value) {
                                  num parsedValue = num.tryParse(value);
                                  if (value.isEmpty) {
                                    return 'Please enter item weight.';
                                  } else if (!(parsedValue is num)) {
                                    return 'Please enter a numerical value.';
                                  } else if (parsedValue < 0 ||
                                      parsedValue > 1000) {
                                    return 'Please enter valid number';
                                  }
                                  return null;
                                },
                                onEditingComplete: () =>
                                    FocusScope.of(context).nextFocus(),
                                keyboardType: TextInputType.number,
                                textInputAction: TextInputAction.done,
                                decoration: InputDecoration(
                                  labelText: 'Item Weight (kg)',
                                  prefixIcon: const Icon(Icons.person_outline),
                                ),
                              ),
                            ],
                          )
                        : Container(),
                    Container(
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                        ),
                        child: RaisedButton(
                          onPressed: () {
                            if (_formKey.currentState.validate()) {
                              return widget.onSubmitFinished(Stop(
                                weight: num.tryParse(_weightController.text),
                                type: typeOfParcel,
                                address: widget.location.address,
                                houseDetails: _floorController.text,
                                name: _nameController.text,
                                phone: _phoneController.text,
                                location: Location(
                                  (b) => b
                                    ..lat = widget.location.latLng.latitude
                                    ..lng = widget.location.latLng.longitude,
                                ),
                                id: getRandomString(15),
                              ));
                            }
                          },
                          color: Theme.of(context).primaryColor,
                          textColor: Colors.white,
                          child: Text('Confirm'),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
Random _rnd = Random();

String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
    length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));
