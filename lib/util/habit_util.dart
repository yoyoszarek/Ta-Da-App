//givem a habit list of completion days
// is the habit completed today

import 'package:myapp/models/habit.dart';

bool isHabitCompletedToday(List<DateTime>completedDays){
  final today = DateTime.now();
  return completedDays.any(
  (date) =>
  date.year == today.year &&
  date.month == today.month &&
  date.day == today.day,
  );
}

// prep heat map data set
Map<DateTime,int> prepHeatMapDataset(List<Habit>habits){
  Map<DateTime, int> dataset = {};

  for(var habit in habits){
    for(var date in habit.completedDays){
      //normalize date to avoid time mismatch
      final normalizedDate = DateTime(date.year,date.month,date.day);

      // if date exists, increment 
      if(dataset.containsKey(normalizedDate)){
        dataset[normalizedDate] = dataset[normalizedDate]! +1;
      }else{
        //else initialize w count of 1
        dataset[normalizedDate] = 1;
      }
    }
  }
  return dataset;
}