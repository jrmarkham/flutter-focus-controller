part of 'focus_controller_cubit.dart';

enum FMSStatus { init, dataUpdate, positionChange }

@immutable
class FocusControllerCubitState {
  final FMSStatus status;
  final bool isChannel;
  final int focusPosition;
  final List<FocusNode> channelNode;
  final List<FocusNode> firstTimeline;
  final FocusNode? activeNode;

  const FocusControllerCubitState(
      {required this.status,
      required this.isChannel,
      required this.focusPosition,
      required this.channelNode,
      required this.firstTimeline,
      this.activeNode});

  static FocusControllerCubitState init(
          {required List<FocusNode> initChannelNodeList, required List<FocusNode> initTimelineNodeList}) =>
      FocusControllerCubitState(
          status: FMSStatus.init,
          isChannel: true,
          focusPosition: 0,
          channelNode: initChannelNodeList,
          firstTimeline: initTimelineNodeList);

  FocusControllerCubitState copyWith(
          {int? updateFocusPosition,
          List<FocusNode>? updateChannelNode,
          List<FocusNode>? updateFirstTimelineNode,
          bool? updateIsChannel,
          FocusNode? updateActiveNote}) =>
      FocusControllerCubitState(
          status: updateFocusPosition == null ? FMSStatus.dataUpdate : FMSStatus.positionChange,
          focusPosition: updateFocusPosition ?? focusPosition,
          channelNode: updateChannelNode ?? channelNode,
          firstTimeline: updateFirstTimelineNode ?? firstTimeline,
          isChannel: updateIsChannel ?? isChannel,
          activeNode: updateActiveNote ?? activeNode);
}
