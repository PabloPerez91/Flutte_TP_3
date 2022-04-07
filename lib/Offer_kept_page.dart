import 'package:exo_3/main.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'job.dart';

class Offer_kept extends StatefulWidget {
  const Offer_kept({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<Offer_kept> createState() => _Offer_keptState();
}

class _Offer_keptState extends State<Offer_kept> {

 late Box<Job> jobs;

@override
  void initState(){
    super.initState();
    jobs = Hive.box(MyApp.jobsbox);
  }

  // Fonction pour supprimer un job
 void suprJob(int numjob) async {
   jobs.deleteAt(numjob);
 }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: const Color.fromRGBO(51, 55, 61, 1),
      body: Center(
        child: ValueListenableBuilder(
          valueListenable: jobs.listenable(),
          builder: (context, Box<Job> box, widget){
            if (box.isEmpty) {
              return const Text(
                  "Veuillez rajouter des offres",
                  style: TextStyle(color: Colors.white,fontSize: 20,letterSpacing: 2)
              );
            }
            else {
              return Expanded(
                child:Scrollbar(
                  thickness: 10,
                  isAlwaysShown: true,
                  child: ListView.builder(
                    itemCount: box.length,
                    itemBuilder: (context, index){
                    Box<Job> currentBox = box;
                    Job job = currentBox.getAt(index)!;
                    return Container(
                        margin: const EdgeInsets.all(25.0),
                        padding: const EdgeInsets.all(25.0),

                        decoration: BoxDecoration(
                          color: const Color.fromRGBO(63, 68, 75, 1),
                          border: Border.all(
                              color: Colors.white38,
                              width: 2.0,
                              style: BorderStyle.solid),
                          //Border.all
                          borderRadius: const BorderRadius.all(
                            Radius.circular(10),
                          ), //BorderRadius.all
                        ),
                        child:Expanded(
                          child:Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children:[
                              Container(
                                padding: const EdgeInsets.all(25.0),

                                decoration: BoxDecoration(
                                  color: const Color.fromRGBO(63, 68, 75, 1),
                                  border: Border.all(
                                      color: Colors.white38,
                                      width: 2.0,
                                      style: BorderStyle.solid),
                                  //Border.all
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(10),
                                  ), //BorderRadius.all
                                ),
                                child:Text(
                                    "Entreprise : " + job.entreprise,
                                    style: const TextStyle(color: Colors.white,fontSize: 18,letterSpacing: 2)
                                ),
                              ),
                              const SizedBox(height: 10,),
                              Container(
                                padding: const EdgeInsets.all(25.0),

                                decoration: BoxDecoration(
                                  color: const Color.fromRGBO(63, 68, 75, 1),
                                  border: Border.all(
                                      color: Colors.white38,
                                      width: 2.0,
                                      style: BorderStyle.solid),
                                  //Border.all
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(10),
                                  ), //BorderRadius.all
                                ),
                                child:Text(
                                    "Le status est : " + job.status,
                                    style: const TextStyle(color: Colors.white,fontSize: 18,letterSpacing: 2)
                                ),
                              ),
                              const SizedBox(height: 10,),
                              Container(
                                padding: const EdgeInsets.all(25.0),

                                decoration: BoxDecoration(
                                  color: const Color.fromRGBO(63, 68, 75, 1),
                                  border: Border.all(
                                      color: Colors.white38,
                                      width: 2.0,
                                      style: BorderStyle.solid),
                                  //Border.all
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(10),
                                  ), //BorderRadius.all
                                ),
                                child:Text(
                                    "Le type de contrat est : " + job.contrattype,
                                    style: const TextStyle(color: Colors.white,fontSize: 18,letterSpacing: 2)
                                ),
                              ),
                              const SizedBox(height: 10,),
                              Container(
                                padding: const EdgeInsets.all(25.0),

                                decoration: BoxDecoration(
                                  color: const Color.fromRGBO(63, 68, 75, 1),
                                  border: Border.all(
                                      color: Colors.white38,
                                      width: 2.0,
                                      style: BorderStyle.solid),
                                  //Border.all
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(10),
                                  ), //BorderRadius.all
                                ),
                                child:Text(
                                    "Le salaire net proposé est de : " + job.salairenet.toString() + " €",
                                    style: const TextStyle(color: Colors.white,fontSize: 18,letterSpacing: 2)
                                ),
                              ),
                              const SizedBox(height: 10,),
                              Container(
                                padding: const EdgeInsets.all(25.0),

                                decoration: BoxDecoration(
                                  color: const Color.fromRGBO(63, 68, 75, 1),
                                  border: Border.all(
                                      color: Colors.white38,
                                      width: 2.0,
                                      style: BorderStyle.solid),
                                  //Border.all
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(10),
                                  ), //BorderRadius.all
                                ),
                                child:Text(
                                  "Sentiment pour l'offre d'emploie : " + job.sentiment,
                                  style: const TextStyle(color: Colors.white,fontSize: 18,letterSpacing: 2),
                                )
                              ),
                              const SizedBox(height: 15,),
                              FloatingActionButton.extended(
                                  onPressed: (){
                                    showDialog (
                                        context: context,
                                        builder: (_) => AlertDialog(
                                          title: const Text("Message"),
                                          content: const Text("Voulez-vous supprimer l'offre d'emploi sélectionné"),
                                          actions: <Widget>[
                                            TextButton.icon(
                                              label: const Text('Accepter'),
                                              icon: const Icon(Icons.check),
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                                suprJob(index);
                                              },
                                            ),
                                            TextButton.icon(
                                              label: const Text('Annuler'),
                                              icon: const Icon(Icons.close_outlined),
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                            )
                                          ],
                                        ));
                                  },
                                  backgroundColor: const Color.fromRGBO(211, 71, 48, 1),
                                  label: const Text("supprimer"),
                                  icon: const Icon(Icons.delete)
                              ),
                            ]
                          ),
                        ),
                      );
                    },
                  ),
                ),
              );
            }
          }
        ),
      ),
    );
  }
}
