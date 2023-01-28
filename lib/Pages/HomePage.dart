import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'dart:convert';
import 'dart:math';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sticky_notes_app/Pages/Editing.dart';
import 'package:sticky_notes_app/class/appbar.dart';
import 'package:sticky_notes_app/class/todo_class.dart';




class HomePage extends StatefulWidget {

  Todos? item;
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  List<Todos> list = <Todos>[];
  List<Color> colorList = [];
  late SharedPreferences sharedPreferences;

  late TextEditingController titleController;

  @override
  void initState() {
    super.initState();
    loadSharedPreferencesAndData();

    titleController = TextEditingController(
        text: widget.item != null ? widget.item?.title : null
    );
  }


  void dispose(){
    super.dispose();
    loadSharedPreferencesAndData();
  }

  void loadSharedPreferencesAndData() async {
    sharedPreferences = await SharedPreferences.getInstance();
    loadData();
  }



  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: MyAppBar(title:'Sticky Note'),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: (){
            _simpleDialog();
          },
        ),
        body: list.isEmpty ? emptyList() : buildListView()
    );
  }

  Widget emptyList(){
    return Center(
        child:  Lottie.asset("images/checklist.json"),
    );
  }

  Widget buildListView() {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      itemCount: list.length,
      itemBuilder: (BuildContext context,int index){
        return buildListTile(list[index], index);
      },

    );
  }



  Widget buildListTile(Todos item, int index){
    print(item.completed);
    Size size = MediaQuery.of(context).size;



    return InkWell(
      onLongPress: () => goToEditItemView(item),
      child: Container(

        margin: EdgeInsets.only(left: 10, top: 10, right: 10, bottom: 10),
        decoration:
        BoxDecoration(

          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10)
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
        ),

        child: Stack(
          children: [

            Container(
              child: Image.asset("images/stickynote.png",fit: BoxFit.fill,),
            ),
            Column(

              crossAxisAlignment: CrossAxisAlignment.end,
              children: [


                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,

                    children: [
                      IconButton(
                          onPressed: (){
                            removeItem(item);
                            setState(() {
                              buildListView();
                            });
                          },
                          icon: Icon(Icons.delete)
                      ),
                    ],
                  ),
                ),




                Expanded(
                  child: Center(



                    child: Text(item.title,
                      style: TextStyle(
                        color: item.completed ? Colors.black : Colors.black,
                        decoration: item.completed ? TextDecoration.lineThrough : null,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),



                  ),
                ),
                Expanded(
                  child: IconButton(
                    onPressed: (){
                      changeItemCompleteness(item);

                    },

                    icon: Icon(item.completed
                        ? Icons.check_box
                        : Icons.check_box_outline_blank,
                      key: Key('completed-icon-$index'),
                    ),
                  ),
                )





              ],
            ),
          ],
        ),


      ),
    );



  }

  static Color ColorGenerator(){

    return  Colors.primaries[ Random().nextInt(Colors.primaries.length)];


  }

  void goToNewItemView()  {
    Navigator.of(context).push(MaterialPageRoute(builder:
        (context) => EditingView()

    )).then((title){
      if(title != null) {
        addItem(Todos(title: title, completed: false));
      }
    });
  }

  void addItem(Todos item){
    setState(() {
      list.add(item);


    });
    saveData();
  }

  void changeItemCompleteness(Todos item){
    setState(() {
      item.completed = !item.completed;
    });
    saveData();
  }

  void goToEditItemView(item){
    Navigator.of(context).push(MaterialPageRoute(builder: (context){
      return EditingView();
    })).then((title){
      if(title != null) {
        editItem(item, title);
      }
    });
    saveData();
  }

  void editItem(Todos item ,String title){

    setState(() {
      item.title = title;
    });

    saveData();
  }

  void removeItem(Todos item){
    list.remove(item);
    saveData();
  }

  void loadData() {
    List<String>? listString = sharedPreferences.getStringList('list');
    if(listString != null){
      list = listString.map(
              (item) => Todos.fromMap(json.decode(item))
      ).toList();

    }
    setState((){});
  }

  void saveData(){
    List<String> stringList = list.map(
            (item) => json.encode(item.toMap()
        )).toList();
    sharedPreferences.setStringList('list', stringList);
  }

  _simpleDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: const Text('New TODO Task'),
          children: <Widget>[
            Center(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TextField(
                      controller: TextEditingController.fromValue(
                        TextEditingValue(
                            text: titleController.text,
                            selection: TextSelection(
                              baseOffset: titleController.text.length,
                              extentOffset: titleController.text.length,
                            )
                        ),
                      ),
                      textDirection: TextDirection.ltr,





                      decoration: InputDecoration(
                        labelText: 'Your Todo',
                        hintText: 'Enter Your Todo',

                      ),
                      onChanged: (value) => titleController.text = value,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ElevatedButton(

                            child: Text(
                              'Submit',
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ),

                            onPressed: (){
                              Todos _item = Todos(title: titleController.text, completed: false);
                              addItem(_item);
                              submit();
                            },
                          ),
                          ElevatedButton(

                            onPressed: () => Navigator.pop(context),
                            child: const Text('Cancel'),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        );
      },
    );
  }
  void submit(){
    titleController.clear();
    Navigator.pop(context);
  }

}