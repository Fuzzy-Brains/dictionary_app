import 'dart:convert';

import 'package:dictionary_app/backend.dart';
import 'package:dictionary_app/constants.dart';
import 'package:dictionary_app/models/error.dart';
import 'package:dictionary_app/models/response.dart';
import 'package:dictionary_app/models/response1.dart';
import 'package:dictionary_app/models/response2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dialogs/flutter_dialogs.dart';
import 'package:flutter_dropdown/flutter_dropdown.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

import '../models/response2.dart';
import '../models/response2.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({Key? key}) : super(key: key);

  @override
  _DashboardViewState createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  final TextEditingController _controller = TextEditingController();
  List<String> codes = ['SELECT', 'ENGLISH', 'HINDI', 'CHHATTISGARI'];
  var dropdownValue = "ENGLISH";
  final String BASE_URL = 'https://api.dictionaryapi.dev/api/v2/entries/';
  final String APP_ID = '319abc3c';
  final String APP_KEY = '0baf90ac56e59199c756c7bbcce7b08d';
  Response2? response2;
  bool _loading = false;

  _onChanged(String text) async {
    if (text.isEmpty) {

    }

    String word = text.toString().trim();

  }

  _search() async {
    if (_controller.text.isEmpty) {

    }

    String word = _controller.text.toString().trim();


  }

   Map<String, String> languageCodes = {
    'ENGLISH' : 'en', 'HINDI' : 'hi', 'CHHATTISGARI' : 'rg'
  };

  submit() async{
    String? code = languageCodes[dropdownValue];
    String word = _controller.text.toString().trim();

    word = word.toLowerCase();

    call(word, code!);
  }

  // english(String word, String code) async{
  //   var response = await http.get(
  //     Uri.parse(BASE_URL + code +  '/' + word),
  //   );
  //
  //   // print(jsonDecode(response.body));
  //
  //   try{
  //     List responses = jsonDecode(response.body);
  //     List<Response> Responses1 = [];
  //     for(var x in responses){
  //       Response r = Response.fromJson(x);
  //       Responses1.add(r);
  //     }
  //
  //     setState(() {
  //       Responses = Responses1;
  //       _loading = false;
  //       Results.clear();
  //     });
  //     // for(Response r in Responses){
  //     //   print(r.toJson());
  //     // }
  //   }catch(e){
  //     try{
  //       ErrorResponse errorResponse = ErrorResponse.fromJson(jsonDecode(response.body));
  //       if(response.statusCode==404){
  //         setState(() {
  //           Responses.clear();
  //           _loading = false;
  //           Results.clear();
  //         });
  //       }
  //     }catch(e){
  //       setState(() {
  //         Responses.clear();
  //         _loading = false;
  //         Results.clear();
  //       });
  //     }
  //
  //     if(Responses.isEmpty && Results.isEmpty){
  //       showPlatformDialog(context: context,
  //           builder: (context) => BasicDialogAlert(
  //             title: Text('Word Not Found.', style: GoogleFonts.lato(
  //                 fontWeight: FontWeight.bold, fontSize: 22, color: primaryColor),),
  //             content: Text(
  //               'Sorry, the word you entered cannot be found in our database. '
  //                   'But We are constantly adding data to our database. Please help us by sending an email to us '
  //                   'about the details of this word.', style: GoogleFonts.lato(fontSize: 18),
  //             ),
  //             actions: [
  //               BasicDialogAction(
  //                 title: Text('OK', style: GoogleFonts.lato(fontSize: 18, color: primaryColor,
  //                     fontWeight: FontWeight.bold),),
  //                 onPressed: (){
  //                   Navigator.pop(context);
  //                 },
  //               )
  //             ],
  //           ));
  //     }
  //   }
  // }

  call(String word, String code) async{
    Response2? res = await apiCall(word, code);
    setState(() {
      response2 = res;
      _loading = false;
    });

    if(response2 == null){
      showPlatformDialog(context: context,
          builder: (context) => BasicDialogAlert(
            title: Text('Word Not Found.', style: GoogleFonts.lato(
                fontWeight: FontWeight.bold, fontSize: 22, color: primaryColor),),
            content: Text(
              'Sorry, the word you entered cannot be found in our database. '
                  'But We are constantly adding data to our database. Please help us by sending an email to us '
                  'about the details of this word.', style: GoogleFonts.lato(fontSize: 18),
            ),
            actions: [
              BasicDialogAction(
                title: Text('OK', style: GoogleFonts.lato(fontSize: 18, color: primaryColor,
                    fontWeight: FontWeight.bold),),
                onPressed: (){
                  Navigator.pop(context);
                },
              )
            ],
          ));
    }
  }

  // regional(String word, String code) async{
  //   var response = await http.post(
  //     Uri.parse('https://dictionary-api-fuzzy-brains.herokuapp.com/api/fetchDefinitionByWord'),
  //     body: {
  //       'word': word,
  //       'languageCode': code
  //     }
  //   );
  //
  //   // print(response.body);
  //   List responses = jsonDecode(response.body)['result'];
  //   List<Response1> Results1 = [];
  //   for(var x in responses){
  //     Response1 r= Response1.fromJson(x);
  //     Results1.add(r);
  //   }
  //
  //   setState(() {
  //     Results = Results1;
  //     _loading = false;
  //     Responses.clear();
  //   });
  //
  //   if(Responses.isEmpty && Results.isEmpty){
  //
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 24, vertical: 24),
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            color: Color(0xFFF3F3F3),
            height: 310,
            child: Column(
              children: [
                Container(
                  child: Text('Enter word to search',
                    style: GoogleFonts.lato(fontSize: 20, fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic, color: Colors.black ),),
                ),
                SizedBox(height: 14,),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20)
                  ),
                  child: TextFormField(
                    autofocus: false,
                    cursorColor: primaryColor,
                    onChanged: _onChanged,
                    controller: _controller,
                    decoration: InputDecoration(
                        labelStyle: GoogleFonts.lato(fontSize: 16, ),
                        hintText: 'Search for a word',
                        hintStyle: GoogleFonts.lato(fontSize: 16, ),
                        contentPadding: EdgeInsets.only(left: 24),
                        border: InputBorder.none),
                  ),
                ),
                SizedBox(height: 14,),
                Container(
                  child: Text('Select Language',
                    style: GoogleFonts.lato(fontSize: 20, fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic, color: Colors.black ),),
                ),
                SizedBox(height: 14,),
                Container(
                  // margin: const EdgeInsets.symmetric(
                  //     horizontal: 18.0, vertical: 8.0),
                    padding: EdgeInsets.only(left: 20),
                    // alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                    ),
                    child: DropDown<String>(
                      icon: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(Icons.arrow_drop_down_circle_outlined, color: primaryColor,),
                      ),
                      showUnderline: false,
                      dropDownType: DropDownType.Button,
                      hint: Text('Select Language'),
                      items: codes,
                      initialValue: dropdownValue,
                      onChanged: (language) {
                        setState(() {
                          dropdownValue = language!;
                        });
                      },
                    )
                ),
                SizedBox(height: 14,),
                MaterialButton(onPressed: (){
                  setState(() {
                    _loading = true;
                  });
                  submit();
                },
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: primaryColor,
                    ),
                    child: Center(
                      child: Text('Submit', style: GoogleFonts.lato(fontSize: 20, fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic, color: Colors.white ),),
                    ),
                  ),
                )
              ],
            ),
          ),

          SizedBox(height: 24,),
          _loading ? Center(
            child: Column(
              children: [
                Text('Searching..Please wait...', style: GoogleFonts.lato(fontSize: 17,
                    fontWeight: FontWeight.bold, color: primaryColor ),),
                SizedBox(height: 8,),
                CircularProgressIndicator(color: primaryColor,)
              ],
            ),
          ) : response2==null ? Center(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: Text('Please enter a valid word to search.',
                style: GoogleFonts.lato(fontSize: 20, fontStyle: FontStyle.italic,
                    color: primaryColor, fontWeight: FontWeight.bold),),
            ),
          ) : ListTileWidget2(listItem: response2!)
        ],
      ),
    );
  }
}

class ListTileWidget extends StatefulWidget {
  final Response listItem;
  const ListTileWidget({Key? key, required this.listItem}) : super(key: key);

  @override
  _ListTileWidgetState createState() => _ListTileWidgetState();
}

class _ListTileWidgetState extends State<ListTileWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 24, vertical: 24),
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      // height: 300,
      color: Color(0xFFF3F3F3),
      child: ListTile(
        title: Text(widget.listItem.word, style: GoogleFonts.lato(fontSize: 36, fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic, color: Colors.black ),),
        trailing: Text(widget.listItem.meanings[0].partOfSpeech, style: GoogleFonts.lato(fontSize: 22,
            fontStyle: FontStyle.italic, color: Colors.black ),),
        subtitle: Text(widget.listItem.meanings[0].definitions[0].definition, style: GoogleFonts.lato(fontSize: 20,
            fontStyle: FontStyle.italic, color: Colors.black ),),
      ),
    );
  }
}

class ListTileWidget2 extends StatefulWidget {
  final Response2 listItem;
  const ListTileWidget2({Key? key, required this.listItem}) : super(key: key);

  @override
  _ListTileWidget2State createState() => _ListTileWidget2State();
}

class _ListTileWidget2State extends State<ListTileWidget2> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 24, vertical: 24),
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      // height: 300,
      color: Color(0xFFF3F3F3),
      // child: ListTile(
      //   title: Text(widget.listItem.english, style: GoogleFonts.lato(fontSize: 36, fontWeight: FontWeight.bold,
      //       fontStyle: FontStyle.italic, color: Colors.black ),),
      //   trailing: Text(widget.listItem.hindi, style: GoogleFonts.lato(fontSize: 22,
      //       fontStyle: FontStyle.italic, color: Colors.black ),),
      //   subtitle: Text(widget.listItem.chhattisgarhi, style: GoogleFonts.lato(fontSize: 20,
      //       fontStyle: FontStyle.italic, color: Colors.black ),),
      // ),

      child: ListTile(
        title: Text('Description of the word', style: GoogleFonts.lato(fontSize: 24, fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic, color: Colors.black ),),
        subtitle: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 8),
              child: Text('English (en) : ${widget.listItem.english}',
                style: GoogleFonts.lato(fontSize: 20,
                  fontStyle: FontStyle.italic, color: Colors.black ),),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 8),
              child: Text('Hindi (hi) : ${widget.listItem.hindi}',
                style: GoogleFonts.lato(fontSize: 20,
                    fontStyle: FontStyle.italic, color: Colors.black ),),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 8),
              child: Text('Chhattisgarhi (cg) : ${widget.listItem.chhattisgarhi}',
                style: GoogleFonts.lato(fontSize: 20,
                    fontStyle: FontStyle.italic, color: Colors.black ),),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 8),
              child: Text('Part of speech : ${widget.listItem.partOfSpeech}',
                style: GoogleFonts.lato(fontSize: 20,
                    fontStyle: FontStyle.italic, color: Colors.black ),),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 8),
              child: Text('Meaning : ${widget.listItem.meaning}',
                style: GoogleFonts.lato(fontSize: 20,
                    fontStyle: FontStyle.italic, color: Colors.black ),),
            ),
          ],
        ),
      ),
    );
  }
}
