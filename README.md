# BetterRest
Designed to help coffee drinkers get a good night’s sleep by asking them three questions. Feed them into Core ML to get a result telling us when they ought to go to bed.

## Model Training
I trained my model with a CSV file containing the following fields:

-> “wake”: when the user wants to wake up. This is expressed as the number of seconds from midnight, so 8am would be 8 hours multiplied by 60 multiplied by 60, giving 28800.
-> “estimatedSleep”: roughly how much sleep the user wants to have, stored as values from 4 through 12 in quarter increments.
-> “coffee”: roughly how many cups of coffee the user drinks per day.
