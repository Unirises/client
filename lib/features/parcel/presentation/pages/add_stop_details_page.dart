import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fluttercontactpicker/fluttercontactpicker.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:place_picker/place_picker.dart';

import '../../built_models/built_stop.dart';
import '../../built_models/location.dart';

class AddStopDetailsPage extends StatefulWidget {
  final LocationResult location;
  final Function(BuiltStop) onSubmitFinished;
  final VoidCallback? onCancelled;
  final bool? isPickup;

  final BuiltStop? previousData;

  const AddStopDetailsPage({
    Key? key,
    required this.location,
    required this.onSubmitFinished,
    this.previousData,
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
  final _notesController = TextEditingController();
  final _itemPriceController = TextEditingController();

  String? _typeOfParcel;
  String? _id;
  bool _receiverWillShoulder = false;

  @override
  void initState() {
    if (widget.previousData != null) {
      _floorController.text = widget.previousData!.houseDetails ?? '';
      _nameController.text = widget.previousData!.name ?? '';
      _phoneController.text = widget.previousData!.phone ?? '';
      _id = widget.previousData!.id ?? getRandomString(15);
      _typeOfParcel = widget.previousData!.type ?? 'Documents';
      _weightController.text = widget.previousData!.weight == null
          ? ''
          : widget.previousData!.weight.toString();
      _notesController.text = widget.previousData!.specialNote ?? '';
      _itemPriceController.text = widget.previousData!.itemPrice.toString();
      _receiverWillShoulder =
          widget.previousData!.receiverWillShoulder ?? false;
    } else {
      _floorController.text = '';
      _nameController.text = '';
      _phoneController.text = '';
      _id = getRandomString(15);
      _typeOfParcel = 'Documents';
      _weightController.text = '';
      _itemPriceController.text = '0';
      _notesController.text = '';
      _receiverWillShoulder = false;
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.location.formattedAddress!),
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
                  CameraPosition(target: widget.location.latLng!, zoom: 18),
              markers: {
                Marker(
                  markerId: MarkerId('point'),
                  position: widget.location.latLng!,
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
                        if (value!.isEmpty) {
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
                        prefixIcon: const Icon(Icons.house),
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: _nameController,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter the name.';
                              }
                              return null;
                            },
                            onEditingComplete: () =>
                                FocusScope.of(context).nextFocus(),
                            keyboardType: TextInputType.name,
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                              labelText: 'Name',
                              prefixIcon: const Icon(Icons.person_outline),
                              suffixIcon: IconButton(
                                  icon: Icon(Icons.contacts),
                                  onPressed: () async {
                                    final PhoneContact contact =
                                        await FlutterContactPicker
                                            .pickPhoneContact();

                                    setState(() {
                                      _nameController.text =
                                          contact.fullName ?? 'No Name';
                                      _phoneController.text =
                                          contact.phoneNumber!.number ?? '';
                                    });
                                  }),
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

                              if (value!.isEmpty) {
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
                    (!widget.isPickup!)
                        ? Column(
                            children: [
                              DropdownButton<String>(
                                value: _typeOfParcel,
                                icon: Icon(Icons.arrow_downward),
                                iconSize: 24,
                                elevation: 16,
                                underline: Container(
                                  height: 2,
                                  color: Theme.of(context).primaryColor,
                                ),
                                isExpanded: true,
                                onChanged: (String? newValue) {
                                  if (mounted)
                                    setState(() {
                                      _typeOfParcel = newValue;
                                    });
                                },
                                items: <String>[
                                  'Documents',
                                  'Food',
                                  'Boxed Fragile Item',
                                  'Groceries',
                                  'Others'
                                ].map<DropdownMenuItem<String>>((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(
                                      value,
                                      style: TextStyle(fontSize: 18),
                                    ),
                                  );
                                }).toList(),
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: TextFormField(
                                      controller: _itemPriceController,
                                      validator: (value) {
                                        num? parsedValue = num.tryParse(value!);
                                        if (value.isEmpty) {
                                          return 'Please enter item price.';
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
                                        labelText: 'Item Price (Php)',
                                        prefixIcon: const Icon(Icons.money),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: TextFormField(
                                      controller: _weightController,
                                      validator: (value) {
                                        num? parsedValue = num.tryParse(value!);
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
                                        prefixIcon:
                                            const Icon(Icons.fitness_center),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              TextFormField(
                                controller: _notesController,
                                keyboardType: TextInputType.multiline,
                                minLines: 1,
                                maxLines: 3,
                                decoration: InputDecoration(
                                  labelText: 'Special Notes (Optional)',
                                  prefixIcon: const Icon(Icons.notes),
                                ),
                              ),
                              CheckboxListTile(
                                title: Text("Receiver will shoulder fees."),
                                value: _receiverWillShoulder,
                                onChanged: (newValue) {
                                  setState(() {
                                    _receiverWillShoulder = newValue!;
                                  });
                                },
                                controlAffinity: ListTileControlAffinity
                                    .leading, //  <-- leading Checkbox
                              )
                            ],
                          )
                        : Container(),
                    Container(
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                        ),
                        child: ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              return widget.onSubmitFinished(BuiltStop(
                                (b) => b
                                  ..weight =
                                      num.tryParse(_weightController.text)
                                  ..type = _typeOfParcel
                                  ..address = widget.location.formattedAddress
                                  ..houseDetails = _floorController.text
                                  ..name = _nameController.text
                                  ..phone = _phoneController.text
                                  ..specialNote = _notesController.text
                                  ..receiverWillShoulder = _receiverWillShoulder
                                  ..itemPrice =
                                      num.parse(_itemPriceController.text)
                                  ..location = Location(
                                    (b) => b
                                      ..lat = widget.location.latLng!.latitude
                                      ..lng = widget.location.latLng!.longitude,
                                  ).toBuilder()
                                  ..id = _id,
                              ));
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Theme.of(context).primaryColor,
                          ),
                          child: Text(
                            'Confirm',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
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
