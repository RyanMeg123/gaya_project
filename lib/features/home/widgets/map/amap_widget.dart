import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:amap_flutter_map/amap_flutter_map.dart';
import 'package:amap_flutter_base/amap_flutter_base.dart';

class CustomAMapWidget extends StatefulWidget {
  final String iosKey;
  final String androidKey;
  final LatLng? initialLocation;
  final void Function(AMapController controller)? onMapCreated;
  final Set<Marker>? markers;
  final Set<Polyline>? polylines;

  const CustomAMapWidget({
    super.key,
    required this.iosKey,
    required this.androidKey,
    this.initialLocation,
    this.onMapCreated,
    this.markers,
    this.polylines,
  });

  @override
  State<CustomAMapWidget> createState() => _CustomAMapWidgetState();
}

class _CustomAMapWidgetState extends State<CustomAMapWidget> {
  AMapController? _mapController;

  @override
  Widget build(BuildContext context) {
    CameraPosition initialPosition = CameraPosition(
      target: widget.initialLocation ?? const LatLng(39.909187, 116.397451),
      zoom: 14.0,
    );

    return AMapWidget(
      initialCameraPosition: initialPosition,
      buildingsEnabled: false,
      onMapCreated: _onMapCreated,
      privacyStatement: const AMapPrivacyStatement(
        hasShow: true,
        hasAgree: true,
        hasContains: true,
      ),
      apiKey: AMapApiKey(
        iosKey: widget.iosKey,
        androidKey: widget.androidKey,
      ),
      markers: widget.markers ?? {},
      polylines: widget.polylines ?? {},
    );
  }

  void _onMapCreated(AMapController controller) {
    _mapController = controller;
    if (widget.onMapCreated != null) {
      widget.onMapCreated!(controller);
    }
  }

  @override
  void dispose() {
    super.dispose();
  }
}
