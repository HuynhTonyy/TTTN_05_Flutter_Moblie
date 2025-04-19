# FutureLens - Student Performance Analysis Mobile Application

A sophisticated Flutter-based mobile application that leverages machine learning to analyze and predict student performance. This project combines mobile development, machine learning, and data analysis to provide valuable insights into student academic outcomes.

## 🚀 Project Overview

This application is designed to help educators and administrators predict and analyze student performance using Decision Tree Regressor algorithm. It features a modern, user-friendly interface built with Flutter and integrates with a Python backend that processes and analyzes student data.

## 🛠 Technical Stack

### Frontend

- **Flutter/Dart**: Cross-platform mobile development framework
- **State Management**: Provider pattern for efficient state handling
- **UI Components**: Material Design with custom theming
- **Local Storage**: SharedPreferences for persistent data storage

### Backend

- **Python**: Core machine learning implementation
- **Scikit-learn**: Decision Tree Regressor algorithm for performance prediction
- **RESTful API**: HTTP endpoints for data processing
- **Data Processing**: CSV handling and data preprocessing

### Key Features

- Student performance prediction using machine learning
- Data visualization and analytics
- Secure data handling and storage
- Cross-platform compatibility (iOS & Android)
- Offline data processing capabilities
- Export functionality for analysis results in various formats (CSV, xlsx)

## 📊 Machine Learning Implementation

- Utilizes Decision Tree algorithm for performance prediction
- Trained on comprehensive student dataset
- Model persistence using joblib
- Real-time prediction capabilities

## 🔧 Project Structure

```
lib/
├── Screens/         # UI screens and components
├── main.dart        # Application entry point
backend/
├── decision_tree.py # ML model implementation
├── student_data_train.csv # Training dataset
└── decision_tree.joblib   # Trained model
```

## 🚀 Getting Started

### Prerequisites

- Flutter SDK (^3.5.3)
- Python 3.x
- Scikit-learn
- Dart SDK

### Installation

1. Clone the repository
2. Install Flutter dependencies:
   ```bash
   flutter pub get
   ```
3. Set up Python environment:
   ```bash
   cd backend
   python -m venv venv
   source venv/bin/activate  # On Windows: venv\Scripts\activate
   pip install -r requirements.txt
   ```

### Running the Application

1. Start the backend server
2. Run the Flutter application:
   ```bash
   flutter run
   ```

## 🎯 Key Achievements

- Implemented end-to-end machine learning pipeline in a mobile application
- Achieved cross-platform compatibility with native performance
- Developed efficient data processing and storage mechanisms
- Created an intuitive user interface for complex data analysis

## 📚 Learning Outcomes

- Gained expertise in Flutter mobile development
- Implemented machine learning models in production
- Mastered cross-platform development best practices
- Developed skills in data processing and visualization
- Learned to integrate multiple technologies into a cohesive solution

## 🤝 Contributing

This project is open for contributions. Please feel free to submit issues and pull requests.
