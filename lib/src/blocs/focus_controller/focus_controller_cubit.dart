import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'focus_controller_state.dart';

class FocusControllerCubit extends Cubit<FocusControllerCubitState> {
  FocusControllerCubit({required List<FocusNode> initChannelNodeList, required List<FocusNode> initTimelineNodeList})
      : super(FocusControllerCubitState.init(
            initChannelNodeList: initChannelNodeList, initTimelineNodeList: initTimelineNodeList));

  void addNodeToList(FocusNode nodeItem) {
    final List<FocusNode> list = state.channelNode.toList();
    list.add(nodeItem);
    emit(state.copyWith(updateChannelNode: List.unmodifiable(list.toList())));
  }

  void setIsChannel(bool updateIsChannel) =>
      updateIsChannel != state.isChannel ? emit(state.copyWith(updateIsChannel: updateIsChannel)) : null;

  void down() => emit(state.copyWith(
      updateFocusPosition: state.focusPosition == state.channelNode.length - 1 ?  state.channelNode.length - 1 : state.focusPosition + 1));

  void up() => emit(state.copyWith(
      updateFocusPosition: state.focusPosition == 0 ? 0 : state.focusPosition - 1));
}
