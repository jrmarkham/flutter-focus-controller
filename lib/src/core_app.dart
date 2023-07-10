import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'blocs/focus_controller/focus_controller_cubit.dart';
import 'widgets/focus_box_item.dart';

class CoreApp extends StatelessWidget {
  const CoreApp({super.key});

  @override
  Widget build(BuildContext context) {
    final List<FocusNode> mList = [];
    final List<FocusNode> sList = [];
    for (int idx = 0; idx < 50; idx++) {
      mList.add(FocusNode());
      sList.add(FocusNode());
    }

    final FocusControllerCubit fmCubit = FocusControllerCubit(initMainNodeList: mList, initSecondaryNodeList: sList);


    Future.delayed(const Duration(milliseconds: 2750), ()=> fmCubit.state.secondaryNodeList[4].requestFocus());

    return BlocListener<FocusControllerCubit, FocusControllerCubitState>(
      bloc: fmCubit,
      listenWhen: (FocusControllerCubitState prev, FocusControllerCubitState curr) =>
          curr.status == FMSStatus.positionChange || prev.isMain != curr.isMain,
      listener: (BuildContext context, FocusControllerCubitState state) {
        debugPrint('BlocListener state $state isMain ${state.isMain}');

        if (state.status == FMSStatus.positionChange && state.mainNodeList.isNotEmpty) {
          debugPrint('BlocListener update focus position ${state.focusPosition} isMain ${state.isMain}');
          FocusScope.of(context).unfocus();
          state.isMain
              ? state.mainNodeList[state.focusPosition].requestFocus()
              : state.secondaryNodeList[state.focusPosition].requestFocus();
        }

        // TODO: implement listener
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Focus Controller'),
        ),
        body: RawKeyboardListener(
          focusNode: FocusNode(),
          onKey: (RawKeyEvent event) {
            // keyboard back button in navigation
            if (event.isKeyPressed(LogicalKeyboardKey.escape)) {
              ///popNavigation();
            }

            if (event.isKeyPressed(LogicalKeyboardKey.arrowUp)) {
              debugPrint('RawKeyboardListener something arrow up ');
              fmCubit.up();
            }

            if (event.isKeyPressed(LogicalKeyboardKey.arrowDown)) {
              fmCubit.down();
            }

            if (event.isKeyPressed(LogicalKeyboardKey.select) || event.isKeyPressed(LogicalKeyboardKey.enter)) {}
          },
          child: Padding(
            padding: const EdgeInsets.all(50.0),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100.0), border: Border.all(color: Colors.blueGrey, width: 4)),
              child: BlocBuilder<FocusControllerCubit, FocusControllerCubitState>(
                  bloc: fmCubit,
                  buildWhen: (FocusControllerCubitState prev, FocusControllerCubitState curr) => prev.mainNodeList != curr.mainNodeList,
                  builder: (BuildContext context, FocusControllerCubitState state) {
                    return SingleChildScrollView(
                      child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
                        for (int idx = 0; idx < state.mainNodeList.length; idx++)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              FocusBoxItem(
                                name: 'main $idx ',
                                focusNode: state.mainNodeList[idx],
                                autoFocus: idx == 5,
                                focusCallback: () => fmCubit.setIsMain(true),
                              ),
                              const SizedBox(width: 10),
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  for (int jdx = 0; jdx < 5; jdx++)
                                    jdx == 0
                                        ? FocusBoxItem(
                                            name: '$idx sub $jdx ',
                                            focusNode: state.secondaryNodeList[idx],
                                            focusCallback: () => fmCubit.setIsMain(false))
                                        : FocusBoxItem(
                                            name: '$idx sub $jdx ',
                                            focusNode: FocusNode()
                                          )
                                ],
                              )
                            ],
                          )
                      ]),
                    );
                  }),
            ),
          ),
        ),
      ),
    );
  }
}
