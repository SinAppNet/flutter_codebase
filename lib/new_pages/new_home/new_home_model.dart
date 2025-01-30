import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/new_pages/new_app_bar/new_app_bar_widget.dart';
import 'dart:async';
import 'new_home_widget.dart' show NewHomeWidget;
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class NewHomeModel extends FlutterFlowModel<NewHomeWidget> {
  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Backend Call - Query Rows] action in newHome widget.
  List<UsersRow>? cuSer;
  // Stores action output result for [Action Block - updateUserState] action in newHome widget.
  UsersRow? user;
  // Stores action output result for [Backend Call - Query Rows] action in newHome widget.
  List<RegistroDiarioRow>? diario;
  // Stores action output result for [Backend Call - Query Rows] action in newHome widget.
  List<NotificationsRow>? notifies;
  Stream<List<UsersRow>>? containerSupabaseStream1;
  // State field(s) for Carousel widget.
  CarouselSliderController? carouselController;
  int carouselCurrentIndex = 1;

  // Stores action output result for [Backend Call - Query Rows] action in Container widget.
  List<MatchTrackingRow>? matchTrack;
  // Stores action output result for [Backend Call - Query Rows] action in Container widget.
  List<UsersRow>? userd;
  // Stores action output result for [Backend Call - Query Rows] action in Container widget.
  List<EmpresasRow>? empresa;
  Stream<List<FeedPostagensRow>>? columnSupabaseStream;
  // Model for newAppBar component.
  late NewAppBarModel newAppBarModel;
  Stream<List<UsersRow>>? containerSupabaseStream2;

  @override
  void initState(BuildContext context) {
    newAppBarModel = createModel(context, () => NewAppBarModel());
  }

  @override
  void dispose() {
    newAppBarModel.dispose();
  }
}
