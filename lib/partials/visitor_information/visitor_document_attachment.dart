import 'package:flutter/material.dart';
import 'package:vms/custom_widgets/custom_input_field_with_icon.dart';

class VisitorDocumentAttachment extends StatefulWidget {
  const VisitorDocumentAttachment({Key? key}) : super(key: key);

  @override
  State<VisitorDocumentAttachment> createState() =>
      _VisitorDocumentAttachmentState();
}

class _VisitorDocumentAttachmentState extends State<VisitorDocumentAttachment> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          CustomInputFieldWithIcon(
              hintText: "Attachment (Optional)",
              icon: Icon(Icons.add),
              labelText: "Attachment (Optional)",
              bordered: false),
        ],
      ),
    );
  }
}
