import 'dart:io';
import 'package:flutter/material.dart';
//import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share_plus/share_plus.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:topline/Constants/colors.dart';

class PDFPreviewScreen extends StatefulWidget {
  final String pdfPath;
  final String orderName;

  const PDFPreviewScreen(this.pdfPath, this.orderName, {super.key});

  @override
  State<PDFPreviewScreen> createState() => _PDFPreviewScreenState();
}

class _PDFPreviewScreenState extends State<PDFPreviewScreen> {
  String? _localPDFPath;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _preparePDF();
    });
  }

  // Copy PDF to app sandbox for iOS and Android
  Future<void> _preparePDF() async {
    try {
      Directory appDir;
      if (Platform.isAndroid) {
        appDir = (await getExternalStorageDirectory())!;
      } else {
        appDir = await getApplicationDocumentsDirectory();
      }

      String fileName = path.basename(widget.pdfPath);
      String newPath = path.join(appDir.path, fileName);

      await File(widget.pdfPath).copy(newPath);

      setState(() {
        _localPDFPath = newPath;
      });
    } catch (e) {
      print("Error preparing PDF: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.topRight,
              colors: [
                secondaryPurple,
                primarylightPurple,
                secondarylightPurple,
                secondaryPurple,
              ],
            ),
          ),
        ),
        automaticallyImplyLeading: false,
        toolbarHeight: 80,
        backgroundColor: whitelightPurple,
        title: Row(
          children: [
            GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Center(
                  child: Icon(
                Icons.chevron_left_rounded,
                color: white,
                size: 0.06.sh,
              )),
            ),
            const SizedBox(width: 20),
            Text(
              'Your Report',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 0.02.sh,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
      body: _localPDFPath == null
          ? Center(
                      child: SizedBox(
                        width: 50,
                        height: 50,
                        child: Image.asset(
                          'assets/Loading.gif',
                          scale: 1.sp,
                        ),
                      ),
                    )
          : SfPdfViewer.file(File(_localPDFPath!)),
      floatingActionButton: FloatingActionButton(
        onPressed: _downloadOrSharePDF,
        backgroundColor: secondaryPurple,
        child: const Icon(Icons.download, color: Colors.white),
      ),
    );
  }

  // ------------------- DOWNLOAD / SHARE -------------------
  Future<void> _downloadOrSharePDF() async {
    if (_localPDFPath == null) return;

    if (Platform.isAndroid) {
      bool granted = await _requestPermission();
      if (!granted) {
        _showDialog("Storage permission denied", success: false);
        return;
      }

      try {
        Directory downloadsDir = (await getExternalStorageDirectory())!;
        String newPath = path.join(downloadsDir.path, "${widget.orderName}.pdf");
        await File(_localPDFPath!).copy(newPath);
        _showDownloadDialog();
      } catch (e) {
        print("Error saving PDF on Android: $e");
        _showDialog("Download failed", success: false);
      }
    } else if (Platform.isIOS) {
      // Share sheet on iOS
      try {
        await Share.shareXFiles([XFile(_localPDFPath!)],
            text: "Download your PDF: ${widget.orderName}");
      } catch (e) {
        print("Error sharing PDF on iOS: $e");
        _showDialog("Share failed", success: false);
      }
    }
  }

  Future<bool> _requestPermission() async {
    if (Platform.isAndroid) {
      if (await Permission.manageExternalStorage.isGranted) return true;
      PermissionStatus status =
          await Permission.manageExternalStorage.request();
      return status.isGranted;
    }
    return true; // iOS does not require permission
  }

  // ------------------- DIALOGS -------------------
  void _showDownloadDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const DownloadDialog(),
    );
  }

  void _showDialog(String message, {required bool success}) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(success ? Icons.done : Icons.close,
                color: success ? Colors.green : Colors.red, size: 60),
            const SizedBox(height: 10),
            Text(message),
          ],
        ),
      ),
    );

    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) Navigator.pop(context);
    });
  }
}

// ------------------- DOWNLOAD DIALOG -------------------
class DownloadDialog extends StatefulWidget {
  const DownloadDialog({super.key});

  @override
  State<DownloadDialog> createState() => _DownloadDialogState();
}

class _DownloadDialogState extends State<DownloadDialog> {
  bool _isDownloading = true;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) setState(() => _isDownloading = false);
      Future.delayed(const Duration(seconds: 2), () {
        if (mounted) Navigator.pop(context);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      content: SizedBox(
        height: 200,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _isDownloading
                ? Image.asset('assets/download.gif', width: 60, height: 60)
                : const Icon(Icons.done, color: Colors.green, size: 80),
            const SizedBox(height: 15),
            Text(
              _isDownloading ? "Downloading..." : "Download Successful!",
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
