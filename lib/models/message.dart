class Message 
{
  final String text;
   var id;

  Message(this.text, this.id);

  factory Message.fromJson(jsonData)    // take the data in shape of map      from jsom takes the json data from database
  {
    return Message(jsonData["text"],jsonData["id"]);   // return the data (value) according to the feild (key)  
    // يبقي انا في الكونستراكتور دخلتله ماب اسمها جيسون داتا فيها كي و فاليو وهترجعلي الداتا بس في صورة فاليو بس من خلال الك اللي اسمه تيكست
  }
}