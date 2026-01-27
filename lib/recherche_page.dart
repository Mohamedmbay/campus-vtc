import 'dart:async';
import 'package:flutter/material.dart';
import 'historique_page.dart';

List<String> historiqueCourses = [];

class RecherchePage extends StatefulWidget {
  final String destination;

  RecherchePage({required this.destination});

  @override
  State<RecherchePage> createState() => _RecherchePageState();
}

class _RecherchePageState extends State<RecherchePage> {

  bool chauffeurTrouve = false;

  String chauffeurNom = "Moussa Diallo";
  String voiture = "Toyota Corolla";
  String plaque = "DK-2345-AA";

  @override
  void initState() {
    super.initState();

    Timer(Duration(seconds: 3), () {
      setState(() {
        chauffeurTrouve = true;
        historiqueCourses.add(widget.destination);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Recherche chauffeur"),
        backgroundColor: Colors.deepPurple,
      ),
      body: Center(
        child: chauffeurTrouve
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  Icon(Icons.check_circle, size: 80, color: Colors.green),
                  SizedBox(height: 15),

                  Text("Chauffeur trouvé !",
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),

                  SizedBox(height: 20),

                  Text("Nom : $chauffeurNom"),
                  Text("Voiture : $voiture"),
                  Text("Plaque : $plaque"),

                  SizedBox(height: 30),

                  ElevatedButton.icon(
                    icon: Icon(Icons.phone),
                    label: Text("Appeler le chauffeur"),
                    onPressed: () {},
                  ),

                  ElevatedButton.icon(
                    icon: Icon(Icons.history),
                    label: Text("Historique"),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              HistoriquePage(courses: historiqueCourses),
                        ),
                      );
                    },
                  ),

                  ElevatedButton.icon(
                    icon: Icon(Icons.map),
                    label: Text("Voir carte"),
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Carte bientôt disponible")),
                      );
                    },
                  ),
                ],
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  CircularProgressIndicator(color: Colors.deepPurple),
                  SizedBox(height: 20),
                  Text("Recherche d'un chauffeur..."),

                ],
              ),
      ),
    );
  }
}
