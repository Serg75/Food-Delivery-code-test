# Food Delivery App

It was created as a test assignment.

## Functionality

The Food Delivery App fetches restaurant data from the provided API and presents it in a list view. Each restaurant card displays basic information about the restaurant, such as its name, rating, delivery time, and filters. 

When a user taps on a restaurant card, a detail view opens up, showing whether the restaurant is open or closed. 

Additionally, the app fetches filters associated with each restaurant and presents them in a horizontal list. Users can select multiple filters, and the restaurant list updates dynamically to display only those restaurants that match the selected filters.

## Resources

### Design

The design for the Food Delivery App was provided in Figma.

### Endpoints

The endpoints for fetching restaurant data and filters are available at [Food Delivery API Swagger Documentation](https://food-delivery.umain.io/swagger/).

## Code Structure

The codebase consists of several SwiftUI views and ViewModel classes to implement the functionality described above. Here's an overview of the main components:

- **Views**
  - `ContentView`: The main view of the app, containing the list of restaurants and the filter section.
  - `FiltersView`: Displays the list of filters in a horizontal scrollable view.
  - `RestaurantCard`: Represents a single restaurant card in the list.
  - `RestaurantDetailView`: Displays detailed information about a selected restaurant.
  
- **ViewModels**
  - `RestaurantsViewModel`: Manages the fetching and filtering of restaurant data.
  - `FiltersViewModel`: Handles the fetching and selection of filters.
  - `DetailsViewModel`: Manages the detailed information of a selected restaurant, including its status and filters.

- **Helpers**
  - `FilterHandler`: Handles the fetching and processing of filter descriptions.
  - `StatusFetcher`: Fetches the open/closed status of restaurants.
  
- **Tests**
  - Tests are provided for `DetailsViewModel` and `FiltersViewModel` to ensure proper functionality and error handling.
  
