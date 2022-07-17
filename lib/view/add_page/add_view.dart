import 'package:flutter/material.dart';
import 'package:learn_english/core/constants/app/app_constants.dart';
import 'package:learn_english/core/providers/words_provider.dart';
import 'package:provider/provider.dart';

class AddPage extends StatelessWidget {
  const AddPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController english = TextEditingController();
    TextEditingController turkish = TextEditingController();
    final words = Provider.of<WordsProvider>(context);
    return Scaffold(
      backgroundColor: AppConstants.backgroundColor,
      appBar: appBar(),
      body: GridView.builder(
        padding: const EdgeInsets.all(8),
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (_, index) {
          return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: AppConstants.boxDecoration,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Positioned(
                        top: 0,
                        right: 0,
                        left: 0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              onTap: () async {
                                showDialogBox(
                                  context,
                                  TextEditingController(
                                    text: words.english[index],
                                  ),
                                  TextEditingController(
                                    text: words.turkish[index],
                                  ),
                                  words,
                                  true,
                                  index,
                                );
                              },
                              child: Icon(
                                Icons.edit,
                                color: Colors.green.shade400,
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                words.deleteWord(index);
                              },
                              child: Icon(
                                Icons.delete,
                                color: Colors.grey.shade400,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 25),
                        child: Center(
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                Text(
                                  words.english[index],
                                  style: AppConstants.boxTextStyle,
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: 2,
                                  color: AppConstants.borderColor,
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  words.turkish[index],
                                  style: AppConstants.boxTextStyle,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ));
        },
        itemCount: words.getListLenght(),
      ),
      floatingActionButton: floatingActionButton(context, english, turkish),
    );
  }

  AppBar appBar() {
    return AppBar(
      centerTitle: true,
      bottom: PreferredSize(
          preferredSize: const Size.fromHeight(4.0),
          child: Container(
            color: AppConstants.borderColor,
            height: 2.0,
          )),
      backgroundColor: Colors.transparent,
      elevation: 0,
      title: const Text(
        'Note English Words',
        style: TextStyle(
          fontSize: 20,
          color: AppConstants.textColor,
        ),
      ),
    );
  }

  FloatingActionButton floatingActionButton(BuildContext context,
      TextEditingController english, TextEditingController turkish) {
    final words = Provider.of<WordsProvider>(context);
    return FloatingActionButton(
      mini: false,
      backgroundColor: Colors.white,
      splashColor: Colors.black,
      onPressed: () {
        showDialogBox(context, english, turkish, words, false);
      },
      hoverElevation: 1.5,
      shape: const StadiumBorder(
          side: BorderSide(color: AppConstants.borderColor, width: 2)),
      elevation: 1.5,
      child: const Icon(
        Icons.add,
        color: AppConstants.borderColor,
      ),
    );
  }

  void showDialogBox(BuildContext context, TextEditingController english,
      TextEditingController turkish, WordsProvider words, bool isEdit,
      [index]) {
    showDialog<void>(
      context: context,
      useSafeArea: true,
      barrierColor: const Color.fromARGB(47, 0, 0, 0),
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
            side: const BorderSide(
              color: Colors.black,
              width: 1,
            ),
          ),
          elevation: 12,
          backgroundColor: AppConstants.backgroundColor,
          title: const Text(
            'Add Words',
            textAlign: TextAlign.center,
            style: TextStyle(color: AppConstants.textColor),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                textFromField(english, false),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                textFromField(turkish, true),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                      side: const BorderSide(
                        color: AppConstants.borderColor,
                        width: 3,
                      ),
                    ),
                  ),
                  onPressed: () {
                    if (isEdit) {
                      words.editWord(index, english.text, turkish.text);
                    } else {
                      words.addWord(turkish.text, english.text);
                    }
                    Navigator.pop(context);
                  },
                  child: Padding(
                    padding: EdgeInsets.all(15.0),
                    child: Text(
                      isEdit ? 'Edit' : 'Add',
                      style: const TextStyle(
                        fontSize: 20,
                        color: AppConstants.borderColor,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  TextFormField textFromField(
    TextEditingController textEditingController,
    bool isTurkish,
  ) {
    return TextFormField(
      decoration: InputDecoration(
          filled: true,
          enabled: true,
          fillColor: AppConstants.backgroundColor,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(
              color: AppConstants.borderColor,
              style: BorderStyle.solid,
              width: 1,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: AppConstants.borderColor,
              style: BorderStyle.solid,
              width: 2,
            ),
          ),
          labelStyle: const TextStyle(
            color: AppConstants.textColor,
          ),
          label: isTurkish
              ? const Text('Turkish Word')
              : const Text('English Word'),
          hintText: isTurkish ? 'Araba,Kalem,Ev...' : 'Car,Pencil,Home...',
          hintStyle: const TextStyle(
            color: Colors.grey,
          )),
      style: const TextStyle(
        color: AppConstants.textColor,
        fontSize: 18,
        decorationThickness: 0,
      ),
      cursorColor: AppConstants.textColor,
      cursorWidth: 1,
      controller: textEditingController,
    );
  }
}
