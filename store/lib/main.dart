import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store/Model/FetchingDataModel.dart';
import 'package:store/provider.dart';



void main()async {



runApp(
    /// Providers are above [MyApp] instead of inside it, so that tests
    /// can use [MyApp] while mocking the providers
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) =>provider()),
      ],
      child: const MyApp(),
    ));
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home:MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {


  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".



  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
bool k=true;
  late provider vmProvider;late provider vmProvider1;
  int _counter = 0;
@override
  void initState() {

    super.initState();
  }
Future<void> _showMyDialog({context,required id,required title,required price,required image,required category,
  required description,required Function ontap}) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context,) {
      return AlertDialog(
        title: const Text('Update'),
        content: Container(height: 200,width: 200,
            child: Column(children: [
              TextField(controller:vmProvider1.titlecon,decoration: InputDecoration(hintText: title),),
              TextField(controller: vmProvider1.pricecon,
              decoration: InputDecoration(hintText:price),),
              TextField(controller: vmProvider1.descriptioncon,decoration: InputDecoration(hintText: description),),
              TextField(controller: vmProvider1.categorycon,decoration: InputDecoration(hintText: category),)],)
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('تاكيد'),
            onPressed: () {
              if(vmProvider1.titlecon.text.isNotEmpty){vmProvider1.title1=vmProvider1.titlecon.text;}else{vmProvider1.title1=title;}
            if(vmProvider1.pricecon.text.isNotEmpty){vmProvider1.price1=vmProvider1.pricecon.text;}else{print(price);
              vmProvider1.price1=price;}
            if(vmProvider1.descriptioncon.text.isNotEmpty){vmProvider1.description1=vmProvider1.descriptioncon.text;}else{
            vmProvider1.description1=description;}
            if(vmProvider1.categorycon.text.isNotEmpty){vmProvider1.category1=vmProvider1.categorycon.text;}else{
              vmProvider1.category1=category;}
              ontap();
              vmProvider1.titlecon.clear();vmProvider1.descriptioncon.clear();vmProvider1.pricecon.clear();vmProvider1.categorycon.clear();
            Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {vmProvider1 = Provider.of<provider>(context, listen: false);
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
          
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
          Container(height:MediaQuery.of(context).size.height-5,
            child: FutureBuilder<List<FetchingDataModel>>(future:vmProvider1.FetchingData1(), builder: (BuildContext context, AsyncSnapshot<List<FetchingDataModel>> snapshot) {
              if(snapshot.hasData){return Consumer<provider>(
                builder: (BuildContext context, provider value, Widget? child) {print(value.listfit.length); return GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisSpacing: 10.0,
                      mainAxisSpacing: 10.0,
                      crossAxisCount:2,
                    ),
                    itemCount: value.listfit.length,
                    itemBuilder: (BuildContext context, int index) {if(value.listfit.length>index){return Container(decoration:BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 10,
                          blurRadius: 10,
                          offset: Offset(5, 10), // changes position of shadow
                        ),
                      ],
                    ) ,height: 50,child:Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Stack(
                        children:[Center(
                          child: Column(mainAxisAlignment: MainAxisAlignment.center,children:[Image.network('${value.listfit[index].image}',height: 90,width: 90,fit: BoxFit.fill,)
                            ,Text(value.listfit[index].description.toString(), overflow: TextOverflow.ellipsis,
                              maxLines: 1,),Text(value.listfit[index].title.toString(), overflow: TextOverflow.ellipsis,
                              maxLines: 1,),Text('\$ ${value.listfit[index].price}'),Text(value.listfit[index].category.toString(), overflow: TextOverflow.ellipsis,
                              maxLines: 1,)],),
                        ),Positioned(left: 10,right: 10,bottom: 150,child: Container(width: 200,child: Row(children: [InkWell(onTap:(){
          
                        },child: InkWell(onTap:(){value.addData(context: context,title:value.listfit[index].title, price: '${value.listfit[index].price}', category:value.listfit[index].category, description:value.listfit[index].description, image:value.listfit[index].image);} ,child: Container(height: 50,width: 50,child: Center(child: Icon(Icons.add,size: 30,))))),Expanded(child: Container()),InkWell(onTap:(){value.deleteData(context: context,id:index+1,image:value.listfit[index].image );} ,child: Container(height: 50,width: 50,child: Center(child: Icon(Icons.remove,size:30,))))],)))
                          ,Positioned(left: 10,right: 10,bottom: 10,child: Container(width: 210,child: Row(children: [Expanded(flex: 5,child: Container()),InkWell(onTap:() async {
                            await _showMyDialog(ontap:(){
                              value.updateData(id:index+1, title:value.title1, price:value.price1, category:value.category1, description:value.description1, image: value.listfit[index].image);
                             } ,
                                context: context, title:value.listfit[index].title,price:'${value.listfit[index].price}',category: value.listfit[index].category,description:value.listfit[index].description, image:value.listfit[index].image, id: index+1);
                          } ,child: Container(width: 50,height: 50,child: Center(child: Icon(Icons.update))))],)))] ,
                      ),
                    ));}else{}
          
                    }
                );},
          
              );}else{return Container(height:50,width: 50,child: CircularProgressIndicator());}
          
            },),
          ),
              ]),
        )
      ),
// This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
