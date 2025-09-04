Here’s a polished and GitHub-ready version of your README for **SecureTravelBuddy** with improved readability, structure, and professional tone:

---

# SecureTravelBuddy

**SecureTravelBuddy** is a modern iOS application that lets users track their current location, save favorite places, and view them on a map. It combines the power of **MapKit** and **CoreLocation** with a SwiftUI interface, offering a seamless and interactive experience.

---

## 🌟 Features

* **Live Location Tracking**
  Continuously tracks and updates the user's current location on the map in real-time.

* **Save Favorite Places**
  Long-press on the map or tap the save button to store a location along with its city name.

* **View Saved Locations**
  Display all saved places with custom map annotations for easy navigation.

* **Interactive Map**
  Supports zooming, scrolling, and tapping annotations to enhance the user experience.

* **Reverse Geocoding**
  Automatically fetches and displays city names for both the current location and saved locations.

* **Modern SwiftUI & UIKit Integration**
  Utilizes `UIViewRepresentable` for `MKMapView` while maintaining a SwiftUI interface for smooth UI experience.

* **MVVM Architecture**
  Clean separation of UI and data logic using `MapViewModel` for maintainable and testable code.

---

## 🛠️ Technologies Used

* **Swift 5 / iOS 17+**
* **SwiftUI** for modern UI components
* **UIKit (`MKMapView`)** for advanced map functionality
* **CoreLocation** for GPS tracking
* **MapKit** for maps, annotations, and interactions
* **CLGeocoder** for reverse geocoding
* **MVVM Architecture** for organized, maintainable code
* **Quick & Nimble** *(optional)* for unit testing
* **SQLite / Core Data / Custom Database** for persisting saved locations

---

## 📱 Screensh
![map2](https://github.com/user-attachments/assets/f3bb4b47-900c-4ace-8eba-b1a02922c17e)
ots
![map1](https://github.com/user-attachments/assets/d1af9b9e-6c1d-4612-b7ce-cb26f27d3171)
<img width="1206" height="2622" alt="Simulator Screenshot - iPhone 16 Pro - 2025-09-04 at 20 39 56" src="https://github.com/user-attachments/assets/b15dca86-4b27-4271-822a-fd71284edda8" />


*(Optional: Add screenshots here for better visualization.)*

---

## ⚡ Usage

1. Clone the repository:

   ```bash
   git clone https://github.com/yourusername/SecureTravelBuddy.git
   ```
2. Open the project in **Xcode 15+**.
3. Run the app on a simulator or real device.
4. Allow location access when prompted to enable live tracking.
5. Long-press on the map or tap the save button to store favorite places.

---

## 🏗️ Architecture

The project uses **MVVM architecture**:

* **Model:** Stores information about places, coordinates, and city names.
* **ViewModel:** Handles all map logic, location updates, saving/retrieving locations, and reverse geocoding.
* **View:** SwiftUI-based UI that interacts with the `MapViewModel` and displays `MKMapView` through `UIViewRepresentable`.

---

## 🔮 Future Enhancements

* Add **search functionality** to find places by name.
* Integrate **route navigation** between saved locations.
* Implement **iCloud sync** for saving locations across devices.
* Add **dark mode** support for a better user experience.

---

