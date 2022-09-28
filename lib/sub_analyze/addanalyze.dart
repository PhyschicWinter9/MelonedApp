import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:newmelonedv2/reuse/container.dart';
import 'package:newmelonedv2/reuse/hamburger.dart';
import 'package:newmelonedv2/reuse/sizedbox.dart';
import 'package:newmelonedv2/style/colortheme.dart';

import 'package:pytorch_lite/pigeon.dart';
import 'package:pytorch_lite/pytorch_lite.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'RunCameraModel.dart';

import '../reuse/bottombar.dart';
import '../style/textstyle.dart';

class AddAnalyze extends StatefulWidget {
  const AddAnalyze({Key? key}) : super(key: key);

  @override
  State<AddAnalyze> createState() => _AddAnalyzeState();
}

class _AddAnalyzeState extends State<AddAnalyze> {
  late ModelObjectDetection _objectModel;
  String? _imagePrediction;
  File? _image;
  List tempgrade = [0, 0, 0];
  bool showBoundingBox = false;

  final ImagePicker _picker = ImagePicker();
  bool objectDetection = false;
  List<ResultObjectDetection?> objDetect = [];

  @override
  void initState() {
    super.initState();
    loadModel();
  }

  loadModel() async {
    String pathObjectDetectionModel = "assets/models/best.torchscript";
    try {
      _objectModel = await PytorchLite.loadObjectDetectionModel(
          pathObjectDetectionModel, 3, 640, 640,
          labelPath: "assets/labels/labels.txt");
    } catch (e) {
      if (e is PlatformException) {
        print("only supported for android, Error is $e");
      } else {
        print("Error is $e");
      }
    }
  }

  Future<void> getImage(ImageSource src) async {
    try {
      final XFile? image = await _picker.pickImage(source: src);
      if (image == null) return;

      // await runObjectDetection(File(image.path));

      setState(() {
        _image = File(image.path);
        objDetect = [];
      });
    } on PlatformException catch (e) {
      print("Fail to Piick Image $e");
    }
  }

  Future runObjectDetection() async {
    objDetect = await _objectModel.getImagePrediction(
        await File(_image!.path).readAsBytes(),
        minimumScore: 0.6,
        IOUThershold: 0.3);
    objDetect.forEach((element) {
      // Count the number of elements in the image
      if (element?.classIndex == 0) {
        setState(() {
          tempgrade[0] += 1;
        });
      }
      if (element?.classIndex == 1) {
        setState(() {
          tempgrade[1] += 1;
        });
      }
      if (element?.classIndex == 2) {
        setState(() {
          tempgrade[2] += 1;
        });
      }

      // print({
      //   "score": element?.score,
      //   "className": element?.className,
      //   "class": element?.classIndex,
      //   "rect": {
      //     "left": element?.rect.left,
      //     "top": element?.rect.top,
      //     "width": element?.rect.width,
      //     "height": element?.rect.height,
      //     "right": element?.rect.right,
      //     "bottom": element?.rect.bottom,
      //   },
      // });
    });
    Navigator.pushNamed(
      context,
      '/afteranalyze',
      arguments: {
        '_objectModel': _objectModel.renderBoxesOnImage(_image!, objDetect),
        'temp': tempgrade
      },
    );
    tempgrade = [0, 0, 0];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('เพิ่มการวิเคราะห์'),
        actions: [
          IconButton(
            onPressed: () => {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => RunCameraModel()),
              ),
            },
            icon: Icon(Icons.switch_video_outlined),
          ),
        ],
      ),
      drawer: Hamburger(),
      body: BGContainer(
        child: Column(
          children: [
            _image != null
                ? Container(
                    height: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: Center(
                      child: Image.file(_image!),
                    ),
                  )
                : Container(
                    height: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: Center(
                        child: Text(
                      'Preview Image',
                      style: TextCustom.previewtext(),
                    )),
                  ),

            sizedBox.Boxh10(),
            ElevatedButton(
              onPressed: () => getImage(ImageSource.camera),
              child: Text('ถ่ายรูป', style: TextCustom.buttontext2()),
              style: ElevatedButton.styleFrom(
                elevation: 2,
                primary: ColorCustom.yellowcolor(),
                onPrimary: ColorCustom.lightyellowcolor(),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                minimumSize: Size(double.infinity, 20),
                padding: EdgeInsets.all(10),
              ),
            ),
            sizedBox.Boxh10(),
            ElevatedButton(
              onPressed: () => getImage(ImageSource.gallery),
              child: Text('เลือกจากแกลเลอรี่', style: TextCustom.buttontext2()),
              style: ElevatedButton.styleFrom(
                elevation: 2,
                primary: ColorCustom.yellowcolor(),
                onPrimary: ColorCustom.lightyellowcolor(),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                minimumSize: Size(double.infinity, 20),
                padding: EdgeInsets.all(10),
              ),
            ),
            sizedBox.Boxh10(),
            // ElevatedButton(
            //   onPressed: () {},
            //   child: Text('เปลี่ยนรูป', style: TextCustom.buttontext2()),
            //   style: ElevatedButton.styleFrom(
            //     elevation: 2,
            //     primary: ColorCustom.yellowcolor(),
            //     onPrimary: ColorCustom.lightyellowcolor(),
            //     shape: RoundedRectangleBorder(
            //       borderRadius: BorderRadius.circular(30),
            //     ),
            //     minimumSize: Size(double.infinity, 20),
            //     padding: EdgeInsets.all(10),
            //   ),
            // ),
            // sizedBox.Boxh10(),
            _image != null
                ? ElevatedButton(
                    onPressed: () {
                      setState(() {
                        runObjectDetection();
                      });
                    },
                    child: Text('วิเคราะห์', style: TextCustom.buttontext3()),
                    style: ElevatedButton.styleFrom(
                      elevation: 2,
                      primary: ColorCustom.mediumgreencolor(),
                      onPrimary: ColorCustom.lightgreencolor(),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      minimumSize: Size(double.infinity, 20),
                      padding: EdgeInsets.all(10),
                    ),
                  )
                : Text(""),
          ],
        ),
      ),
      bottomNavigationBar: BottomBar(),
    );
  }
}
