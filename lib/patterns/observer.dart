/*
- Observer Pattern -

The observer pattern is actually pretty simple.
There is an observable (subject) and observers classes.
An observable notifies its observers when a certain event has occurred inside of it.
Some data are passed along through the `notify` method of the observable.
And its observers receive that data through the `update` method.

This pattern has many ways to implement with different variations.
There is probably more better way to approach this but I think my implementation is still reasonable.
I also thought of the observers to have an ability to observe multiple observables but nah.
*/

import "../main.dart";

class Observable {
  final List<Observer> observers = [];
  
  void register(Observer observer) {
    observers.add(observer);
  }
  
  void unregister(Observer observer) {
    observers.remove(observer);
  }
  
  void _notify({dynamic data}) {
    for (var observer in observers) {
      observer.update(this, data);
    }
  }
}

abstract class Observer<T> {
  void update(T observable, dynamic data);
}

class Item {
  int userId;
  int id;
  String title;
  bool completed;
  
  Item.fromJSON(Map data) {
    userId = data["userId"];
    id = data["id"];
    title = data["title"];
    completed = data["completed"];
  }
  
  Map toJSON() {
    return {
      "userId": userId,
      "id": id,
      "title": title,
      "completed": completed
    };
  }
}

class ToDoList extends Observable {
  final String name;
  
  ToDoList(this.name);
  
  Future<Item> getItem(int id) async {
    final data = await HTTP.get("https://jsonplaceholder.typicode.com/todos");
    
    for (Map itemData in data) {
      final item = Item.fromJSON(itemData);
      if (item.id == id) return item;
    }
    
    return null;
  }
  
  Future<void> completeItem(int id) async {
    final item = await getItem(id);
    item.completed = true;
    
    await HTTP.put(
      "https://jsonplaceholder.typicode.com/todos",
      body: item.toJSON()
    );
    
    _notify(data: item);
  }
}

class ToDoListWatcher implements Observer<ToDoList> {
  @override
  void update(ToDoList observable, dynamic data) {
    print("New changes on ${observable.name}:\nAn item has been completed: ${data.title}");
  }
}
