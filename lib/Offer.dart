import 'package:exo_3/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'job.dart';

class Offer extends StatefulWidget {
  const Offer({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<Offer> createState() => _OfferState();
}

class _OfferState extends State<Offer> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final ScrollController _scrollController = ScrollController();

  TextEditingController entreprise = TextEditingController();
  TextEditingController salairebrut = TextEditingController();
  TextEditingController salairenet = TextEditingController();
  TextEditingController sentiment = TextEditingController();

  int? _valuechoicechip = 0;

  int _contrat = 0;

  List<String> options = [
    'Non Cadre',
    'Cadre',
    'Fonction Publique',
    'Profession Libérale',
    'Portage Salarial'
  ];

  var itemstype = <String>[
    "CDI",
    "CDD",
    "CTT",
    "CA",
    "CP",
    "CUI",
    "CAE",
    "CIE"
  ];

  late Box<Job> jobs;

  @override
  void initState(){
    super.initState();
    jobs = Hive.box(MyApp.jobsbox);
  }

// Fonction pour ajouter un job j'utilise l'ordre de mon constructeur pour remplir mes variables
  void addJob() async {
    Job job = Job(
       entreprise.text,
       double.parse(salairenet.text),
       options[_valuechoicechip!],
       double.parse(salairebrut.text),
       sentiment.text,
       itemstype[_contrat],
    );
    jobs.add(job);
  }

  // Fonction pour faire apparaître un message lorsque luilisateur clique sur sauvegarder
  onPressHander()  {
    showDialog (
        context: context,
        builder: (_) => AlertDialog(
          title: const Text("Message"),
          content: const Text("Vous avez sauvegardé votre offre avec succès"),
          actions: <Widget>[
            TextButton.icon(
              label: const Text('Fermer'),
              icon: const Icon(Icons.close_outlined),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        ));
  }

  // Fonction pour passer du brut au net
  void updatePaybruttonet(String text){
    if (text != "") {
      double sb = (double.parse(salairebrut.text) / 12);
      if (text=="Cadre"){
        salairenet.text = (sb*0.75).toStringAsFixed(0);
      }
      else if(text=="Non Cadre"){
        salairenet.text = (sb*0.78).toStringAsFixed(0);
      }
      else if(text=="Fonction Publique"){
        salairenet.text = (sb*0.85).toStringAsFixed(0);
      }
      else if(text=="Profession Libérale"){
      salairenet.text = (sb*0.55).toStringAsFixed(0);
      }
      else if(text=="Portage Salarial"){
      salairenet.text = (sb*0.49).toStringAsFixed(0);
      }
    } else {
      salairenet.text = "";
    }
  }
  // Fonction pour passer du net au brut
  void updatePaynettobrut(String text){
    if (text != "") {
      double sb = (double.parse(salairenet.text) * 12);
      if (text=="Cadre"){
        salairebrut.text = (sb/0.75).toStringAsFixed(0);
      }
      else if(text=="Non Cadre"){
        salairebrut.text = (sb/0.78).toStringAsFixed(0);
      }
      else if(text=="Fonction Publique"){
        salairebrut.text = (sb/0.85).toStringAsFixed(0);
      }
      else if(text=="Profession Libérale"){
        salairebrut.text = (sb/0.55).toStringAsFixed(0);
      }
      else if(text=="Portage Salarial"){
        salairebrut.text = (sb/0.49).toStringAsFixed(0);
      }
    } else {
      salairebrut.text = "";
    }
  }
  // J'ai créé mon choicechip pour que cela sois plus simple à utiliser
  Widget categoriesList(BuildContext context) {

    return Wrap(
      spacing: 25,
      runSpacing: 25,
      children: List<Widget>.generate(
        options.length,
            (int idx) {
          return ChoiceChip(
              label: Text(options[idx]),
              labelStyle: const TextStyle(color: Colors.white,letterSpacing: 2),
              selected: _valuechoicechip == idx,
              avatar: const Icon(Icons.person, color: Colors.white, size: 20),
              backgroundColor: Colors.black54,
              padding: const EdgeInsets.all(15),
              selectedColor: Colors.blue,
              onSelected: (bool selected) {
                setState(() {
                  _valuechoicechip = selected ? idx : null;
                  updatePaybruttonet(options[idx]);
                  updatePaynettobrut(options[idx]);
                }
              );
            }
          );
        },
      ).toList(),
    );
  }

  // Le contenu de ma page
  @override
  Widget build(BuildContext context) {

    double deviceWidth = MediaQuery.of(context).size.width;
    // je l'utilise pour que l'écran s'adapte entre un écran d'ordinateur et un téléphone

    return Scaffold(
        backgroundColor: const Color.fromRGBO(63, 68, 75, 1),
        body: Center(
          child:SingleChildScrollView(
          child: Container(

            margin: const EdgeInsets.all(15.0),
            padding: const EdgeInsets.all(15.0),

            decoration: BoxDecoration(
            color: const Color.fromRGBO(63, 68, 75, 1),
            border: Border.all(
            color: const Color.fromRGBO(78, 83, 91, 1),
            width: 4.0,
            style: BorderStyle.solid),
            //Border.all
            borderRadius: const BorderRadius.all(
            Radius.circular(6),
            ), //BorderRadius.all
            ),
            child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      controller: entreprise,
                      keyboardType: TextInputType.text,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                          fillColor: Colors.white,
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                            borderSide: const BorderSide(
                              color: Colors.blue,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                            borderSide: const BorderSide(
                              color: Colors.white38,
                              width: 2.0,
                            ),
                          ),
                          labelStyle: const TextStyle(
                              color: Colors.white,letterSpacing: 2,
                          ),
                          labelText: "Nom de l'entreprise",
                          hintStyle: const TextStyle(
                              color: Colors.white,letterSpacing: 2,
                          ),
                          hintText: "Entrer le nom de l'entreprise",
                          icon: const Icon(Icons.corporate_fare, color: Colors.blue, size: 35),
                          border: const OutlineInputBorder()),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Veuillez saisir le Nom de l'entreprise";
                        }
                        return null;
                      },
                    ),
                    const SizedBox( height: 25.0, ),
                    TextFormField(
                      controller: salairebrut,
                      onChanged:(text){ updatePaybruttonet(options[_valuechoicechip!]);},
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      keyboardType: TextInputType.number,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                          fillColor: Colors.white,
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                            borderSide: const BorderSide(
                              color: Colors.blue,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                            borderSide: const BorderSide(
                              color: Colors.white38,
                              width: 2.0,
                            ),
                          ),
                          labelStyle: const TextStyle(
                              color: Colors.white,letterSpacing: 2,
                          ),
                          labelText: "Salaire Brut Annuel",
                          hintStyle: const TextStyle(
                              color: Colors.white,letterSpacing: 2,
                          ),
                          hintText: 'Entrer du texte',
                          icon: const Icon(Icons.attach_money_rounded, color: Colors.green, size: 35),
                          border: const OutlineInputBorder()),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Veuillez saisir le salaire brut';
                        }
                        return null;
                      },
                    ),
                    const SizedBox( height: 20.0, ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        const Icon(Icons.arrow_forward_rounded, color: Colors.white, size: 35),
                        const SizedBox(width: 20),
                        SizedBox(
                          height: 40,
                          width: deviceWidth * 0.65,
                          child:RawScrollbar(
                            controller: _scrollController,
                            thumbColor: Colors.cyanAccent,
                            radius: const Radius.circular(20),
                            thickness: 5,
                            isAlwaysShown: true,
                            child:ListView(
                              controller: _scrollController,
                              scrollDirection: Axis.horizontal,
                              children:[
                                categoriesList(context),
                              ]
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox( height: 20.0, ),
                    Row(
                     children:[
                      const Icon(Icons.account_circle_rounded, color: Colors.white, size: 35),
                      const SizedBox(width: 20),
                       SizedBox(
                         width: deviceWidth * 0.30,

                         child:DropdownButtonFormField(

                           decoration: InputDecoration(

                             enabledBorder: OutlineInputBorder(

                               borderSide: const BorderSide(color: Colors.black38, width: 2),
                               borderRadius: BorderRadius.circular(20),
                             ),

                             border: OutlineInputBorder(

                               borderSide: const BorderSide(color: Colors.black38, width: 2),
                               borderRadius: BorderRadius.circular(20),
                             ),

                             filled: true,
                             fillColor: const Color.fromRGBO(115, 115, 115, 1),
                           ),

                           icon: const Padding(
                             //Icon at tail, arrow bottom is default icon
                               padding: EdgeInsets.only(left:20),
                               child:Icon(Icons.arrow_circle_down_sharp, color: Colors.black38, size: 25,)
                           ),

                           iconEnabledColor: Colors.blue,
                           dropdownColor: Colors.blue,
                           style: const TextStyle(color:Colors.white),
                           value: _contrat == null ? null : itemstype[_contrat],
                           items: itemstype.map((String value) {
                             return DropdownMenuItem(
                                 value: value,
                                 child: Text(
                                     value,
                                     style: const TextStyle(fontSize: 18,letterSpacing: 2) ,
                                 )
                             );
                           }).toList(),

                           onChanged: (value) {
                             setState(() {
                               _contrat = itemstype.indexOf(value as String);
                             });
                           },
                         ),
                       ),
                      ]
                    ),

                    const SizedBox( height: 20.0, ),

                    TextFormField(

                      controller: salairenet,
                      onChanged:(text){ updatePaynettobrut(options[_valuechoicechip!]);},
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      keyboardType: TextInputType.number,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                          fillColor: Colors.white,
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                            borderSide: const BorderSide(
                              color: Colors.blue,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                            borderSide: const BorderSide(
                              color: Colors.white38,
                              width: 2.0,
                            ),
                          ),
                          labelStyle: const TextStyle(
                              color: Colors.white,letterSpacing: 2,
                          ),
                          labelText: "Salaire Net Mensuel",
                          hintStyle: const TextStyle(
                              color: Colors.white,letterSpacing: 2,
                          ),
                          hintText: 'Entrer du texte',
                          icon: const Icon(Icons.attach_money_rounded, color: Colors.green, size: 35),
                          border: const OutlineInputBorder()),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Veuillez saisir le salaire net';
                        }
                        return null;
                      },
                    ),
                    const SizedBox( height: 25.0, ),
                    TextFormField(
                      controller: sentiment,
                      style: const TextStyle(color: Colors.white,letterSpacing: 2),
                      keyboardType: TextInputType.multiline,
                      maxLines: null, // l'utilisateur écrit une description sans qu'il ne soit limité
                      decoration: InputDecoration(
                          fillColor: Colors.white,
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                            borderSide: const BorderSide(
                              color: Colors.blue,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                            borderSide: const BorderSide(
                              color: Colors.white38,
                              width: 2.0,
                            ),
                          ),
                          labelStyle: const TextStyle(
                              color: Colors.white,letterSpacing: 2,
                          ),
                          labelText: "Mon Sentiment",
                          hintStyle: const TextStyle(
                              color: Colors.white,letterSpacing: 2,
                          ),
                          hintText: 'Entrer du texte',
                          icon: const Icon(Icons.favorite, color: Colors.red, size: 35),
                          border: const OutlineInputBorder()),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Veuillez saisir une description';
                        }
                        return null;
                      },
                    ),
                    const SizedBox( height: 25.0, ),
                    Padding(
                      padding: const EdgeInsets.all(15),
                      child:ElevatedButton.icon(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            addJob();
                            onPressHander();
                          }
                        },
                        style: ButtonStyle(padding: MaterialStateProperty.all(const EdgeInsets.all(20))),
                        icon: const Icon(
                          Icons.send,
                        ),
                        label: const Text(
                          "Sauvegarder",
                          style: TextStyle(fontSize: 20.0,color: Colors.white,letterSpacing: 2),
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