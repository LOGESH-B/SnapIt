
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:screenshot/screenshot.dart';
import 'package:snap_it/components/snap_tag.dart';
import 'package:snap_it/controllers/edit_controller.dart';
import 'package:snap_it/controllers/position_controller.dart';
import 'package:stack_board/stack_board.dart';


class CustomItem extends StackBoardItem {
  const CustomItem({
    required this.color,
    Future<bool> Function()? onDel,
    int? id, // <==== must
  }) : super(
          child: const Text('CustomItem'),
          onDel: onDel,
          id: id, // <==== must
        );

  final Color? color;

  @override // <==== must
  CustomItem copyWith({
    CaseStyle? caseStyle,
    Widget? child,
    int? id,
    Future<bool> Function()? onDel,
    dynamic Function(bool)? onEdit,
    bool? tapToEdit,
    Color? color,
  }) =>
      CustomItem(
        onDel: onDel,
        id: id,
        color: color ?? this.color,
      );
}

class EditBoard extends StatefulWidget {
  EditBoard({Key? key,required this.byte_img}) : super(key: key);
  final byte_img;
  
  @override
  _EditBoardState createState() => _EditBoardState();
}

class _EditBoardState extends State<EditBoard> {
  late StackBoardController _boardController;
  EditController editController = Get.put(EditController());
  PositionController positionController=Get.put(PositionController());
  bool isEdit = false;
  bool bgcolor=false;
  @override
  void initState() {
    super.initState();
    _boardController = StackBoardController();
  }

  @override
  void dispose() {
    _boardController.dispose();
    super.dispose();
  }

  Future<bool> _onDel() async {
    final bool? r = await showDialog<bool>(
      context: context,
      builder: (_) {
        return Center(
          child: SizedBox(
            width: 400,
            child: Material(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    const Padding(
                      padding: EdgeInsets.only(top: 10, bottom: 60),
                      child: Text('确认删除?'),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        IconButton(
                            onPressed: () => Navigator.pop(context, true),
                            icon: const Icon(Icons.check)),
                        IconButton(
                            onPressed: () => Navigator.pop(context, false),
                            icon: const Icon(Icons.clear)),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );

    return r ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Edit'),
        backgroundColor: Color(0xFF598ae4),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.more_vert_outlined))
        ],
        elevation: 0,
      ),
      body: GetBuilder<EditController>(builder: (controller) {
        return Screenshot(
          controller: controller.screenshotController,
          child: Stack(children: [
            Container(
              color: bgcolor?Colors.black:Colors.white,
            ),
           Center(child: ClipRRect(
                              child: SizedOverflowBox(
                                  size: const Size(480, 600),
                                  alignment: Alignment.center,
                                  child: Image.file(File(widget.byte_img.path),fit: BoxFit.cover,)))),
                  Tag(controller: positionController, top: 510.0, left: 5.0),
            StackBoard(
              controller: _boardController,
              caseStyle: const CaseStyle(
                borderColor: Colors.grey,
                iconColor: Colors.white,
              ),
              background: ColoredBox(color: Colors.transparent),
              customBuilder: (StackBoardItem t) {
                if (t is CustomItem) {
                  return ItemCase(
                    key: Key('StackBoardItem${t.id}'), // <==== must
                    isCenter: false,
                    onDel: () async => _boardController.remove(t.id),
                    onTap: () => _boardController.moveItemToTop(t.id),
                    caseStyle: const CaseStyle(
                      borderColor: Colors.grey,
                      iconColor: Colors.white,
                    ),
                    child: Container(
                      width: 100,
                      height: 100,
                      color: t.color,
                      alignment: Alignment.center,
                      child: const Text(
                        'Custom item',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  );
                }

                return null;
              },
            ),
          ]),
        );
      }),
      floatingActionButton: Container(
        color: Colors.white.withOpacity(0.3),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Flexible(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: <Widget>[
                    const SizedBox(width: 25),
                    IconButton(
                      color: Colors.black,
                      onPressed: () {
                        _boardController.add(
                          const AdaptiveText(
                            'Flutter Candies',
                            tapToEdit: true,
                            caseStyle: CaseStyle(),
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        );
                      },
                      icon: const Icon(Icons.border_color),
                    ),
                    IconButton(onPressed: (){
                       _boardController.add(
                          StackBoardItem(
                           child:Image.asset('assets/images/KEC K blue.png')
                          ),
                        );
                    }, icon:Icon(Icons.image_outlined)),
                    IconButton(onPressed: (){
                       _boardController.add(
                          StackBoardItem(
                           child:Image.asset('assets/images/KEC Round blue.png')
                          ),
                        );
                    }, icon:Icon(Icons.image_outlined)),
                    IconButton(onPressed: (){
                       setState(() {
                         bgcolor=!bgcolor?true:false;
                       });
                    }, icon:Icon(Icons.color_lens))
                  ],
                ),
              ),
            ),
            IconButton(
              onPressed: () async {
                final bytes = await editController.screenshotController.capture();
                editController.saveimage(bytes);
                Get.snackbar("Downloaded", 'Downloaded in your local Storage');
               // Get.to(() => Preview(byte_img: bytes));
              },
              color: Colors.black,
              //_boardController.clear(),
              icon: const Icon(Icons.download_outlined),
            ),
          ],
        ),
      ),
    );
  }

  Widget get _spacer => const SizedBox(width: 5);
}

class ItemCaseDemo extends StatefulWidget {
  const ItemCaseDemo({Key? key}) : super(key: key);

  @override
  _ItemCaseDemoState createState() => _ItemCaseDemoState();
}

class _ItemCaseDemoState extends State<ItemCaseDemo> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        ItemCase(
          isCenter: false,
          child: const Text('Custom case'),
          onDel: () async {},
          onOperatStateChanged: (OperatState operatState) => null,
          onOffsetChanged: (Offset offset) => null,
          onSizeChanged: (Size size) => null,
        ),
      ],
    );
  }
}
