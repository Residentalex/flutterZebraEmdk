import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_zebra_emdk/src/controllers/product_controller.dart';
import 'package:flutter_zebra_emdk/src/data/models/product_model.dart';
import 'package:flutter_zebra_emdk/src/utils/helpers/formarter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../routes/app_routes.dart';
import '../utils/helpers/cloud_helper_functions.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => new _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const EventChannel eventChannel =
      const EventChannel('samples.flutter.io/barcodereceived');
  String _barcodeRead = '';
  var controller = ProductController.instance;
  ProductModel product = ProductModel(name: '');

  @override
  void initState() {
    super.initState();
    eventChannel.receiveBroadcastStream().listen(_onEvent, onError: _onError);
  }

  void _onEvent(dynamic event) async {
    setState(() {
      _barcodeRead = event;
    });
  }

  void _onError(dynamic error) {
    setState(() {
      _barcodeRead = 'Barcode read: unknown.';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          leading: IconButton(
              onPressed: () => Get.toNamed(AppRoutes.login),
              icon: const Icon(Icons.settings)),
        ),
      ),
      body: Container(
        decoration: null,
        child: Padding(
          padding: const EdgeInsets.only(right: 24.0, left: 24),
          child: FutureBuilder(
              future: _barcodeRead.isEmpty
                  ? null
                  : controller.getProductByCode(code: _barcodeRead),
              builder: (_, snapshot) {
                if (_barcodeRead.isNotEmpty) {
                  final response =
                      TCloudHelperFunctions.checkSingleRecordState(snapshot);
                  if (response != null) return response;

                  product = snapshot.data! as ProductModel;
                }

                return Center(
                  child: new Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      new Text(
                        product.name!,
                        style: GoogleFonts.raleway(
                          textStyle: const TextStyle(
                              fontSize: 32, fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        _barcodeRead,
                        style: GoogleFonts.nunito(
                          textStyle: const TextStyle(
                              fontSize: 32, fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Text(
                        TFormarter.moneyToString(money: product.price),
                        style: GoogleFonts.nunito(
                          textStyle: const TextStyle(
                              fontSize: 60, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                );
              }),
        ),
      ),
    );
  }
}
