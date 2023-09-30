import 'package:andin_project/app/core/resources/app_color.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class AttachmentAudio extends StatelessWidget {
  const AttachmentAudio({
    required this.fileName,
    required this.onClick,
    required this.onRemoveDocument,
    super.key,
    this.canRemove = true,
  });

  final String fileName;
  final Function onClick;
  final Function onRemoveDocument;
  final bool canRemove;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: colorDisabled),
      ),
      child: IntrinsicHeight(
        child: HStack([
          DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(4),
                bottomLeft: Radius.circular(4),
              ),
            ),
            child: Icon(
              Icons.audio_file,
              color: colorPrimary,
            ),
          ).wh(75, 75),
          VerticalDivider(
            color: colorDisabled,
            width: 2,
          ).pOnly(right: 16),
          Container(
            child: '$fileName'.text.maxLines(3).overflow(TextOverflow.ellipsis).make(),
          ).expand(),
          if (canRemove) Icon(Icons.clear_rounded, color: colorDisabled).p8().onInkTap(() => onRemoveDocument()) else SizedBox(),
        ]).onInkTap(
          () => onClick(),
        ),
      ),
    ).h(75).wFull(context).pOnly(bottom: 16);
  }
}
