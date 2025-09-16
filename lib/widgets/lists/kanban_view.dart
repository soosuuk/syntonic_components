import 'package:flutter/animation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'dart:core';
import 'package:vs_scrollbar/vs_scrollbar.dart';
import 'dart:async';

import '../../services/vibrate_service.dart';



class BoardView extends StatefulWidget {
  final List<BoardList>? lists;
  final double width;
  Widget? middleWidget;
  double? bottomPadding;
  bool isSelecting;
  bool? scrollbar;
  ScrollbarStyle? scrollbarStyle;
  BoardViewController? boardViewController;
  BoardController? boardController;
  int dragDelay;
  final Function(int)? onPageChanged;

  Function(bool)? itemInMiddleWidget;
  OnDropBottomWidget? onDropItemInMiddleWidget;
  BoardView({Key? key, this.itemInMiddleWidget,this.scrollbar,this.scrollbarStyle,this.boardViewController,this.boardController,this.dragDelay=300,this.onDropItemInMiddleWidget, this.isSelecting = false, this.lists, this.width = 280, this.middleWidget, this.bottomPadding, this.onPageChanged}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return BoardViewState();
  }
}

typedef void OnDropBottomWidget(int? listIndex, int? itemIndex,double percentX);
typedef void OnDropItemState(int? listIndex, int? itemIndex);
typedef void OnDropListState(int? listIndex);

class BoardViewState extends State<BoardView> with AutomaticKeepAliveClientMixin {
  Widget? draggedItem;
  int? draggedItemIndex;
  int? draggedListIndex;
  double? dx;
  double? dxInit;
  double? dyInit;
  double? dy;
  double? offsetX;
  double? offsetY;
  double? initialX = 0;
  double? initialY = 0;
  double? rightListX;
  double? leftListX;
  double? topListY;
  double? bottomListY;
  double? topItemY;
  double? bottomItemY;
  double? height;
  int? startListIndex;
  int? startItemIndex;

  bool canDrag = true;

  ScrollController boardViewController = PageController(viewportFraction: 0.8);

  List<BoardListState> listStates = [];

  OnDropItemState? onDropItem;
  OnDropListState? onDropList;

  bool isScrolling = false;

  bool _isInWidget = false;

  GlobalKey _middleWidgetKey = GlobalKey();

  var pointer;

  late PageController pageController;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    pageController = PageController(viewportFraction: 0.8);

    // Initialize modern controller if provided
    if (widget.boardController != null) {
      widget.boardController!.itemWidth = widget.width;
      widget.boardController!.attachScrollController(boardViewController);
    }

    // Maintain backward compatibility
    if (widget.boardViewController != null) {
      widget.boardViewController!.controller.itemWidth = widget.width;
      widget.boardViewController!.controller.attachScrollController(boardViewController);
    }
  }

  @override
  void dispose() {
    boardViewController.dispose();
    widget.boardController?.dispose();
    widget.boardViewController?.dispose();
    super.dispose();
  }

  void moveDown() {
    VibrateService().click();
    if(topItemY != null){
      topItemY = topItemY! + listStates[draggedListIndex!].itemStates[draggedItemIndex! + 1].height;
    }
    if(bottomItemY != null){
      bottomItemY = bottomItemY! + listStates[draggedListIndex!].itemStates[draggedItemIndex! + 1].height;
    }
    var item = widget.lists![draggedListIndex!].items![draggedItemIndex!];
    widget.lists![draggedListIndex!].items!.removeAt(draggedItemIndex!);
    var itemState = listStates[draggedListIndex!].itemStates[draggedItemIndex!];
    listStates[draggedListIndex!].itemStates.removeAt(draggedItemIndex!);
    if(draggedItemIndex != null){
      draggedItemIndex = draggedItemIndex! + 1;
    }
    widget.lists![draggedListIndex!].items!.insert(draggedItemIndex!, item);
    listStates[draggedListIndex!].itemStates.insert(draggedItemIndex!, itemState);
    if(listStates[draggedListIndex!].mounted) {
      listStates[draggedListIndex!].setState(() {});
    }
  }

  void moveUp() {
    VibrateService().click();
    if(topItemY != null){
      topItemY = topItemY! - listStates[draggedListIndex!].itemStates[draggedItemIndex! - 1].height;
    }
    if(bottomItemY != null){
      bottomItemY = bottomItemY!-listStates[draggedListIndex!].itemStates[draggedItemIndex! - 1].height;
    }
    var item = widget.lists![draggedListIndex!].items![draggedItemIndex!];
    widget.lists![draggedListIndex!].items!.removeAt(draggedItemIndex!);
    var itemState = listStates[draggedListIndex!].itemStates[draggedItemIndex!];
    listStates[draggedListIndex!].itemStates.removeAt(draggedItemIndex!);
    if(draggedItemIndex != null){
      draggedItemIndex = draggedItemIndex! - 1;
    }
    widget.lists![draggedListIndex!].items!.insert(draggedItemIndex!, item);
    listStates[draggedListIndex!].itemStates.insert(draggedItemIndex!, itemState);
    if(listStates[draggedListIndex!].mounted) {
      listStates[draggedListIndex!].setState(() {});
    }
  }

  void moveListRight() {
    VibrateService().click();
    var list = widget.lists![draggedListIndex!];
    var listState = listStates[draggedListIndex!];
    widget.lists!.removeAt(draggedListIndex!);
    listStates.removeAt(draggedListIndex!);
    if(draggedListIndex != null){
      draggedListIndex = draggedListIndex! + 1;
    }
    widget.lists!.insert(draggedListIndex!, list);
    listStates.insert(draggedListIndex!, listState);
    canDrag = false;
    if (boardViewController != null && boardViewController.hasClients) {
      int? tempListIndex = draggedListIndex;
      boardViewController
          .animateTo(draggedListIndex! * widget.width, duration: Duration(milliseconds: 400), curve: Curves.ease)
          .whenComplete(() {
        if (mounted && tempListIndex != null &&
            tempListIndex < listStates.length &&
            listStates[tempListIndex].mounted &&
            listStates[tempListIndex].context != null) {
          try {
            RenderBox object = listStates[tempListIndex].context.findRenderObject() as RenderBox;
            Offset pos = object.localToGlobal(Offset.zero);
            leftListX = pos.dx;
            rightListX = pos.dx + object.size.width;
          } catch (e) {
            print("Error accessing list state context: $e");
          }
        }
        if (mounted) {
          Future.delayed(Duration(milliseconds: widget.dragDelay), () {
            if (mounted) {
              canDrag = true;
            }
          });
        }
      });
    }
    if(mounted){
      setState(() {});
    }
  }

  void moveRight() {
    VibrateService().click();
    var item = widget.lists![draggedListIndex!].items![draggedItemIndex!];
    var itemState = listStates[draggedListIndex!].itemStates[draggedItemIndex!];
    widget.lists![draggedListIndex!].items!.removeAt(draggedItemIndex!);
    listStates[draggedListIndex!].itemStates.removeAt(draggedItemIndex!);
    if(listStates[draggedListIndex!].mounted) {
      listStates[draggedListIndex!].setState(() {});
    }
    if(draggedListIndex != null){
      draggedListIndex = draggedListIndex! + 1;
    }
    double closestValue = 10000;
    draggedItemIndex = 0;
    for (int i = 0; i < listStates[draggedListIndex!].itemStates.length; i++) {
      if (listStates[draggedListIndex!].itemStates[i].mounted && listStates[draggedListIndex!].itemStates[i].context != null) {
        RenderBox box = listStates[draggedListIndex!].itemStates[i].context.findRenderObject() as RenderBox;
        Offset pos = box.localToGlobal(Offset.zero);
        var temp = (pos.dy - dy! + (box.size.height / 2)).abs();
        if (temp < closestValue) {
          closestValue = temp;
          draggedItemIndex = i;
          dyInit = dy;
        }
      }
    }
    widget.lists![draggedListIndex!].items!.insert(draggedItemIndex!, item);
    listStates[draggedListIndex!].itemStates.insert(draggedItemIndex!, itemState);
    canDrag = false;
    if(listStates[draggedListIndex!].mounted) {
      listStates[draggedListIndex!].setState(() {});
    }
    if (boardViewController != null && boardViewController.hasClients) {
      int? tempListIndex = draggedListIndex;
      int? tempItemIndex = draggedItemIndex;
      boardViewController
          .animateTo(draggedListIndex! * widget.width, duration: Duration(milliseconds: 400), curve: Curves.ease)
          .whenComplete(() {
        if (mounted && tempListIndex != null &&
            tempListIndex < listStates.length &&
            listStates[tempListIndex].mounted &&
            listStates[tempListIndex].context != null) {
          try {
            RenderBox object = listStates[tempListIndex].context.findRenderObject() as RenderBox;
            Offset pos = object.localToGlobal(Offset.zero);
            leftListX = pos.dx;
            rightListX = pos.dx + object.size.width;
          } catch (e) {
            print("Error accessing list state context: $e");
          }
        }
        if (mounted && tempListIndex != null && tempItemIndex != null &&
            tempListIndex < listStates.length &&
            tempItemIndex < listStates[tempListIndex].itemStates.length &&
            listStates[tempListIndex].itemStates[tempItemIndex].mounted &&
            listStates[tempListIndex].itemStates[tempItemIndex].context != null) {
          try {
            RenderBox box = listStates[tempListIndex].itemStates[tempItemIndex].context.findRenderObject() as RenderBox;
            Offset itemPos = box.localToGlobal(Offset.zero);
            topItemY = itemPos.dy;
            bottomItemY = itemPos.dy + box.size.height;
          } catch (e) {
            print("Error accessing item state context: $e");
          }
        }
        if (mounted) {
          Future.delayed(Duration(milliseconds: widget.dragDelay), () {
            if (mounted) {
              canDrag = true;
            }
          });
        }
      });
    }
    if(mounted){
      setState(() { });
    }
  }

  void moveListLeft() {
    VibrateService().click();
    var list = widget.lists![draggedListIndex!];
    var listState = listStates[draggedListIndex!];
    widget.lists!.removeAt(draggedListIndex!);
    listStates.removeAt(draggedListIndex!);
    if(draggedListIndex != null){
      draggedListIndex = draggedListIndex! - 1;
    }
    widget.lists!.insert(draggedListIndex!, list);
    listStates.insert(draggedListIndex!, listState);
    canDrag = false;
    if (boardViewController != null && boardViewController.hasClients) {
      int? tempListIndex = draggedListIndex;
      boardViewController
          .animateTo(draggedListIndex! * widget.width, duration: Duration(milliseconds: widget.dragDelay), curve: Curves.ease)
          .whenComplete(() {
        if (mounted && tempListIndex != null &&
            tempListIndex < listStates.length &&
            listStates[tempListIndex].mounted &&
            listStates[tempListIndex].context != null) {
          try {
            RenderBox object = listStates[tempListIndex].context.findRenderObject() as RenderBox;
            Offset pos = object.localToGlobal(Offset.zero);
            leftListX = pos.dx;
            rightListX = pos.dx + object.size.width;
          } catch (e) {
            print("Error accessing list state context: $e");
          }
        }
        if (mounted) {
          Future.delayed(Duration(milliseconds: widget.dragDelay), () {
            if (mounted) {
              canDrag = true;
            }
          });
        }
      });
    }
    if(mounted) {
      setState(() {});
    }
  }

  void moveLeft() {
    VibrateService().click();
    var item = widget.lists![draggedListIndex!].items![draggedItemIndex!];
    var itemState = listStates[draggedListIndex!].itemStates[draggedItemIndex!];
    widget.lists![draggedListIndex!].items!.removeAt(draggedItemIndex!);
    listStates[draggedListIndex!].itemStates.removeAt(draggedItemIndex!);
    if(listStates[draggedListIndex!].mounted) {
      listStates[draggedListIndex!].setState(() {});
    }
    if(draggedListIndex != null){
      draggedListIndex = draggedListIndex! - 1;
    }
    double closestValue = 10000;
    draggedItemIndex = 0;
    for (int i = 0; i < listStates[draggedListIndex!].itemStates.length; i++) {
      if (listStates[draggedListIndex!].itemStates[i].mounted && listStates[draggedListIndex!].itemStates[i].context != null) {
        RenderBox box = listStates[draggedListIndex!].itemStates[i].context.findRenderObject() as RenderBox;
        Offset pos = box.localToGlobal(Offset.zero);
        var temp = (pos.dy - dy! + (box.size.height / 2)).abs();
        if (temp < closestValue) {
          closestValue = temp;
          draggedItemIndex = i;
          dyInit = dy;
        }
      }
    }
    widget.lists![draggedListIndex!].items!.insert(draggedItemIndex!, item);
    listStates[draggedListIndex!].itemStates.insert(draggedItemIndex!, itemState);
    canDrag = false;
    if(listStates[draggedListIndex!].mounted) {
      listStates[draggedListIndex!].setState(() {});
    }
    if (boardViewController != null && boardViewController.hasClients) {
      int? tempListIndex = draggedListIndex;
      int? tempItemIndex = draggedItemIndex;
      boardViewController
          .animateTo(draggedListIndex! * widget.width, duration: Duration(milliseconds: 400), curve: Curves.ease)
          .whenComplete(() {
        if (mounted && tempListIndex != null &&
            tempListIndex < listStates.length &&
            listStates[tempListIndex].mounted &&
            listStates[tempListIndex].context != null) {
          try {
            RenderBox object = listStates[tempListIndex].context.findRenderObject() as RenderBox;
            Offset pos = object.localToGlobal(Offset.zero);
            leftListX = pos.dx;
            rightListX = pos.dx + object.size.width;
          } catch (e) {
            print("Error accessing list state context: $e");
          }
        }
        if (mounted && tempListIndex != null && tempItemIndex != null &&
            tempListIndex < listStates.length &&
            tempItemIndex < listStates[tempListIndex].itemStates.length &&
            listStates[tempListIndex].itemStates[tempItemIndex].mounted &&
            listStates[tempListIndex].itemStates[tempItemIndex].context != null) {
          try {
            RenderBox box = listStates[tempListIndex].itemStates[tempItemIndex].context.findRenderObject() as RenderBox;
            Offset itemPos = box.localToGlobal(Offset.zero);
            topItemY = itemPos.dy;
            bottomItemY = itemPos.dy + box.size.height;
          } catch (e) {
            print("Error accessing item state context: $e");
          }
        }
        if (mounted) {
          Future.delayed(Duration(milliseconds: widget.dragDelay), () {
            if (mounted) {
              canDrag = true;
            }
          });
        }
      });
    }
    if(mounted) {
      setState(() {});
    }
  }

  bool shown = true;

  @override
  Widget build(BuildContext context) {
    print("dy:${dy}");
    print("topListY:${topListY}");
    print("bottomListY:${bottomListY}");
    if(boardViewController.hasClients) {
      WidgetsBinding.instance.addPostFrameCallback((Duration duration) {
        try {
          boardViewController.position.didUpdateScrollPositionBy(0);
        }catch(e){}
        bool _shown = boardViewController.position.maxScrollExtent!=0;
        if(_shown != shown){
          setState(() {
            shown = _shown;
          });
        }
      });
    }
    // Widget listWidget = PageView.builder(
    //   onPageChanged: (widget.onPageChanged != null)
    //       ? (index) {
    //     widget.onPageChanged!(index);
    //   }
    //       : null,
    //   padEnds: false,
    //   itemCount: widget.lists!.length,
    //   controller: pageController,
    //   itemBuilder: (BuildContext context, int index) {
    //     if (widget.lists![index].boardView == null) {
    //       widget.lists![index] = BoardList(
    //         items: widget.lists![index].items,
    //         footer: widget.lists![index].footer,
    //         header: widget.lists![index].header,
    //         boardView: this,
    //         draggable: widget.lists![index].draggable,
    //         onDropList: widget.lists![index].onDropList,
    //         onTapList: widget.lists![index].onTapList,
    //         onStartDragList: widget.lists![index].onStartDragList,
    //         itemScrollController: widget.lists![index].itemScrollController,
    //       );
    //     }
    //     if (widget.lists![index].index != index) {
    //       widget.lists![index] = BoardList(
    //         items: widget.lists![index].items,
    //         footer: widget.lists![index].footer,
    //         header: widget.lists![index].header,
    //         boardView: this,
    //         draggable: widget.lists![index].draggable,
    //         index: index,
    //         onDropList: widget.lists![index].onDropList,
    //         onTapList: widget.lists![index].onTapList,
    //         onStartDragList: widget.lists![index].onStartDragList,
    //         itemScrollController: widget.lists![index].itemScrollController,
    //       );
    //     }
    //
    //     var temp = Container(
    //       width: widget.width,
    //       padding: EdgeInsets.fromLTRB(0, 0, 0, widget.bottomPadding ?? 0),
    //       child: Row(
    //         crossAxisAlignment: CrossAxisAlignment.start,
    //         mainAxisAlignment: MainAxisAlignment.start,
    //         children: <Widget>[Expanded(child: widget.lists![index])],
    //       ),
    //     );
    //     if (draggedListIndex == index && draggedItemIndex == null) {
    //       return Opacity(
    //         opacity: 0.0,
    //         child: temp,
    //       );
    //     } else {
    //       return temp;
    //     }
    //   },
    // );
    Widget listWidget = ListView.builder(
      physics: const PageScrollPhysics(),
      itemCount: widget.lists!.length,
      scrollDirection: Axis.horizontal,
      controller: boardViewController,
      itemBuilder: (BuildContext context, int index) {
        if (widget.lists![index].boardView == null) {
          widget.lists![index] = BoardList(
            items: widget.lists![index].items,
            footer: widget.lists![index].footer,
            header: widget.lists![index].header,
            boardView: this,
            draggable: widget.lists![index].draggable,
            onDropList: widget.lists![index].onDropList,
            onTapList: widget.lists![index].onTapList,
            onStartDragList: widget.lists![index].onStartDragList,
            itemScrollController: widget.lists![index].itemScrollController,
          );
        }
        if (widget.lists![index].index != index) {
          widget.lists![index] = BoardList(
            items: widget.lists![index].items,
            footer: widget.lists![index].footer,
            header: widget.lists![index].header,
            boardView: this,
            draggable: widget.lists![index].draggable,
            index: index,
            onDropList: widget.lists![index].onDropList,
            onTapList: widget.lists![index].onTapList,
            onStartDragList: widget.lists![index].onStartDragList,
            itemScrollController: widget.lists![index].itemScrollController,
          );
        }

        var temp = Container(
            width: widget.width,
            padding: EdgeInsets.fromLTRB(0, 0, 0, widget.bottomPadding ?? 0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[Expanded(child: widget.lists![index])],
            ));
        if (draggedListIndex == index && draggedItemIndex == null) {
          return Opacity(
            opacity: 0.0,
            child: temp,
          );
        } else {
          return temp;
        }
      },
    );
    // if(widget.scrollbar == true){
    //   listWidget = VsScrollbar(
    //       controller: boardViewController,
    //       showTrackOnHover: true,// default false
    //       isAlwaysShown: shown&&widget.lists!.length>1, // default false
    //       scrollbarFadeDuration: Duration(milliseconds: 500), // default : Duration(milliseconds: 300)
    //       scrollbarTimeToFade: Duration(milliseconds: 800),// default : Duration(milliseconds: 600)
    //       style: widget.scrollbarStyle!=null?VsScrollbarStyle(
    //           hoverThickness: widget.scrollbarStyle!.hoverThickness,
    //           radius: widget.scrollbarStyle!.radius,
    //           thickness: widget.scrollbarStyle!.thickness,
    //           color: widget.scrollbarStyle!.color
    //       ):VsScrollbarStyle(),
    //       child:listWidget);
    // }
    List<Widget> stackWidgets = <Widget>[
      listWidget
    ];
    bool isInBottomWidget = false;
    if (dy != null) {
      if (MediaQuery.of(context).size.height - dy! < 80) {
        isInBottomWidget = true;
      }
    }
    if(widget.itemInMiddleWidget != null && _isInWidget != isInBottomWidget) {
      widget.itemInMiddleWidget!(isInBottomWidget);
      _isInWidget = isInBottomWidget;
    }
    if (initialX != null &&
        initialY != null &&
        offsetX != null &&
        offsetY != null &&
        dx != null &&
        dy != null &&
        height != null &&
        widget.width != null) {
      if (canDrag && dxInit != null && dyInit != null && !isInBottomWidget) {
        if (draggedItemIndex != null && draggedItem != null && topItemY != null && bottomItemY != null) {
          //dragging item
          if (0 <= draggedListIndex! - 1 && dx! < leftListX! + 45) {
            //scroll left
            if (boardViewController != null && boardViewController.hasClients) {
              boardViewController.animateTo(boardViewController.position.pixels - 5,
                  duration: Duration(milliseconds: 10), curve: Curves.ease);
              if(listStates[draggedListIndex!].mounted) {
                RenderBox object = listStates[draggedListIndex!].context
                    .findRenderObject() as RenderBox;
                Offset pos = object.localToGlobal(Offset.zero);
                leftListX = pos.dx;
                rightListX = pos.dx + object.size.width;
              }
            }
          }
          if (widget.lists!.length > draggedListIndex! + 1 && dx! > rightListX! - 45) {
            //scroll right
            if (boardViewController != null && boardViewController.hasClients) {
              boardViewController.animateTo(boardViewController.position.pixels + 5,
                  duration: Duration(milliseconds: 10), curve: Curves.ease);
              if(listStates[draggedListIndex!].mounted) {
                RenderBox object = listStates[draggedListIndex!].context
                    .findRenderObject() as RenderBox;
                Offset pos = object.localToGlobal(Offset.zero);
                leftListX = pos.dx;
                rightListX = pos.dx + object.size.width;
              }
            }
          }
          if (0 <= draggedListIndex! - 1 && dx! < leftListX!) {
            //move left
            moveLeft();
          }
          if (widget.lists!.length > draggedListIndex! + 1 && dx! > rightListX!) {
            //move right
            moveRight();
          }
          if (dy! < topListY! + 70) {
            //scroll up
            if (listStates[draggedListIndex!].boardListController != null &&
                listStates[draggedListIndex!].boardListController.hasClients && !isScrolling) {
              isScrolling = true;
              double pos = listStates[draggedListIndex!].boardListController.position.pixels;
              listStates[draggedListIndex!].boardListController.animateTo(
                  listStates[draggedListIndex!].boardListController.position.pixels - 5,
                  duration: Duration(milliseconds: 10),
                  curve: Curves.ease).whenComplete((){

                if (mounted && draggedListIndex != null &&
                    draggedListIndex! < listStates.length &&
                    listStates[draggedListIndex!].boardListController != null &&
                    listStates[draggedListIndex!].boardListController.hasClients) {
                  pos -= listStates[draggedListIndex!].boardListController.position.pixels;
                  if(initialY == null)
                    initialY = 0;
                  isScrolling = false;
                  if(topItemY != null) {
                    topItemY = topItemY! + pos;
                  }
                  if(bottomItemY != null) {
                    bottomItemY = bottomItemY! + pos;
                  }
                  if(mounted){
                    setState(() { });
                  }
                } else {
                  isScrolling = false;
                }
              });
            }
          }
          if (0 <= draggedItemIndex! - 1 &&
              dy! < topItemY! - listStates[draggedListIndex!].itemStates[draggedItemIndex! - 1].height / 2) {
            //move up
            moveUp();
          }
          double? tempBottom = bottomListY;
          if(widget.middleWidget != null){
            if(_middleWidgetKey.currentContext != null) {
              RenderBox _box = _middleWidgetKey.currentContext!
                  .findRenderObject() as RenderBox;
              tempBottom = _box.size.height;
              print("tempBottom:${tempBottom}");
            }
          }
          if (dy! > tempBottom! - 70) {
            //scroll down

            if (listStates[draggedListIndex!].boardListController != null &&
                listStates[draggedListIndex!].boardListController.hasClients) {
              isScrolling = true;
              double pos = listStates[draggedListIndex!].boardListController.position.pixels;
              listStates[draggedListIndex!].boardListController.animateTo(
                  listStates[draggedListIndex!].boardListController.position.pixels + 5,
                  duration: Duration(milliseconds: 10),
                  curve: Curves.ease).whenComplete((){
                if (mounted && draggedListIndex != null &&
                    draggedListIndex! < listStates.length &&
                    listStates[draggedListIndex!].boardListController != null &&
                    listStates[draggedListIndex!].boardListController.hasClients) {
                  pos -= listStates[draggedListIndex!].boardListController.position.pixels;
                  if(initialY == null)
                    initialY = 0;
//                if(widget.boardViewController != null) {
//                  initialY -= pos;
//                }
                  isScrolling = false;
                  if(topItemY != null) {
                    topItemY = topItemY! + pos;
                  }
                  if(bottomItemY != null) {
                    bottomItemY = bottomItemY! + pos;
                  }
                  if(mounted){
                    setState(() {});
                  }
                } else {
                  isScrolling = false;
                }
              });
            }
          }
          if (widget.lists![draggedListIndex!].items!.length > draggedItemIndex! + 1 &&
              dy! > bottomItemY! + listStates[draggedListIndex!].itemStates[draggedItemIndex! + 1].height / 2) {
            //move down
            moveDown();
          }
        } else {
          //dragging list
          if (0 <= draggedListIndex! - 1 && dx! < leftListX! + 45) {
            //scroll left
            if (boardViewController != null && boardViewController.hasClients) {
              boardViewController.animateTo(boardViewController.position.pixels - 5,
                  duration: Duration(milliseconds: 10), curve: Curves.ease);
              if(leftListX != null){
                leftListX = leftListX! + 5;
              }
              if(rightListX != null){
                rightListX = rightListX! + 5;
              }
            }
          }

          if (widget.lists!.length > draggedListIndex! + 1 && dx! > rightListX! - 45) {
            //scroll right
            if (boardViewController != null && boardViewController.hasClients) {
              boardViewController.animateTo(boardViewController.position.pixels + 5,
                  duration: Duration(milliseconds: 10), curve: Curves.ease);
              if(leftListX != null){
                leftListX = leftListX! - 5;
              }
              if(rightListX != null){
                rightListX = rightListX! - 5;
              }
            }
          }
          if (widget.lists!.length > draggedListIndex! + 1 && dx! > rightListX!) {
            //move right
            moveListRight();
          }
          if (0 <= draggedListIndex! - 1 && dx! < leftListX!) {
            //move left
            moveListLeft();
          }
        }
      }
      if (widget.middleWidget != null) {
        stackWidgets.add(Container(key:_middleWidgetKey,child:widget.middleWidget));
      }
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        if(mounted){
          setState(() {});
        }
      });
      stackWidgets.add(Positioned(
        width: widget.width,
        height: height,
        child: Material(
          color: Theme.of(context).colorScheme.surfaceContainerHigh,
          elevation: 8, // Adjust the elevation value as needed
          child: draggedItem,
        ),
        left: (dx! - offsetX!) + initialX!,
        top: (dy! - offsetY!) + initialY!,
      ));
    }

    return Container(
        child: Listener(
            onPointerMove: (opm) {
              if (draggedItem != null) {
                if (dxInit == null) {
                  dxInit = opm.position.dx;
                }
                if (dyInit == null) {
                  dyInit = opm.position.dy;
                }
                dx = opm.position.dx;
                dy = opm.position.dy;
                if(mounted) {
                  setState(() {});
                }
              }
            },
            onPointerDown: (opd) {
              RenderBox box = context.findRenderObject() as RenderBox;
              Offset pos = box.localToGlobal(opd.position);
              offsetX = pos.dx;
              offsetY = pos.dy;
              pointer = opd;
              if(mounted) {
                setState(() {});
              }
            },
            onPointerUp: (opu) {
              if (onDropItem != null) {
                int? tempDraggedItemIndex = draggedItemIndex;
                int? tempDraggedListIndex = draggedListIndex;
                int? startDraggedItemIndex = startItemIndex;
                int? startDraggedListIndex = startListIndex;

                if(_isInWidget && widget.onDropItemInMiddleWidget != null){
                  onDropItem!(startDraggedListIndex, startDraggedItemIndex);
                  widget.onDropItemInMiddleWidget!(startDraggedListIndex, startDraggedItemIndex,opu.position.dx/MediaQuery.of(context).size.width);
                }else{
                  onDropItem!(tempDraggedListIndex, tempDraggedItemIndex);
                }
              }
              if (onDropList != null) {
                int? tempDraggedListIndex = draggedListIndex;
                if(_isInWidget && widget.onDropItemInMiddleWidget != null){
                  onDropList!(tempDraggedListIndex);
                  widget.onDropItemInMiddleWidget!(tempDraggedListIndex,null,opu.position.dx/MediaQuery.of(context).size.width);
                }else{
                  onDropList!(tempDraggedListIndex);
                }
              }
              draggedItem = null;
              offsetX = null;
              offsetY = null;
              initialX = null;
              initialY = null;
              dx = null;
              dy = null;
              draggedItemIndex = null;
              draggedListIndex = null;
              onDropItem = null;
              onDropList = null;
              dxInit = null;
              dyInit = null;
              leftListX = null;
              rightListX = null;
              topListY = null;
              bottomListY = null;
              topItemY = null;
              bottomItemY = null;
              startListIndex = null;
              startItemIndex = null;
              if(mounted) {
                setState(() {});
              }
            },
            child: Stack(
              children: stackWidgets,
            )));
  }

  void run() {
    if (pointer != null) {
      dx = pointer.position.dx;
      dy = pointer.position.dy;
      if(mounted) {
        setState(() {});
      }
    }
  }
}

class ScrollbarStyle{
  double hoverThickness;
  double thickness;
  Radius radius;
  Color color;
  ScrollbarStyle({this.radius = const Radius.circular(10),this.hoverThickness = 10,this.thickness = 10,this.color = Colors.black});
}


typedef void OnDropListList(int listIndex, int oldListIndex);
typedef void OnTapList(int? listIndex);
typedef void OnStartDragList(int? listIndex);

class BoardList extends StatefulWidget {
  final Widget? header;
  final Widget? footer;
  final List<BoardItem>? items;
  final BoardViewState? boardView;
  final OnDropListList? onDropList;
  final OnTapList? onTapList;
  final OnStartDragList? onStartDragList;
  final bool draggable;
  final ItemScrollController itemScrollController;

  const BoardList({
    Key? key,
    this.header,
    this.items,
    this.footer,
    this.boardView,
    this.draggable = true,
    this.index, this.onDropList, this.onTapList, this.onStartDragList,
    required this.itemScrollController,
  }) : super(key: key);

  final int? index;

  @override
  State<StatefulWidget> createState() {
    return BoardListState();
  }
}

class BoardListState extends State<BoardList> with AutomaticKeepAliveClientMixin{
  List<BoardItemState> itemStates = [];
  ScrollController boardListController = ScrollController();
  late BoardListController listController;
  final ItemPositionsListener _itemPositionsListener = ItemPositionsListener.create();

  void onDropList(int? listIndex) {
    if(widget.onDropList != null){
      widget.onDropList!(listIndex!,widget.boardView!.startListIndex!);
    }
    widget.boardView!.draggedListIndex = null;
    if(widget.boardView!.mounted) {
      widget.boardView!.setState(() {

      });
    }
  }

  void _startDrag(Widget item, BuildContext context) {
    if (widget.boardView != null && widget.draggable) {
      if(widget.onStartDragList != null){
        widget.onStartDragList!(widget.index);
      }
      widget.boardView!.startListIndex = widget.index;
      widget.boardView!.height = context.size!.height;
      widget.boardView!.draggedListIndex = widget.index!;
      widget.boardView!.draggedItemIndex = null;
      widget.boardView!.draggedItem = item;
      widget.boardView!.onDropList = onDropList;
      widget.boardView!.run();
      if(widget.boardView!.mounted) {
        widget.boardView!.setState(() {});
      }
    }
  }

  @override
  void initState() {
    super.initState();
    listController = BoardListController();
    listController.attachScrollController(boardListController);
  }

  @override
  void dispose() {
    listController.dispose();
    boardListController.dispose();
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    List<Widget> listWidgets = [];
    // if (widget.header != null) {
    //   listWidgets.add(GestureDetector(
    //       onTap: (){
    //         if(widget.onTapList != null){
    //           widget.onTapList!(widget.index);
    //         }
    //       },
    //       onTapDown: (otd) {
    //         if(widget.draggable) {
    //           RenderBox object = context.findRenderObject() as RenderBox;
    //           Offset pos = object.localToGlobal(Offset.zero);
    //           widget.boardView!.initialX = pos.dx;
    //           widget.boardView!.initialY = pos.dy;
    //
    //           widget.boardView!.rightListX = pos.dx + object.size.width;
    //           widget.boardView!.leftListX = pos.dx;
    //         }
    //       },
    //       onTapCancel: () {},
    //       onLongPress: () {
    //         if(!widget.boardView!.widget.isSelecting && widget.draggable) {
    //           _startDrag(widget, context);
    //         }
    //       },
    //       child: widget.header!));
    //
    // }
    if (widget.items != null) {
      listWidgets.add(Container(
          child: Flexible(
              fit: FlexFit.loose,
              child: new ListView.builder(
                shrinkWrap: true,
                physics: ClampingScrollPhysics(),
                controller: boardListController,
                itemCount: widget.items!.length,
                itemBuilder: (ctx, index) {
                  if (widget.items![index].boardList == null ||
                      widget.items![index].index != index ||
                      widget.items![index].boardList!.widget.index != widget.index ||
                      widget.items![index].boardList != this) {
                    widget.items![index] = BoardItem(
                      boardList: this,
                      item: widget.items![index].item,
                      draggable: widget.items![index].draggable,
                      index: index,
                      onDropItem: widget.items![index].onDropItem,
                      onTapItem: widget.items![index].onTapItem,
                      onDragItem: widget.items![index].onDragItem,
                      onStartDragItem: widget.items![index].onStartDragItem,
                    );
                  }
                  if (widget.boardView!.draggedItemIndex == index &&
                      widget.boardView!.draggedListIndex == widget.index) {
                    return Opacity(
                      opacity: 0.0,
                      child: widget.items![index],
                    );
                  } else {
                    return widget.items![index];
                  }
                },
              ))));
    }

    // if (widget.footer != null) {
    //   listWidgets.add(widget.footer!);
    // }

    if (widget.boardView!.listStates.length > widget.index!) {
      widget.boardView!.listStates.removeAt(widget.index!);
    }
    widget.boardView!.listStates.insert(widget.index!, this);

    return CustomScrollView(
      // physics: const ClampingScrollPhysics(),
      controller: ScrollController(),
      slivers: [
        AutoSizeSliverHeader(child: widget.header!),
        SliverFillRemaining(
          child: ScrollablePositionedList.builder(
            itemCount: widget.items!.length + 1, // Adjust childCount
            itemBuilder: (context, index) {
              print('アイテムの数 : ${widget.items!.length}, index : $index');
              if (index == widget.items!.length) {
                // Add your processing here
                return Column(mainAxisSize: MainAxisSize.min, children: [widget.footer!, SizedBox(height: MediaQuery.sizeOf(context).height / 3,)],);
              }
              if (widget.items![index].boardList == null ||
                  widget.items![index].index != index ||
                  widget.items![index].boardList!.widget.index != widget.index ||
                  widget.items![index].boardList != this) {
                widget.items![index] = BoardItem(
                  boardList: this,
                  item: widget.items![index].item,
                  draggable: widget.items![index].draggable,
                  index: index,
                  onDropItem: widget.items![index].onDropItem,
                  onTapItem: widget.items![index].onTapItem,
                  onDragItem: widget.items![index].onDragItem,
                  onStartDragItem: widget.items![index].onStartDragItem,
                );
              }
              return widget.items![index];
            },
            itemScrollController: widget.itemScrollController,
            itemPositionsListener: _itemPositionsListener,
          ),
        ),
        SliverToBoxAdapter(
          child: SizedBox(
              height: MediaQuery.of(context).size.height /
                  3), // Add 40px height spacer
        ),
      ],
    );
    // return Container(
    //     margin: EdgeInsets.all(8),
    //     color: Colors.red,
    //     child: Column(
    //       mainAxisSize: MainAxisSize.min,
    //       mainAxisAlignment: MainAxisAlignment.start,
    //       children: listWidgets as List<Widget>,
    //     ));
  }
}


class AutoSizeSliverHeader extends StatefulWidget {
  final Widget child;

  const AutoSizeSliverHeader({required this.child, Key? key})
      : super(key: key);

  @override
  State<AutoSizeSliverHeader> createState() => _AutoSizeSliverHeaderState();
}

class _AutoSizeSliverHeaderState extends State<AutoSizeSliverHeader> {
  final GlobalKey _key = GlobalKey();
  double _height = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final context = _key.currentContext;
      if (context != null) {
        final renderBox = context.findRenderObject() as RenderBox;
        setState(() {
          _height = renderBox.size.height;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_height == 0) {
      return SliverToBoxAdapter(
        child: Container(key: _key, child: widget.child),
      );
    }

    return SliverPersistentHeader(
      pinned: true,
      delegate: _CustomHeaderDelegate(
        child: widget.child,
        height: _height,
      ),
    );
  }
}

class _CustomHeaderDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;
  final double height;

  _CustomHeaderDelegate({
    required this.child,
    required this.height,
  });

  @override
  double get minExtent => height;

  @override
  double get maxExtent => height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return child;
  }

  @override
  bool shouldRebuild(covariant _CustomHeaderDelegate oldDelegate) {
    return oldDelegate.child != child || oldDelegate.height != height;
  }
}


typedef void OnDropItemItem(int? listIndex, int? itemIndex,int? oldListIndex,int? oldItemIndex, BoardItemState state);
typedef void OnTapItem(int? listIndex, int? itemIndex, BoardItemState state);
typedef void OnStartDragItem(
    int? listIndex, int? itemIndex, BoardItemState state);
typedef void OnDragItem(int oldListIndex, int oldItemIndex, int newListIndex,
    int newItemIndex, BoardItemState state);

class BoardItem extends StatefulWidget {
  final BoardListState? boardList;
  final Widget? item;
  final int? index;
  final OnDropItemItem? onDropItem;
  final OnTapItem? onTapItem;
  final OnStartDragItem? onStartDragItem;
  final OnDragItem? onDragItem;
  final bool draggable;

  const BoardItem(
      {Key? key,
        this.boardList,
        this.item,
        this.index,
        this.onDropItem,
        this.onTapItem,
        this.onStartDragItem,
        this.draggable = true,
        this.onDragItem})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return BoardItemState();
  }
}

class BoardItemState extends State<BoardItem> with AutomaticKeepAliveClientMixin{
  late double height;
  double? width;

  @override
  bool get wantKeepAlive => true;

  void onDropItem(int? listIndex, int? itemIndex) {
    if (widget.onDropItem != null) {
      widget.onDropItem!(listIndex, itemIndex,widget.boardList!.widget.boardView!.startListIndex,widget.boardList!.widget.boardView!.startItemIndex, this);
    }
    widget.boardList!.widget.boardView!.draggedItemIndex = null;
    widget.boardList!.widget.boardView!.draggedListIndex = null;
    if(widget.boardList!.widget.boardView!.listStates[listIndex!].mounted) {
      widget.boardList!.widget.boardView!.listStates[listIndex].setState(() { });
    }
  }

  void _startDrag(Widget item, BuildContext context) {
    if (widget.boardList!.widget.boardView != null) {
      widget.boardList!.widget.boardView!.onDropItem = onDropItem;
      if(widget.boardList!.mounted) {
        widget.boardList!.setState(() { });
      }
      widget.boardList!.widget.boardView!.draggedItemIndex = widget.index;
      widget.boardList!.widget.boardView!.height = context.size!.height;
      widget.boardList!.widget.boardView!.draggedListIndex =
          widget.boardList!.widget.index;
      widget.boardList!.widget.boardView!.startListIndex =
          widget.boardList!.widget.index;
      widget.boardList!.widget.boardView!.startItemIndex = widget.index;
      widget.boardList!.widget.boardView!.draggedItem = item;
      if (widget.onStartDragItem != null) {
        widget.onStartDragItem!(
            widget.boardList!.widget.index, widget.index, this);
      }
      widget.boardList!.widget.boardView!.run();
      if(widget.boardList!.widget.boardView!.mounted) {
        widget.boardList!.widget.boardView!.setState(() { });
      }
    }
  }

  void afterFirstLayout(BuildContext context) {
    try {
      height = context.size!.height;
      width = context.size!.width;
    }catch(e){}
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance
        .addPostFrameCallback((_) => afterFirstLayout(context));
    if (widget.boardList!.itemStates.length > widget.index!) {
      widget.boardList!.itemStates.removeAt(widget.index!);
    }
    widget.boardList!.itemStates.insert(widget.index!, this);
    return GestureDetector(
      onTapDown: (otd) {
        if(widget.draggable) {
          RenderBox object = context.findRenderObject() as RenderBox;
          Offset pos = object.localToGlobal(Offset.zero);
          RenderBox box = widget.boardList!.context.findRenderObject() as RenderBox;
          Offset listPos = box.localToGlobal(Offset.zero);
          widget.boardList!.widget.boardView!.leftListX = listPos.dx;
          widget.boardList!.widget.boardView!.topListY = listPos.dy;
          widget.boardList!.widget.boardView!.topItemY = pos.dy;
          widget.boardList!.widget.boardView!.bottomItemY =
              pos.dy + object.size.height;
          widget.boardList!.widget.boardView!.bottomListY =
              listPos.dy + box.size.height;
          widget.boardList!.widget.boardView!.rightListX =
              listPos.dx + box.size.width;

          widget.boardList!.widget.boardView!.initialX = pos.dx;
          widget.boardList!.widget.boardView!.initialY = pos.dy;
        }
      },
      onTapCancel: () {},
      onTap: () {
        if (widget.onTapItem != null) {
          widget.onTapItem!(widget.boardList!.widget.index, widget.index, this);
        }
      },
      onLongPress: () {
        VibrateService().clickMedium();
        if(!widget.boardList!.widget.boardView!.widget.isSelecting && widget.draggable) {
          _startDrag(widget, context);
        }
      },
      child: widget.item,
    );
  }
}


/// Utility functions for board operations
class BoardUtils {
  /// Calculates the position of an item within a list
  static Offset? calculateItemPosition(
      BuildContext? context,
      int itemIndex,
      List<double> itemHeights,
      ) {
    if (context == null) return null;

    try {
      final RenderBox renderBox = context.findRenderObject() as RenderBox;
      final position = renderBox.localToGlobal(Offset.zero);

      double yOffset = 0;
      for (int i = 0; i < itemIndex && i < itemHeights.length; i++) {
        yOffset += itemHeights[i];
      }

      return Offset(position.dx, position.dy + yOffset);
    } catch (e) {
      debugPrint('Error calculating item position: $e');
      return null;
    }
  }

  /// Calculates the size of a widget
  static Size? calculateWidgetSize(BuildContext? context) {
    if (context == null) return null;

    try {
      final RenderBox renderBox = context.findRenderObject() as RenderBox;
      return renderBox.size;
    } catch (e) {
      debugPrint('Error calculating widget size: $e');
      return null;
    }
  }

  /// Checks if a point is within a rectangle
  static bool isPointInRect(Offset point, Offset rectPosition, Size rectSize) {
    return point.dx >= rectPosition.dx &&
        point.dx <= rectPosition.dx + rectSize.width &&
        point.dy >= rectPosition.dy &&
        point.dy <= rectPosition.dy + rectSize.height;
  }

  /// Finds the closest item index to a given position
  static int findClosestItemIndex(
      Offset position,
      List<Offset> itemPositions,
      List<Size> itemSizes,
      ) {
    if (itemPositions.isEmpty) return 0;

    double minDistance = double.infinity;
    int closestIndex = 0;

    for (int i = 0; i < itemPositions.length; i++) {
      final itemCenter = Offset(
        itemPositions[i].dx + itemSizes[i].width / 2,
        itemPositions[i].dy + itemSizes[i].height / 2,
      );

      final distance = (position - itemCenter).distance;
      if (distance < minDistance) {
        minDistance = distance;
        closestIndex = i;
      }
    }

    return closestIndex;
  }

  /// Safely executes a function with error handling
  static T? safeExecute<T>(T Function() function, {String? debugMessage}) {
    try {
      return function();
    } catch (e) {
      if (debugMessage != null) {
        debugPrint('$debugMessage: $e');
      }
      return null;
    }
  }

  /// Debounces a function call
  static void debounce(
      VoidCallback function,
      Duration delay, {
        required String key,
      }) {
    _debounceTimers[key]?.cancel();
    _debounceTimers[key] = Timer(delay, function);
  }

  static final Map<String, Timer> _debounceTimers = {};

  /// Clears all debounce timers
  static void clearDebounceTimers() {
    for (final timer in _debounceTimers.values) {
      timer.cancel();
    }
    _debounceTimers.clear();
  }
}


/// Legacy BoardViewController for backward compatibility
/// Consider using the new BoardController instead
@Deprecated('Use BoardController instead')
class BoardViewController {
  final BoardController _controller = BoardController();

  BoardViewController();

  /// Gets the underlying modern controller
  BoardController get controller => _controller;

  /// Animates to a specific list index
  ///
  /// [index] - The index of the list to animate to
  /// [duration] - Animation duration (defaults to 400ms)
  /// [curve] - Animation curve (defaults to Curves.ease)
  Future<void> animateTo(int index, {
    Duration? duration,
    Curve? curve,
  }) async {
    await _controller.animateToList(
      index,
      duration: duration ?? const Duration(milliseconds: 400),
      curve: curve ?? Curves.ease,
    );
  }

  /// Disposes the controller
  void dispose() {
    _controller.dispose();
  }
}

/// A modern controller for the BoardView widget that extends ChangeNotifier
/// and provides a clean API for controlling board state and animations.
class BoardController extends ChangeNotifier {
  ScrollController? _scrollController;
  double _itemWidth = 280.0;
  bool _isDisposed = false;
  bool _isAnimating = false;
  bool _isScrolling = false;
  bool _isSelecting = false;
  final List<BoardItemSelection> _selectedItems = [];
  BoardCallbacks? _callbacks;

  /// The current scroll position of the board
  double get scrollPosition => _scrollController?.offset ?? 0.0;

  /// Whether the controller is attached to a scrollable widget
  bool get isAttached => _scrollController?.hasClients ?? false;

  /// The width of each board item/list
  double get itemWidth => _itemWidth;

  /// Sets the item width for calculations
  set itemWidth(double width) {
    if (_isDisposed) return;
    _itemWidth = width;
    notifyListeners();
  }

  /// Whether the controller is currently animating
  bool get isAnimating => _isAnimating;

  /// Whether the board is currently scrolling
  bool get isScrolling => _isScrolling;

  /// Whether the board is in selection mode
  bool get isSelecting => _isSelecting;

  /// The currently selected items
  List<BoardItemSelection> get selectedItems => List.unmodifiable(_selectedItems);

  /// Sets the callbacks for state changes
  void setCallbacks(BoardCallbacks? callbacks) {
    if (_isDisposed) return;
    _callbacks = callbacks;
  }

  /// Attaches the scroll controller
  void attachScrollController(ScrollController controller) {
    if (_isDisposed) return;
    _scrollController = controller;
    _callbacks?.onControllerStateChanged?.call(true);

    // Listen to scroll changes
    controller.addListener(_onScrollChanged);
  }

  /// Handles scroll position changes
  void _onScrollChanged() {
    if (_isDisposed || _scrollController == null) return;

    final position = _scrollController!.offset;
    final maxExtent = _scrollController!.position.maxScrollExtent;

    // Check if scrolling state changed
    final wasScrolling = _isScrolling;
    _isScrolling = _scrollController!.position.isScrollingNotifier.value;

    if (wasScrolling != _isScrolling) {
      _callbacks?.onScrollStateChanged?.call(_isScrolling);
    }

    _callbacks?.onScroll?.call(position, maxExtent);
  }

  /// Animates to a specific list index
  Future<void> animateToList(int listIndex, {
    Duration duration = const Duration(milliseconds: 400),
    Curve curve = Curves.ease,
  }) async {
    if (!isAttached || _isDisposed) return;

    try {
      _setAnimating(true);
      final targetOffset = listIndex * _itemWidth;
      await _scrollController!.animateTo(
        targetOffset,
        duration: duration,
        curve: curve,
      );
    } catch (e, stackTrace) {
      _callbacks?.onError?.call('Failed to animate to list $listIndex: $e', stackTrace);
    } finally {
      _setAnimating(false);
    }
  }

  /// Scrolls to a specific list index instantly
  void jumpToList(int listIndex) {
    if (!isAttached || _isDisposed) return;

    final targetOffset = listIndex * _itemWidth;
    _scrollController!.jumpTo(targetOffset);
  }

  /// Scrolls to a specific pixel offset
  Future<void> animateToOffset(double offset, {
    Duration duration = const Duration(milliseconds: 400),
    Curve curve = Curves.ease,
  }) async {
    if (!isAttached || _isDisposed) return;

    try {
      _setAnimating(true);
      await _scrollController!.animateTo(
        offset,
        duration: duration,
        curve: curve,
      );
    } catch (e, stackTrace) {
      _callbacks?.onError?.call('Failed to animate to offset $offset: $e', stackTrace);
    } finally {
      _setAnimating(false);
    }
  }

  /// Gets the current visible list index based on scroll position
  int get currentListIndex {
    if (!isAttached || _isDisposed) return 0;
    return (scrollPosition / _itemWidth).round();
  }

  /// Gets the maximum scroll extent
  double get maxScrollExtent => _scrollController?.position.maxScrollExtent ?? 0.0;

  /// Gets the minimum scroll extent
  double get minScrollExtent => _scrollController?.position.minScrollExtent ?? 0.0;

  /// Sets the animation state
  void _setAnimating(bool animating) {
    if (_isDisposed || _isAnimating == animating) return;
    _isAnimating = animating;
    _callbacks?.onAnimationStateChanged?.call(_isAnimating);
  }

  /// Enables or disables selection mode
  void setSelectionMode(bool selecting) {
    if (_isDisposed || _isSelecting == selecting) return;
    _isSelecting = selecting;

    if (!selecting) {
      _selectedItems.clear();
    }

    _callbacks?.onSelectionModeChanged?.call(_isSelecting);
    _callbacks?.onSelectionChanged?.call(selectedItems);
  }

  /// Selects or deselects an item
  void toggleItemSelection(int listIndex, int itemIndex, Widget item) {
    if (_isDisposed || !_isSelecting) return;

    final selection = BoardItemSelection(
      listIndex: listIndex,
      itemIndex: itemIndex,
      item: item,
    );

    final existingIndex = _selectedItems.indexWhere((s) => s.listIndex == listIndex && s.itemIndex == itemIndex);

    if (existingIndex >= 0) {
      _selectedItems.removeAt(existingIndex);
    } else {
      _selectedItems.add(selection);
    }

    _callbacks?.onSelectionChanged?.call(selectedItems);
  }

  /// Clears all selected items
  void clearSelection() {
    if (_isDisposed || _selectedItems.isEmpty) return;
    _selectedItems.clear();
    _callbacks?.onSelectionChanged?.call(selectedItems);
  }

  /// Notifies about drag start
  void notifyDragStart(int listIndex, int itemIndex) {
    if (_isDisposed) return;
    _callbacks?.onDragStart?.call(listIndex, itemIndex);
  }

  /// Notifies about drag end
  void notifyDragEnd(int fromListIndex, int fromItemIndex, int toListIndex, int toItemIndex) {
    if (_isDisposed) return;
    _callbacks?.onDragEnd?.call(fromListIndex, fromItemIndex, toListIndex, toItemIndex);

    // Also call more specific callbacks
    if (fromListIndex == toListIndex) {
      _callbacks?.onItemReorder?.call(fromListIndex, fromItemIndex, toItemIndex);
    } else {
      _callbacks?.onItemMove?.call(fromListIndex, fromItemIndex, toListIndex, toItemIndex);
    }
  }

  /// Notifies about drag cancel
  void notifyDragCancel(int listIndex, int itemIndex) {
    if (_isDisposed) return;
    _callbacks?.onDragCancel?.call(listIndex, itemIndex);
  }

  /// Notifies about list reorder
  void notifyListReorder(int fromIndex, int toIndex) {
    if (_isDisposed) return;
    _callbacks?.onListReorder?.call(fromIndex, toIndex);
  }

  /// Notifies about layout change
  void notifyLayoutChange(Size boardSize) {
    if (_isDisposed) return;
    _callbacks?.onLayoutChange?.call(boardSize);
  }

  @override
  void dispose() {
    if (!_isDisposed) {
      _scrollController?.removeListener(_onScrollChanged);
      _scrollController = null;
      _selectedItems.clear();
      _callbacks?.onControllerStateChanged?.call(false);
      _callbacks = null;
      _isDisposed = true;
      super.dispose();
    }
  }
}

/// A specialized controller for individual board lists
class BoardListController extends ChangeNotifier {
  ScrollController? _scrollController;
  bool _isDisposed = false;
  bool _isScrolling = false;
  int _listIndex = 0;
  BoardListCallbacks? _callbacks;

  /// Whether the controller is attached to a scrollable widget
  bool get isAttached => _scrollController?.hasClients ?? false;

  /// The current scroll position
  double get scrollPosition => _scrollController?.offset ?? 0.0;

  /// Whether this list is currently scrolling
  bool get isScrolling => _isScrolling;

  /// The index of this list in the board
  int get listIndex => _listIndex;

  /// Sets the list index
  void setListIndex(int index) {
    if (_isDisposed) return;
    _listIndex = index;
  }

  /// Sets the callbacks for state changes
  void setCallbacks(BoardListCallbacks? callbacks) {
    if (_isDisposed) return;
    _callbacks = callbacks;
  }

  /// Attaches the scroll controller
  void attachScrollController(ScrollController controller) {
    if (_isDisposed) return;
    _scrollController = controller;

    // Listen to scroll changes
    controller.addListener(_onScrollChanged);
  }

  /// Handles scroll position changes
  void _onScrollChanged() {
    if (_isDisposed || _scrollController == null) return;

    final position = _scrollController!.offset;
    final maxExtent = _scrollController!.position.maxScrollExtent;

    // Check if scrolling state changed
    final wasScrolling = _isScrolling;
    _isScrolling = _scrollController!.position.isScrollingNotifier.value;

    if (wasScrolling != _isScrolling) {
      _callbacks?.onScrollStateChanged?.call(_listIndex, _isScrolling);
    }

    _callbacks?.onScroll?.call(_listIndex, position, maxExtent);
  }

  /// Animates to a specific item index within the list
  Future<void> animateToItem(int itemIndex, {
    Duration duration = const Duration(milliseconds: 300),
    Curve curve = Curves.ease,
  }) async {
    if (!isAttached || _isDisposed) return;

    try {
      // This is a simplified version - in a real implementation,
      // you'd calculate the actual item offset based on item heights
      await _scrollController!.animateTo(
        itemIndex * 60.0, // Assuming average item height of 60
        duration: duration,
        curve: curve,
      );
    } catch (e, stackTrace) {
      _callbacks?.onError?.call('Failed to animate to item $itemIndex in list $_listIndex: $e', stackTrace);
    }
  }

  /// Scrolls to the top of the list
  Future<void> scrollToTop({
    Duration duration = const Duration(milliseconds: 300),
    Curve curve = Curves.ease,
  }) async {
    if (!isAttached || _isDisposed) return;

    try {
      await _scrollController!.animateTo(
        0.0,
        duration: duration,
        curve: curve,
      );
    } catch (e, stackTrace) {
      _callbacks?.onError?.call('Failed to scroll to top of list $_listIndex: $e', stackTrace);
    }
  }

  /// Scrolls to the bottom of the list
  Future<void> scrollToBottom({
    Duration duration = const Duration(milliseconds: 300),
    Curve curve = Curves.ease,
  }) async {
    if (!isAttached || _isDisposed) return;

    try {
      await _scrollController!.animateTo(
        _scrollController!.position.maxScrollExtent,
        duration: duration,
        curve: curve,
      );
    } catch (e, stackTrace) {
      _callbacks?.onError?.call('Failed to scroll to bottom of list $_listIndex: $e', stackTrace);
    }
  }

  /// Notifies about item visibility change
  void notifyItemVisibilityChanged(int itemIndex, bool isVisible) {
    if (_isDisposed) return;
    _callbacks?.onItemVisibilityChanged?.call(_listIndex, itemIndex, isVisible);
  }

  @override
  void dispose() {
    if (!_isDisposed) {
      _scrollController?.removeListener(_onScrollChanged);
      _scrollController = null;
      _callbacks = null;
      _isDisposed = true;
      super.dispose();
    }
  }
}

/// Callback function signatures for various board state changes

/// Called when the board scroll position changes
typedef BoardScrollCallback = void Function(double position, double maxExtent);

/// Called when a list becomes visible or hidden
typedef BoardListVisibilityCallback = void Function(int listIndex, bool isVisible);

/// Called when the board starts or stops scrolling
typedef BoardScrollStateCallback = void Function(bool isScrolling);

/// Called when a drag operation starts
typedef BoardDragStartCallback = void Function(int listIndex, int itemIndex);

/// Called when a drag operation ends
typedef BoardDragEndCallback = void Function(int fromListIndex, int fromItemIndex, int toListIndex, int toItemIndex);

/// Called when a drag operation is cancelled
typedef BoardDragCancelCallback = void Function(int listIndex, int itemIndex);

/// Called when an item is moved within the same list
typedef BoardItemReorderCallback = void Function(int listIndex, int fromIndex, int toIndex);

/// Called when an item is moved to a different list
typedef BoardItemMoveCallback = void Function(int fromListIndex, int fromItemIndex, int toListIndex, int toItemIndex);

/// Called when a list is reordered
typedef BoardListReorderCallback = void Function(int fromIndex, int toIndex);

/// Called when a list scroll position changes
typedef BoardListScrollCallback = void Function(int listIndex, double position, double maxExtent);

/// Called when a list starts or stops scrolling
typedef BoardListScrollStateCallback = void Function(int listIndex, bool isScrolling);

/// Called when an item becomes visible or hidden in a list
typedef BoardItemVisibilityCallback = void Function(int listIndex, int itemIndex, bool isVisible);

/// Called when the board layout changes (e.g., orientation, size)
typedef BoardLayoutChangeCallback = void Function(Size boardSize);

/// Called when an error occurs during board operations
typedef BoardErrorCallback = void Function(String error, StackTrace? stackTrace);

/// Called when the board controller is attached or detached
typedef BoardControllerStateCallback = void Function(bool isAttached);

/// Called when animation starts or completes
typedef BoardAnimationCallback = void Function(bool isAnimating);

/// Called when the board enters or exits selection mode
typedef BoardSelectionModeCallback = void Function(bool isSelecting);

/// Called when items are selected or deselected
typedef BoardSelectionCallback = void Function(List<BoardItemSelection> selectedItems);

/// Represents a selected item
class BoardItemSelection {
  final int listIndex;
  final int itemIndex;
  final Widget item;

  const BoardItemSelection({
    required this.listIndex,
    required this.itemIndex,
    required this.item,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is BoardItemSelection &&
        other.listIndex == listIndex &&
        other.itemIndex == itemIndex;
  }

  @override
  int get hashCode => listIndex.hashCode ^ itemIndex.hashCode;

  @override
  String toString() => 'BoardItemSelection(listIndex: $listIndex, itemIndex: $itemIndex)';
}

/// Container for all board callbacks
class BoardCallbacks {
  final BoardScrollCallback? onScroll;
  final BoardListVisibilityCallback? onListVisibilityChanged;
  final BoardScrollStateCallback? onScrollStateChanged;
  final BoardDragStartCallback? onDragStart;
  final BoardDragEndCallback? onDragEnd;
  final BoardDragCancelCallback? onDragCancel;
  final BoardItemReorderCallback? onItemReorder;
  final BoardItemMoveCallback? onItemMove;
  final BoardListReorderCallback? onListReorder;
  final BoardLayoutChangeCallback? onLayoutChange;
  final BoardErrorCallback? onError;
  final BoardControllerStateCallback? onControllerStateChanged;
  final BoardAnimationCallback? onAnimationStateChanged;
  final BoardSelectionModeCallback? onSelectionModeChanged;
  final BoardSelectionCallback? onSelectionChanged;

  const BoardCallbacks({
    this.onScroll,
    this.onListVisibilityChanged,
    this.onScrollStateChanged,
    this.onDragStart,
    this.onDragEnd,
    this.onDragCancel,
    this.onItemReorder,
    this.onItemMove,
    this.onListReorder,
    this.onLayoutChange,
    this.onError,
    this.onControllerStateChanged,
    this.onAnimationStateChanged,
    this.onSelectionModeChanged,
    this.onSelectionChanged,
  });

  /// Creates a copy of this callbacks object with some values replaced
  BoardCallbacks copyWith({
    BoardScrollCallback? onScroll,
    BoardListVisibilityCallback? onListVisibilityChanged,
    BoardScrollStateCallback? onScrollStateChanged,
    BoardDragStartCallback? onDragStart,
    BoardDragEndCallback? onDragEnd,
    BoardDragCancelCallback? onDragCancel,
    BoardItemReorderCallback? onItemReorder,
    BoardItemMoveCallback? onItemMove,
    BoardListReorderCallback? onListReorder,
    BoardLayoutChangeCallback? onLayoutChange,
    BoardErrorCallback? onError,
    BoardControllerStateCallback? onControllerStateChanged,
    BoardAnimationCallback? onAnimationStateChanged,
    BoardSelectionModeCallback? onSelectionModeChanged,
    BoardSelectionCallback? onSelectionChanged,
  }) {
    return BoardCallbacks(
      onScroll: onScroll ?? this.onScroll,
      onListVisibilityChanged: onListVisibilityChanged ?? this.onListVisibilityChanged,
      onScrollStateChanged: onScrollStateChanged ?? this.onScrollStateChanged,
      onDragStart: onDragStart ?? this.onDragStart,
      onDragEnd: onDragEnd ?? this.onDragEnd,
      onDragCancel: onDragCancel ?? this.onDragCancel,
      onItemReorder: onItemReorder ?? this.onItemReorder,
      onItemMove: onItemMove ?? this.onItemMove,
      onListReorder: onListReorder ?? this.onListReorder,
      onLayoutChange: onLayoutChange ?? this.onLayoutChange,
      onError: onError ?? this.onError,
      onControllerStateChanged: onControllerStateChanged ?? this.onControllerStateChanged,
      onAnimationStateChanged: onAnimationStateChanged ?? this.onAnimationStateChanged,
      onSelectionModeChanged: onSelectionModeChanged ?? this.onSelectionModeChanged,
      onSelectionChanged: onSelectionChanged ?? this.onSelectionChanged,
    );
  }
}

/// Container for board list callbacks
class BoardListCallbacks {
  final BoardListScrollCallback? onScroll;
  final BoardListScrollStateCallback? onScrollStateChanged;
  final BoardItemVisibilityCallback? onItemVisibilityChanged;
  final BoardErrorCallback? onError;

  const BoardListCallbacks({
    this.onScroll,
    this.onScrollStateChanged,
    this.onItemVisibilityChanged,
    this.onError,
  });

  /// Creates a copy of this callbacks object with some values replaced
  BoardListCallbacks copyWith({
    BoardListScrollCallback? onScroll,
    BoardListScrollStateCallback? onScrollStateChanged,
    BoardItemVisibilityCallback? onItemVisibilityChanged,
    BoardErrorCallback? onError,
  }) {
    return BoardListCallbacks(
      onScroll: onScroll ?? this.onScroll,
      onScrollStateChanged: onScrollStateChanged ?? this.onScrollStateChanged,
      onItemVisibilityChanged: onItemVisibilityChanged ?? this.onItemVisibilityChanged,
      onError: onError ?? this.onError,
    );
  }
}
