// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:fifthbeat_project/common_widgets/dialog.dart';
import 'package:flutter/material.dart';

class Permessi extends StatefulWidget {
  const Permessi({Key? key}) : super(key: key);

  @override
  State<Permessi> createState() => _PermessiState();
}

class _PermessiState extends State<Permessi> {
  @override
  void initState() {
    wrap = WrapperHolder();
    super.initState();
  }

  late List<bool> checkBoxValues = [false, false, false, false, false];
  late List<Widget> body = [];
  late WrapperHolder wrap;
  int i = 0;
  bool isAllChecked() {
    for (int k = 0; k < 5; k++) {
      print(checkBoxValues[k]);
      if (!checkBoxValues[k]) return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    Container _makeItem(String title, String content, int index) {
      return Container(
        child: Column(
          children: [
            CheckboxListTile(
                title: Text(
                  title,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                value: checkBoxValues[index],
                onChanged: (e) {
                  setState(() {
                    checkBoxValues[index] = (e ?? false);
                  });
                }),
            SizedBox(
                width: MediaQuery.of(context).size.width * 0.95,
                child: Text(content)),
          ],
        ),
      );
    }

    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: wrap.size,
              itemBuilder: (context, index) {
                checkBoxValues.add(false);
                return _makeItem(
                    wrap.getTitleAt(index), wrap.getContentAt(index), index);
              },
            ),
          ),
          SizedBox(
            height: 120,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(
                    "Annulla",
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xff157DB3),
                  ),
                  onPressed: () => isAllChecked()
                      ? Navigator.pushNamed(context, "/login")
                      : Dialogs().showMessageWithOneOptions(
                          context,
                          "Impossibile proseguire",
                          "Accettare tutti i termini è necessario per continuare"),
                  child: Text("Accetta"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class MultiTextWrapper {
  String title;
  String content;

  MultiTextWrapper({
    required this.title,
    required this.content,
  });

  String get getTitle => this.title;

  set setTitle(String title) => this.title = title;
  get getContent => this.content;

  set setContent(content) => this.content = content;
}

class WrapperHolder {
  List<MultiTextWrapper> wrapper = [];
  int size = 0;

  List<MultiTextWrapper> getWrap() => wrapper;

  String getTitleAt(int index) => wrapper[index].title;

  String getContentAt(int index) => wrapper[index].content;

  WrapperHolder() {
    this.wrapper = [
      MultiTextWrapper(
        title: "Condizioni generali",
        content:
            "Dichiaro di aver letto e di accettare il contenuto delle condizioni generali di Contratto e degli allegati in esso indicati.\nVedi allegato",
      ),
      MultiTextWrapper(
        title: "Clausole vessatorie",
        content:
            "Ai sensi e per gli effetti degli artt. 1341 e 1342 c.c., le Parti dichiarano di avere preso conoscenza del contenuto del contratto e di approvarne specificamente ed espressamente per iscritto le pattuizioni contenute nelle seguenti clausole: 2. Regole Generali; 3. Accesso all’Applicazione ed ai Servizi; 7. Avvertenze all’utilizzo; 8. Utilizzo del servizio “Ordina Farmaco”; 9. Utilizzo del servizio prenotazione di visite mediche specialistiche e/o esami diagnostici; 10. Esonero delle garanzie e responsabilità; 11. Responsabilità dell’utente; 12. Interruzione e sospensione dei servizi; 13. Modifica e cessazione dei servizi; 14 Links con altri siti; 15. Diritti di proprietà intellettuale; 17. Mediazione introdotta per i servizi di intermediazione online; 18. Legge applicabile e foro competente.",
      ),
      MultiTextWrapper(
        title: "Informativa privacy",
        content:
            "Dichiaro di aver letto la informativa privacy fornitami da XXXXXX s.r.l. in qualità di titolare del trattamento. Vedi allegato",
      ),
      MultiTextWrapper(
        title: "Trattamento dei dati",
        content:
            "Autorizzo XXXXXX s.r.l. al trattamento di categorie particolari di dati personali (i.e. dati idonei a rivelare il mio stato di salute) riferibili alla mia persona relativi al tipo di prestazione prenotata, ai motivi della visita ed alle ulteriori informazioni idonee a rilevare lo stato di salute comunque collegate alla prenotazione richiesta, per finalità di fornitura del servizio in conformità a quanto previsto nel contratto e nell’informativa privacy",
      ),
      MultiTextWrapper(
        title: "Finalità di marketing (Opzionale)",
        content:
            "Autorizzo il trattamento dei miei dati da parte di XXXXXX s.r.l. per finalità di marketing telefonico e/o a mezzo posta elettronica o ordinaria, compresi l’invio di materiale pubblicitario e la vendita diretta di prodotti del Titolare e/o di altre società del gruppo XXXXXX nonché lo svolgimento di indagini di mercato e questionari di customer satisfaction",
      ),
    ];
    size = wrapper.length;
  }
}
