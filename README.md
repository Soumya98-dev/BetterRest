# BetterRest
Designed to help coffee drinkers get a good night’s sleep by asking them three questions. Feed them into Core ML to get a result telling us when they ought to go to bed.

## Model Training
I trained my model with a CSV file containing the following fields:

Parameters
1. wake: The desired wake-up time for the user, expressed as the number of seconds from midnight. For example, 8:00 AM would be calculated as 8 hours * 60 minutes * 60 seconds = 28800.

2. estimatedSleep: The approximate amount of sleep the user wants to have. This value is represented in quarter-hour increments, ranging from 4 to 12 hours.

3. coffee: The approximate number of cups of coffee the user consumes per day.

![image](https://github.com/user-attachments/assets/4a16c44d-3d9c-47f6-a5dd-c8740d5c1856)
