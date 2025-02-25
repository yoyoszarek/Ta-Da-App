import 'package:flutter/material.dart';
// ignore: unused_import
import 'package:flutter_heatmap_calendar/flutter_heatmap_calendar.dart';
import 'package:myapp/components/my_drawer.dart';
import 'package:myapp/components/my_habit_tile.dart';
import 'package:myapp/components/my_heat_map.dart';
import 'package:myapp/database/habit_database.dart';
import 'package:myapp/models/habit.dart';
import 'package:myapp/util/habit_util.dart';
import 'package:provider/provider.dart';


class HomePage extends StatefulWidget{
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>{

  @override
  void initState(){
    //read existing happens on app start
    Provider.of<HabitDatabase>(context, listen:false).readHabits();

    super.initState();
  }

  //text controller
  final TextEditingController textController = TextEditingController();

  //create new habit
  void createNewHabit(){
    showDialog(context: context, 
    builder: (context) => AlertDialog(
      content: TextField(
        controller: textController,
        decoration: const InputDecoration(hintText: "Create a new habit"),
        ),
        actions: [
          //save
          MaterialButton(
            onPressed: (){
            //get the new habit name
            String newHabitName = textController.text;

            //save to db
            context.read<HabitDatabase>().addHabit(newHabitName);

            //pop box
            Navigator.pop(context);

            //clear controller
            textController.clear();
          },
          child: const Text('Save'),
          ),
          
          //cancel button
          MaterialButton(
            onPressed: (){
            //pop box
            Navigator.pop(context);

            //clear controller
            textController.clear();

          },
          child: const Text('Cancel'),
          )
        ],  
      ),
    );
  }

  //check habit on & off
  void checkHabitOnOff(bool? value, Habit habit){
    //update habit completion status

    //habit debug
      print("Toggling habit: ${habit.name}, New value: $value");
      
    if(value != null){
      context.read<HabitDatabase>().updateHabitCompletion(habit.id, value);
    }
  }

  // edit habit box
  void editHabitBox(Habit habit){
    //set the controller's text to the habit's current name
    textController.text = habit.name;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: TextField(
          controller: textController
        ),
        actions:[
          //save
          MaterialButton(
            onPressed: (){
            //get the new habit name
            String newHabitName = textController.text;

            //update to db
            context.read<HabitDatabase>()
            .updateHabitName(habit.id,newHabitName);

            //pop box
            Navigator.pop(context);

            //clear controller
            textController.clear();
          },
          child: const Text('Save'),
          ),
          
          //cancel button
          MaterialButton(
            onPressed: (){
            //pop box
            Navigator.pop(context);

            //clear controller
            textController.clear();

          },
          child: const Text('Cancel'),
          )
        ]
      ),
    );
  }

  //delete box
  void deleteHabitBox(Habit habit){
        showDialog(
      context: context,
      builder: (context) => AlertDialog(
       title: const Text("Are you sure you want to delete?"),
        actions:[
          //delete
          MaterialButton(
            onPressed: (){
          
            //update to db
            context.read<HabitDatabase>().deleteHabit(habit.id);

            //pop box
            Navigator.pop(context);

          },
          child: const Text('Delete'),
          ),
          
          //cancel button
          MaterialButton(
            onPressed: (){
            //pop box
            Navigator.pop(context);

          },
          child: const Text('Cancel'),
          )
        ]
      ),
    );
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      drawer: const MyDrawer(),
      floatingActionButton: FloatingActionButton(
        onPressed: createNewHabit,
        elevation: 0,
        backgroundColor: Theme.of(context).colorScheme.tertiary,
        child:const Icon(Icons.add), 
        ),
        body: ListView(
          children:[
            //H E A T M A P
            _buildHeatMap(),
            // H A B I T L I S T 
            _buildHabitList(),
          ] ,
        ),
      );
  }
  //build heat map
  Widget _buildHeatMap(){
    //habit database
    final habitDatabase = context.watch<HabitDatabase>();

    //current habits
    List<Habit>currentHabits = habitDatabase.currentHabits;

    //return heatmap UI
    return FutureBuilder<DateTime?>(
      future: habitDatabase.getFirstLaunchDate(),
      builder: (context,snapshot){
        //once the data is avail -> build
        if(snapshot.hasData){
          return MyHeatMap(
            startDate: snapshot.data!, 
            datasets: prepHeatMapDataset(currentHabits),
            );
        }

            //handle cases where no data is returned
            else{
              return Container();
        }
      },
      );
  }

  //build habit list
  Widget _buildHabitList(){
    //habit db
    final habitDatabase = context.watch<HabitDatabase>();

    //curent habits
    List<Habit>currentHabits = habitDatabase.currentHabits;

    //retuurn list of habits UI
    return ListView.builder(
      itemCount: currentHabits.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index){
        //get each infividual habit
        final habit = currentHabits[index];

        //check if the habut is comoleted today
        bool isCompletedToday = isHabitCompletedToday(habit.completedDays);

        //return habit title UI
        return MyHabitTile(
          text: habit.name, 
          isCompleted: isCompletedToday,
          onChanged: (value) => checkHabitOnOff(value, habit),
          editHabit: (context) => editHabitBox(habit),
          deleteHabit: (context) => deleteHabitBox(habit),
          );
        },
      );
  }
}