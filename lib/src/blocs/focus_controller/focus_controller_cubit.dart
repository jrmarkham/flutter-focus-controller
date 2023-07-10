import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'focus_controller_state.dart';

class FocusControllerCubit extends Cubit<FocusControllerCubitState> {
  FocusControllerCubit({required List<FocusNode> initMainNodeList, required List<FocusNode> initSecondaryNodeList})
      : super(FocusControllerCubitState.init(
            initMainNodeList: initMainNodeList, initSecondaryNodeList: initSecondaryNodeList));

  void addNodeToList(FocusNode nodeItem) {
    final List<FocusNode> list = state.mainNodeList.toList();
    list.add(nodeItem);
    emit(state.copyWith(updateChannelNode: List.unmodifiable(list.toList())));
  }

  void setIsMain(bool updateIsChannel) =>
      updateIsChannel != state.isMain ? emit(state.copyWith(updateIsChannel: updateIsChannel)) : null;

  void down() => emit(state.copyWith(
      updateFocusPosition: state.focusPosition == state.mainNodeList.length - 1 ?  state.mainNodeList.length - 1 : state.focusPosition + 1));

  void up() => emit(state.copyWith(
      updateFocusPosition: state.focusPosition == 0 ? 0 : state.focusPosition - 1));
}
