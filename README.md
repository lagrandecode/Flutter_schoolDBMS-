# School Management App (Flutter)

A modern Flutter application that provides an intuitive dashboard and management interface for the School Management System. This application connects to the Django REST API backend to provide real-time analytics and student management capabilities.

## Features

### 📊 Interactive Dashboard
- **Real-time Analytics**
  - Live student statistics with auto-refresh (30s interval)
  - Interactive charts and visualizations
  - Last update timestamp indicator
  - Manual refresh option

### 📈 Data Visualization
- **Gender Distribution**
  - Interactive pie chart
  - Percentage breakdowns
  - Color-coded segments
  - Animated transitions

- **Age Distribution**
  - Dynamic bar chart
  - Interactive tooltips
  - Age range analysis
  - Count per age group

- **Grade Distribution**
  - Progress bar visualization
  - Percentage calculations
  - Grade-wise breakdown
  - Color-coded indicators

- **Average Age per Grade**
  - Line chart visualization
  - Trend analysis
  - Interactive data points
  - Grade progression insights

### 👥 Student Management
- **Student List**
  - Real-time search functionality
  - Filterable student records
  - Sortable columns
  - Quick action buttons

- **Student Details**
  - Comprehensive profile view
  - Editable information
  - Contact details
  - Academic records

### 🎨 UI/UX Features
- Material Design 3 implementation
- Responsive layout adaptation
- Dark/Light theme support
- Smooth animations and transitions
- Error handling with retry options
- Loading state indicators

## Getting Started

### Prerequisites
- Flutter SDK (latest stable version)
- Dart SDK
- Android Studio / VS Code with Flutter plugins
- A running instance of the Django backend server

### Installation

1. Clone the repository:
   ```bash
   git clone <repository-url>
   cd school_management_app
   ```

2. Install dependencies:
   ```bash
   flutter pub get
   ```

3. Configure the API endpoint:
   - Open `lib/config/api_config.dart`
   - Update the `baseUrl` to match your Django backend:
   ```dart
   class ApiConfig {
     static const String baseUrl = 'http://your-backend-url:8000/api';
   }
   ```

4. Run the application:
   ```bash
   flutter run
   ```

### Configuration

#### API Connection
Update the API configuration in `lib/config/api_config.dart`:
```dart
class ApiConfig {
  static const String baseUrl = 'http://localhost:8000/api';
  static const int timeout = 30000; // milliseconds
  static const bool enableLogging = true;
}
```

#### Theme Customization
Modify the theme in `lib/config/theme.dart`:
```dart
ThemeData lightTheme = ThemeData(
  primaryColor: Colors.blue,
  // ... other theme configurations
);
```

## Project Structure

```
lib/
├── config/
│   ├── api_config.dart
│   └── theme.dart
├── models/
│   └── student.dart
├── providers/
│   └── student_provider.dart
├── screens/
│   ├── dashboard_screen.dart
│   └── student_list_screen.dart
├── widgets/
│   ├── charts/
│   │   ├── age_distribution_chart.dart
│   │   ├── gender_distribution_chart.dart
│   │   └── grade_distribution_chart.dart
│   └── common/
│       ├── loading_indicator.dart
│       └── error_view.dart
└── main.dart
```

## State Management

This application uses the Provider pattern for state management:

```dart
void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => StudentProvider()),
        // Other providers...
      ],
      child: const MyApp(),
    ),
  );
}
```

## Key Components

### StudentProvider
Manages student data and provides methods for:
- Fetching student records
- Searching and filtering
- Statistical calculations
- Auto-refresh management

### Charts
Built using `fl_chart` package:
- Pie charts for gender distribution
- Bar charts for age distribution
- Progress indicators for grade distribution
- Line charts for age trends

### Responsive Design
Automatically adapts to different screen sizes:
```dart
LayoutBuilder(
  builder: (context, constraints) {
    if (constraints.maxWidth > 600) {
      return WideLayout();
    }
    return NarrowLayout();
  },
)
```

## Performance Optimization

- Lazy loading of student lists
- Caching of API responses
- Debounced search implementation
- Optimized chart rendering
- Memory-efficient image handling

## Error Handling

The app includes comprehensive error handling:
- Network error recovery
- Data validation
- User feedback
- Graceful degradation
- Retry mechanisms

## Testing

Run the tests using:
```bash
flutter test
```

Key test areas:
- Widget tests for UI components
- Integration tests for API communication
- Unit tests for business logic
- Provider tests for state management

## Contributing

1. Fork the repository
2. Create your feature branch
3. Commit your changes
4. Push to the branch
5. Create a Pull Request

## Troubleshooting

### Common Issues

1. **API Connection Errors**
   - Verify backend server is running
   - Check API configuration
   - Confirm network connectivity

2. **Chart Rendering Issues**
   - Ensure data format is correct
   - Verify screen dimensions
   - Check for null values

3. **Performance Issues**
   - Enable performance overlay
   - Check for memory leaks
   - Optimize image assets

## Dependencies

Key packages used:
```yaml
dependencies:
  flutter:
    sdk: flutter
  provider: ^6.0.0
  fl_chart: ^0.55.0
  http: ^0.13.0
  intl: ^0.17.0
```

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Acknowledgments

- Flutter team for the framework
- Chart library contributors
- Design inspiration sources
- Community contributors

## Screenshots

[Add your application screenshots here]

## Contact

For support or queries, please contact:
- Email: [your-email]
- GitHub Issues: [repository-issues-link]
