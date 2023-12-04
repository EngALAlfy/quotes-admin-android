import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_tags/flutter_tags.dart';
import 'package:provider/provider.dart';
import 'package:quotes_admin_app/providers/QuotesProvider.dart';
import 'package:smart_select/smart_select.dart';

class AddQuotePage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final tagController = TextEditingController();

  final textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    QuotesProvider quotesProvider = Provider.of(context, listen: false);
    quotesProvider.getCategories();
    return SingleChildScrollView(
      key: PageStorageKey<int>(4),
      child: Form(
        key: _formKey,
        child: Consumer<QuotesProvider>(builder: (context, quotes, child) {
          return Column(
            children: [
              TextFormField(
                minLines: 5,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                controller: textController,
                decoration: InputDecoration(
                  labelText: "نص الرساله",
                  suffixIcon: Wrap(
                    direction: Axis.vertical,
                    children: [
                      IconButton(
                          icon: Icon(Icons.close),
                          onPressed: () async {
                            textController.clear();
                          }),
                      IconButton(
                          icon: Icon(Icons.paste),
                          onPressed: () async {
                            textController.text =
                            await FlutterClipboard.paste();
                            quotes.clearTags();
                            List tags = textController.text.split(" ");
                            tags.forEach((element) {
                              quotes.addTag(element);
                            });
                          }),
                    ],
                  ),
                ),
                validator: (v) {
                  if (v.isEmpty) {
                    return "من فضلك ادخل النص";
                  }
                  return null;
                },
                onSaved: (v) {
                  quotes.text = v;
                },
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                decoration: InputDecoration(
                  labelText: "التاجات",
                  suffixIcon: Wrap(
                    direction: Axis.horizontal,
                    children: [
                      IconButton(
                          icon: Icon(Icons.close),
                          onPressed: () async {
                            quotes.clearTags();
                          }),
                      IconButton(
                          icon: Icon(Icons.add),
                          onPressed: () {
                            if (tagController.text != null &&
                                tagController.text.isNotEmpty) {
                              quotes.addTag(tagController.text);
                            }
                          }),
                    ],
                  ),
                ),
                controller: tagController,
              ),
              SizedBox(
                height: 10,
              ),
              Tags(
                itemCount: quotes.tags.length, // required
                itemBuilder: (int index) {
                  final item = quotes.tags[index];
                  return ItemTags(
                    key: Key(index.toString()),
                    index: index,
                    title: item,
                    combine: ItemTagsCombine.onlyText,
                    removeButton: ItemTagsRemoveButton(
                      onRemoved: () {
                        quotes.removeTag(item);
                        return true;
                      },
                    ),
                  );
                },
              ),
              SizedBox(
                height: 10,
              ),
              SmartSelect<String>.single(
                title: 'الاقسام',
                value: quotes.category_id,
                choiceItems: quotes.categories,
                modalType: S2ModalType.bottomSheet,
                choiceType: S2ChoiceType.radios,
                onChange: (state) {
                  quotes.category_id = state.value;
                },
                tileBuilder: (context, state) {
                  return S2Tile.fromState(
                    state,
                    isTwoLine: true,
                    trailing: Icon(Icons.keyboard_arrow_left_rounded),
                  );
                },
              ),
              SizedBox(
                height: 10,
              ),
              RaisedButton.icon(
                onPressed: () async {
                  if (_formKey.currentState.validate()) {
                    _formKey.currentState.save();
                    var added = await quotes.add();
                    if (added == true) {
                      quotes.reset();
                      textController.clear();
                    }
                  }
                },
                icon: Icon(Icons.save),
                label: Text("حفظ"),
              )
            ],
          );
        }),
      ),
    );
  }
}
