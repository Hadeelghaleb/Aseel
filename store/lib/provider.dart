

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;

import 'Model/FetchingDataModel.dart';
class provider extends ChangeNotifier{List<FetchingDataModel>listfit=[];
  late String title1='ggg';
late String price1='gg';
late String category1='gg';
late String description1='gg';
late String image1='gg';
bool b=true;
late dynamic id;bool k1=false;
TextEditingController titlecon=TextEditingController();
TextEditingController pricecon=TextEditingController();
TextEditingController descriptioncon=TextEditingController();
TextEditingController categorycon=TextEditingController();
   Future<List<FetchingDataModel>>FetchingData1() async {
if(listfit.isNotEmpty){return listfit;}else{ listfit=[];listfit.clear();
var fet=await http.get(Uri.parse('https://fakestoreapi.com/products'));
List<dynamic> fetdecode=jsonDecode(fet.body);
for(int y=0;y<fetdecode.length;y++){
  listfit.add(FetchingDataModel.fromJson(fetdecode[y]));
}}
    return listfit;
    notifyListeners();
  }
Future<void>addData({required context,required title,required price,required category,
required description,required image}) async {
var fet=await http.post(Uri.parse('https://fakestoreapi.com/products'),body:
{
  "title": "${title}",
  "price": "${price}",
  "category": "${category}",
  "description": "${description}",
  "image": "${image}"
});
var  fetdecode=jsonDecode(fet.body);
FetchingDataModel m=FetchingDataModel.fromJson(fetdecode);
if(title==m.title){
  listfit.add(FetchingDataModel
    (title:title,price:price,category:category,description:description,image:image,id:m.id));
  await _showMyDialog(context: context,title: 'Successfully added to the end of the list',ontap:(){});
}else{await _showMyDialog(context: context,title: 'Not added successfully',ontap:(){});}
  //listfit.add(FetchingDataModel.fromJson(fetdecode[y]));


notifyListeners();
}
Future<void>deleteData({required context,required id,required image}) async {var t;
     for(int y=0 ;y<listfit.length;++y){
       if(image.toString()==listfit[y].image.toString()){print(listfit[y].image);print(image);
         t=listfit[y].id;
       print('t');
         print(t);
         break;
       }else{}
      }

     if(t==null&&id<=20){b=true;
       t=id;
     }else{listfit.removeAt(id-1);
     await _showMyDialog(context: context,title: 'Deleted successfully',ontap:(){});
     b=false;
     }
if(b==true){var fet=await http.delete(Uri.parse('https://fakestoreapi.com/products/${t}'));
var  fetdecode=jsonDecode(fet.body);
FetchingDataModel m=FetchingDataModel.fromJson(fetdecode);
if(t==m.id||image==m.image){
  listfit.removeAt(id-1);
  await _showMyDialog(context: context,title: 'Deleted successfully',ontap:(){});
}else{await _showMyDialog(title: 'The deletion was not successful',ontap:(){});}
b=true;}else{}

  //listfit.add(FetchingDataModel.fromJson(fetdecode[y]));


  notifyListeners();
}
Future<void>updateData({required id,required title,required price,required category,
  required description,required image}) async {
  var fet=await http.put(Uri.parse('https://fakestoreapi.com/products/${id}'),body:
  {
    "title": "${title}",
    "price": "${price}",
    "category": "${category}",
    "description": "${description}",
    "image": "${image}"
  }
  );
  var  fetdecode=jsonDecode(fet.body);
  FetchingDataModel m=FetchingDataModel.fromJson(fetdecode);
  if(id==m.id||title==m.title){
    listfit.removeAt(id-1);
    listfit.insert(id-1,FetchingDataModel(title: title1,price: price1,category: category1,description: description1,image: image));
  }else{print('no');}
  //listfit.add(FetchingDataModel.fromJson(fetdecode[y]));


  notifyListeners();
}
}
Future<void> _showMyDialog({context,required title,required Function ontap}) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context,) {
      return AlertDialog(

        content: Container(height: 50,width: 50,
              child: Text(title)
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('تاكيد'),
            onPressed: () {

              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}