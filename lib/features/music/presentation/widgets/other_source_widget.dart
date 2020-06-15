
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class OtherSourceWidget extends StatelessWidget {

  final String buttonText;
  final String url;
  // final String imageUrl;


  const OtherSourceWidget({Key key, this.buttonText, this.url}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final mainSize = MediaQuery.of(context).size.width * 0.7;

    return Container(
      width: mainSize,
      height: 50,
      decoration: BoxDecoration(
        color: Colors.grey[800],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Icon(Icons.music_note),
            Text(buttonText),
            RaisedButton(
              onPressed: url != null ? () {
                launch(url);
              } : null,
              color: Theme.of(context).primaryColor,
              child: Text(url != null ? 'Open' : 'Not avaliable'),
            ),
          ],
        ),
      ),
    );
  }
}
