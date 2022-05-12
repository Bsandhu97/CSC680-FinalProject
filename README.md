# CSC680-FinalProject - Exercise Tracker App
- Introduction:

When i was asked to think of a app i thought that could be improved i immeditaly thought of Google's and Samsungs health app. As their apps can be annoying to use as someone that just wants to log in their exercises, calorie intake, sleep schedule, etc. Since to log in values for each of those tables, we have to go through so many screens and it can be tedious at times. The overall desgin of the apps seems to be based on smartwatches and phones, where they would draw in data from them on when you are exercising, moving, sleeping, etc, and then calucalte the values for the tables. This is something i didnt like, as my smartwatch wasnt always accurate on when i was working out, or it would log in false data that i would need to delete or change. 

So with this in mind, i wanted to create a app that is for a user to log in data and view data easier and with less hassle. A more bare bones app, with less frills like recommended sleep cycle or reminders to workout. 

- Must Have Features:
    - Workouts:
    
         User can add workouts, delete workouts, and mark them as done. They can add workouts thru the button in the top right of the screen, a pop up would then be            shown asking for title of the workout. To delete, the user would need to swipe the workout to delete to the left. To mark the workout as done, the user would          just need to tap on the workout. 
         
    - Daily Calories: 

         User can enter their daily calories. They can save their daily calories by pressing the enter button the right of the text field. The daily calorie amount              entered would be saved and shown to the user at the bottom of the text field
       
    - Calorie Calculator: 
    
         User can input their height, weight, and age to find how much calories they would need to eat just to maintain their current weight. 
         Their daily calorie needs would be displayed at the bottom of all the text fields.
         If the user fails to fill any of the text fields (other than the inches text field), the calcultor will produce a error to the user with a correction message
         
     - CoreData / Persistence: 
        
         Used to save all changes made by the user to the app. To make sure that the workout list is persistince and can reload all the data entered or changed even            when the app has been closed. Also to make sure that the daily calories entered are saved and can be reloaded even when the app has been closed. 
    

- Would Like to Have Features:
    - Daily Calorie Tables: 
        
        Show the daily calories entries in a table format in a seperate page via a button labled Calorie Data. User can then view and delete entries. 
 
 
- Feature Implemented:

   Workouts, Daily Calories, Calorie Calculator, CoreData, and Daily Calorie Tables
   
   
- Screens:
  - Main Page:
  
  <img width="356" alt="Screen Shot 2022-05-12 at 1 30 14 AM" src="https://user-images.githubusercontent.com/78628964/168028518-a7fc0765-9d5d-49f6-926f-4f7a4bc193e2.png">

  - Workouts Lists:
  
  <img width="356" alt="Screen Shot 2022-05-12 at 1 33 44 AM" src="https://user-images.githubusercontent.com/78628964/168028340-b390cbdd-9d57-4f78-b5b1-e0d9fd211964.png">

  - Workouts List Popup:
  
  <img width="356" alt="Screen Shot 2022-05-12 at 1 33 49 AM" src="https://user-images.githubusercontent.com/78628964/168028629-28d9140a-cabe-4441-ac4a-1f9a00e5e539.png">

- Calories Page:

  <img width="356" alt="Screen Shot 2022-05-12 at 1 30 57 AM" src="https://user-images.githubusercontent.com/78628964/168028728-7037026f-688d-42c1-911c-c2148561f858.png">

- Daily Calories Table:

  <img width="356" alt="Screen Shot 2022-05-12 at 1 31 05 AM" src="https://user-images.githubusercontent.com/78628964/168028807-54c918e8-1c13-4776-b7f6-5f079b198c43.png">


