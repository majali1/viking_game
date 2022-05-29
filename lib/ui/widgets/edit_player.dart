import 'package:flutter/material.dart';
import 'package:viking_game/ui/widgets/bordered-textfield.dart';
import 'package:viking_game/ui/widgets/filled_button.dart';
import 'package:viking_game/utilities/constants.dart';

class EditPlayer extends StatefulWidget {
  final String name;

  const EditPlayer({Key? key, required this.name}) : super(key: key);

  @override
  _EditPlayerState createState() => _EditPlayerState();
}

class _EditPlayerState extends State<EditPlayer> {
  TextEditingController _editingController = new TextEditingController();

  @override
  void initState() {
    super.initState();
    _editingController.text = widget.name;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.5),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(9)),
      height: 300.0,
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Player Name',
                  style: TextStyle(
                      fontFamily: FontFamily.BaiJamjureeSemiBold,
                      color: Colors.black,
                      fontSize: 16),
                ),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: Icon(Icons.close),
                ),
              ],
            ),
            Divider(
              color: Color(0x29000000),
            ),
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      margin: EdgeInsets.only(top: 29.0, bottom: 29.0),
                      width: 250,
                      child: BorderedTextField(
                        hintText: 'Player Name',
                        labelText: 'Player Name',
                        textEditingController: _editingController,
                        textInputType: TextInputType.text,
                        showCustomError: false,
                        isRequired: true,
                        requiredError: 'Please fill the name',
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 25,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 250,
                  child: FilledButton(
                    text: 'SAVE',
                    onPressed: () {
                      Navigator.pop(context, _editingController.text);
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}