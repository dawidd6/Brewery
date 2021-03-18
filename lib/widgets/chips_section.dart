import 'package:brewery/styles/brewery_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChipsSection extends StatelessWidget {
  final String header;
  final List<String> list;
  final void Function(String)? onChipTap;
  final bool Function(String)? clickableIf;

  ChipsSection({
    Key? key,
    required this.header,
    required this.list,
    this.onChipTap,
    this.clickableIf,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: list.isNotEmpty,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            header,
            style: BreweryTheme.sectionHeader,
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
              (index) {
                if (onChipTap != null) {
                  if (clickableIf == null || clickableIf!(list[index])) {
                    return ActionChip(
                      label: Text(
                        list[index],
                        style: TextStyle(decoration: TextDecoration.underline),
                      ),
                      onPressed: () => onChipTap!(list[index]),
                    );
                  }
                }
                return Chip(
                  label: Text(list[index]),
                );
              },
            ),
          ),
          SizedBox(
            height: 40.0,
          ),
        ],
      ),
    );
  }
}
