import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:samera_app/core/styles/colors/colors.dart';
import 'package:samera_app/core/styles/typography/text_styles.dart';

void showTransportationDialog(BuildContext context, {required String currentValue, required void Function(String) onSave}) {
  final Map<String, String> options = {
    'motor': 'Motor',
    'mobil': 'Mobil',
    'kereta': 'Kereta',
    'pesawat': 'Pesawat',
    'kapal': 'Kapal',
  };

  showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        elevation: 0,
        backgroundColor: Colors.transparent,
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Atur Transportasi', style: tsTitleMediumSemiBold(Colors.black87)),
              const SizedBox(height: 16),
              ...options.entries.map((entry) {
                return ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(entry.value, style: tsBodyMediumRegular(Colors.black87)),
                  trailing: currentValue == entry.key ? const Icon(Icons.check, color: ColorsResources.colorsPrimary) : null,
                  onTap: () {
                    onSave(entry.key);
                    Navigator.pop(context);
                  },
                );
              }),
            ],
          ),
        ),
      );
    }
  );
}

void showInterestDialog(BuildContext context, {required List<String> currentValues, required void Function(List<String>) onSave}) {
  final Map<String, String> options = {
    'destination': 'Destinasi',
    'heritage': 'Sejarah',
    'cuisine': 'Kuliner',
    'culture': 'Budaya',
    'local_experience': 'Aktivitas Lokal',
  };

  List<String> selected = List.from(currentValues);

  showDialog(
    context: context,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return Dialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
            elevation: 0,
            backgroundColor: Colors.transparent,
            child: Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Atur Minat', style: tsTitleMediumSemiBold(Colors.black87)),
                  const SizedBox(height: 16),
                  Flexible(
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: options.entries.map((entry) {
                          return CheckboxListTile(
                            contentPadding: EdgeInsets.zero,
                            title: Text(entry.value, style: tsBodyMediumRegular(Colors.black87)),
                            value: selected.contains(entry.key),
                            onChanged: (bool? val) {
                              setState(() {
                                if (val == true) {
                                  selected.add(entry.key);
                                } else {
                                  selected.remove(entry.key);
                                }
                              });
                            },
                            activeColor: ColorsResources.colorsPrimary,
                            controlAffinity: ListTileControlAffinity.leading,
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      Expanded(
                        child: TextButton(
                          onPressed: () => Navigator.pop(context),
                          style: TextButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                          ),
                          child: Text('Batal', style: tsBodyMediumMedium(Colors.grey[600]!)),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            onSave(selected);
                            Navigator.pop(context);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: ColorsResources.colorsPrimary,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            elevation: 0,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                          ),
                          child: Text('Simpan', style: tsBodyMediumSemiBold(Colors.white)),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      );
    }
  );
}

void showCityDialog(BuildContext context, {required String currentValue, required void Function(String) onSave}) {
  showDialog(
    context: context,
    builder: (context) {
      return FutureBuilder<String>(
        future: rootBundle.loadString('assets/data/regions.json'),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
             return const AlertDialog(
               content: SizedBox(
                 height: 100, 
                 child: Center(child: CircularProgressIndicator())
               )
             );
          }
          
          List<dynamic> data = jsonDecode(snapshot.data!);
          List<Map<String, dynamic>> regions = data.cast<Map<String, dynamic>>();

          return Dialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
            elevation: 0,
            backgroundColor: Colors.transparent,
            child: Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Atur Kota Favorit', style: tsTitleMediumSemiBold(Colors.black87)),
                  const SizedBox(height: 16),
                  Flexible(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: regions.length,
                      itemBuilder: (context, index) {
                        final region = regions[index];
                        final String id = region['id'];
                        final String name = region['name'];

                        return ListTile(
                          contentPadding: EdgeInsets.zero,
                          title: Text(name, style: tsBodyMediumRegular(Colors.black87)),
                          trailing: currentValue == id ? const Icon(Icons.check, color: ColorsResources.colorsPrimary) : null,
                          onTap: () {
                            onSave(id);
                            Navigator.pop(context);
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        }
      );
    }
  );
}
