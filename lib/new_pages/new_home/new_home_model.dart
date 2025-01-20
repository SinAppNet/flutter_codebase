import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/new_pages/new_app_bar/new_app_bar_widget.dart';
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
  // State field(s) for Carousel widget.
  CarouselSliderController? carouselController;
  int carouselCurrentIndex = 1;

  Stream<List<FeedPostagensRow>>? columnSupabaseStream;
  // Model for newAppBar component.
  late NewAppBarModel newAppBarModel;
  Stream<List<UsersRow>>? containerSupabaseStream;
  // Stores action output result for [Backend Call - Query Rows] action in Row widget.
  List<InviteRow>? invite;
  // Stores action output result for [Backend Call - Insert Row] action in Row widget.
  InviteRow? createdInvite;

  @override
  void initState(BuildContext context) {
    newAppBarModel = createModel(context, () => NewAppBarModel());
  }

  @override
  void dispose() {
    newAppBarModel.dispose();
  }
}