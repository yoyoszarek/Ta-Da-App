import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:myapp/models/app_settings.dart';
import 'package:myapp/models/habit.dart';
import 'package:path_provider/path_provider.dart';

class HabitDatabase extends ChangeNotifier{
  static late Isar isar;
  /*
  Set UP
  */
  //Initialize
  static Future<void> initialize() async{
    final dir = await getApplicationDocumentsDirectory();
    isar = await Isar.open([HabitSchema, AppSettingsSchema], 
    directory: dir.path,
    );
  }
  // save first date 
  Future<void>saveFirstLaunchDate() async{
    final existingSettings = await isar.appSettings.where().findFirst();
    if(existingSettings == null){
      final settings = AppSettings()..firstLaunchDate = DateTime.now();
      await isar.writeTxn(() => isar.appSettings.put(settings));
    }
  }
  //get first date
  Future<DateTime?> getFirstLaunchDate() async{
    final settings = await isar.appSettings.where().findFirstSync();
    return settings?.firstLaunchDate;
  }
  
  //NOT FUN OPERATIONS

  //list of habits
  final List<Habit> currentHabits = [];

  //C R E A T E - add a new habit
  Future<void>addHabit(String habitName) async{
    //create a new habit
    final newHabit = Habit()..name = habitName;

    //save to
    await isar.writeTxn(() => isar.habits.put(newHabit));

    //reread
    readHabits();
  }

  //R E A D - read saved habits from db
  Future<void> readHabits() async{
    //fetch all habits
    List<Habit> fetchedHabits = await isar.habits.where().findAll();
    //give to current habits
    currentHabits.clear();
    currentHabits.addAll(fetchedHabits);

    //update UI
    notifyListeners();
  }
 
  //UPDATE - check habit on and off
  Future<void>updateHabitCompletion(int id, bool isCompleted) async{
    final habit = await isar.habits.get(id);

    //update completion status
    if(habit != null){
      await isar.writeTxn(() async{
      if(isCompleted && !habit.completedDays.contains(DateTime.now())){
        //today
        final today = DateTime.now();

        //add current date
        habit.completedDays.add(
          DateTime(
            today.year,
            today.month,
            today.day,
          ),
        );
      }

      //if habit is NOT completed -> remove the date from list
      else{
        //remove the current date
        habit.completedDays.removeWhere(
          (date) => 
             date.year == DateTime.now().year && 
             date.month == DateTime.now().month &&
             date.day == DateTime.now().day,
      );
    }
      //save updated habits back to database
      await isar.habits.put(habit);
    });
    }
  //re-ready from db
  readHabits();
  }

  //U P D A T E - edit habit name
  Future<void> updateHabitName(int id, String newName) async{
    //find the specific habit
    final habit = await isar.habits.get(id);

    //update habit name
    if(habit != null){
      //update name
      await isar.writeTxn(() async{
        habit.name = newName;
        //save update
        await isar.habits.put(habit);
      });
     }
    //re-read
    readHabits();
  }

 //D E L E T E - delete habit
  Future<void> deleteHabit(int id) async{
    //perform the delete
    await isar.writeTxn(() async{
      await isar.habits.delete(id);
    });

  //re-read
  readHabits();
  }
}