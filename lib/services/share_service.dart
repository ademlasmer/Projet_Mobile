import 'package:share_plus/share_plus.dart';
import 'dart:typed_data';

class ShareService {
  Future<void> shareFile(Uint8List fileData, String filename, String text) async {
    final xFile = XFile.fromData(fileData, name: filename, mimeType: 'application/pdf');
    await Share.shareXFiles([xFile], text: text);
  }
}
