import 'package:flutter/material.dart';
import 'data/local/db_helper.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
void main() {
  runApp(GarageInventoryApp());
}
class GarageInventoryApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'National Auto Service',
      theme: ThemeData(
        fontFamily: 'Itim',
        primaryColor: Colors.black,
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: Colors.black,
          secondary: Colors.red[500], // Text and icon color set to red[500]
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.black,
          foregroundColor: Colors.red[500], // Title color set to red
          titleTextStyle: TextStyle(
            fontFamily: 'Itim',
            fontSize: 28, // Increased font size for AppBar titles
            fontWeight: FontWeight.bold,
            color: Colors.red[500], // Ensures the title color is red
          ),
        ),
        textTheme: TextTheme(
          bodyLarge: TextStyle(fontFamily: 'Itim'),
          bodyMedium: TextStyle(fontFamily: 'Itim'),
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('National Auto Service'),
      ),
      drawer: AppDrawer(),
      body: Container(
        color: Colors.grey[800], // Background color set to grey[800]
        child: Center(
          child: Container(
            width: 300, // Width of the container
            height: 250, // Adjusted height since we removed the last button
            padding: EdgeInsets.all(16), // Padding inside the container
            decoration: BoxDecoration(
              color: Colors.red, // Background color of the container
              borderRadius: BorderRadius.circular(12), // Rounded corners
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.5), // Shadow color
                  spreadRadius: 2,
                  blurRadius: 8,
                  offset: Offset(0, 4), // Shadow position
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min, // To fit the content
              children: [
                SizedBox(height: 5),
                Text(
                  '-> Search inventory by',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 24, // Increased font size
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Itim',
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 25), // Increased space between header and buttons
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ByBikePage()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black, // Button color
                    foregroundColor: Colors.red[500], // Text and icon color
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start, // Align items to start
                    children: [
                      Icon(Icons.directions_bike, color: Colors.red[500]),
                      SizedBox(width: 7), // Space between icon and text
                      Expanded( // Allow text to take remaining space
                        child: Center( // Center text vertically
                          child: Text(
                            'Bike',
                            style: TextStyle(
                              color: Colors.red[500],
                              fontSize: 20, // Increased font size
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20), // Space between buttons
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => BySparePartPage()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black, // Button color
                    foregroundColor: Colors.red[500], // Text and icon color
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start, // Align items to start
                    children: [
                      Icon(Icons.build, color: Colors.red[500]),
                      SizedBox(width: 8), // Space between icon and text
                      Expanded( // Allow text to take remaining space
                        child: Center( // Center text vertically
                          child: Text(
                            'Spare Parts',
                            style: TextStyle(
                              color: Colors.red[500],
                              fontSize: 20, // Increased font size
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
class ShowDetailsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('All Details'),
      ),
      body: Container(
        color: Colors.grey[800],
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => BikeDetailsPage()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.red[500],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                ),
                child: Text(
                  'Bike',
                  style: TextStyle(color: Colors.red[500]),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SparePartDetailsPage()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.red[500],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                ),
                child: Text(
                  'Spare Part',
                  style: TextStyle(color: Colors.red[500]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
class BikeDetailsPage extends StatefulWidget {
  @override
  _BikeDetailsPageState createState() => _BikeDetailsPageState();
}
class _BikeDetailsPageState extends State<BikeDetailsPage> {
  List<Map<String, dynamic>> bikeDetails = [];

  @override
  void initState() {
    super.initState();
    fetchBikeDetails();
  }

  Future<void> fetchBikeDetails() async {
    try {
      // Open the database
      final database = await openDatabase(
        join(await getDatabasesPath(), 'garage_inventory.db'),
      );

      // Fetch all data from the bike_details table
      final List<Map<String, dynamic>> bikeMaps = await database.query('bike_details');

      // Update the state with the fetched data
      setState(() {
        bikeDetails = bikeMaps;
      });
    } catch (e) {
      // Log or display the error for debugging
      print('Error fetching bike details: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bike Details'),
      ),
      body: Container(
        color: Colors.grey[800],
        child: bikeDetails.isEmpty
            ? Center(
          child: CircularProgressIndicator(), // Show a loading spinner if data is not yet loaded
        )
            : ListView.builder(
          itemCount: bikeDetails.length,
          itemBuilder: (context, index) {
            return Container(
              color: Colors.black, // Set the background color to black
              child: ListTile(
                title: Text(
                  bikeDetails[index]['bike_name'],
                  style: TextStyle(
                    color: Colors.red[500],
                    fontSize: 22, // Increased font size
                  ),
                ),
                trailing: Icon(
                  Icons.edit, // Edit icon
                  color: Colors.blue, // Change the icon color to blue
                ),
                // onTap: () {
                //   // Debugging: Print the selected bike ID to ensure onTap is working
                //   print('Tapped on bike ID: ${bikeDetails[index]['bike_id']}');
                //
                //   // Navigate to the SparePartsPage and pass the bike_id
                //   Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //       builder: (context) => SparePartsPage(
                //         bikeId: bikeDetails[index]['bike_id'],
                //       ),
                //     ),
                //   );
                // },
              ),
            );
          },
        ),
      ),
    );
  }
}
class SparePartDetailsPage extends StatefulWidget {
  @override
  _SparePartDetailsPageState createState() => _SparePartDetailsPageState();
}
class _SparePartDetailsPageState extends State<SparePartDetailsPage> {
  List<Map<String, dynamic>> sparePartDetails = [];

  @override
  void initState() {
    super.initState();
    fetchSparePartDetails();
  }

  Future<void> fetchSparePartDetails() async {
    // Open the database
    final database = await openDatabase(
      join(await getDatabasesPath(), 'garage_inventory.db'),
    );

    // Fetch all data from the spare_part_details table
    final List<Map<String, dynamic>> sparePartMaps = await database.query('spare_part_details');

    // Update the state with the fetched data
    setState(() {
      sparePartDetails = sparePartMaps;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Spare Part Details'),
      ),
      body: Container(
        color: Colors.grey[800],
        child: sparePartDetails.isEmpty
            ? Center(
          child: CircularProgressIndicator(), // Show a loading spinner if data is not yet loaded
        )
            : ListView.builder(
          itemCount: sparePartDetails.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(
                'Spare Part: ${sparePartDetails[index]['spare_part_name']}',
                style: TextStyle(color: Colors.red[500]),
              ),
              subtitle: Text(
                'Spare Part ID: ${sparePartDetails[index]['spare_part_id']} | '
                    'Bike ID: ${sparePartDetails[index]['bike_id']} | '
                    'Price: ${sparePartDetails[index]['spare_part_price']} | '
                    'Quantity: ${sparePartDetails[index]['spare_part_quantity']}',
                style: TextStyle(color: Colors.white),
              ),
            );
          },
        ),
      ),
    );
  }
}
class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200, // Adjust the width as needed; try 250 for a narrower drawer
      child: Drawer(
        child: Container(
          color: Colors.grey[800], // Set the background color of the drawer items
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.black,
                  // Same color as the AppBar
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/Logo-1.png',
                      fit: BoxFit.contain,
                      height: 125, // Adjust height as needed for a perfect fit
                    ),
                  ],
                ),
              ),
              ListTile(
                leading: Icon(Icons.home, color: Colors.red[500]),
                title: Text('Home', style: TextStyle(color: Colors.red[500])),
                onTap: () {
                  // Navigate to Home Page
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HomePage()),
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.directions_bike, color: Colors.red[500]),
                title: Text('Bike list', style: TextStyle(color: Colors.red[500])),
                onTap: () {
                  // Navigate to "By Bike" Page
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ByBikePage()),
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.build, color: Colors.red[500]),
                title: Text('Spare Parts List', style: TextStyle(color: Colors.red[500])),
                onTap: () {
                  // Navigate to "By Spare Parts" Page
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => BySparePartPage()),
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.info, color: Colors.red[500]),
                title: Text('Show All Table Data', style: TextStyle(color: Colors.red[500])),
                onTap: () {
                  // Navigate to Show All Table Data Page
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ShowDetailsPage()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
class GenericPage extends StatelessWidget {
  final String title;
  final String content;

  GenericPage({required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title, style: TextStyle(fontFamily: 'Itim')),
      ),
      drawer: AppDrawer(),
      body: Container(
        color: Colors.grey[800],
        child: Center(
          child: Text(content, style: TextStyle(fontFamily: 'Itim', color: Colors.red[500])),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print('FAB clicked on $title page');
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.black,
        foregroundColor: Colors.red[500],
      ),
    );
  }
}
class ByBikePage extends StatefulWidget {
  @override
  _ByBikePageState createState() => _ByBikePageState();
}
class _ByBikePageState extends State<ByBikePage> {
  final DatabaseHelper _dbHelper = DatabaseHelper();
  List<Map<String, dynamic>> _bikes = [];
  List<Map<String, dynamic>> _filteredBikes = [];
  bool _isSearching = false;
  TextEditingController _searchController = TextEditingController();
  var color = Colors.grey[800];
  @override
  void initState() {
    super.initState();
    _fetchBikes();
    _searchController.addListener(_onSearchChanged);
  }

  void _fetchBikes() async {
    final bikes = await _dbHelper.getBikes();
    setState(() {
      _bikes = bikes;
      _filteredBikes = bikes;
    });
  }

  void _onSearchChanged() {
    setState(() {
      _filteredBikes = _bikes
          .where((bike) => bike['bike_name']
          .toLowerCase()
          .contains(_searchController.text.toLowerCase()))
          .toList();
    });
  }

  void _clearSearch() {
    _searchController.clear();
    setState(() {
      _isSearching = false;
      _filteredBikes = _bikes;
    });
  }

  // Show Add Bike Form
  void _showAddBikeForm() {
    final TextEditingController bikeNameController = TextEditingController();

    showDialog(
      context: this.context,
      builder: (context) {
        return AlertDialog(
          title: Text('Add New Bike'),
          content: TextField(
            controller: bikeNameController,
            decoration: InputDecoration(hintText: 'Enter bike name'),
          ),
          actions: [
            TextButton(
              onPressed: () async {
                String bikeName = bikeNameController.text;
                if (bikeName.isNotEmpty) {
                  await _dbHelper.addBike(bikeName);
                  _fetchBikes(); // Refresh the list
                }
                Navigator.pop(context); // Close the dialog
              },
              child: Text('Done'),
            ),
          ],
        );
      },
    );
  }

  // Edit bike functionality
  void _showEditBikeForm(int bikeId, String currentName) {
    final TextEditingController bikeNameController = TextEditingController(text: currentName);

    showDialog(
      context: this.context,
      builder: (context) {
        return AlertDialog(
          title: Text('Edit Bike'),
          content: TextField(
            controller: bikeNameController,
            decoration: InputDecoration(hintText: 'Enter new bike name'),
          ),
          actions: [
            TextButton(
              onPressed: () async {
                String bikeName = bikeNameController.text;
                if (bikeName.isNotEmpty) {
                  await _dbHelper.updateBike(bikeId, bikeName);  // Update the bike in the DB
                  _fetchBikes(); // Refresh the list
                }
                Navigator.pop(context); // Close the dialog
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }

  // Delete bike functionality
  void _deleteBike(int bikeId) {
    showDialog(
      context: this.context,
      builder: (context) {
        return AlertDialog(
          title: Text('Delete Bike'),
          content: Text('Are you sure you want to delete this bike?'),
          actions: [
            TextButton(
              onPressed: () async {
                await _dbHelper.deleteBike(bikeId); // Delete the bike from the DB
                _fetchBikes(); // Refresh the list
                Navigator.pop(context); // Close the dialog
              },
              child: Text('Yes'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog without doing anything
              },
              child: Text('No'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _isSearching
            ? TextField(
          controller: _searchController,
          decoration: InputDecoration(
            hintText: 'Search Bikes',
            hintStyle: TextStyle(color: Colors.red[500]),
            border: InputBorder.none,
          ),
          style: TextStyle(color: Colors.red[500]),
        )
            : Text('Bike List', style: TextStyle(fontFamily: 'Itim')),
        actions: [
          IconButton(
            icon: Icon(_isSearching ? Icons.clear : Icons.search, color: Colors.red[500]),
            onPressed: () {
              setState(() {
                if (_isSearching) {
                  _clearSearch();
                } else {
                  _isSearching = true;
                }
              });

            },
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: Container(
        color: Colors.grey[800],
        child: _filteredBikes.isEmpty
            ? Center(child: CircularProgressIndicator())
            : ListView.builder(
          itemCount: _filteredBikes.length,
          itemBuilder: (context, index) {
            return Container(

              // Background color of each row
              decoration: BoxDecoration(
                color: Colors.black26,
                border: Border(bottom: BorderSide(color: Colors.grey[800]!, width: 1)),
              ),

              child: ListTile(
                title: Text(
                  _filteredBikes[index]['bike_name'],
                  style: TextStyle(
                    color: Colors.red[500],
                    fontFamily: 'Itim',
                    fontSize: 22, // Increased font size
                  ),
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Edit button with blue color
                    IconButton(
                      icon: Icon(Icons.edit, color: Colors.blue),
                      onPressed: () {
                        _showEditBikeForm(_filteredBikes[index]['bike_id'], _filteredBikes[index]['bike_name']);
                      },
                    ),
                    // Delete button
                    IconButton(
                      icon: Icon(Icons.delete, color: Colors.red[500]),
                      onPressed: () {
                        _deleteBike(_filteredBikes[index]['bike_id']);
                      },
                    ),
                  ],
                ),
                onTap: () {
                  // Navigate to SparePartsPage with the bike ID
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SparePartsPage(
                        bikeId: _filteredBikes[index]['bike_id'],
                      ),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddBikeForm,
        child: Icon(Icons.add),
        backgroundColor: Colors.black,
        foregroundColor: Colors.red[500],
      ),
    );
  }
}
class SparePartsPage extends StatefulWidget {
  final int bikeId;
  SparePartsPage({required this.bikeId});

  @override
  _SparePartsPageState createState() => _SparePartsPageState();
}
class _SparePartsPageState extends State<SparePartsPage> {
  final DatabaseHelper _dbHelper = DatabaseHelper();
  List<Map<String, dynamic>> _spareParts = [];
  List<Map<String, dynamic>> _filteredSpareParts = [];
  bool _isSearching = false;
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchSpareParts();
    _searchController.addListener(_onSearchChanged);
  }

  Future<void> _fetchSpareParts() async {
    final parts = await _dbHelper.getSparePartsByBikeId(widget.bikeId);
    setState(() {
      _spareParts = parts;
      _filteredSpareParts = parts;
    });
  }

  void _onSearchChanged() {
    setState(() {
      _filteredSpareParts = _spareParts
          .where((part) => part['spare_part_name']
          .toLowerCase()
          .contains(_searchController.text.toLowerCase()))
          .toList();
    });
  }

  void _clearSearch() {
    _searchController.clear();
    setState(() {
      _isSearching = false;
      _filteredSpareParts = _spareParts;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _isSearching
            ? TextField(
          controller: _searchController,
          decoration: InputDecoration(
            hintText: 'Search Spare Parts',
            hintStyle: TextStyle(color: Colors.red[500]),
            border: InputBorder.none,
          ),
          style: TextStyle(color: Colors.red[500]),
        )
            : Text('Bike Spare Parts List', style: TextStyle(fontFamily: 'Itim')),
        actions: [
          IconButton(
            icon: Icon(_isSearching ? Icons.clear : Icons.search, color: Colors.red[500]),
            onPressed: () {
              setState(() {
                if (_isSearching) {
                  _clearSearch();
                } else {
                  _isSearching = true;
                }
              });
            },
          ),
        ],
      ),
      body: Container(
        color: Colors.grey[800],
        child: _filteredSpareParts.isEmpty
            ? Center(
          child: Text(
            'No spare parts found for this bike.',
            style: TextStyle(color: Colors.white),
          ),
        )
            : ListView.builder(
          itemCount: _filteredSpareParts.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(
                _filteredSpareParts[index]['spare_part_name'],
                style: TextStyle(color: Colors.red[500], fontFamily: 'Itim'),
              ),
              subtitle: Text(
                'Price: ${_filteredSpareParts[index]['spare_part_price']} | Quantity: ${_filteredSpareParts[index]['spare_part_quantity']}',
                style: TextStyle(color: Colors.white),
              ),
            );
          },
        ),
      ),
    );
  }
}
class BySparePartPage extends StatefulWidget {
  @override
  _BySparePartPageState createState() => _BySparePartPageState();
}
class _BySparePartPageState extends State<BySparePartPage> {
  String searchQuery = '';
  bool isSearching = false;
  TextEditingController searchController = TextEditingController();
// Controllers for the edit form
  TextEditingController priceController = TextEditingController();
  TextEditingController quantityController = TextEditingController();

  // Fetch the full spare part details with bike name
  Future<List<Map<String, dynamic>>> fetchFullSparePartTable() async {
    final database = await openDatabase(
      join(await getDatabasesPath(), 'garage_inventory.db'),
    );

    final List<Map<String, dynamic>> maps = await database.rawQuery('''
      SELECT spare_part_details.spare_part_name, 
             spare_part_details.spare_part_price, 
             spare_part_details.spare_part_quantity, 
             spare_part_details.spare_part_id, 
             bike_details.bike_name
      FROM spare_part_details
      JOIN bike_details ON spare_part_details.bike_id = bike_details.bike_id
    ''');

    return maps;
  }
// Function to update spare part in the database
  Future<void> updateSparePart(int sparePartId, double newPrice, int newQuantity) async {
    final database = await openDatabase(
      join(await getDatabasesPath(), 'garage_inventory.db'),
    );

    await database.update(
      'spare_part_details',
      {
        'spare_part_price': newPrice,
        'spare_part_quantity': newQuantity,
      },
      where: 'spare_part_id = ?',
      whereArgs: [sparePartId],
    );

    ScaffoldMessenger.of(this.context).showSnackBar(
      SnackBar(content: Text('Spare part updated successfully!')),
    );

    setState(() {}); // Refresh the list
  }
  Future<void> deleteSparePart(BuildContext context, int sparePartId) async {
    final database = await openDatabase(
      join(await getDatabasesPath(), 'garage_inventory.db'),
    );

    // Fetch the spare part name before deleting
    final List<Map<String, dynamic>> result = await database.query(
      'spare_part_details',
      columns: ['spare_part_name'],
      where: 'spare_part_id = ?',
      whereArgs: [sparePartId],
    );

    // Check if the spare part exists and get its name
    String sparePartName = result.isNotEmpty ? result[0]['spare_part_name'] : 'Spare part';

    // Proceed to delete the spare part
    await database.delete(
      'spare_part_details',
      where: 'spare_part_id = ?',
      whereArgs: [sparePartId],
    );

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('$sparePartName deleted successfully!')),
    );

    setState(() {}); // Refresh the UI
  }

// Function to show the edit form
  void showEditForm(BuildContext context, Map<String, dynamic> sparePart) {
    priceController.text = sparePart['spare_part_price'].toString();
    quantityController.text = sparePart['spare_part_quantity'].toString();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Edit Spare Part'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: priceController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Price'),
              ),
              TextField(
                controller: quantityController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Quantity'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                // Reset the values to the original ones
                priceController.text = sparePart['spare_part_price'].toString();
                quantityController.text = sparePart['spare_part_quantity'].toString();
              },
              child: Text('Reset'),
            ),
            TextButton(
              onPressed: () {
                double newPrice = double.tryParse(priceController.text) ?? 0.0;
                int newQuantity = int.tryParse(quantityController.text) ?? 0;
                updateSparePart(sparePart['spare_part_id'], newPrice, newQuantity);
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Update'),
            ),
          ],
        );
      },
    );
  }

  void showDeleteConfirmation(BuildContext context, int sparePartId) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Confirm Delete'),
          content: Text('Are you sure you want to delete this spare part?'),
          actions: [
            TextButton(
              onPressed: () {
                deleteSparePart(context, sparePartId);
                Navigator.of(context).pop();
              },
              child: Text('Delete'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  void startSearch() {
    setState(() {
      isSearching = true;
    });
  }

  void stopSearch() {
    setState(() {
      isSearching = false;
      searchQuery = '';
      searchController.clear();
    });
  }

  void navigateToAddSparePartForm(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddSparePartForm()),
    ).then((_) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: isSearching
            ? TextField(
          controller: searchController,
          cursorColor: Colors.red,
          style: TextStyle(color: Colors.red),
          decoration: InputDecoration(
            hintText: 'Search Spare Parts',
            hintStyle: TextStyle(color: Colors.red),
            border: InputBorder.none,
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.red),
            ),
          ),
          onChanged: (query) {
            setState(() {
              searchQuery = query;
            });
          },
        )
            : Text(
          'Spare Part List',
          style: TextStyle(color: Colors.red),
        ),
        iconTheme: IconThemeData(color: Colors.red),
        actions: isSearching
            ? [
          IconButton(
            icon: Icon(Icons.close, color: Colors.red),
            onPressed: stopSearch,
          ),
        ]
            : [
          IconButton(
            icon: Icon(Icons.search, color: Colors.red),
            onPressed: startSearch,
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: Container(
        color: Colors.grey[800],
        child: FutureBuilder<List<Map<String, dynamic>>>(
          future: fetchFullSparePartTable(),

          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            }

            final spareParts = snapshot.data!;
            final filteredSpareParts = spareParts
                .where((sparePart) => sparePart['spare_part_name']
                .toString()
                .toLowerCase()
                .contains(searchQuery.toLowerCase()))
                .toList();

            return ListView.builder(
              itemCount: filteredSpareParts.length,
              itemBuilder: (context, index) {
                return Container(
                  // Set the background color to black
                  // color: Colors.black,
                  decoration: BoxDecoration(
                    // Add bottom border with grey[800] color
                    color: Colors.black26,
                    border: Border(

                      bottom: BorderSide(color: Colors.grey[800]!, width: 1),
                    ),
                  ),
                  child: ListTile(
                    title: Text(
                      filteredSpareParts[index]['spare_part_name'],
                      style: TextStyle(color: Colors.red[500], fontSize: 22),
                    ),
                    subtitle: Text(
                      'Rs.${filteredSpareParts[index]['spare_part_price']}  |  '
                          'Q: ${filteredSpareParts[index]['spare_part_quantity']}  |  '
                          'B: ${filteredSpareParts[index]['bike_name']}',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit, color: Colors.blue),
                          onPressed: () {
                            showEditForm(context, filteredSpareParts[index]);
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            showDeleteConfirmation(
                                context, filteredSpareParts[index]['spare_part_id']);
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          navigateToAddSparePartForm(context);
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.black,
        foregroundColor: Colors.red[500],
      ),
    );
  }
}
class AddSparePartForm extends StatefulWidget {
  @override
  _AddSparePartFormState createState() => _AddSparePartFormState();
}
class _AddSparePartFormState extends State<AddSparePartForm> {
  final TextEditingController sparePartNameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();
  final TextEditingController newBikeNameController = TextEditingController();

  String? selectedBike;
  List<Map<String, dynamic>> bikes = []; // Stores both bike names and IDs
  Map<String, int> bikeNameToIdMap = {}; // Maps bike names to their IDs

  @override
  void initState() {
    super.initState();
    fetchBikes();
  }

  Future<void> fetchBikes() async {
    final database = await openDatabase(
      join(await getDatabasesPath(), 'garage_inventory.db'),
    );

    final List<Map<String, dynamic>> maps = await database.query('bike_details');
    setState(() {
      bikes = maps;
      bikeNameToIdMap = {
        for (var bike in maps) bike['bike_name']: bike['bike_id'],
      };
    });
  }

  Future<void> addNewBike() async {
    final database = await openDatabase(
      join(await getDatabasesPath(), 'garage_inventory.db'),
    );

    await database.insert(
      'bike_details',
      {
        'bike_name': newBikeNameController.text,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    await fetchBikes();
    Navigator.pop(this.context);
  }

  Future<void> addSparePart() async {
    if (sparePartNameController.text.isEmpty ||
        priceController.text.isEmpty ||
        quantityController.text.isEmpty ||
        selectedBike == null) {
      ScaffoldMessenger.of(this.context).showSnackBar(
        SnackBar(
          content: Text('Please fill all fields and select a bike.'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    final int? bikeId = bikeNameToIdMap[selectedBike]; // Fetch the bike_id

    final database = await openDatabase(
      join(await getDatabasesPath(), 'garage_inventory.db'),
    );

    await database.insert(
      'spare_part_details',
      {
        'spare_part_name': sparePartNameController.text,
        'spare_part_price': double.tryParse(priceController.text) ?? 0,
        'spare_part_quantity': int.tryParse(quantityController.text) ?? 0,
        'bike_id': bikeId, // Include the bike_id in the data to be inserted
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    Navigator.pop(this.context);
    setState(() {});
  }

  void showAddBikeDialog() {
    showDialog(
      context: this.context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add New Bike'),
          content: TextField(
            controller: newBikeNameController,
            decoration: InputDecoration(
              labelText: 'Bike Name',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () async {
                if (newBikeNameController.text.isNotEmpty) {
                  await addNewBike();
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Please enter a bike name.'),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              },
              child: Text('Add Bike'),
            ),
          ],
        );
      },
    );
  }

  void resetForm() {
    setState(() {
      sparePartNameController.clear();
      priceController.clear();
      quantityController.clear();
      selectedBike = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Spare Part', style: TextStyle(fontFamily: 'Itim')),
      ),
      body: Container(
        color: Colors.grey[800],
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: sparePartNameController,
              decoration: InputDecoration(
                labelText: 'Spare Part Name',
                labelStyle: TextStyle(color: Colors.white),
              ),
              style: TextStyle(color: Colors.white),
            ),
            TextField(
              controller: priceController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Price',
                labelStyle: TextStyle(color: Colors.white),
              ),
              style: TextStyle(color: Colors.white),
            ),
            TextField(
              controller: quantityController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Quantity',
                labelStyle: TextStyle(color: Colors.white),
              ),
              style: TextStyle(color: Colors.white),
            ),
            DropdownButton<String>(
              value: selectedBike,
              hint: Text(
                'Select a Bike',
                style: TextStyle(color: Colors.white),
              ),
              dropdownColor: Colors.grey[600],
              isExpanded: false,
              iconEnabledColor: Colors.yellow,
              onChanged: (String? newValue) {
                if (newValue == '+') {
                  showAddBikeDialog();
                } else {
                  setState(() {
                    selectedBike = newValue;
                  });
                }
              },
              items: [
                DropdownMenuItem<String>(
                  value: '+',
                  child: Text(
                    '+ Add New Bike',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                ...bikes.map<DropdownMenuItem<String>>((Map<String, dynamic> bike) {
                  return DropdownMenuItem<String>(
                    value: bike['bike_name'],
                    child: Text(
                      bike['bike_name'],
                      style: TextStyle(color: Colors.white),
                    ),
                  );
                }).toList(),
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: addSparePart,
                  child: Text('ADD'),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.red[500],
                    backgroundColor: Colors.black,
                  ),
                ),
                ElevatedButton(
                  onPressed: resetForm,
                  child: Text('RESET'),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.red[500],
                    backgroundColor: Colors.black,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
//okq