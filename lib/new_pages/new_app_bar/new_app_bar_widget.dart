import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:badges/badges.dart' as badges;
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'new_app_bar_model.dart';
export 'new_app_bar_model.dart';

class NewAppBarWidget extends StatefulWidget {
  const NewAppBarWidget({
    super.key,
    int? currentPage,
  }) : currentPage = currentPage ?? 0;

  final int currentPage;

  @override
  State<NewAppBarWidget> createState() => _NewAppBarWidgetState();
}

class _NewAppBarWidgetState extends State<NewAppBarWidget> {
  late NewAppBarModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => NewAppBarModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return FutureBuilder<List<NotificationsRow>>(
      future: FFAppState().notifies(
        requestFn: () => NotificationsTable().querySingleRow(
          queryFn: (q) => q.eqOrNull(
            'user',
            FFAppState().currentUser.id,
          ),
        ),
      ),
      builder: (context, snapshot) {
        // Customize what your widget looks like when it's loading.
        if (!snapshot.hasData) {
          return const Center(
            child: SizedBox(
              width: 50.0,
              height: 50.0,
              child: SpinKitPulse(
                color: Color(0xFF009C3B),
                size: 50.0,
              ),
            ),
          );
        }
        List<NotificationsRow> containerNotificationsRowList = snapshot.data!;

        final containerNotificationsRow =
            containerNotificationsRowList.isNotEmpty
                ? containerNotificationsRowList.first
                : null;

        return Container(
          width: double.infinity,
          height: 80.0,
          decoration: BoxDecoration(
            color: FlutterFlowTheme.of(context).secondaryBackground,
            boxShadow: const [
              BoxShadow(
                blurRadius: 5.0,
                color: Color(0x33000000),
                offset: Offset(
                  0.0,
                  -2.0,
                ),
                spreadRadius: 0.0,
              )
            ],
          ),
          child: Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(0.0, 8.0, 0.0, 8.0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Stack(
                  children: [
                    InkWell(
                      splashColor: Colors.transparent,
                      focusColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () async {
                        context.pushNamed(
                          'newHome',
                          extra: <String, dynamic>{
                            kTransitionInfoKey: const TransitionInfo(
                              hasTransition: true,
                              transitionType: PageTransitionType.fade,
                              duration: Duration(milliseconds: 0),
                            ),
                          },
                        );
                      },
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            FFIcons.kcasinha2,
                            color: widget.currentPage == 0
                                ? const Color(0xFF009C3B)
                                : Colors.black,
                            size: 24.0,
                          ),
                          Text(
                            'Home',
                            style: FlutterFlowTheme.of(context)
                                .labelSmall
                                .override(
                                  fontFamily: 'Inter',
                                  color: widget.currentPage == 0
                                      ? const Color(0xFF009C3B)
                                      : Colors.black,
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.w600,
                                ),
                          ),
                        ].divide(const SizedBox(height: 4.0)),
                      ),
                    ),
                  ],
                ),
                Stack(
                  children: [
                    InkWell(
                      splashColor: Colors.transparent,
                      focusColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () async {
                        context.pushNamed(
                          'newFeed',
                          extra: <String, dynamic>{
                            kTransitionInfoKey: const TransitionInfo(
                              hasTransition: true,
                              transitionType: PageTransitionType.fade,
                              duration: Duration(milliseconds: 0),
                            ),
                          },
                        );
                      },
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            FFIcons.klikeoutl,
                            color: widget.currentPage == 1
                                ? const Color(0xFF009C3B)
                                : Colors.black,
                            size: 24.0,
                          ),
                          Text(
                            'Feed',
                            style: FlutterFlowTheme.of(context)
                                .labelSmall
                                .override(
                                  fontFamily: 'Inter',
                                  color: widget.currentPage == 1
                                      ? const Color(0xFF009C3B)
                                      : Colors.black,
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.w600,
                                ),
                          ),
                        ].divide(const SizedBox(height: 4.0)),
                      ),
                    ),
                  ],
                ),
                Stack(
                  children: [
                    InkWell(
                      splashColor: Colors.transparent,
                      focusColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () async {
                        context.pushNamed(
                          'newConnections',
                          extra: <String, dynamic>{
                            kTransitionInfoKey: const TransitionInfo(
                              hasTransition: true,
                              transitionType: PageTransitionType.fade,
                              duration: Duration(milliseconds: 0),
                            ),
                          },
                        );

                        await NotificationsTable().update(
                          data: {
                            'connection': false,
                          },
                          matchingRows: (rows) => rows.eqOrNull(
                            'id',
                            containerNotificationsRow?.id,
                          ),
                        );
                      },
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            FFIcons.kadduser,
                            color: widget.currentPage == 2
                                ? const Color(0xFF009C3B)
                                : const Color(0xA5000000),
                            size: 24.0,
                          ),
                          Text(
                            'Conexões',
                            style: FlutterFlowTheme.of(context)
                                .labelSmall
                                .override(
                                  fontFamily: 'Inter',
                                  color: widget.currentPage == 2
                                      ? const Color(0xFF009C3B)
                                      : Colors.black,
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.w600,
                                ),
                          ),
                        ].divide(const SizedBox(height: 4.0)),
                      ),
                    ),
                    if (containerNotificationsRow?.connection == true)
                      Align(
                        alignment: const AlignmentDirectional(1.0, -1.0),
                        child: badges.Badge(
                          badgeContent: Text(
                            '',
                            textAlign: TextAlign.start,
                            style: FlutterFlowTheme.of(context)
                                .titleSmall
                                .override(
                                  fontFamily: 'Inter',
                                  color: Colors.white,
                                  fontSize: 12.0,
                                  letterSpacing: 0.0,
                                ),
                          ),
                          showBadge: true,
                          shape: badges.BadgeShape.circle,
                          badgeColor: const Color(0xFF0EA203),
                          elevation: 4.0,
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              8.0, 8.0, 8.0, 8.0),
                          position: badges.BadgePosition.topEnd(),
                          animationType: badges.BadgeAnimationType.scale,
                          toAnimate: true,
                        ),
                      ),
                  ],
                ),
                Stack(
                  children: [
                    InkWell(
                      splashColor: Colors.transparent,
                      focusColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () async {
                        context.pushNamed(
                          'newChats',
                          extra: <String, dynamic>{
                            kTransitionInfoKey: const TransitionInfo(
                              hasTransition: true,
                              transitionType: PageTransitionType.fade,
                              duration: Duration(milliseconds: 0),
                            ),
                          },
                        );

                        await NotificationsTable().update(
                          data: {
                            'message': false,
                          },
                          matchingRows: (rows) => rows.eqOrNull(
                            'id',
                            containerNotificationsRow?.id,
                          ),
                        );
                      },
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.insert_comment_outlined,
                            color: widget.currentPage == 3
                                ? const Color(0xFF009C3B)
                                : const Color(0xA5000000),
                            size: 24.0,
                          ),
                          Text(
                            'Chat',
                            style: FlutterFlowTheme.of(context)
                                .labelSmall
                                .override(
                                  fontFamily: 'Inter',
                                  color: widget.currentPage == 3
                                      ? const Color(0xFF009C3B)
                                      : Colors.black,
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.w600,
                                ),
                          ),
                        ].divide(const SizedBox(height: 4.0)),
                      ),
                    ),
                    if (containerNotificationsRow?.message == true)
                      Align(
                        alignment: const AlignmentDirectional(1.0, -1.0),
                        child: badges.Badge(
                          badgeContent: Text(
                            '',
                            textAlign: TextAlign.start,
                            style: FlutterFlowTheme.of(context)
                                .titleSmall
                                .override(
                                  fontFamily: 'Inter',
                                  color: Colors.white,
                                  fontSize: 12.0,
                                  letterSpacing: 0.0,
                                ),
                          ),
                          showBadge: true,
                          shape: badges.BadgeShape.circle,
                          badgeColor: const Color(0xFF0EA203),
                          elevation: 4.0,
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              8.0, 8.0, 8.0, 8.0),
                          position: badges.BadgePosition.topEnd(),
                          animationType: badges.BadgeAnimationType.scale,
                          toAnimate: true,
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
