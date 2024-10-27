import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:markdown_widget/markdown_widget.dart';

class MarkdownPage extends StatelessWidget {
  final String data;

  const MarkdownPage(this.data, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(children: [
        SizedBox(
          width: MediaQuery.of(context).size.width,
          child: const Text("Jawaban : ", textAlign: TextAlign.left,)),
        Stack(
        children: [
          MarkdownBlock(data: data),
          Container(
            margin: const EdgeInsets.only(top: 15, right: 5),
            alignment: Alignment.topRight,
            child: IconButton(
              tooltip: "Copy Jawaban",
              onPressed: () {
                Clipboard.setData(ClipboardData(text: data));
              },
              icon: const Icon(
                Icons.content_copy,
                size: 14,
              ),
            ),
          )
        ],
      ),
      ],)
    );
  }
  //Widget buildMarkdown() => SingleChildScrollView(child: MarkdownWidget(data: data,));
}
