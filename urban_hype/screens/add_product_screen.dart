import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

class AddProduct extends StatefulWidget {
  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  final _formKey = GlobalKey<FormState>();

  final _priceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();

   String _title = '';
   String _price = '';
   String _description = '';

  final _picker = ImagePicker();
  File _pickedImage;

  var _isLoading = false;
  var _uuid = Uuid();

  var _mySelection;


  void _addProduct() async {
    final _isValid = _formKey.currentState.validate();
    FocusScope.of(context).unfocus();

    if(!_isValid){
      return;
    }
    if(_pickedImage == null){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Select an Image first')));
      return;
    }

    _formKey.currentState.save();
    _isLoading = true;

    var _message = 'Product added successfully';
    try {
      final _ref = FirebaseStorage.instance.ref().child('productImages').child(_uuid.v1().toString());
      await _ref.putFile(_pickedImage);
      final _url = await _ref.getDownloadURL();

      await FirebaseFirestore.instance.collection('products').add({
        'category' : _mySelection,
        'productName': _title,
        'price': '₹'+_price,
        'productId': _uuid.v4().toString(),
        'description': _description,
        'imageUrl': _url
      });
    } catch(e){
      _message = e.toString();
    }

    setState(() {
      _isLoading = false;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(_message)));
    });
  }

  @override
  void dispose() {
    _descriptionFocusNode.dispose();
    _priceFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Product'),
      ),
      body: Container(
        padding: EdgeInsets.all(12.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(hintText: 'Title'),
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_priceFocusNode);
                  },
                  validator: (value){
                    if(value.trim().isEmpty){
                      return 'Please enter a Title';
                    }else{
                      return null;
                    }
                  },
                  onSaved: (value){
                    _title = value;
                  },

                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  focusNode: _priceFocusNode,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(hintText: 'Price'),
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_descriptionFocusNode);
                  },
                  validator: (value){
                    if(value.trim().isEmpty){
                      return 'Please enter a Price';
                    }else{
                      return null;
                    }
                  },
                  onSaved: (value){
                    _price = value;
                  },

                ),
                TextFormField(
                  textInputAction: TextInputAction.newline,
                  focusNode: _descriptionFocusNode,
                  maxLines: 3,
                  decoration: InputDecoration(hintText: 'Description'),
                  validator: (value){
                    if(value.trim().isEmpty){
                      return 'Please enter a Description';
                    }else{
                      return null;
                    }
                  },
                  onSaved: (value){
                    _description = value;
                  },

                ),
                SizedBox(
                  height: 10.0,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      width: 100.0,
                      height: 100.0,
                      decoration: BoxDecoration(
                        border: Border.all(width: 1),
                      ),
                      child: _pickedImage != null
                          ? Image(
                            image: FileImage(_pickedImage),
                          )
                          : null,
                    ),
                    SizedBox(width: 15.0,),
                    Column(
                      children: [
                        //ElevatedButton(onPressed: (){},child: Text('data'),),
                        Container(
                          width: 150.0,
                          //height: 30.0,
                          child: StreamBuilder(
                              stream: FirebaseFirestore.instance.collection('categories').snapshots(),
                              builder: (ctx, categoriesSnapshots){
                                if(!categoriesSnapshots.hasData){
                                  return Text('Loading...');
                                }
                                /*if(categoriesSnapshots.connectionState == ConnectionState.waiting){
                                  return CircularProgressIndicator();
                                }*/
                                return DropdownButtonFormField<String>(
                                  //hint: Text('Select Category'),
                                  decoration: InputDecoration(
                                    hintText: 'Select Category',
                                  ),
                                  items: categoriesSnapshots.data.docs.map<DropdownMenuItem<String>>((map) {
                                    return DropdownMenuItem<String>(
                                      value: map['category'],
                                      child: Text(
                                        map['category'],
                                      ),
                                    );
                                  }).toList(),
                                 validator: (value){
                                    if(value == null){
                                      return 'Please select a category';
                                    }
                                    return null;
                                 },
                                  onChanged: (value){
                                      _mySelection = value;
                                  },
                                );
                              }
                          ),
                        ),
                        SizedBox(height: 20.0,),
                        TextButton.icon(
                            onPressed: () {
                              showModalBottomSheet(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  context: context,
                                  builder: (_) {
                                    return Container(
                                      height: 100,
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          TextButton.icon(
                                              onPressed: () async {

                                                final _pickedImageFile =
                                                    await _picker.getImage(
                                                        source: ImageSource.camera,
                                                    imageQuality: 60,
                                                    );
                                                if (_pickedImageFile != null) {
                                                  _pickedImage =
                                                      File(_pickedImageFile.path);
                                                } else {
                                                  print('No image selected.');
                                                }
                                                setState(() {
                                                  Navigator.pop(context);
                                                });
                                              },
                                              icon: Icon(Icons.camera_alt_outlined),
                                              label: Text('Take an Image')),
                                          TextButton.icon(
                                              onPressed: () async {

                                                final _pickedImageFile =
                                                    await _picker.getImage(
                                                        source:
                                                            ImageSource.gallery,
                                                      imageQuality: 60,
                                                    );
                                                if (_pickedImageFile != null) {
                                                  _pickedImage =
                                                      File(_pickedImageFile.path);
                                                } else {
                                                  print('No image selected.');
                                                }
                                                setState(() {
                                                  Navigator.pop(context);
                                                });
                                              },
                                              icon: Icon(Icons.image),
                                              label: Text('Select from Gallery')),
                                        ],
                                      ),
                                    );
                                  });
                            },
                            icon: Icon(Icons.image),
                            label: Text('Add an Image')),

                      ],
                    ),
                  ],
                ),
                SizedBox(height: 20.0,),

                _isLoading ? CircularProgressIndicator() : ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: ElevatedButton(
                    child: Text('Add Product'),
                    onPressed: _addProduct,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
