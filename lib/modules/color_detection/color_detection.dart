import 'dart:io';
import 'package:google_ml_vision/google_ml_vision.dart';
import 'package:tflite/tflite.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ColorDetection extends StatefulWidget {
  @override
  State<ColorDetection> createState() => _ColorDetectionState();
}

class _ColorDetectionState extends State<ColorDetection> {
bool _hasRunModel=false;
late List<CameraDescription>cameras;
late CameraController? cameraController;
File? _image;
bool isCamInitialize = false;
List? _result;

//final _picker=ImagePicker();

// function for load model
  Future<dynamic> loadModel()async
  {
    await Tflite.loadModel(
        model:'asset/images/model_unquant.tflite',
        labels: 'asset/images/labels.txt');
  }
 @override
  void initState() {
    loadModel().then((value)=>_initializeCamera());
    super.initState();
  }
  @override
  void dispose() {
    Tflite.close();
    cameraController!.dispose();
    _hasRunModel=false;
    super.dispose();

  }

  Future<void> _initializeCamera() async {
    final cameras = await availableCameras();
    //final firstCamera = cameras.first;
    cameraController = CameraController(
        cameras[0],
        ResolutionPreset.high,
        enableAudio: false,
    );
    await cameraController!.initialize().then((value)
    {
      if(!mounted)
      {
        return;
      }
      setState(() {
        //isCamInitialize = true;
      });
    }).catchError((error)
    {
      print(error);
    });
    // to refresh widget

  }
// function to detect color
  void detectionColor(final File image)async
  {
  var result=await Tflite.runModelOnImage(
      path:image.path,
      numResults: 8,
      threshold: 0.6,
     imageMean: 127.5,
     imageStd: 127.5,
  );
  setState(() {
    _result=result;
    _hasRunModel=true;
  });
  }

void pickCameraImage()async
{
  final image = await cameraController!.takePicture();
  final visionImage = GoogleVisionImage.fromFilePath(image.path);
 // var image=await ImagePicker.pickImage(source: ImageSource.camera);
  if(image==null)return null;
  setState(() {
    _image=File(image.path);
  });
  detectionColor(_image!);
}
void pickGalleryImage()async
{
 // var image=await ImagePicker.pickImage(source: ImageSource.gallery);
//  if(image==null)return null;
  setState(() {
   // _image=File(image.path);
  });
  detectionColor(_image!);
}

  @override
  Widget build(BuildContext context) {
   if(cameraController!.value.isInitialized){
     return Scaffold(
      body:Stack(
        children: [
          CameraPreview(cameraController!),
          _hasRunModel?Column(
            children: [
              SizedBox(
                height: 300,
                width: MediaQuery.of(context).size.width,
                child: Image.file(_image!),
              ),
              Container(
                padding: const EdgeInsets.all(20),
                child: Text('${_result![0]['label']}',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.w500,
                  ),),
              ),
            ],
          ):
          Center(
            child: Text('Uncertainly color',style: TextStyle(
              fontSize: 17,
              color:Colors.white,
            )),
          ),
          selectionButton(),
        ],
      ),
    );}
   else{
     return const SizedBox();
   }
  }

  Widget selectionButton()=>SingleChildScrollView(
    child: Column(
      children: [
        selectionPhoto(pickCameraImage),
      ],
    ),
  );

  Widget selectionPhoto( final VoidCallback onTap)
  =>GestureDetector(
    onTap:onTap,
  );
}
