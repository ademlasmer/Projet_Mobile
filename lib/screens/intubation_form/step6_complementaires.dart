import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import '../../providers/intubation_provider.dart';
import '../../widgets/step_indicator.dart';
import '../../widgets/custom_button.dart';

class Step6Complementaires extends StatefulWidget {
  const Step6Complementaires({Key? key}) : super(key: key);

  @override
  _Step6ComplementairesState createState() => _Step6ComplementairesState();
}

class _Step6ComplementairesState extends State<Step6Complementaires> {
  final ImagePicker _picker = ImagePicker();
  String? _photoPath;
  String? _audioPath;

  Future<void> _takePhoto() async {
    final XFile? photo = await _picker.pickImage(source: ImageSource.camera);
    if (photo != null) {
      setState(() {
        _photoPath = photo.path;
      });
      final provider = Provider.of<IntubationProvider>(context, listen: false);
      if (provider.currentIntubation != null) {
        provider.updateIntubation(provider.currentIntubation!.copyWith(photosPath: photo.path));
      }
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Photo ajoutée avec succès !')));
    }
  }

  Future<void> _recordAudio() async {
    // Simulating audio recording for web compatibility
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Enregistrement en cours (Simulation)...')));
    await Future.delayed(const Duration(seconds: 2));
    final simulatedPath = 'audio_record_${DateTime.now().millisecondsSinceEpoch}.m4a';
    setState(() {
      _audioPath = simulatedPath;
    });
    final provider = Provider.of<IntubationProvider>(context, listen: false);
    if (provider.currentIntubation != null) {
      provider.updateIntubation(provider.currentIntubation!.copyWith(audioPath: simulatedPath));
    }
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Mémo vocal enregistré !')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Étape 6 : Complémentaires')),
      body: Column(
        children: [
          const StepIndicator(currentStep: 6),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16.0),
              children: [
                ElevatedButton.icon(
                  onPressed: _takePhoto,
                  icon: const Icon(Icons.camera_alt),
                  label: const Text('Ajouter une photo'),
                ),
                if (_photoPath != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text('Photo sélectionnée', style: TextStyle(color: Colors.green[300])),
                  ),
                const SizedBox(height: 16),
                ElevatedButton.icon(
                  onPressed: _recordAudio,
                  icon: const Icon(Icons.mic),
                  label: const Text('Ajouter un mémo vocal (Optionnel)'),
                ),
                if (_audioPath != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text('Audio enregistré', style: TextStyle(color: Colors.green[300])),
                  ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: CustomButton(
              text: 'Terminer',
              onPressed: () async {
                final provider = Provider.of<IntubationProvider>(context, listen: false);
                if (provider.currentIntubation != null) {
                  await provider.saveIntubation(provider.currentIntubation!);
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Intubation sauvegardée !')));
                    Navigator.popUntil(context, ModalRoute.withName('/dashboard'));
                  }
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
