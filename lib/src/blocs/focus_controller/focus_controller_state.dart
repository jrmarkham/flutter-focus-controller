part of 'focus_controller_cubit.dart';

enum FMSStatus { init, dataUpdate, positionChange }

@immutable
class FocusControllerCubitState {
  final FMSStatus status;
  final bool isMain;
  final int focusPosition;
  final List<FocusNode> mainNodeList;
  final List<FocusNode> secondaryNodeList;
  final FocusNode? activeNode;

  const FocusControllerCubitState(
      {required this.status,
      required this.isMain,
      required this.focusPosition,
      required this.mainNodeList,
      required this.secondaryNodeList,
      this.activeNode});

  static FocusControllerCubitState init(
          {required List<FocusNode> initMainNodeList, required List<FocusNode> initSecondaryNodeList}) =>
      FocusControllerCubitState(
          status: FMSStatus.init,
          isMain: true,
          focusPosition: 0,
          mainNodeList: initMainNodeList,
          secondaryNodeList: initSecondaryNodeList);

  FocusControllerCubitState copyWith(
          {int? updateFocusPosition,
          List<FocusNode>? updateChannelNode,
          List<FocusNode>? updateFirstTimelineNode,
          bool? updateIsChannel,
          FocusNode? updateActiveNote}) =>
      FocusControllerCubitState(
          status: updateFocusPosition == null ? FMSStatus.dataUpdate : FMSStatus.positionChange,
          focusPosition: updateFocusPosition ?? focusPosition,
          mainNodeList: updateChannelNode ?? mainNodeList,
          secondaryNodeList: updateFirstTimelineNode ?? secondaryNodeList,
          isMain: updateIsChannel ?? isMain,
          activeNode: updateActiveNote ?? activeNode);
}
