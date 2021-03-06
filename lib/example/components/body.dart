import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:http/http.dart' as http;

import 'package:plat/constants.dart';

class MapSample extends StatefulWidget {
  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  Completer<GoogleMapController> _controller = Completer();
  MapType _googleMapType = MapType.normal;
  int _mapType = 0;
  Set<Marker> _markers = Set();
  GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();

  @override
  void initState() {
    super.initState();
    _markers.add(
      Marker(
        markerId: MarkerId('myinitialPosition'),
        position: LatLng(37.382782, 127.1189054),
        infoWindow: InfoWindow(
          title: 'MyPosition,',
          snippet: 'Where am i?',
        ),
      ),
    );
  }

  CameraPosition _initialCameraPosition = CameraPosition(
    target: LatLng(37.382782, 127.1189054),
    zoom: 14,
  );

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  void _changeMapType() {
    setState(() {
      _mapType++;
      _mapType = _mapType % 4;

      switch (_mapType) {
        case 0:
          _googleMapType = MapType.normal;
          break;
        case 1:
          _googleMapType = MapType.satellite;
          break;
        case 2:
          _googleMapType = MapType.terrain;
          break;
        case 3:
          _googleMapType = MapType.hybrid;
          break;
      }
    });
  }

  void _searchPlaces(
    String locationName,
    double latitude,
    double longitude,
  ) async {
    setState(() {
      _markers.clear();
    });

    final String url =
        '$baseUrl?key=$API_KEY&location=$latitude,$longitude&radius=1000&language=ko&keywword=$locationName';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      if (data['status'] == 'OK') {
        GoogleMapController controller = await _controller.future;
        controller.animateCamera(CameraUpdate.newLatLng(
          LatLng(latitude, longitude),
        ));

        setState(() {
          final foundPlaces = data['results'];

          for (int i = 0; i < foundPlaces.length; i++) {
            _markers.add(
              Marker(
                markerId: MarkerId(foundPlaces[i]['id']),
                position: LatLng(
                  foundPlaces[i]['geometry']['location']['lat'],
                  foundPlaces[i]['geometry']['location']['lng'],
                ),
                infoWindow: InfoWindow(
                  title: foundPlaces[i]['name'],
                  snippet: foundPlaces[i]['vicinity'],
                ),
              ),
            );
          }
        });
      } else {
        print('fail to fetch');
      }
    }
  }

  void _submit() {
    if (!_fbKey.currentState!.validate()) {
      return;
    }

    _fbKey.currentState?.save();
    final inputValues = _fbKey.currentState?.value;
    final id = inputValues!['placeId'];
    print(id);

    final foundPlace = places.firstWhere(
      (place) => place['id'] == id,
      // orElse: () => null,
    );

    print(foundPlace['placeName']);

    _searchPlaces('${foundPlace['placeName']}', 37.498295, 127.026437);

    Navigator.of(context).pop();
  }

  void _gotoGangnam() {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15.0),
          topRight: Radius.circular(15.0),
        )),
        builder: (context) {
          return SingleChildScrollView(
              child: Container(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                    padding: const EdgeInsets.only(
                      top: 40,
                      right: 20,
                      left: 20,
                      bottom: 20,
                    ),
                    child: FormBuilder(
                      key: _fbKey,
                      child: Column(children: [
                        FormBuilderDropdown(
                          name: 'placeId',
                          hint: Text('?????? ????????? ?????????????'),
                          decoration: InputDecoration(
                            filled: true,
                            labelText: '??????',
                            border: OutlineInputBorder(),
                          ),
                          validator: FormBuilderValidators.required(
                              errorText: '?????? ????????? ???????????????!'),
                          items: places.map<DropdownMenuItem<String>>(
                            (place) {
                              return DropdownMenuItem<String>(
                                value: place['id'],
                                child: Text('${place['placeName']}'),
                              );
                            },
                          ).toList(),
                        )
                      ]),
                    )),
                MaterialButton(
                  onPressed: _submit,
                  child: Text('submit'),
                  color: Colors.indigo,
                  textColor: Colors.white,
                ),
                SizedBox(height: 20),
              ],
            ),
          ));
        });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          GoogleMap(
            mapType: _googleMapType,
            initialCameraPosition: _initialCameraPosition,
            onMapCreated: _onMapCreated,
            myLocationEnabled: true,
            markers: _markers,
          ),
          Container(
            alignment: Alignment.topRight,
            margin: EdgeInsets.only(
              top: 60,
              right: 10,
            ),
            child: Column(children: <Widget>[
              FloatingActionButton.extended(
                heroTag: "btn1",
                onPressed: _changeMapType,
                label: Text('$_googleMapType'),
                elevation: 8,
                backgroundColor: Colors.red[400],
              ),
              SizedBox(
                height: 10,
              ),
              FloatingActionButton.extended(
                heroTag: "btn2",
                onPressed: _gotoGangnam,
                label: Text('???????????? ???????'),
                elevation: 8,
                backgroundColor: Colors.blue[400],
              )
            ]),
          )
        ],
      ),
    );
  }
}
