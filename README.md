# Notes App
![note-logo]



## About The Project


Notes App is a simple and elegant notes app built using Flutter, a powerful cross-platform app development framework. This app allows users to add, modify, and remove notes with ease, and provides a rich set of features for managing and organizing notes. One of the key features of this app is the use of provider state management technique, which allows for efficient state management and data synchronization across different parts of the app.

Features

•	Add, Modify, and Remove Notes: Users can add new notes, modify existing notes, and remove notes either by clicking the bin icon on the right of each note or by swiping from right to left on a note.

•	Search Functionality: The app provides a search function that allows users to search through their notes based on keywords or tags, making it easy to find specific notes.

•	Pull to Refresh: Users can refresh the list of notes by performing a swipe from top to bottom (pull to refresh) gesture. This updates the notes list and displays all the notes, in case the user wants to view all the notes and not just the searched notes.

•	Customizable Colors: Users can customize the background color of the app as well as the color of the notes. This allows users to personalize the app and make it visually appealing.

•	Persistent Data Storage: The app uses shared_preferences library from pub.dev to save the notes and colors state, ensuring that the notes and colors are persisted even after restarting or exiting the app.

•	Color Picker: The app uses flutter_colorpicker library to provide a rich and intuitive color picker interface for users to choose their preferred background color and notes color.

Implementation

The app uses a TaskProvider class which extends ChangeNotifier for managing the state of notes and colors. The TaskProvider class is responsible for adding, modifying, and removing notes, as well as managing the background color and notes color. It also uses shared_preferences library to save and load notes and colors state from shared preferences.
The HomePage widget is the main screen of the app, and it uses the TaskProvider to access the notes and colors state. It displays the list of notes, provides search functionality, and allows users to customize the background color and notes color. The HomePage widget also provides a pull to refresh gesture to update the notes list.

Usage
To use the Notes App, follow these steps:
1.	Clone the repository from GitHub: git clone <repository-url>
2.	Open the app in Flutter editor of your choice (e.g., Android Studio, VSCode)
3.	Run the app on an emulator or physical device
4.	Add, modify, and remove notes using the provided UI controls
5.	Customize the background color and notes color using the color picker
6.	Search for notes using the search bar
7.	Swipe from top to bottom to refresh the notes list
      Conclusion
      My Notes App is a powerful and feature-rich notes app built using Flutter and provider state management technique. It provides a seamless and intuitive user experience for managing notes, and offers customization options for background color and notes color. The use of shared_preferences library ensures that the notes and colors state are persisted even after restarting or exiting the app. Try it out and organize your notes in style!






## Contact
[![LinkedIn][linkedin-shield]][linkedin-url]








[linkedin-shield]: https://img.shields.io/badge/-LinkedIn-black.svg?style=for-the-badge&logo=linkedin&colorB=555
[linkedin-url]: https://www.linkedin.com/in/ivan-cilakov-551489168/
[product-screenshot]: images/screenshot.png
[note-logo]: https://i.imgur.com/65Aa9SLb.jpg



 


# Notes-App
# Notes-App
# Notes-App
