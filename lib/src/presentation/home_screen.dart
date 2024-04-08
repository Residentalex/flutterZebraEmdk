import 'dart:async';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_zebra_emdk/src/controllers/company_controller.dart';
import 'package:flutter_zebra_emdk/src/controllers/product_controller.dart';
import 'package:flutter_zebra_emdk/src/data/models/product_model.dart';
import 'package:flutter_zebra_emdk/src/utils/constants/image_string.dart';
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
  var companyController = CompanyController.instance;
  ProductModel product = ProductModel(name: '');

  bool showAppBar = false;

  @override
  void initState() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    Timer.periodic(Duration(seconds: 5), (timer) {
      setState(() {
        checkImage();
      });
    });
    super.initState();
    eventChannel.receiveBroadcastStream().listen(_onEvent, onError: _onError);
  }

  Future<String> checkImage() async {
    return '';
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

  void _startCountDown() {
    Timer.periodic(Duration(seconds: 5), (timer) {
      setState(() {
        _barcodeRead = '';
        timer.cancel();
      });
    });
  }

  void _startAppVisibleDown() {
    Timer.periodic(Duration(seconds: 5), (timer) {
      setState(() {
        showAppBar = false;
        timer.cancel();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onDoubleTap: () {
        setState(() {
          showAppBar = !showAppBar;
          _startAppVisibleDown();
        });
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: showAppBar
            ? PreferredSize(
                preferredSize: const Size.fromHeight(60),
                child: AppBar(
                  leading: IconButton(
                      onPressed: () => Get.toNamed(AppRoutes.login),
                      icon: const Icon(Icons.settings)),
                ),
              )
            : null,
        body: Container(
          decoration: null,
          child: Padding(
            padding: const EdgeInsets.only(right: 28.0, left: 28.0),
            child: FutureBuilder(
                future: _barcodeRead.isEmpty
                    ? checkImage()
                    : controller.getProductByCode(code: _barcodeRead),
                builder: (_, snapshot) {
                  if (_barcodeRead.isNotEmpty) {
                    final response =
                        TCloudHelperFunctions.checkSingleRecordState(snapshot);
                    if (response != null) return response;

                    product = snapshot.data! as ProductModel;
                    _startCountDown();
                  } else {
                    product = ProductModel(name: '');
                  }

                  return (product.name == '')
                      ? Obx(
                          () => companyController.imageUrl.value == ''
                              ? Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image(
                                        image: AssetImage(TImages.logoSoluweb),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Text("Cargando...")
                                    ],
                                  ),
                                )
                              : Image(
                                  image: NetworkImage(
                                      companyController.imageUrl.value)),
                        )
                      : Checker(product: product, barcodeRead: _barcodeRead);
                }),
          ),
        ),
      ),
    );
  }
}

class Checker extends StatelessWidget {
  const Checker({
    Key? key,
    required this.product,
    required String barcodeRead,
  })  : _barcodeRead = barcodeRead,
        super(key: key);

  final ProductModel product;
  final String _barcodeRead;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new Text(
            product.name!,
            style: GoogleFonts.raleway(
              textStyle: const TextStyle(
                fontSize: 42,
                fontWeight: FontWeight.bold,
              ),
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 40,
          ),
          Container(
            child: _barcodeRead.isEmpty || product.code == null
                ? null
                : Text(
                    TFormarter.moneyToString(
                        money: product.price, simbol: 'RD\$'),
                    style: GoogleFonts.nunito(
                      textStyle: const TextStyle(
                        fontSize: 72,
                        fontWeight: FontWeight.w700,
                        color: Colors.red,
                      ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
