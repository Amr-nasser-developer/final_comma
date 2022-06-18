import 'dart:io';

import 'package:comma/modules/cubit/cubit.dart';
import 'package:comma/modules/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class ScanQrPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ScanQrPageState();
}

class _ScanQrPageState extends State<ScanQrPage> {
  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  void _onQRViewCreated(QRViewController controller) {
    setState(() => this.controller = controller);
    controller.scannedDataStream.listen((scanData) {
      setState(() => result = scanData);
    });
  }
  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    } else if (Platform.isIOS) {
      controller!.resumeCamera();
    }
  }

  void readQr() async {
    if (result != null) {
      controller!.pauseCamera();
      print(result!.code);
      print(result!.format.formatName);
      print(result!.format.name);
      print(result!.format.index);

    }
  }

  @override
  Widget build(BuildContext context) {
    readQr();
    return BlocProvider(create: (context)=> AppCubit(),
    child: BlocConsumer<AppCubit, AppStates>(
      listener: (context, state){
        if(state is SendAttendSuccess){
          Navigator.pop(context);
          controller!.dispose();
        }
      },
      builder: (context, state){
        if(result != null){
          AppCubit.get(context).sendQrCodeData(id: result!.code.toString());
        }
        return Scaffold(
          body: QRView(
            key: qrKey,
            onQRViewCreated: _onQRViewCreated,
            overlay: QrScannerOverlayShape(
              borderColor: Colors.orange,
              borderRadius: 10,
              borderLength: 30,
              borderWidth: 10,
              cutOutSize: 250,
            ),
          ),
        );
      },
    ),
    );
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}