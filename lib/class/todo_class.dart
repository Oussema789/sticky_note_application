class Todos{
  String title;
  bool completed;
  Todos({
   required this.title,
   required this.completed,

});

  Todos.fromMap(Map map):
      this.title = map['title'],
      this.completed = map['completed'];

  Map toMap(){
    return {
      'title': this.title,
      'completed': this.completed,

    };
  }




}