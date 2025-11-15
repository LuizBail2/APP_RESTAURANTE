import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class LocationPermissionScreen extends StatefulWidget {
  const LocationPermissionScreen({super.key});

  @override
  State<LocationPermissionScreen> createState() => _LocationPermissionScreenState();
}

class _LocationPermissionScreenState extends State<LocationPermissionScreen> {
  bool _isRequesting = false;
  String _message = 'Precisamos da sua localização para continuar.';

  Future<void> _requestPermission() async {
    setState(() {
      _isRequesting = true;
      _message = 'Solicitando permissão...';
    });


    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      setState(() {
        _message = 'Ative a localização nas configurações do dispositivo.';
        _isRequesting = false;
      });
      return;
    }


    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.deniedForever) {
      setState(() {
        _message = 'Permissão negada permanentemente. Vá até as configurações.';
        _isRequesting = false;
      });
      return;
    }

    if (permission == LocationPermission.always || permission == LocationPermission.whileInUse) {
      setState(() {
        _message = 'Permissão concedida ✅';
      });

      Future.delayed(const Duration(seconds: 1), () {
        Navigator.pushReplacementNamed(context, '/home');
      });
    } else {
      setState(() {
        _message = 'Permissão não concedida.';
        _isRequesting = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.location_on, size: 80, color: Colors.deepOrange),
              const SizedBox(height: 20),
              Text(
                _message,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: _isRequesting ? null : _requestPermission,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepOrange,
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                ),
                child: Text(
                  _isRequesting ? 'Aguarde...' : 'Permitir localização',
                  style: const TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
