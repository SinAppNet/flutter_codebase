import '/auth/supabase_auth/auth_util.dart';
import '/backend/schema/enums/enums.dart';
import '/backend/supabase/supabase.dart';
import '/componentes/empty/empty_widget.dart';
import '/componentes/solicitador_card/solicitador_card_widget.dart';
import '/components/limit_views_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/new_pages/new_app_bar/new_app_bar_widget.dart';
import 'dart:async';
import '/actions/actions.dart' as action_blocks;
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:webviewx_plus/webviewx_plus.dart';
import 'new_connections_model.dart';
export 'new_connections_model.dart';

class NewConnectionsWidget extends StatefulWidget {
  const NewConnectionsWidget({super.key});

  @override
  State<NewConnectionsWidget> createState() => _NewConnectionsWidgetState();
}

class _NewConnectionsWidgetState extends State<NewConnectionsWidget> {
  late NewConnectionsModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => NewConnectionsModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      unawaited(
        () async {
          await action_blocks.appTracking(
            context,
            userid: FFAppState().currentUser.id,
            eventName: 'pqge-loaded',
            pageName: 'conexoes',
          );
        }(),
      );
    });

    _model.pesquisaNomeTextController ??= TextEditingController();
    _model.pesquisaNomeFocusNode ??= FocusNode();
    _model.pesquisaNomeFocusNode!.addListener(
      () async {
        _model.usr = await UsersTable().queryRows(
          queryFn: (q) => q.eqOrNull(
            'nome',
            _model.pesquisaNomeTextController.text,
          ),
        );
        if ((_model.usr != null && (_model.usr)!.isNotEmpty) == false) {
          safeSetState(() {
            _model.pesquisaNomeTextController?.clear();
          });
          FFAppState().filtroOn = false;
          safeSetState(() {});
        } else {
          FFAppState().filtroOn = true;
          safeSetState(() {});
        }

        safeSetState(() {});
      },
    );
    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: Colors.white,
        body: SafeArea(
          top: true,
          child: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              color: Color(0x00FFFFFF),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:
                      const EdgeInsetsDirectional.fromSTEB(32.0, 32.0, 32.0, 0.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Conexões',
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              fontFamily: 'Inter',
                              fontSize: 28.0,
                              letterSpacing: 0.0,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      Container(
                        width: 42.0,
                        height: 42.0,
                        decoration: BoxDecoration(
                          color: const Color(0x43009C3B),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Builder(
                          builder: (context) => InkWell(
                            splashColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () async {
                              var shouldSetState = false;
                              _model.userd = await UsersTable().queryRows(
                                queryFn: (q) => q.eqOrNull(
                                  'uuid',
                                  currentUserUid,
                                ),
                              );
                              shouldSetState = true;
                              if (_model.userd?.firstOrNull?.perfilCompleto ==
                                  true) {
                                _model.matchTrack =
                                    await MatchTrackingTable().queryRows(
                                  queryFn: (q) => q
                                      .eqOrNull(
                                        'user',
                                        FFAppState().currentUser.id,
                                      )
                                      .eqOrNull(
                                        'date',
                                        supaSerialize<DateTime>(
                                            getCurrentTimestamp),
                                      ),
                                );
                                shouldSetState = true;
                                if (_model.matchTrack?.firstOrNull
                                        ?.qntdDisponivel ==
                                    0) {
                                  await showDialog(
                                    barrierDismissible: false,
                                    context: context,
                                    builder: (dialogContext) {
                                      return Dialog(
                                        elevation: 0,
                                        insetPadding: EdgeInsets.zero,
                                        backgroundColor: Colors.transparent,
                                        alignment:
                                            const AlignmentDirectional(0.0, 0.0)
                                                .resolve(
                                                    Directionality.of(context)),
                                        child: WebViewAware(
                                          child: GestureDetector(
                                            onTap: () {
                                              FocusScope.of(dialogContext)
                                                  .unfocus();
                                              FocusManager.instance.primaryFocus
                                                  ?.unfocus();
                                            },
                                            child: const SizedBox(
                                              height: double.infinity,
                                              width: double.infinity,
                                              child: LimitViewsWidget(
                                                type: 'recomendacoes',
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  );

                                  if (shouldSetState) safeSetState(() {});
                                  return;
                                } else {
                                  if (_model.matchTrack?.firstOrNull
                                          ?.likesDisponiveis ==
                                      0) {
                                    await showDialog(
                                      barrierDismissible: false,
                                      context: context,
                                      builder: (dialogContext) {
                                        return Dialog(
                                          elevation: 0,
                                          insetPadding: EdgeInsets.zero,
                                          backgroundColor: Colors.transparent,
                                          alignment: const AlignmentDirectional(
                                                  0.0, 0.0)
                                              .resolve(
                                                  Directionality.of(context)),
                                          child: WebViewAware(
                                            child: GestureDetector(
                                              onTap: () {
                                                FocusScope.of(dialogContext)
                                                    .unfocus();
                                                FocusManager
                                                    .instance.primaryFocus
                                                    ?.unfocus();
                                              },
                                              child: const SizedBox(
                                                height: double.infinity,
                                                width: double.infinity,
                                                child: LimitViewsWidget(
                                                  type: 'likes',
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  } else {
                                    context.pushNamed(
                                      'matchPage',
                                      extra: <String, dynamic>{
                                        kTransitionInfoKey: const TransitionInfo(
                                          hasTransition: true,
                                          transitionType:
                                              PageTransitionType.fade,
                                          duration: Duration(milliseconds: 0),
                                        ),
                                      },
                                    );

                                    unawaited(
                                      () async {
                                        await action_blocks.appTracking(
                                          context,
                                          userid: FFAppState().currentUser.id,
                                          eventName: 'abrir-central-conexoes',
                                        );
                                      }(),
                                    );
                                  }

                                  if (shouldSetState) safeSetState(() {});
                                  return;
                                }
                              } else {
                                context.pushNamed('matchPage');

                                if (shouldSetState) safeSetState(() {});
                                return;
                              }

                              if (shouldSetState) safeSetState(() {});
                            },
                            child: const Icon(
                              FFIcons.kadduser,
                              color: Color(0xFF009C3B),
                              size: 18.0,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                if (_model.tab != 1)
                  Padding(
                    padding:
                        const EdgeInsetsDirectional.fromSTEB(32.0, 12.0, 32.0, 0.0),
                    child: FutureBuilder<List<UsuariosSemConexaoAceitaRow>>(
                      future: UsuariosSemConexaoAceitaTable().queryRows(
                        queryFn: (q) => q.eqOrNull(
                          'perfil_completo',
                          true,
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
                        List<UsuariosSemConexaoAceitaRow>
                            containerUsuariosSemConexaoAceitaRowList =
                            snapshot.data!;

                        return Container(
                          width: double.infinity,
                          height: 40.0,
                          decoration: BoxDecoration(
                            color: const Color(0x53D0D0D0),
                            borderRadius: BorderRadius.circular(1.0),
                            border: Border.all(
                              color: (_model.pesquisaNomeFocusNode?.hasFocus ??
                                      false)
                                  ? const Color(0xFF6CEB57)
                                  : const Color(0xFFD0D5DD),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                15.0, 0.0, 15.0, 0.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(8.0),
                                  child: Image.asset(
                                    'assets/images/search-lg.png',
                                    width: 20.0,
                                    height: 20.0,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Expanded(
                                  child: TextFormField(
                                    controller:
                                        _model.pesquisaNomeTextController,
                                    focusNode: _model.pesquisaNomeFocusNode,
                                    onChanged: (_) => EasyDebounce.debounce(
                                      '_model.pesquisaNomeTextController',
                                      const Duration(milliseconds: 0),
                                      () => safeSetState(() {}),
                                    ),
                                    autofocus: false,
                                    textInputAction: TextInputAction.done,
                                    obscureText: false,
                                    decoration: InputDecoration(
                                      isDense: true,
                                      hintText: 'Pesquise pelo nome do usuário',
                                      hintStyle: FlutterFlowTheme.of(context)
                                          .labelMedium
                                          .override(
                                            fontFamily: 'Inter',
                                            color: const Color(0xFF667085),
                                            fontSize: 16.0,
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.w500,
                                          ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          color: Color(0x00E0E3E7),
                                          width: 0.0,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          color: Color(0x004B39EF),
                                          width: 0.0,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          color: Color(0x00FF5963),
                                          width: 0.0,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                      focusedErrorBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          color: Color(0x00FF5963),
                                          width: 0.0,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                      contentPadding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                              10.0, 20.0, 10.0, 0.0),
                                    ),
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          fontFamily: 'Inter',
                                          letterSpacing: 0.0,
                                        ),
                                    validator: _model
                                        .pesquisaNomeTextControllerValidator
                                        .asValidator(context),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(32.0, 24.0, 0.0, 0.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      InkWell(
                        splashColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () async {
                          _model.tab = 0;
                          safeSetState(() {});
                          unawaited(
                            () async {
                              await action_blocks.appTracking(
                                context,
                                userid: FFAppState().currentUser.id,
                                eventName: 'tab-loaded',
                                pageName: 'minhas-conexoes',
                              );
                            }(),
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: _model.tab == 0
                                ? const Color(0xFF009C3B)
                                : const Color(0xFFB6B6B6),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                12.0, 8.0, 12.0, 8.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Text(
                                  'Suas conexões',
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'Inter',
                                        color: Colors.white,
                                        letterSpacing: 0.0,
                                      ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        splashColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () async {
                          _model.tab = 1;
                          safeSetState(() {});
                          unawaited(
                            () async {
                              await action_blocks.appTracking(
                                context,
                                userid: FFAppState().currentUser.id,
                                eventName: 'tab-loaded',
                                pageName: 'minhas-solicitacoes',
                              );
                            }(),
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: _model.tab == 1
                                ? const Color(0xFF009C3B)
                                : const Color(0xFFB6B6B6),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                12.0, 8.0, 12.0, 8.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Text(
                                  'Solicitações',
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'Inter',
                                        color: Colors.white,
                                        letterSpacing: 0.0,
                                      ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ].divide(const SizedBox(width: 12.0)),
                  ),
                ),
                if ((_model.tab == 0) &&
                    (_model.pesquisaNomeTextController.text == ''))
                  Expanded(
                    child: Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(0.0, 24.0, 0.0, 0.0),
                      child: Container(
                        width: double.infinity,
                        height: double.infinity,
                        decoration: BoxDecoration(
                          color: const Color(0xFFF1F1F1),
                          border: Border.all(
                            color: FlutterFlowTheme.of(context)
                                .secondaryBackground,
                            width: 2.0,
                          ),
                        ),
                        child: FutureBuilder<List<ConexoesAceitasRow>>(
                          future: ConexoesAceitasTable().queryRows(
                            queryFn: (q) => q,
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
                            List<ConexoesAceitasRow>
                                listViewConexoesAceitasRowList = snapshot.data!;

                            if (listViewConexoesAceitasRowList.isEmpty) {
                              return const Center(
                                child: EmptyWidget(
                                  message: 'Nenhuma conexão encontrada.',
                                ),
                              );
                            }

                            return ListView.builder(
                              padding: EdgeInsets.zero,
                              scrollDirection: Axis.vertical,
                              itemCount: listViewConexoesAceitasRowList.length,
                              itemBuilder: (context, listViewIndex) {
                                final listViewConexoesAceitasRow =
                                    listViewConexoesAceitasRowList[
                                        listViewIndex];
                                return Align(
                                  alignment: const AlignmentDirectional(0.0, 0.0),
                                  child: Padding(
                                    padding: const EdgeInsetsDirectional.fromSTEB(
                                        25.0, 0.0, 25.0, 0.0),
                                    child: Container(
                                      width: 360.0,
                                      height: 94.0,
                                      decoration: const BoxDecoration(
                                        color: Color(0x00FFFFFF),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsetsDirectional.fromSTEB(
                                            0.0, 10.0, 0.0, 10.0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            InkWell(
                                              splashColor: Colors.transparent,
                                              focusColor: Colors.transparent,
                                              hoverColor: Colors.transparent,
                                              highlightColor:
                                                  Colors.transparent,
                                              onTap: () async {
                                                _model.user = await UsersTable()
                                                    .queryRows(
                                                  queryFn: (q) => q.eqOrNull(
                                                    'id',
                                                    listViewConexoesAceitasRow
                                                        .id,
                                                  ),
                                                );

                                                context.pushNamed(
                                                  'userProfile',
                                                  queryParameters: {
                                                    'user': serializeParam(
                                                      _model.user?.firstOrNull,
                                                      ParamType.SupabaseRow,
                                                    ),
                                                  }.withoutNulls,
                                                  extra: <String, dynamic>{
                                                    kTransitionInfoKey:
                                                        const TransitionInfo(
                                                      hasTransition: true,
                                                      transitionType:
                                                          PageTransitionType
                                                              .fade,
                                                      duration: Duration(
                                                          milliseconds: 0),
                                                    ),
                                                  },
                                                );

                                                unawaited(
                                                  () async {
                                                    await action_blocks
                                                        .appTracking(
                                                      context,
                                                      userid: FFAppState()
                                                          .currentUser
                                                          .id,
                                                      eventName:
                                                          'perfil-visualizado',
                                                      props: <String, dynamic>{
                                                        'page': 'conexoes',
                                                        'usuario-id':
                                                            listViewConexoesAceitasRow
                                                                .id,
                                                        'usuario-nome':
                                                            listViewConexoesAceitasRow
                                                                .nome,
                                                      },
                                                    );
                                                  }(),
                                                );

                                                safeSetState(() {});
                                              },
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  Container(
                                                    width: 62.0,
                                                    height: 62.0,
                                                    decoration: BoxDecoration(
                                                      color: const Color(0x00ECECEC),
                                                      image: DecorationImage(
                                                        fit: BoxFit.cover,
                                                        image: Image.network(
                                                          valueOrDefault<
                                                              String>(
                                                            listViewConexoesAceitasRow
                                                                .profilePic,
                                                            'https://static.vecteezy.com/system/resources/thumbnails/003/337/584/small/default-avatar-photo-placeholder-profile-icon-vector.jpg',
                                                          ),
                                                        ).image,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              200.0),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsetsDirectional
                                                            .fromSTEB(14.0, 0.0,
                                                                0.0, 0.0),
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          valueOrDefault<
                                                              String>(
                                                            listViewConexoesAceitasRow
                                                                .nome,
                                                            'Nome usuário',
                                                          ).maybeHandleOverflow(
                                                            maxChars: 18,
                                                            replacement: '…',
                                                          ),
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .bodyMedium
                                                              .override(
                                                                fontFamily:
                                                                    'Inter',
                                                                color: const Color(
                                                                    0xFF101828),
                                                                fontSize: 18.0,
                                                                letterSpacing:
                                                                    0.0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                              ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      0.0,
                                                                      2.0,
                                                                      0.0,
                                                                      0.0),
                                                          child: Text(
                                                            valueOrDefault<
                                                                String>(
                                                              listViewConexoesAceitasRow
                                                                  .empresaNome,
                                                              'Nome empresa',
                                                            ).maybeHandleOverflow(
                                                              maxChars: 25,
                                                              replacement: '…',
                                                            ),
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .bodyMedium
                                                                .override(
                                                                  fontFamily:
                                                                      'Inter',
                                                                  color: const Color(
                                                                      0xFF101828),
                                                                  fontSize:
                                                                      12.0,
                                                                  letterSpacing:
                                                                      0.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Row(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                InkWell(
                                                  splashColor:
                                                      Colors.transparent,
                                                  focusColor:
                                                      Colors.transparent,
                                                  hoverColor:
                                                      Colors.transparent,
                                                  highlightColor:
                                                      Colors.transparent,
                                                  onTap: () async {
                                                    _model.chats =
                                                        await ChatTable()
                                                            .queryRows(
                                                      queryFn: (q) => q
                                                          .containsOrNull(
                                                            'users',
                                                            '{${listViewConexoesAceitasRow.id}}',
                                                          )
                                                          .containsOrNull(
                                                            'users',
                                                            '{${FFAppState().currentUser.id}}',
                                                          ),
                                                    );
                                                    if ((_model.chats != null &&
                                                            (_model.chats)!
                                                                .isNotEmpty) ==
                                                        true) {
                                                      context.pushNamed(
                                                        'newChat',
                                                        queryParameters: {
                                                          'chat':
                                                              serializeParam(
                                                            _model.chats
                                                                ?.firstOrNull,
                                                            ParamType
                                                                .SupabaseRow,
                                                          ),
                                                        }.withoutNulls,
                                                        extra: <String,
                                                            dynamic>{
                                                          kTransitionInfoKey:
                                                              const TransitionInfo(
                                                            hasTransition: true,
                                                            transitionType:
                                                                PageTransitionType
                                                                    .fade,
                                                            duration: Duration(
                                                                milliseconds:
                                                                    0),
                                                          ),
                                                        },
                                                      );

                                                      unawaited(
                                                        () async {
                                                          await action_blocks
                                                              .appTracking(
                                                            context,
                                                            userid: FFAppState()
                                                                .currentUser
                                                                .id,
                                                            eventName:
                                                                'abrir-chat',
                                                            props: <String,
                                                                dynamic>{
                                                              'page':
                                                                  'conexoes',
                                                              'usuario-id':
                                                                  listViewConexoesAceitasRow
                                                                      .id,
                                                              'usuario-nome':
                                                                  listViewConexoesAceitasRow
                                                                      .nome,
                                                            },
                                                          );
                                                        }(),
                                                      );
                                                    } else {
                                                      _model.chat =
                                                          await ChatTable()
                                                              .insert({
                                                        'users': (int var1,
                                                                int var2) {
                                                          return [var1, var2];
                                                        }(
                                                            listViewConexoesAceitasRow
                                                                .id!,
                                                            FFAppState()
                                                                .currentUser
                                                                .id),
                                                      });

                                                      context.pushNamed(
                                                        'newChat',
                                                        queryParameters: {
                                                          'chat':
                                                              serializeParam(
                                                            _model.chat,
                                                            ParamType
                                                                .SupabaseRow,
                                                          ),
                                                        }.withoutNulls,
                                                        extra: <String,
                                                            dynamic>{
                                                          kTransitionInfoKey:
                                                              const TransitionInfo(
                                                            hasTransition: true,
                                                            transitionType:
                                                                PageTransitionType
                                                                    .fade,
                                                            duration: Duration(
                                                                milliseconds:
                                                                    0),
                                                          ),
                                                        },
                                                      );

                                                      unawaited(
                                                        () async {
                                                          await action_blocks
                                                              .appTracking(
                                                            context,
                                                            userid: FFAppState()
                                                                .currentUser
                                                                .id,
                                                            eventName:
                                                                'abrir-chat',
                                                            props: <String,
                                                                dynamic>{
                                                              'page':
                                                                  'conexoes',
                                                              'usuario-id':
                                                                  listViewConexoesAceitasRow
                                                                      .id,
                                                              'usuario-nome':
                                                                  listViewConexoesAceitasRow
                                                                      .nome,
                                                            },
                                                          );
                                                        }(),
                                                      );
                                                    }

                                                    safeSetState(() {});
                                                  },
                                                  child: Container(
                                                    width: 38.0,
                                                    height: 38.0,
                                                    decoration: BoxDecoration(
                                                      color: const Color(0x43009C3B),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8.0),
                                                    ),
                                                    child: const Icon(
                                                      Icons
                                                          .insert_comment_outlined,
                                                      color: Color(0x7214181B),
                                                      size: 18.0,
                                                    ),
                                                  ),
                                                ),
                                              ].divide(const SizedBox(width: 8.0)),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                if ((_model.tab == 0) &&
                    (_model.pesquisaNomeTextController.text != ''))
                  Expanded(
                    child: Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(0.0, 24.0, 0.0, 0.0),
                      child: Container(
                        width: double.infinity,
                        height: double.infinity,
                        decoration: BoxDecoration(
                          color: const Color(0xFFF1F1F1),
                          border: Border.all(
                            color: FlutterFlowTheme.of(context)
                                .secondaryBackground,
                            width: 2.0,
                          ),
                        ),
                        child: FutureBuilder<List<ConexoesAceitasRow>>(
                          future: ConexoesAceitasTable().queryRows(
                            queryFn: (q) => q.ilike(
                              'nome',
                              (String var1) {
                                return '%$var1%';
                              }(_model.pesquisaNomeTextController.text),
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
                            List<ConexoesAceitasRow>
                                listViewConexoesAceitasRowList = snapshot.data!;

                            if (listViewConexoesAceitasRowList.isEmpty) {
                              return const Center(
                                child: EmptyWidget(
                                  message: 'Nenhuma conexão encontrada.',
                                ),
                              );
                            }

                            return ListView.builder(
                              padding: EdgeInsets.zero,
                              scrollDirection: Axis.vertical,
                              itemCount: listViewConexoesAceitasRowList.length,
                              itemBuilder: (context, listViewIndex) {
                                final listViewConexoesAceitasRow =
                                    listViewConexoesAceitasRowList[
                                        listViewIndex];
                                return Align(
                                  alignment: const AlignmentDirectional(0.0, 0.0),
                                  child: Padding(
                                    padding: const EdgeInsetsDirectional.fromSTEB(
                                        25.0, 0.0, 25.0, 0.0),
                                    child: Container(
                                      width: 360.0,
                                      height: 94.0,
                                      decoration: const BoxDecoration(
                                        color: Color(0x00FFFFFF),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsetsDirectional.fromSTEB(
                                            0.0, 10.0, 0.0, 10.0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            InkWell(
                                              splashColor: Colors.transparent,
                                              focusColor: Colors.transparent,
                                              hoverColor: Colors.transparent,
                                              highlightColor:
                                                  Colors.transparent,
                                              onTap: () async {
                                                _model.userCopy =
                                                    await UsersTable()
                                                        .queryRows(
                                                  queryFn: (q) => q.eqOrNull(
                                                    'id',
                                                    listViewConexoesAceitasRow
                                                        .id,
                                                  ),
                                                );

                                                context.pushNamed(
                                                  'userProfile',
                                                  queryParameters: {
                                                    'user': serializeParam(
                                                      _model.userCopy
                                                          ?.firstOrNull,
                                                      ParamType.SupabaseRow,
                                                    ),
                                                  }.withoutNulls,
                                                  extra: <String, dynamic>{
                                                    kTransitionInfoKey:
                                                        const TransitionInfo(
                                                      hasTransition: true,
                                                      transitionType:
                                                          PageTransitionType
                                                              .fade,
                                                      duration: Duration(
                                                          milliseconds: 0),
                                                    ),
                                                  },
                                                );

                                                safeSetState(() {});
                                              },
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  Container(
                                                    width: 62.0,
                                                    height: 62.0,
                                                    decoration: BoxDecoration(
                                                      color: const Color(0x00ECECEC),
                                                      image: DecorationImage(
                                                        fit: BoxFit.cover,
                                                        image: Image.network(
                                                          valueOrDefault<
                                                              String>(
                                                            listViewConexoesAceitasRow
                                                                .profilePic,
                                                            'https://static.vecteezy.com/system/resources/thumbnails/003/337/584/small/default-avatar-photo-placeholder-profile-icon-vector.jpg',
                                                          ),
                                                        ).image,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              200.0),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsetsDirectional
                                                            .fromSTEB(14.0, 0.0,
                                                                0.0, 0.0),
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          valueOrDefault<
                                                              String>(
                                                            listViewConexoesAceitasRow
                                                                .nome,
                                                            'name',
                                                          ).maybeHandleOverflow(
                                                            maxChars: 18,
                                                            replacement: '…',
                                                          ),
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .bodyMedium
                                                              .override(
                                                                fontFamily:
                                                                    'Inter',
                                                                color: const Color(
                                                                    0xFF101828),
                                                                fontSize: 18.0,
                                                                letterSpacing:
                                                                    0.0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                              ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      0.0,
                                                                      2.0,
                                                                      0.0,
                                                                      0.0),
                                                          child: Text(
                                                            valueOrDefault<
                                                                String>(
                                                              listViewConexoesAceitasRow
                                                                  .empresaNome,
                                                              'Nome empresa',
                                                            ).maybeHandleOverflow(
                                                              maxChars: 25,
                                                              replacement: '…',
                                                            ),
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .bodyMedium
                                                                .override(
                                                                  fontFamily:
                                                                      'Inter',
                                                                  color: const Color(
                                                                      0xFF101828),
                                                                  fontSize:
                                                                      12.0,
                                                                  letterSpacing:
                                                                      0.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Row(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                InkWell(
                                                  splashColor:
                                                      Colors.transparent,
                                                  focusColor:
                                                      Colors.transparent,
                                                  hoverColor:
                                                      Colors.transparent,
                                                  highlightColor:
                                                      Colors.transparent,
                                                  onTap: () async {
                                                    _model.chatsCopy =
                                                        await ChatTable()
                                                            .queryRows(
                                                      queryFn: (q) => q
                                                          .containsOrNull(
                                                            'users',
                                                            '{${listViewConexoesAceitasRow.id}}',
                                                          )
                                                          .containsOrNull(
                                                            'users',
                                                            '{${FFAppState().currentUser.id}}',
                                                          ),
                                                    );
                                                    if ((_model.chatsCopy !=
                                                                null &&
                                                            (_model.chatsCopy)!
                                                                .isNotEmpty) ==
                                                        true) {
                                                      context.pushNamed(
                                                        'newChat',
                                                        queryParameters: {
                                                          'chat':
                                                              serializeParam(
                                                            _model.chatsCopy
                                                                ?.firstOrNull,
                                                            ParamType
                                                                .SupabaseRow,
                                                          ),
                                                        }.withoutNulls,
                                                        extra: <String,
                                                            dynamic>{
                                                          kTransitionInfoKey:
                                                              const TransitionInfo(
                                                            hasTransition: true,
                                                            transitionType:
                                                                PageTransitionType
                                                                    .fade,
                                                            duration: Duration(
                                                                milliseconds:
                                                                    0),
                                                          ),
                                                        },
                                                      );
                                                    } else {
                                                      _model.chatCopy =
                                                          await ChatTable()
                                                              .insert({
                                                        'users': (int var1,
                                                                int var2) {
                                                          return [var1, var2];
                                                        }(
                                                            listViewConexoesAceitasRow
                                                                .id!,
                                                            FFAppState()
                                                                .currentUser
                                                                .id),
                                                      });

                                                      context.pushNamed(
                                                        'newChat',
                                                        queryParameters: {
                                                          'chat':
                                                              serializeParam(
                                                            _model.chatCopy,
                                                            ParamType
                                                                .SupabaseRow,
                                                          ),
                                                        }.withoutNulls,
                                                        extra: <String,
                                                            dynamic>{
                                                          kTransitionInfoKey:
                                                              const TransitionInfo(
                                                            hasTransition: true,
                                                            transitionType:
                                                                PageTransitionType
                                                                    .fade,
                                                            duration: Duration(
                                                                milliseconds:
                                                                    0),
                                                          ),
                                                        },
                                                      );
                                                    }

                                                    safeSetState(() {});
                                                  },
                                                  child: Container(
                                                    width: 38.0,
                                                    height: 38.0,
                                                    decoration: BoxDecoration(
                                                      color: const Color(0x43009C3B),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8.0),
                                                    ),
                                                    child: const Icon(
                                                      Icons
                                                          .insert_comment_outlined,
                                                      color: Color(0x7214181B),
                                                      size: 18.0,
                                                    ),
                                                  ),
                                                ),
                                              ].divide(const SizedBox(width: 8.0)),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                if (_model.tab == 1)
                  Expanded(
                    child: Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(0.0, 24.0, 0.0, 0.0),
                      child: Container(
                        width: double.infinity,
                        height: double.infinity,
                        decoration: BoxDecoration(
                          color: const Color(0xFFF1F1F1),
                          border: Border.all(
                            color: FlutterFlowTheme.of(context)
                                .secondaryBackground,
                            width: 2.0,
                          ),
                        ),
                        child: FutureBuilder<List<ConexaoRow>>(
                          future: (_model.requestCompleter ??=
                                  Completer<List<ConexaoRow>>()
                                    ..complete(ConexaoTable().queryRows(
                                      queryFn: (q) => q
                                          .eqOrNull(
                                            'solicitado',
                                            FFAppState().currentUser.id,
                                          )
                                          .eqOrNull(
                                            'status',
                                            StatusConexao.solicitada.name,
                                          ),
                                    )))
                              .future,
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
                            List<ConexaoRow> listViewConexaoRowList =
                                snapshot.data!;

                            if (listViewConexaoRowList.isEmpty) {
                              return const Center(
                                child: EmptyWidget(
                                  message: 'Nenhuma solicitação encontrada.',
                                ),
                              );
                            }

                            return ListView.builder(
                              padding: EdgeInsets.zero,
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              itemCount: listViewConexaoRowList.length,
                              itemBuilder: (context, listViewIndex) {
                                final listViewConexaoRow =
                                    listViewConexaoRowList[listViewIndex];
                                return Align(
                                  alignment: const AlignmentDirectional(0.0, 0.0),
                                  child: Padding(
                                    padding: const EdgeInsetsDirectional.fromSTEB(
                                        24.0, 0.0, 24.0, 0.0),
                                    child: SolicitadorCardWidget(
                                      key: Key(
                                          'Key8xo_${listViewIndex}_of_${listViewConexaoRowList.length}'),
                                      conexao: listViewConexaoRow,
                                      callb: () async {
                                        safeSetState(() =>
                                            _model.requestCompleter = null);
                                        await _model.waitForRequestCompleted();
                                      },
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                Align(
                  alignment: const AlignmentDirectional(0.0, 1.0),
                  child: wrapWithModel(
                    model: _model.newAppBarModel,
                    updateCallback: () => safeSetState(() {}),
                    child: const NewAppBarWidget(
                      currentPage: 2,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
