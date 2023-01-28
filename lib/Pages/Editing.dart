import 'package:flutter/material.dart';
import 'package:sticky_notes_app/class/appbar.dart';
import 'package:sticky_notes_app/class/todo_class.dart';



class EditingView extends StatefulWidget {
  Todos? item;

  EditingView({ Key? key });

  @override
  _EditingViewState createState() => _EditingViewState();
}

class _EditingViewState extends State<EditingView> {
  late TextEditingController titleController;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(
        text: widget.item != null ? widget.item?.title : null
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: widget.item != null ? 'New task' : 'Edit task',),


      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
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
                  labelText: 'Editing Task',
                hintText: 'Edit your Task',

              ),
              onChanged: (value) => titleController.text = value,
            ),
            SizedBox(height: 14.0,),
            ElevatedButton(

              child: Text(
                'Submit',
                style: TextStyle(
                    color: Colors.black,
                ),
              ),

              onPressed: () => submit(),
            )
          ],
        ),
      ),
    );
  }

  void submit(){

    Navigator.of(context).pop(titleController.text);
  }


}