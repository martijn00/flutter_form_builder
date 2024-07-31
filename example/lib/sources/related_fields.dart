import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class RelatedFields extends StatefulWidget {
  const RelatedFields({super.key});

  @override
  State<RelatedFields> createState() => _RelatedFieldsState();
}

class _RelatedFieldsState extends State<RelatedFields> {
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();
  String country = '';
  String city = '';
  List<String> cities = <String>[];

  @override
  void initState() {
    country = _allCountries.first;
    city = _allUsaCities.first;
    cities = _allUsaCities;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FormBuilder(
      key: _formKey,
      child: Column(
        children: <Widget>[
          const SizedBox(height: 20),
          FormBuilderDropdown<String>(
            name: 'country',
            decoration: const InputDecoration(
              label: Text('Countries'),
            ),
            initialValue: country,
            onChanged: (String? value) {
              setState(() {
                country = value ?? '';
                city = '';
                changeCities();
              });
            },
            items: _allCountries
                .map((String e) => DropdownMenuItem<String>(
                      value: e,
                      child: Text(e),
                    ))
                .toList(),
          ),
          const SizedBox(height: 10),
          FormBuilderDropdown<String>(
            name: 'city',
            decoration: const InputDecoration(
              label: Text('Cities'),
            ),
            initialValue: city,
            items: cities
                .map((String e) => DropdownMenuItem<String>(
                      value: e,
                      child: Text(e),
                    ))
                .toList(),
          ),
          const SizedBox(height: 10),
          MaterialButton(
            color: Theme.of(context).colorScheme.secondary,
            child: const Text(
              "Submit",
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () {
              _formKey.currentState!.saveAndValidate();
              debugPrint(_formKey.currentState?.instantValue.toString() ?? '');
            },
          ),
        ],
      ),
    );
  }

  void changeCities() {
    switch (country) {
      case 'France':
        cities = _allFranceCities;
        break;
      case 'United States':
        cities = _allUsaCities;
        break;
      default:
        cities = <String>[];
    }
  }
}

const List<String> _allCountries = <String>[
  'United States',
  'France',
];

const List<String> _allUsaCities = <String>[
  'California',
  'Another city',
];

const List<String> _allFranceCities = <String>[
  'Paris',
  'Another city',
];
