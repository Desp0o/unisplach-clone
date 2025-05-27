# Unsplash clone ✨

##### An Unsplash clone is an application that uses the Unsplash API to fetch photos from the server. Here, you can browse images, view the photo's author, like and download photos, and manage your search, likes, and download history.

![Swift](https://img.shields.io/badge/Swift-5.9-orange)
![iOS](https://img.shields.io/badge/iOS-17.0%2B-white)
![Framework](https://img.shields.io/badge/Framework-SwiftUI-skyblue)
![Architecture](https://img.shields.io/badge/Architecture-MVVM-informational)
![Xcode](https://img.shields.io/badge/Xcode-16.3-blue)
![Networking](https://img.shields.io/badge/Networking-Alamofire-critical)

# Features 🚀
- Optimize network calls using _NSCache_
- Display a shimmer effect during image loading
- Request permission to access the photo library
- Main 
  - Scroll through images in a single column or in two columns as tiles
    - A LazyVGrid is used to layout the images
  - Longpress to select and download multiple images 
- Search
  - Search photo with keyword
  - Filter search by order
  - filter search by orientation
  - Total number of search results displayed
  - Clear search result
  - Search history
    - Used userDefault for save between sessions 
  - Tap to search using previous keywords
  - Remove single keyword from history 
  - Clear search history
  -  Scroll in two columns as tiles
    - A LazyVGrid is used to layout the images
  - Longpress to select and download multiple images 
- Photo View
  - View photo in full screen
  - Download photo
  - View photo author
  - share photo to friends
    - used ShareLink
  - Like button
    - Used userDefault for save between sessions 
  - Download Button
  - Photo info Button
    - Used Sheet to display photo info and desctiption
- Profile
  - View profile
  - View liked history
  - View download history
    - clear download history
  - Settings button for switch themes

# Technical sides 💻
- 📱 UI and Logic - I used the SwiftUI framework to build a fast and user-friendly interface. It helped me create smooth and modern user experiences.

- 👀 Observation - I used Apple’s Observation framework to make the UI reactive. This way, the interface updates automatically when data changes. It also reduces the amount of code and makes it easier to manage.

- 🧱 MVVM Architecture - used the MVVM (Model-View-ViewModel) architecture, which I know well and enjoy working with. It helps make the code clean, modular, and scalable. Each view has its own ViewModel where I keep more complex logic. To ensure correctness, I wrote unit tests for my ViewModels using XCTests, which helps catch bugs early and maintain stability as the codebase grows.

- 🧰 Managers  - I created and used manager classes to simplify the code and avoid repetition. With dependency injection, I can easily use these managers in any ViewModel, which also helps with testing.
    - 🌐 _NetworkManager_ – created for handling the network layer. I used Alamofire for making API requests. I also designed a custom and reusable network structure using protocols:
      - NetworkManagerProtocol - for fetching general data
      - ImageNetworkProtocol - for downloading images
  - 🖼️ _PhotoSaverManager_ - created for handle image-related operations. It requests permission from the user to access the photo library and is also used to save images to the device.
    
  - 💾 _UserDefaultsManager_ - I created this class to easily manage user data like liked or downloaded photos, search history, and more using UserDefaults. Since some data from the Unsplash API requires _OAuth_, I chose to keep things simple and avoid overengineering by storing certain info locally with UserDefaults. It containt three main _generic_ functions: _set(), load() and clear()_.
    
  - ♻️ _BaseViewModel_ - to store common variables and functions that are used in multiple ViewModels. This helps reduce boilerplate code and allows me to reuse logic by inheriting from this class.

- 🧩 Extensions - created extensions for Image, View, and Text to avoid writing the same code multiple times. These extensions work like custom view modifiers and help keep the code clean and reusable.

- Enums 🧾 - defined enums to improve type safety and avoid issues like string misusage or typos. These enums make the code more readable, maintainable, and easier to use. I applied them for handling API endpoints, error types, icons, UserDefaults keys, and themes. 

# Folder Strcture 🏗️
<pre>
📁 MyProject
├── Launch Screen.storyboard
├── unisplashClone
│   └── 📂 Enums
│   |   └── APIEndpoinstEnum
│   |   └── AppTheme
│   |   └── IconsEnum.swift
│   |   └── PhotoSaverErrorEnum.swift
│   |   └── SearchEnums.swift
│   |   └── UserDefaultsKeys.swift
├── 📂 Helpers
│   └──  📂 Extensions
│   │   └──Image+Extension.swift
│   │   └── Text+Extension.swift
│   │   └── View+Extension.swift
│   └── 📂 Reusables
│   │   └── CachedAsyncImage.swift
│   │   └── CustomAlertBox.swift 
│   │   └── LayoutPhotoView.swift 
│   │   └── LoadingIndicator.swift 
│   │   └── MultipleDownloaderBar.swift 
│   │   └── SelectedMark.swift 
│   │   └── ShimmerEffect.swift 
│   │   └── Toast.swift   
├── 📂 Managers
│   └── BaseViewModel.swift
│   └── NetworkManager.swift
│   └── PhotoSaverManager.swift
│   └── UserDefaultsManager.swift
├── 📂 Models
│   └── DownloadHistoryModel.swift
│   └── PhotoResponseModel.swift
│   └── SearchedDataModel.swift
├── 📂 Screens
│   └──  📂 Main
│   |    └──  📂 Components  
|   |    |    └── MainViewHeader.swift 
|   |    |    └── MainViewTryAgainButton.swift
|   |    └── MainView.swift
|   |    └── MainViewModel.swift 
│   └──  📂 Profile
│   |    └──  📂 Components  
|   |    |    └── DownloadHistoryView.swift
|   |    |    └── LikedPhotosView.swift
|   |    └── ProfileView.swift
|   |    └── ProfileViewModel.swift
│   └──  📂 Search
│   |    └──  📂 Components  
|   |    |    └── SearchComponent.swift
|   |    |    └── SearchHistoryComponent.swift
|   |    └── SearchView.swift
|   |    └── SearchViewModel.swift
│   └──  📂 SinglePhoto
|   |    └── PhotoDetails.swift
|   |    └── SinglePhotoView.swift
|   |    └── SingleViewModel.swift
│   └──  📂 Tabbar
|   |    └── TabbarView.swift
|   └── Assets.xcassets
|   └── unisplashCloneApp.swift
└── 📂 unisplashCloneTests
|   └── 📂 Mocks
|   |    └── MockNetworkManager.swift
|   |    └── MockPhotoSaverManager.swift
|   |    └── MockUserDefaultsManager.swift
|   └── TestMainViewModel.swift
|   └── TestProfileViewModel.swift
|   └── TestSearchViewModel.swift 
|   └── TestSinglePhotoViewModel.swift
└── 📄 README.md
</pre>


# Vide Demo 🎥

[▶️ Real Device Iphone 12](https://youtube.com/shorts/azubTI4Y4LY?feature=share)                    

[▶️ Simulator Iphone SE](https://youtube.com/shorts/GBJ6W0GrMcI?feature=share)

# Screenshots 📸
### Dark 🌙
<img src="https://cdn.dribbble.com/userupload/43476926/file/original-04f00ab5f379ea554bc469f210f2fd0f.png?resize=1024x2216&vertical=center" alt="dark theme" height="280" width="auto" /> <img src="https://cdn.dribbble.com/userupload/43476932/file/original-5be60c50887a6c4a3e39ee336293d0c4.png?resize=752x1627&vertical=center" alt="dark theme" height="280" width="auto" /> <img src="https://cdn.dribbble.com/userupload/43476933/file/original-40d699f0629d4b789875db8f0bd7b3f1.png?resize=752x1627&vertical=center" alt="dark theme" height="280" width="auto" /> <img src="https://cdn.dribbble.com/userupload/43476930/file/original-0e838886c4572a1b149ecb0756ea5144.png?resize=752x1627&vertical=center" alt="dark theme" height="280" width="auto" /> <img src="https://cdn.dribbble.com/userupload/43476928/file/original-ea4fabed9fbce42437f49a360573fe5a.png?resize=752x1627&vertical=center" alt="dark theme" height="280" width="auto" /> <img src="https://cdn.dribbble.com/userupload/43476934/file/original-80195e64595218d08e28ee463795432e.png?resize=752x1627&vertical=center" alt="dark theme" height="280" width="auto" /> <img src="https://cdn.dribbble.com/userupload/43476927/file/original-0a54f4205e233d59fb3ebe9395ed4e3c.png?resize=752x1627&vertical=center" alt="dark theme" height="280" width="auto" /> <img src="https://cdn.dribbble.com/userupload/43476923/file/original-564e476437075e17067952107e022af0.png?resize=752x1627&vertical=center" alt="dark theme" height="280" width="auto" /> <img src="https://cdn.dribbble.com/userupload/43476931/file/original-b8ba605f12d4503d7aa4c588528dd552.png?resize=752x1627&vertical=center" alt="dark theme" height="280" width="auto" /> <img src="https://cdn.dribbble.com/userupload/43476925/file/original-d67fe7ef6fa9d0e2a61bf9e306bce223.png?resize=752x1627&vertical=center" alt="dark theme" height="280" width="auto" /> <img src="https://cdn.dribbble.com/userupload/43476929/file/original-7c97f83a19dca74d40b3c9cc1a06b0db.png?resize=752x1627&vertical=center" alt="dark theme" height="280" width="auto" />


### Light ☀️

<img src="https://cdn.dribbble.com/userupload/43477386/file/original-b0636146b57539414a499448c898dba9.png?resize=1024x2216&vertical=center" alt="light theme" height="280" width="auto" /> <img src="https://cdn.dribbble.com/userupload/43477391/file/original-9be3c3838da0da65910ed80fcb03e3ff.png?resize=752x1627&vertical=center" alt="light theme" height="280" width="auto" /> <img src="https://cdn.dribbble.com/userupload/43477392/file/original-1fac262951807e5a03b1e1c00f8be162.png?resize=752x1627&vertical=center" alt="light theme" height="280" width="auto" /> <img src="https://cdn.dribbble.com/userupload/43477392/file/original-1fac262951807e5a03b1e1c00f8be162.png?resize=752x1627&vertical=center" alt="light theme" height="280" width="auto" /> <img src="https://cdn.dribbble.com/userupload/43477389/file/original-b0ffbaefb310bff914c45f6af536abb3.png?resize=752x1627&vertical=center" alt="light theme" height="280" width="auto" /> <img src="https://cdn.dribbble.com/userupload/43477390/file/original-e0b3df39720bc000186b784d46cbceb1.png?resize=752x1627&vertical=center" alt="light theme" height="280" width="auto" /> <img src="https://cdn.dribbble.com/userupload/43477387/file/original-54c54ef931e823a9ea3d180cd009c42c.png?resize=752x1627&vertical=center" alt="light theme" height="280" width="auto" /> <img src="https://cdn.dribbble.com/userupload/43477384/file/original-0ba3bd422112d4a65c9a5728050f050e.png?resize=752x1627&vertical=center" alt="light theme" height="280" width="auto" /> <img src="https://cdn.dribbble.com/userupload/43477383/file/original-bf9d22d0cf6e82ba0d02328d510c0389.png?resize=752x1627&vertical=center" alt="light theme" height="280" width="auto" /> <img src="https://cdn.dribbble.com/userupload/43477388/file/original-b1a0459bffc334a1099859a48353b33c.png?resize=752x1627&vertical=center" alt="light theme" height="280" width="auto" /> <img src="https://cdn.dribbble.com/userupload/43477393/file/original-c854e3b95b24e050fe3f21933330123e.png?resize=752x1627&vertical=center" alt="light theme" height="280" width="auto" />

