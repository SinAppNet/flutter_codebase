import '/backend/supabase/supabase.dart';
import '/componentes/init_chat_messages/init_chat_messages_widget.dart';
import '/flutter_flow/flutter_flow_audio_player.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:async';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:record/record.dart';
import 'new_chat_model.dart';
export 'new_chat_model.dart';

class NewChatWidget extends StatefulWidget {
  const NewChatWidget({
    super.key,
    this.chat,
  });

  final ChatRow? chat;

  @override
  State<NewChatWidget> createState() => _NewChatWidgetState();
}

class _NewChatWidgetState extends State<NewChatWidget> {
  late NewChatModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => NewChatModel());

    _model.textController ??= TextEditingController();
    _model.textFieldFocusNode ??= FocusNode();
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
              color: Color(0xFFF1F1F1),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  width: double.infinity,
                  height: 125.0,
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).secondaryBackground,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(18.0, 0.0, 0.0, 0.0),
                        child: InkWell(
                          splashColor: Colors.transparent,
                          focusColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () async {
                            context.safePop();
                          },
                          child: Icon(
                            Icons.arrow_back,
                            color: FlutterFlowTheme.of(context).primaryText,
                            size: 42.0,
                          ),
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(12.0, 0.0, 0.0, 0.0),
                        child: FutureBuilder<List<UsersRow>>(
                          future: UsersTable().querySingleRow(
                            queryFn: (q) => q
                                .inFilterOrNull(
                                  'id',
                                  widget.chat?.users,
                                )
                                .neqOrNull(
                                  'id',
                                  FFAppState().currentUser.id,
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
                            List<UsersRow> rowUsersRowList = snapshot.data!;

                            final rowUsersRow = rowUsersRowList.isNotEmpty
                                ? rowUsersRowList.first
                                : null;

                            return InkWell(
                              splashColor: Colors.transparent,
                              focusColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () async {
                                context.pushNamed(
                                  'userProfile',
                                  queryParameters: {
                                    'user': serializeParam(
                                      rowUsersRow,
                                      ParamType.SupabaseRow,
                                    ),
                                  }.withoutNulls,
                                  extra: <String, dynamic>{
                                    kTransitionInfoKey: const TransitionInfo(
                                      hasTransition: true,
                                      transitionType: PageTransitionType.fade,
                                      duration: Duration(milliseconds: 0),
                                    ),
                                  },
                                );
                              },
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  InkWell(
                                    splashColor: Colors.transparent,
                                    focusColor: Colors.transparent,
                                    hoverColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    onTap: () async {
                                      context.pushNamed(
                                        'userProfile',
                                        queryParameters: {
                                          'user': serializeParam(
                                            rowUsersRow,
                                            ParamType.SupabaseRow,
                                          ),
                                        }.withoutNulls,
                                      );
                                    },
                                    child: Container(
                                      width: 62.0,
                                      height: 62.0,
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFFF0000),
                                        image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: Image.network(
                                            valueOrDefault<String>(
                                              rowUsersRow?.profilePic,
                                              'https://static.vecteezy.com/system/resources/thumbnails/003/337/584/small/default-avatar-photo-placeholder-profile-icon-vector.jpg',
                                            ),
                                          ).image,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(200.0),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsetsDirectional.fromSTEB(
                                        14.0, 0.0, 0.0, 0.0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          valueOrDefault<String>(
                                            rowUsersRow?.nome,
                                            'Nome usuário',
                                          ).maybeHandleOverflow(
                                            maxChars: 50,
                                          ),
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                fontFamily: 'Inter',
                                                color: const Color(0xFF101828),
                                                fontSize: 18.0,
                                                letterSpacing: 0.0,
                                                fontWeight: FontWeight.w600,
                                              ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsetsDirectional.fromSTEB(
                                                  0.0, 2.0, 0.0, 0.0),
                                          child: Text(
                                            valueOrDefault<String>(
                                              rowUsersRow?.empresaNome,
                                              'Nome empresa',
                                            ).maybeHandleOverflow(
                                              maxChars: 12,
                                              replacement: '…',
                                            ),
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                                  fontFamily: 'Inter',
                                                  color: const Color(0xFF101828),
                                                  fontSize: 12.0,
                                                  letterSpacing: 0.0,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: StreamBuilder<List<MensagensRow>>(
                    stream: _model.containerSupabaseStream ??= SupaFlow.client
                        .from("mensagens")
                        .stream(primaryKey: ['id'])
                        .eqOrNull(
                          'chat',
                          widget.chat?.id,
                        )
                        .map((list) =>
                            list.map((item) => MensagensRow(item)).toList()),
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
                      List<MensagensRow> containerMensagensRowList =
                          snapshot.data!;

                      return Container(
                        decoration: const BoxDecoration(),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            if ((containerMensagensRowList.isNotEmpty) == true)
                              Expanded(
                                child: Builder(
                                  builder: (context) {
                                    final messages =
                                        containerMensagensRowList.toList();

                                    return ListView.separated(
                                      padding: const EdgeInsets.fromLTRB(
                                        0,
                                        24.0,
                                        0,
                                        68.0,
                                      ),
                                      shrinkWrap: true,
                                      scrollDirection: Axis.vertical,
                                      itemCount: messages.length,
                                      separatorBuilder: (_, __) =>
                                          const SizedBox(height: 8.0),
                                      itemBuilder: (context, messagesIndex) {
                                        final messagesItem =
                                            messages[messagesIndex];
                                        return Padding(
                                          padding:
                                              const EdgeInsetsDirectional.fromSTEB(
                                                  24.0, 0.0, 24.0, 0.0),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              if (messagesItem
                                                      .firstMessageOfDay ==
                                                  true)
                                                Padding(
                                                  padding: const EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          0.0, 0.0, 0.0, 24.0),
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .alternate,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              12.0),
                                                    ),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  12.0,
                                                                  8.0,
                                                                  12.0,
                                                                  8.0),
                                                      child: Row(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Text(
                                                            dateTimeFormat(
                                                              "relative",
                                                              messagesItem
                                                                  .createdAt,
                                                              locale: FFLocalizations
                                                                      .of(context)
                                                                  .languageCode,
                                                            ),
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .bodyMedium
                                                                .override(
                                                                  fontFamily:
                                                                      'Inter',
                                                                  letterSpacing:
                                                                      0.0,
                                                                ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              if (messagesItem.sender ==
                                                  FFAppState().currentUser.id)
                                                Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.end,
                                                  children: [
                                                    Align(
                                                      alignment:
                                                          const AlignmentDirectional(
                                                              1.0, -1.0),
                                                      child: Container(
                                                        constraints:
                                                            const BoxConstraints(
                                                          minHeight: 35.0,
                                                        ),
                                                        decoration:
                                                            const BoxDecoration(
                                                          color:
                                                              Color(0xFF20A090),
                                                          borderRadius:
                                                              BorderRadius.only(
                                                            bottomLeft:
                                                                Radius.circular(
                                                                    18.0),
                                                            bottomRight:
                                                                Radius.circular(
                                                                    18.0),
                                                            topLeft:
                                                                Radius.circular(
                                                                    18.0),
                                                            topRight:
                                                                Radius.circular(
                                                                    0.0),
                                                          ),
                                                        ),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets.all(
                                                                  10.0),
                                                          child: Column(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .min,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .end,
                                                            children: [
                                                              if (messagesItem
                                                                      .isAudio ==
                                                                  false)
                                                                Text(
                                                                  valueOrDefault<
                                                                      String>(
                                                                    messagesItem
                                                                        .mensagem,
                                                                    'Mensagem',
                                                                  ),
                                                                  style: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .override(
                                                                        fontFamily:
                                                                            'Inter',
                                                                        color: Colors
                                                                            .white,
                                                                        letterSpacing:
                                                                            0.0,
                                                                      ),
                                                                ),
                                                              if (messagesItem
                                                                      .isAudio ==
                                                                  true)
                                                                FlutterFlowAudioPlayer(
                                                                  audio: Audio
                                                                      .network(
                                                                    messagesItem
                                                                        .audioPath!,
                                                                    metas:
                                                                        Metas(
                                                                      title:
                                                                          'Title',
                                                                    ),
                                                                  ),
                                                                  titleTextStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .titleLarge
                                                                      .override(
                                                                        fontFamily:
                                                                            'Inter',
                                                                        fontSize:
                                                                            0.0,
                                                                        letterSpacing:
                                                                            0.0,
                                                                      ),
                                                                  playbackDurationTextStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelMedium
                                                                      .override(
                                                                        fontFamily:
                                                                            'Inter',
                                                                        color: Colors
                                                                            .white,
                                                                        letterSpacing:
                                                                            0.0,
                                                                      ),
                                                                  fillColor: Colors
                                                                      .transparent,
                                                                  playbackButtonColor:
                                                                      Colors
                                                                          .white,
                                                                  activeTrackColor:
                                                                      const Color(
                                                                          0xFF009C3B),
                                                                  inactiveTrackColor:
                                                                      FlutterFlowTheme.of(
                                                                              context)
                                                                          .alternate,
                                                                  elevation:
                                                                      0.0,
                                                                  playInBackground:
                                                                      PlayInBackground
                                                                          .enabled,
                                                                ),
                                                              Text(
                                                                dateTimeFormat(
                                                                  "H:m",
                                                                  messagesItem
                                                                      .createdAt,
                                                                  locale: FFLocalizations.of(
                                                                          context)
                                                                      .languageCode,
                                                                ),
                                                                textAlign:
                                                                    TextAlign
                                                                        .end,
                                                                style: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .override(
                                                                      fontFamily:
                                                                          'Inter',
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .primaryBackground,
                                                                      fontSize:
                                                                          12.0,
                                                                      letterSpacing:
                                                                          0.0,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w200,
                                                                    ),
                                                              ),
                                                            ].divide(const SizedBox(
                                                                height: 8.0)),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ].divide(
                                                      const SizedBox(height: 10.0)),
                                                ),
                                              if (messagesItem.sender !=
                                                  FFAppState().currentUser.id)
                                                Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Align(
                                                      alignment:
                                                          const AlignmentDirectional(
                                                              -1.0, -1.0),
                                                      child: Container(
                                                        constraints:
                                                            const BoxConstraints(
                                                          minHeight: 35.0,
                                                          maxWidth: 280.0,
                                                        ),
                                                        decoration:
                                                            const BoxDecoration(
                                                          color:
                                                              Color(0xFFF2F7FB),
                                                          borderRadius:
                                                              BorderRadius.only(
                                                            bottomLeft:
                                                                Radius.circular(
                                                                    18.0),
                                                            bottomRight:
                                                                Radius.circular(
                                                                    18.0),
                                                            topLeft:
                                                                Radius.circular(
                                                                    0.0),
                                                            topRight:
                                                                Radius.circular(
                                                                    18.0),
                                                          ),
                                                        ),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets.all(
                                                                  10.0),
                                                          child: Column(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              if (messagesItem
                                                                      .isAudio ==
                                                                  false)
                                                                Text(
                                                                  valueOrDefault<
                                                                      String>(
                                                                    messagesItem
                                                                        .mensagem,
                                                                    'Mensagem',
                                                                  ),
                                                                  style: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .override(
                                                                        fontFamily:
                                                                            'Inter',
                                                                        letterSpacing:
                                                                            0.0,
                                                                      ),
                                                                ),
                                                              if (messagesItem
                                                                      .isAudio ==
                                                                  true)
                                                                FlutterFlowAudioPlayer(
                                                                  audio: Audio
                                                                      .network(
                                                                    messagesItem
                                                                        .audioPath!,
                                                                    metas:
                                                                        Metas(
                                                                      title:
                                                                          'Title',
                                                                    ),
                                                                  ),
                                                                  titleTextStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .titleLarge
                                                                      .override(
                                                                        fontFamily:
                                                                            'Inter',
                                                                        fontSize:
                                                                            0.0,
                                                                        letterSpacing:
                                                                            0.0,
                                                                      ),
                                                                  playbackDurationTextStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelMedium
                                                                      .override(
                                                                        fontFamily:
                                                                            'Inter',
                                                                        color: const Color(
                                                                            0xFF009C3B),
                                                                        letterSpacing:
                                                                            0.0,
                                                                      ),
                                                                  fillColor: Colors
                                                                      .transparent,
                                                                  playbackButtonColor:
                                                                      const Color(
                                                                          0xFF009C3B),
                                                                  activeTrackColor:
                                                                      const Color(
                                                                          0xFF009C3B),
                                                                  inactiveTrackColor:
                                                                      FlutterFlowTheme.of(
                                                                              context)
                                                                          .alternate,
                                                                  elevation:
                                                                      0.0,
                                                                  playInBackground:
                                                                      PlayInBackground
                                                                          .enabled,
                                                                ),
                                                              Text(
                                                                dateTimeFormat(
                                                                  "H:m",
                                                                  messagesItem
                                                                      .createdAt,
                                                                  locale: FFLocalizations.of(
                                                                          context)
                                                                      .languageCode,
                                                                ),
                                                                style: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .override(
                                                                      fontFamily:
                                                                          'Inter',
                                                                      color: const Color(
                                                                          0xFF797C7B),
                                                                      fontSize:
                                                                          12.0,
                                                                      letterSpacing:
                                                                          0.0,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w200,
                                                                    ),
                                                              ),
                                                            ].divide(const SizedBox(
                                                                height: 8.0)),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ].divide(
                                                      const SizedBox(height: 10.0)),
                                                ),
                                            ].divide(const SizedBox(height: 8.0)),
                                          ),
                                        );
                                      },
                                      controller: _model.mensagens,
                                    );
                                  },
                                ),
                              ),
                            if ((containerMensagensRowList.isNotEmpty) == false)
                              Expanded(
                                child: Align(
                                  alignment: const AlignmentDirectional(0.0, -1.0),
                                  child: wrapWithModel(
                                    model: _model.initChatMessagesModel,
                                    updateCallback: () => safeSetState(() {}),
                                    child: InitChatMessagesWidget(
                                      username: widget.chat!.users
                                          .where((e) =>
                                              e != FFAppState().currentUser.id)
                                          .toList()
                                          .firstOrNull!,
                                      mensagem: (message) async {
                                        safeSetState(() {
                                          _model.textController?.text =
                                              message!;
                                        });
                                      },
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    if (_model.currentAudio != null &&
                        _model.currentAudio != '')
                      Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(
                            18.0, 18.0, 18.0, 18.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            FlutterFlowAudioPlayer(
                              audio: Audio.network(
                                _model.currentAudio!,
                                metas: Metas(
                                  title: 'Title',
                                ),
                              ),
                              titleTextStyle: FlutterFlowTheme.of(context)
                                  .titleLarge
                                  .override(
                                    fontFamily: 'Inter',
                                    fontSize: 0.0,
                                    letterSpacing: 0.0,
                                  ),
                              playbackDurationTextStyle:
                                  FlutterFlowTheme.of(context)
                                      .labelMedium
                                      .override(
                                        fontFamily: 'Inter',
                                        color: const Color(0xFF009C3B),
                                        letterSpacing: 0.0,
                                      ),
                              fillColor: Colors.transparent,
                              playbackButtonColor: const Color(0xFF009C3B),
                              activeTrackColor: const Color(0xFF009C3B),
                              inactiveTrackColor:
                                  FlutterFlowTheme.of(context).alternate,
                              elevation: 0.0,
                              playInBackground: PlayInBackground.enabled,
                            ),
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  12.0, 12.0, 12.0, 0.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Expanded(
                                    child: FFButtonWidget(
                                      onPressed: () async {
                                        _model.currentAudio = null;
                                        safeSetState(() {});
                                      },
                                      text: 'Deletar áudio',
                                      options: FFButtonOptions(
                                        height: 48.0,
                                        padding: const EdgeInsetsDirectional.fromSTEB(
                                            16.0, 0.0, 16.0, 0.0),
                                        iconPadding:
                                            const EdgeInsetsDirectional.fromSTEB(
                                                0.0, 0.0, 0.0, 0.0),
                                        color:
                                            FlutterFlowTheme.of(context).error,
                                        textStyle: FlutterFlowTheme.of(context)
                                            .titleSmall
                                            .override(
                                              fontFamily: 'Inter',
                                              color: Colors.white,
                                              letterSpacing: 0.0,
                                            ),
                                        elevation: 0.0,
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: FFButtonWidget(
                                      onPressed: () async {
                                        _model.msgsCopy =
                                            await MensagensTable().queryRows(
                                          queryFn: (q) => q
                                              .eqOrNull(
                                                'chat',
                                                widget.chat?.id,
                                              )
                                              .eqOrNull(
                                                'day_sended',
                                                supaSerialize<DateTime>(
                                                    getCurrentTimestamp),
                                              ),
                                        );
                                        if ((_model.msgsCopy != null &&
                                                (_model.msgsCopy)!
                                                    .isNotEmpty) ==
                                            false) {
                                          await MensagensTable().insert({
                                            'chat': widget.chat?.id,
                                            'sender':
                                                FFAppState().currentUser.id,
                                            'day_sended':
                                                supaSerialize<DateTime>(
                                                    getCurrentTimestamp),
                                            'first_message_of_day': true,
                                            'isAudio': true,
                                            'audioPath': _model.currentAudio,
                                          });
                                          await ChatTable().update(
                                            data: {
                                              'messagesCount': functions.sum(
                                                  widget.chat!.messagesCount!,
                                                  1),
                                              'last_message':
                                                  _model.textController.text,
                                            },
                                            matchingRows: (rows) =>
                                                rows.eqOrNull(
                                              'id',
                                              widget.chat?.id,
                                            ),
                                          );
                                          unawaited(
                                            () async {
                                              await _model.mensagens?.animateTo(
                                                _model.mensagens!.position
                                                    .maxScrollExtent,
                                                duration:
                                                    const Duration(milliseconds: 100),
                                                curve: Curves.ease,
                                              );
                                            }(),
                                          );
                                          safeSetState(() {
                                            _model.textController?.clear();
                                          });
                                          _model.currentAudio = null;
                                          safeSetState(() {});
                                        } else {
                                          await MensagensTable().insert({
                                            'chat': widget.chat?.id,
                                            'sender':
                                                FFAppState().currentUser.id,
                                            'day_sended':
                                                supaSerialize<DateTime>(
                                                    getCurrentTimestamp),
                                            'first_message_of_day': false,
                                            'isAudio': true,
                                            'audioPath': _model.currentAudio,
                                          });
                                          await ChatTable().update(
                                            data: {
                                              'messagesCount': functions.sum(
                                                  widget.chat!.messagesCount!,
                                                  1),
                                              'last_message':
                                                  _model.textController.text,
                                            },
                                            matchingRows: (rows) =>
                                                rows.eqOrNull(
                                              'id',
                                              widget.chat?.id,
                                            ),
                                          );
                                          unawaited(
                                            () async {
                                              await _model.mensagens?.animateTo(
                                                _model.mensagens!.position
                                                    .maxScrollExtent,
                                                duration:
                                                    const Duration(milliseconds: 100),
                                                curve: Curves.ease,
                                              );
                                            }(),
                                          );
                                          safeSetState(() {
                                            _model.textController?.clear();
                                          });
                                          _model.currentAudio = null;
                                          safeSetState(() {});
                                        }

                                        await ChatTable().update(
                                          data: {
                                            'last_update':
                                                supaSerialize<DateTime>(
                                                    getCurrentTimestamp),
                                          },
                                          matchingRows: (rows) => rows.eqOrNull(
                                            'id',
                                            widget.chat?.id,
                                          ),
                                        );

                                        safeSetState(() {});
                                      },
                                      text: 'Enviar áudio',
                                      options: FFButtonOptions(
                                        height: 48.0,
                                        padding: const EdgeInsetsDirectional.fromSTEB(
                                            16.0, 0.0, 16.0, 0.0),
                                        iconPadding:
                                            const EdgeInsetsDirectional.fromSTEB(
                                                0.0, 0.0, 0.0, 0.0),
                                        color: const Color(0xFF009C3B),
                                        textStyle: FlutterFlowTheme.of(context)
                                            .titleSmall
                                            .override(
                                              fontFamily: 'Inter',
                                              color: Colors.white,
                                              letterSpacing: 0.0,
                                            ),
                                        elevation: 0.0,
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                    ),
                                  ),
                                ].divide(const SizedBox(width: 18.0)),
                              ),
                            ),
                          ],
                        ),
                      ),
                    if (_model.currentAudio == null ||
                        _model.currentAudio == '')
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  18.0, 18.0, 12.0, 18.0),
                              child: Container(
                                width: double.infinity,
                                constraints: const BoxConstraints(
                                  minHeight: 36.0,
                                  maxHeight: 300.0,
                                ),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFF2F7FB),
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Container(
                                          decoration: const BoxDecoration(),
                                          child: Padding(
                                            padding:
                                                const EdgeInsetsDirectional.fromSTEB(
                                                    12.0, 0.0, 8.0, 0.0),
                                            child: TextFormField(
                                              controller: _model.textController,
                                              focusNode:
                                                  _model.textFieldFocusNode,
                                              autofocus: false,
                                              obscureText: false,
                                              decoration: InputDecoration(
                                                isDense: true,
                                                labelStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .labelMedium
                                                        .override(
                                                          fontFamily: 'Inter',
                                                          letterSpacing: 0.0,
                                                        ),
                                                hintText: 'Nova mensagem',
                                                hintStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .labelMedium
                                                        .override(
                                                          fontFamily: 'Inter',
                                                          letterSpacing: 0.0,
                                                        ),
                                                enabledBorder: InputBorder.none,
                                                focusedBorder: InputBorder.none,
                                                errorBorder: InputBorder.none,
                                                focusedErrorBorder:
                                                    InputBorder.none,
                                              ),
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily: 'Inter',
                                                        letterSpacing: 0.0,
                                                      ),
                                              maxLines: null,
                                              validator: _model
                                                  .textControllerValidator
                                                  .asValidator(context),
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
                                          _model.msgs =
                                              await MensagensTable().queryRows(
                                            queryFn: (q) => q
                                                .eqOrNull(
                                                  'chat',
                                                  widget.chat?.id,
                                                )
                                                .eqOrNull(
                                                  'day_sended',
                                                  supaSerialize<DateTime>(
                                                      getCurrentTimestamp),
                                                ),
                                          );
                                          if ((_model.msgs != null &&
                                                  (_model.msgs)!.isNotEmpty) ==
                                              false) {
                                            await MensagensTable().insert({
                                              'chat': widget.chat?.id,
                                              'sender':
                                                  FFAppState().currentUser.id,
                                              'mensagem':
                                                  _model.textController.text,
                                              'day_sended':
                                                  supaSerialize<DateTime>(
                                                      getCurrentTimestamp),
                                              'first_message_of_day': true,
                                            });
                                            await ChatTable().update(
                                              data: {
                                                'messagesCount': functions.sum(
                                                    widget
                                                        .chat!.messagesCount!,
                                                    1),
                                                'last_message':
                                                    _model.textController.text,
                                              },
                                              matchingRows: (rows) =>
                                                  rows.eqOrNull(
                                                'id',
                                                widget.chat?.id,
                                              ),
                                            );
                                            unawaited(
                                              () async {
                                                await _model.mensagens
                                                    ?.animateTo(
                                                  _model.mensagens!.position
                                                      .maxScrollExtent,
                                                  duration: const Duration(
                                                      milliseconds: 100),
                                                  curve: Curves.ease,
                                                );
                                              }(),
                                            );
                                            safeSetState(() {
                                              _model.textController?.clear();
                                            });
                                          } else {
                                            await MensagensTable().insert({
                                              'chat': widget.chat?.id,
                                              'sender':
                                                  FFAppState().currentUser.id,
                                              'mensagem':
                                                  _model.textController.text,
                                              'day_sended':
                                                  supaSerialize<DateTime>(
                                                      getCurrentTimestamp),
                                              'first_message_of_day': false,
                                            });
                                            await ChatTable().update(
                                              data: {
                                                'messagesCount': functions.sum(
                                                    widget
                                                        .chat!.messagesCount!,
                                                    1),
                                                'last_message':
                                                    _model.textController.text,
                                              },
                                              matchingRows: (rows) =>
                                                  rows.eqOrNull(
                                                'id',
                                                widget.chat?.id,
                                              ),
                                            );
                                            unawaited(
                                              () async {
                                                await _model.mensagens
                                                    ?.animateTo(
                                                  _model.mensagens!.position
                                                      .maxScrollExtent,
                                                  duration: const Duration(
                                                      milliseconds: 100),
                                                  curve: Curves.ease,
                                                );
                                              }(),
                                            );
                                            safeSetState(() {
                                              _model.textController?.clear();
                                            });
                                          }

                                          await ChatTable().update(
                                            data: {
                                              'last_update':
                                                  supaSerialize<DateTime>(
                                                      getCurrentTimestamp),
                                            },
                                            matchingRows: (rows) =>
                                                rows.eqOrNull(
                                              'id',
                                              widget.chat?.id,
                                            ),
                                          );

                                          safeSetState(() {});
                                        },
                                        child: Icon(
                                          Icons.send_rounded,
                                          color: FlutterFlowTheme.of(context)
                                              .secondaryText,
                                          size: 32.0,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          if (_model.isRecording == false)
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  0.0, 0.0, 18.0, 0.0),
                              child: FlutterFlowIconButton(
                                borderColor: Colors.transparent,
                                borderRadius: 32.0,
                                buttonSize: 48.0,
                                fillColor: const Color(0xFF009C3B),
                                icon: const Icon(
                                  Icons.mic_rounded,
                                  color: Colors.white,
                                  size: 24.0,
                                ),
                                onPressed: () async {
                                  _model.isRecording = true;
                                  safeSetState(() {});
                                  await startAudioRecording(
                                    context,
                                    audioRecorder: _model.audioRecorder ??=
                                        AudioRecorder(),
                                  );
                                },
                              ),
                            ),
                          if (_model.isRecording == true)
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  0.0, 0.0, 18.0, 0.0),
                              child: FlutterFlowIconButton(
                                borderColor: Colors.transparent,
                                borderRadius: 32.0,
                                buttonSize: 48.0,
                                fillColor: FlutterFlowTheme.of(context).error,
                                icon: const Icon(
                                  Icons.stop_rounded,
                                  color: Colors.white,
                                  size: 24.0,
                                ),
                                onPressed: () async {
                                  _model.isRecording = false;
                                  safeSetState(() {});
                                  await stopAudioRecording(
                                    audioRecorder: _model.audioRecorder,
                                    audioName: 'recordedFileBytes',
                                    onRecordingComplete:
                                        (audioFilePath, audioBytes) {
                                      _model.stopped = audioFilePath;
                                      _model.recordedFileBytes = audioBytes;
                                    },
                                  );

                                  _model.currentAudio = null;
                                  safeSetState(() {});

                                  safeSetState(() {});
                                },
                              ),
                            ),
                        ],
                      ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}