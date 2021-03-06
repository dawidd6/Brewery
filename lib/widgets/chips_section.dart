import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChipsSection extends StatelessWidget {
  final String header;
  final List<String> list;
  final void Function(String)? onChipTap;

  ChipsSection({
    Key? key,
    required this.header,
    required this.list,
    this.onChipTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (list.isEmpty) {
      return Container();
    }
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          header,
          style: Theme.of(context).textTheme.headline4,
        ),
        Padding(
          padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
          child: Divider(),
        ),
        Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          spacing: 5.0,
          runSpacing: 5.0,
          children: List.generate(
            list.length,
            (index) => onChipTap == null
                ? Chip(
                    label: Text(list[index]),
                  )
                : ActionChip(
                    label: Text(
                      list[index],
                      style: TextStyle(decoration: TextDecoration.underline),
                    ),
                    onPressed: () => onChipTap!(list[index]),
                  ),
          ),
        ),
        SizedBox(
          height: 40.0,
        ),
      ],
    );
  }
}