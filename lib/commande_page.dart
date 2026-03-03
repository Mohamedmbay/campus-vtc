import 'package:flutter/material.dart';
import 'recherche_page.dart';
import 'services/api_service.dart';

class CommandePage extends StatefulWidget {
  @override
  State<CommandePage> createState() => _CommandePageState();
}

class _CommandePageState extends State<CommandePage> {

  final TextEditingController destinationController = TextEditingController();
  String typeVehicule = "Standard";
  String selectedType = "Standard";

  double calculerPrix(String destination) {
    double prix = 500 + destination.length * 50;
    if (typeVehicule == "Premium") {
      prix = prix * 1.5;
    }
    return prix;
  }

  @override
  Widget build(BuildContext context) {

    bool destinationVide = destinationController.text.isEmpty;

    return Scaffold(
      appBar: AppBar(
        title: Text("Commander une voiture"),
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Text(
              "Point de départ : Campus",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: 20),

            TextField(
              controller: destinationController,
              onChanged: (value) {
                setState(() {});
              },
              decoration: InputDecoration(
                labelText: "Destination",
                filled: true,
                fillColor: Colors.grey.shade100,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),

            SizedBox(height: 20),

            Text(
              "Type de véhicule",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),

            RadioListTile(
              title: Text("Standard"),
              value: "Standard",
              groupValue: typeVehicule,
              onChanged: (value) {
                setState(() {
                  typeVehicule = value.toString();
                });
              },
            ),

            RadioListTile(
              title: Text("Premium"),
              value: "Premium",
              groupValue: typeVehicule,
              onChanged: (value) {
                setState(() {
                  typeVehicule = value.toString();
                });
              },
            ),

            SizedBox(height: 30),

            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
         onPressed: destinationVide ? null : () {

  String destination = destinationController.text;
  double prix = calculerPrix(destination);

  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return AlertDialog(
        title: Text("Commande réussie"),
        content: Text(
          "Départ : Campus\n"
          "Destination : $destination\n"
          "Véhicule : $typeVehicule\n"
          "Prix estimé : ${prix.toStringAsFixed(0)} FCFA",
        ),
        actions: [
          TextButton(
      onPressed: () async {
  String destination = destinationController.text;
  double prix = calculerPrix(destination);

  // ✅ ENVOI AU BACKEND
  await ApiService.createCourse(
    destination: destination,
    typeVehicule: selectedType,
    prix: prix,
  );

  // ✅ Ferme le popup
  Navigator.pop(context);

  // ✅ Navigation vers recherche chauffeur
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => RecherchePage(
        destination: destination,
      ),
    ),
  );
},
            child: Text("OK"),
          ),
        ],
      );
    },
  );

},

                child: Text(
                  "Valider la course",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
