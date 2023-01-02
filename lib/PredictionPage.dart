
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite/tflite.dart';

import 'WikipediaExplorer.dart';

class PredictionPage extends StatefulWidget {
  const PredictionPage({Key? key,required this.image,required this.email}) : super(key: key);
  final XFile image;
  final String email;
  @override
  PredictionPageState createState() => PredictionPageState();
}

class PredictionPageState extends State<PredictionPage> {

  // late File _image;
  late List results;
  bool imageSelect = false;
  late String  name;

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
      widget.image;
      imageSelect = true;
      name=(results[0]['label']);
    });
  }
  @override
  Widget build(BuildContext context) {
    //name=results[0]['label'];
    return Scaffold(
      appBar: AppBar(
        title: const Text("Prediction Page"),
      ),
      body: ListView(
        children: [
          /*(imageSelect)?*/
          Container(
            margin: const EdgeInsets.all(10),
            child: Image.file(File(widget.image.path)),
          ),
          // ,Container(
          //   margin: const EdgeInsets.all(10),
          //   child: const Opacity(
          //     opacity: 0.8,
          //     child: Center(
          //       child: Text("No image selected"),
          //     ),
          //   ),
          // ),
          SingleChildScrollView(
            child: Column(
              children: (imageSelect) ? results.map((result) {
                return Card(
                  child: Container(
                    margin: EdgeInsets.all(6),
                    child: Column(
                      children: [
                        Text(
                          "${result['label']} - ${result['confidence']
                              .toStringAsFixed(2)}",

                          style: const TextStyle(color: Colors.redAccent,
                              fontSize: 20),

                        ),
                        IconButton(
                            onPressed: () async {
                              await  Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                    // Builder for the nextpage
                                    // class's constructor.
                                      builder: (context) => WikipediaExplorer(name:result['label'],email:widget.email,)));

                            },
                            icon: Icon(Icons.add_link)
                        )
                      ],
                    ),
                  ),
                );
              }).toList() : [],
            ),
          ),

          RawMaterialButton(
              fillColor: const Color(0xFFB388FF),
              elevation: 0.0,
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0)),
              onPressed: () async {
                // if(widget.image!=null)
                //   {
                imageClassification(File(widget.image.path));
                // }
              },
              child: const Text("Predict", style: TextStyle(color: Colors.white,
                fontSize: 18.0,))
          ),
         // name=results[0]['label'],
         //  ElevatedButton(
         //
         //      onPressed: () {
         //        // Navigator to the next page.
         //        Navigator.of(context).pushReplacement(
         //          MaterialPageRoute(
         //            // Builder for the nextpage
         //            // class's constructor.
         //              builder: (context) => WikipediaExplorer(name:name.toString())));
         //      },
         //      child: Text("wiki page"))
          // RichText(text: TextSpan(
          //     text:"To get more info!",
          //     style: TextStyle(
          //       color: Colors.white,
          //       fontSize: 22,
          //     ),
          //     children: [
          //       TextSpan(
          //           text:" Click Here!",
          //           style: TextStyle(
          //               color: Colors.indigo,
          //               fontSize: 22,
          //               fontWeight: FontWeight.bold
          //           ),
          //           recognizer: TapGestureRecognizer()..onTap=()=>Get.to(()=>WikipediaExplorer())
          //       )
          //     ]
          // ))
        ],
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: ()
      //     {
      //       imageClassification(File(widget.image.path));
      //     },
      //   tooltip: "Pick Image",
      //   child: const Icon(Icons.image),)
    );
  }
}