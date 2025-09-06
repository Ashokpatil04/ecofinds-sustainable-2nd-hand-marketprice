import 'package:ecofinds_secondhand/productmodel.dart';
import 'package:flutter/material.dart';
class AddProductScreen extends StatefulWidget {
  @override
  _AddProductScreenState createState() => _AddProductScreenState();
}
class _AddProductScreenState extends State<AddProductScreen> {
  final _formKey = GlobalKey<FormState>();
  String _title = '';
  String _category = 'Electronics';
  String _description = '';
  double _price = 0.0;
  String _imageUrl = '';

  final List<String> _categories = ['Electronics', 'Clothing', 'Books'];

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      final newProduct = Product(
        title: _title,
        category: _category,
        description: _description,
        price: _price,
        imageUrl: _imageUrl.isNotEmpty
            ? _imageUrl
            : 'https://via.placeholder.com/150',
      );

      Navigator.pop(context, newProduct);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add New Product'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // Product Title
              TextFormField(
                decoration: InputDecoration(labelText: 'Product Title'),
                validator: (value) =>
                value!.isEmpty ? 'Please enter a title' : null,
                onSaved: (value) => _title = value!,
              ),
              // Category Dropdown
              DropdownButtonFormField<String>(
                value: _category,
                decoration: InputDecoration(labelText: 'Category'),
                items: _categories
                    .map((cat) => DropdownMenuItem(
                  child: Text(cat),
                  value: cat,
                ))
                    .toList(),
                onChanged: (val) => setState(() => _category = val!),
              ),
              // Description
              TextFormField(
                decoration: InputDecoration(labelText: 'Description'),
                maxLines: 3,
                validator: (value) =>
                value!.isEmpty ? 'Please enter a description' : null,
                onSaved: (value) => _description = value!,
              ),
              // Price
              TextFormField(
                decoration: InputDecoration(labelText: 'Price'),
                keyboardType:
                TextInputType.numberWithOptions(decimal: true),
                validator: (value) {
                  if (value!.isEmpty) return 'Enter a price';
                  if (double.tryParse(value) == null) return 'Invalid number';
                  return null;
                },
                onSaved: (value) => _price = double.parse(value!),
              ),
              SizedBox(height: 16),
              // Add Image (placeholder)
              ElevatedButton.icon(
                onPressed: () {
                  // This just sets a dummy image link; you'd integrate image picker here
                  setState(() {
                    _imageUrl = 'https://via.placeholder.com/150';
                  });
                },
                icon: Icon(Icons.image),
                label: Text('+ Add Image (Placeholder)'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitForm,
                child: Text('Submit Listing'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
