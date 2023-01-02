import 'dart:io';
import 'package:bird_detection/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite/tflite.dart';
import 'PredictionPage.dart';
import 'WikipediaExplorer.dart';
import 'background-image.dart';

class WelcomePage extends StatefulWidget {
  String email;
  WelcomePage({Key? key, required this.email}) : super(key: key);

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  String selectedImagePath = '';
  late  XFile image;
  late List results;
  bool imageSelect = false;
  late String  name;
  int i=0;

  // ignore: recursive_getters
  get email => email;
  @override
  void initState() {
    super.initState();
    loadModel();
  }

  Future loadModel() async {
    Tflite.close();
    String res;
    res = (await Tflite.loadModel(
        model: "img/finalmeta.tflite",
        labels: "img/Labels.txt"))!;
    print("Models loading status: $res");
  }

  Future imageClassification(File image) async {
    final List? recognitions = await Tflite.runModelOnImage(
      path: image.path,
      numResults: 3,
      threshold: 0.05,
      imageMean: 127.5,
      imageStd: 127.5,
    );
    setState(() {
      results = recognitions!;
      image=File(selectedImagePath);
      imageSelect = true;
      //name=(results[0]['label']);
      i=0;
    });
  }
  // void initState()
  // {
  //   super.initState();
  //   loadModel();
  // }
  // Future loadModel()
  // {
  //   TfL
  // }
  /*File? _image;
  Future getImage(ImageSource source) async{
    try {
      final  image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if(image == null) return;
      //final imageTemporary =File(image.path);
      final imagePermanent = await saveFilePermanently(image.path);
      setState(() {
        this._image = imagePermanent;
      });
    } on PlatformException catch(e){
      print('Failed to pick image: $e');
    }
  }
  Future<File> saveFilePermanently(String imagePath) async {
    final directory = await getApplicationDocumentsDirectory();
    final name = basename(imagePath);
    final image =File('${directory.path}/$name');

    return File(imagePath).copy(imagePath);
  }*/
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Stack(
    children:[
        BackgroundImage(
        image: 'img/p.jpg'
    ),

      Scaffold(
        // appBar: AppBar(
        //   title: const Text("Selection page"),
        // ),
      backgroundColor: Colors.white38,
      body: SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: 60),
          Container(
            width: w,
            margin: const EdgeInsets.only(left:20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "🦚Welcome🦚",
                  style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: Colors.white
                  ),
                ),
                Wrap(
                  children: [
                   // Text("          "),
                    Text(
                      "${widget.email}🦜",
                      style: TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.w500,
                          color: Colors.white70
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 30),

          selectedImagePath == ''
              ? CircleAvatar(
            backgroundImage: AssetImage('img/select.jpeg'),
            radius: 150,
          )
               :ClipRRect(
            borderRadius: BorderRadius.circular(70),
            child: Image.file(File(selectedImagePath),
                    width: 330,
                    fit: BoxFit.cover,),

          ),
          //CircleAvatar(
            // backgroundColor: Colors.blueGrey,
            // child:ClipOval(
            //       child: Image.file(File(selectedImagePath),
            //       height: 400,
            //       width: 400,
            //       fit: BoxFit.cover,)),
            //   radius:190),

          SizedBox(
            height: 20.0,
          ),
          RawMaterialButton(
              fillColor: Colors.orange,
              elevation: 50,
              splashColor: Colors.cyan,
              padding: const EdgeInsets.symmetric(vertical: 20.0,horizontal: 40),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
                onPressed: () async {
                setState(() {});
                selectImage();
                setState(() {});
                          },
              child: const Text("Upload image", style: TextStyle(color: Colors.white,
                fontSize: 20.0,fontWeight: FontWeight.w600))
          ),
          // ElevatedButton(
          //     style: ButtonStyle(
          //         backgroundColor: MaterialStateProperty.all(Colors.orangeAccent),
          //         padding:
          //         MaterialStateProperty.all(const EdgeInsets.all(20)),
          //         textStyle: MaterialStateProperty.all(
          //             const TextStyle(fontSize: 25, color: Colors.white))),
          //
          //     onPressed: () async {
          //       setState(() {});
          //       selectImage();
          //       //setState(() {});
          //     },
          //     child: const Text('Upload Image',
          //     style: TextStyle( fontWeight: FontWeight.w500,fontSize: 25,),)
          // ),
          const SizedBox(height: 10),

          RawMaterialButton(
              fillColor: const Color(0xFFB388FF),
              elevation: 0.0,
              splashColor: Colors.yellowAccent,

              padding: const EdgeInsets.symmetric(vertical: 20.0,horizontal: 30),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              onPressed: () async {
                // if(widget.image!=null)
                //   {
                //setState(() {});
                imageClassification(File(selectedImagePath));
                // }
              },
              child: const Text("Predict", style: TextStyle(color: Colors.white,
                fontSize: 18.0,fontWeight: FontWeight.w400))
          ),
          // name=results[0]['label'],
          SingleChildScrollView(
            child: Column(
              children: (imageSelect) ? results.map((result) {
                return Card(
                    shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(300.0)),
                elevation: 2,
                //color: Colors.pinkAccent,
                shadowColor: Colors.black,
                child: Padding(
                padding: const EdgeInsets.all(8.0),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      children: [
                        Text(
                          "${result['label']} - ${result['confidence']
                              .toStringAsFixed(2)}",

                          style: const TextStyle(color: Colors.redAccent,
                              fontSize: 15,fontWeight: FontWeight.w500),

                        ),
                        IconButton(
                            onPressed: () async {
                              await  Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                    // Builder for the nextpage
                                    // class's constructor.
                                      builder: (context) => WikipediaExplorer(name:result['label'],email:widget.email)));
                              i++;
                            },
                            icon: Icon(Icons.add_link)
                        )
                      ],
                    ),
                  ),
                ));
              }).toList() : [],
            ),
          ),
          // ElevatedButton(
          //
          //     onPressed: () {
          //       // Navigator to the next page.
          //       Navigator.of(context).pushReplacement(
          //           MaterialPageRoute(
          //             // Builder for the nextpage
          //             // class's constructor.
          //               builder: (context) => WikipediaExplorer(name:name.toString())));
          //     },
          //     child: Text("wiki page")),
          /*_image != null ? Image.file(_image!,
            width: 250,
            height: 250,
            fit: BoxFit.cover
          )
              : Image.network('https://picsum.photos/250?image=9'),*/
          // Container(
          //   width: w,
          //   height: h*0.3,
          //   decoration: BoxDecoration(
          //       image: DecorationImage(
          //           image: AssetImage(
          //               "img/p.jpg"
          //           ),
          //           fit: BoxFit.cover
          //       )
          //   ),
         //    child: Column(
         //      children: [
         //        SizedBox(height: h*0.15,),
         //        CircleAvatar(
         //          backgroundColor: Colors.white70,
         //          radius: 60,
         //          backgroundImage: AssetImage(
         //              "img/profile1.png"
         //          ),
         //        )
         //      ],
         //    ),
         // ),
          /*SizedBox(height: 20),
          CustomButton(
              title: 'pick from gallery',
              icon: Icons.image_outlined,
              onClick:() => getImage(ImageSource.gallery),
          ),
          CustomButton(
              title: 'pick from camera',
              icon: Icons.camera,
              onClick: () => getImage(ImageSource.camera)),*/
          SizedBox(height: 20),

          GestureDetector(
            onTap: (){
              AuthController.instance.logOut();
            },
            child: Container(
              width: w*0.4,
              height: h*0.07,
              decoration: BoxDecoration(
                color: Colors.cyanAccent,
                  borderRadius: BorderRadius.circular(30),
                  // image: DecorationImage(
                  //     image: AssetImage(
                  //         "img/P.jpeg"
                  //     ),
                  //     fit: BoxFit.cover
                  // )
              ),
              child: Center(
                child: Text(
                  "logout",
                  style:TextStyle(
                      fontSize:25,
                      fontWeight: FontWeight.bold,
                      color:Colors.black54
                  ),
                ),
              ),

            ),
            // child: Container(
            //     width: w*0.5,
            //     height: h*0.08,
            //     decoration: BoxDecoration(
            //         borderRadius: BorderRadius.circular(30),
            //         image: DecorationImage(
            //             image: AssetImage(
            //                 "img/loginbtn.png"
            //             ),
            //             fit: BoxFit.cover
            //         )
            //     ),
            //     child: Center(
            //       child: Text(
            //         "Sign out",
            //         style:TextStyle(
            //             fontSize:32,
            //             fontWeight: FontWeight.bold,
            //             color:Colors.white
            //         ),
            //       ),
            //     ),
            //   ),
          ),
          SizedBox(height: 40,)
        ],
      ),
      ),
        // floatingActionButton: FloatingActionButton(
        //   onPressed: pickImage,
        //   tooltip: "pick Image",
        //   child: const Icon(Icons.image),
        // ),
    )
    ],
    );
  }
  // Future pickImage()
  // async{
  //   final ImagePicker _picker =ImagePicker();
  // final XFile? pickedFile =await _picker.pickImage(
  //   source: ImageSource.gallery,
  // );
  // File image=File(pickedFile!.path);
  // }
  Future selectImage() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)), //this right here
            child: SizedBox(
              height: 170,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    const Text(
                      'Select Image From ',
                      style: TextStyle(
                        color: Colors.blueGrey,
                          fontSize: 18.0, fontWeight: FontWeight.bold),
                    ),
                    Wrap(
                      //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(

                          onTap: () async {
                            selectImageFromGallery();
                            Navigator.of(context, rootNavigator: true).pop();
                            // selectedImagePath = await selectImageFromGallery();


                            // print('Image_Path:-');
                            // print(selectedImagePath);
                            // if (selectedImagePath != '') {
                            //   Navigator.pop(context);
                            //   await Navigator.push(context,
                            //       MaterialPageRoute(builder: (context) => PredictionPage()));
                            //   /*Navigator.of(context)
                            //       .push(MaterialPageRoute(builder: (_) =>
                            //       PredictionPage(image: selectedImagePath)));*/
                            //   setState(() {
                            //     // _image = File(selectedImagePath!.path);
                            //     // _imageWidget = Image.file(_image!);
                            //     // _predict();
                            //   });
                            // } else {
                            //   ScaffoldMessenger.of(context).showSnackBar(
                            //       const SnackBar(
                            //         content: Text("No Image Selected !"),
                            //       ));
                            // }
                          },
                          child: Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0)),
                              elevation: 5,
                              color: Colors.pinkAccent,
                              shadowColor: Colors.yellowAccent,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: const [
                                  CircleAvatar(
                                    backgroundColor: Colors.white,
                                    radius: 31,
                                    child:  CircleAvatar(
                                      backgroundImage: AssetImage('img/gal.jpeg'),
                                      radius: 30,
                                    ),), //CircleAvata
                                    Text('Gallery',
                                      style: TextStyle(

                                          color: Colors.black87,
                                          fontWeight: FontWeight.w400),),
                                  ],
                                ),
                              )),
                          // child: Card(
                          //     elevation: 5,
                          //
                          //     shadowColor: Colors.deepPurpleAccent,
                          //     child: Padding(
                          //       padding: const EdgeInsets.all(8.0),
                          //       child: Column(
                          //         children: [
                          //           SizedBox(height: 0.10,),
                          //           Image.asset(
                          //             'img/gal.jpeg',
                          //             height: 60,
                          //             width: 60,
                          //           ),
                          //           const Text('Gallery'),
                          //         ],
                          //       ),
                          //     )
                          // ),
                        ),
                        SizedBox(width: 10),
                        GestureDetector(
                          onTap: () async {
                            // selectedImagePath = await selectImageFromCamera();
                            selectImageFromCamera();
                            Navigator.of(context, rootNavigator: true).pop();
                            // print('Image_Path:-');
                            // print(selectedImagePath);

                            // if (selectedImagePath != '') {
                            //   // Navigator.pop(context);
                            //   /*await Navigator.push(context,
                            //       MaterialPageRoute(builder: (context) => PredictionPage()));*/
                            //   /*Navigator.of(context)
                            //       .push(MaterialPageRoute(builder: (_) =>
                            //       PredictionPage(image: selectedImagePath)));*/
                            //   setState(() {});
                            // } else {
                            //   ScaffoldMessenger.of(context).showSnackBar(
                            //       const SnackBar(
                            //         content: Text("No Image Captured !"),
                            //       ));
                            // }
                          },
                          child: Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0)),
                              elevation: 5,
                              color: Colors.lightBlueAccent,
                              shadowColor: Colors.redAccent,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: const [
                                      CircleAvatar(
                                        backgroundImage: AssetImage('img/cam.jpeg'),
                                        radius: 31,
                                    ), //CircleAvata
                                    Text('Camera',
                                      style: TextStyle(

                                      color: Colors.black87,
                                      fontWeight: FontWeight.w400),),
                                  ],
                                ),
                              )),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }
  Future selectImageFromGallery() async {
    XFile? file = await ImagePicker()
        .pickImage(source: ImageSource.gallery, imageQuality: 10);
    if (file != null) {
      //   return file.path;
      //   } else {
      //     return '';
      //   }
      // }
      selectedImagePath=file.path;
      setState(() {});
      // ignore: use_build_context_synchronously
      // Navigator.of(context)
      //     .push(MaterialPageRoute(builder: (_) => PredictionPage(image: file,email:widget.email)));
    }
  }

  Future selectImageFromCamera() async {
    XFile? file = await ImagePicker()
        .pickImage(source: ImageSource.camera, imageQuality: 10);
    if (file != null) {
      // return file.path;
      // } else {
      //   return '';
      // }
      selectedImagePath=file.path;
      setState(() {});
      // ignore: use_build_context_synchronously
      // Navigator.of(context)
      //     .push(MaterialPageRoute(builder: (_) => PredictionPage(image: (file),email: email,)));
    }
  }

}
/*Widget CustomButton({
  required String title,
  required IconData icon,
  required VoidCallback onClick,
}) {
  return Container(
    width: 280,
    child: ElevatedButton(
      onPressed:onClick,
      child: Row(children: [
      Icon(icon),
        SizedBox(width: 20),
      Text(title),

    ],),),
  );*/

