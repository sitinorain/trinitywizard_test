# Trinity Wizard technical test

### To do
Please run "pod install" command and open the project from ".xcworkspace"

### Design Consideration (MVVM + Rx)
The code consist 5 main elements:
1. View - view controller & views
2. ViewModel - view absract representation, manage user interaction and handle services & business logic
3. Model - data content
4. Services - perform specific tasks (services), eg: fetching data json file or local database, insert/update data to local database
5. Configurator & Wireframe - creating view and handle navigation between views
6. Both iPhone and iPad devices are supported
7. Both light and dark mode are supported
8. Unit test cases provided are at minimal for example purposes

### Assumption
1. All json parse expected to be successful. Specific error handling is not implemented in the code.
2. All data loaded at once. Pagination not implemented.

## Application Design

### User Story: Splash

**Life cycle** 
Entry point: App launch
Navigate out: 2 seconds after view did appear to screen

### User Story: Contact Listing

**Life cycle** 
Entry point: 2 seconds after Splash screen did appear
Navigate out: 
- Upon selection any of item in listing
- Upon tapping "+" button

**Element** 
1. Load data from local database upon entry
2. Retrive data from data.json is not data is available in local database. Save data into local database upon retrieved
3. Reload the original list from data.json upon pulling the listing
4. Refresh the list upon new data added / updated into local database

### User Story: Details

**Life cycle** 
Entry point: 
- Item selected from listing screen
- Upon tapping "+" button from listing screen
Navigate out: Upon tapping "Save" or "Cancel" button

**Element** 
1. Showing empty data if coming form "+" button entry point
2. Showing contact data if coming form item selection entry point
3. Allow to save data only if user input first name and last name
4. Disable save data if user input invalid email format
5. Save changes to local data upon tapping "Save" button
