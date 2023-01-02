// import 'dart:io';
//
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:saranya/PredictionPage.dart';
// import 'package:saranya/predtictClass.dart';
// import 'package:image/image.dart' as img;
// // import 'package:tflite_flutter_helper/tflite_flutter_helper.dart';
// // import 'package:logger/logger.dart';
//
// class ImagePickerPage extends StatefulWidget{
//   const ImagePickerPage({Key? key}):super(key:key);
//   @override
//   _ImagePickerPageState createState() => _ImagePickerPageState();
//
// }
//
// class _ImagePickerPageState extends State<ImagePickerPage> {
//   String selectedImagePath = '';
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(backgroundColor: Colors.deepPurple,
//         centerTitle: true,
//         title: const Text(
//           'Image Page', style: TextStyle(color: Colors.white),
//         ),
//       ),
//       backgroundColor: Colors.deepPurpleAccent.shade100,
//       body: Center(
//         child: Column(children: [
//           selectedImagePath == ''
//               ? Image.asset('assets/images/image_placeholder.jpg', height: 200,
//             width: 200,
//             fit: BoxFit.fill,)
//               : Image.file(File(selectedImagePath), width: 200,
//             height: 200,
//             fit: BoxFit.fill,),
//           const Text(
//             'Select Image',
//             style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
//           ),
//           const SizedBox(
//             height: 20.0,
//           ),
//           ElevatedButton(
//               style: ButtonStyle(
//                   backgroundColor: MaterialStateProperty.all(Colors.green),
//                   padding:
//                   MaterialStateProperty.all(const EdgeInsets.all(20)),
//                   textStyle: MaterialStateProperty.all(
//                       const TextStyle(fontSize: 14, color: Colors.white))),
//               onPressed: () async {
//                 selectImage();
//                 setState(() {});
//               },
//               child: const Text('Select')),
//           const SizedBox(height: 10),
//           /* ElevatedButton(
//             style: ButtonStyle(
//                 backgroundColor: MaterialStateProperty.all(Colors.green),
//                 padding:
//                 MaterialStateProperty.all(const EdgeInsets.all(20)),
//                 textStyle: MaterialStateProperty.all(
//                     const TextStyle(fontSize: 14, color: Colors.white))
//             ),
//             onPressed: () async {
//               Navigator.of(context).pushReplacement(
//                   MaterialPageRoute(builder: (context) => PredictionPage()));
//             },
//             child: const Text('predict'),
//           ),*/
//           //)
//         ],),
//       ),
//     );
//   }
//
//   Future selectImage() {
//     return showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return Dialog(
//             shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(20.0)), //this right here
//             child: SizedBox(
//               height: 150,
//               child: Padding(
//                 padding: const EdgeInsets.all(12.0),
//                 child: Column(
//                   children: [
//                     const Text(
//                       'Select Image From !',
//                       style: TextStyle(
//                           fontSize: 18.0, fontWeight: FontWeight.bold),
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                       children: [
//                         GestureDetector(
//                           onTap: () async {
//                             // selectedImagePath = await selectImageFromGallery();
//                             selectImageFromGallery();
//                             // print('Image_Path:-');
//                             // print(selectedImagePath);
//                             // if (selectedImagePath != '') {
//                             //   Navigator.pop(context);
//                             //   await Navigator.push(context,
//                             //       MaterialPageRoute(builder: (context) => PredictionPage()));
//                             //   /*Navigator.of(context)
//                             //       .push(MaterialPageRoute(builder: (_) =>
//                             //       PredictionPage(image: selectedImagePath)));*/
//                             //   setState(() {
//                             //     // _image = File(selectedImagePath!.path);
//                             //     // _imageWidget = Image.file(_image!);
//                             //     // _predict();
//                             //   });
//                             // } else {
//                             //   ScaffoldMessenger.of(context).showSnackBar(
//                             //       const SnackBar(
//                             //         content: Text("No Image Selected !"),
//                             //       ));
//                             // }
//                           },
//                           child: Card(
//                               elevation: 5,
//                               child: Padding(
//                                 padding: const EdgeInsets.all(8.0),
//                                 child: Column(
//                                   children: [
//                                     Image.asset(
//                                       'assets/images/gallery.jpg',
//                                       height: 60,
//                                       width: 60,
//                                     ),
//                                     const Text('Gallery'),
//                                   ],
//                                 ),
//                               )),
//                         ),
//                         GestureDetector(
//                           onTap: () async {
//                             // selectedImagePath = await selectImageFromCamera();
//                             selectImageFromCamera();
//                             // print('Image_Path:-');
//                             // print(selectedImagePath);
//
//                             // if (selectedImagePath != '') {
//                             //   // Navigator.pop(context);
//                             //   /*await Navigator.push(context,
//                             //       MaterialPageRoute(builder: (context) => PredictionPage()));*/
//                             //   /*Navigator.of(context)
//                             //       .push(MaterialPageRoute(builder: (_) =>
//                             //       PredictionPage(image: selectedImagePath)));*/
//                             //   setState(() {});
//                             // } else {
//                             //   ScaffoldMessenger.of(context).showSnackBar(
//                             //       const SnackBar(
//                             //         content: Text("No Image Captured !"),
//                             //       ));
//                             // }
//                           },
//                           child: Card(
//                               elevation: 5,
//                               child: Padding(
//                                 padding: const EdgeInsets.all(8.0),
//                                 child: Column(
//                                   children: [
//                                     Image.asset(
//                                       'assets/images/camera.jpg',
//                                       height: 60,
//                                       width: 60,
//                                     ),
//                                     const Text('Camera'),
//                                   ],
//                                 ),
//                               )),
//                         ),
//                       ],
//                     )
//                   ],
//                 ),
//               ),
//             ),
//           );
//         });
//   }
//   Future selectImageFromGallery() async {
//     XFile? file = await ImagePicker()
//         .pickImage(source: ImageSource.gallery, imageQuality: 10);
//     if (file != null) {
//       //   return file.path;
//       //   } else {
//       //     return '';
//       //   }
//       // }
//       selectedImagePath=file.path;
//       Navigator.of(context)
//           .push(MaterialPageRoute(builder: (_) => PredictionPage(image: file)));
//     }
//   }
//
//   Future selectImageFromCamera() async {
//     XFile? file = await ImagePicker()
//         .pickImage(source: ImageSource.camera, imageQuality: 10);
//     if (file != null) {
//       // return file.path;
//       // } else {
//       //   return '';
//       // }
//       selectedImagePath=file.path;
//       Navigator.of(context)
//           .push(MaterialPageRoute(builder: (_) => PredictionPage(image: (file))));
//     }
//   }
//
// }