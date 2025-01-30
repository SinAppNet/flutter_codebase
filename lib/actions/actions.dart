import '/auth/supabase_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/schema/structs/index.dart';
import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'dart:async';
import '/custom_code/actions/index.dart' as actions;
import 'package:flutter/material.dart';

Future<UsersRow?> updateUserState(BuildContext context) async {
  List<UsersRow>? returnedUser;
  String? fcm;

  await Future.wait([
    Future(() async {
      returnedUser = await UsersTable().queryRows(
        queryFn: (q) => q.eqOrNull(
          'uuid',
          currentUserUid,
        ),
      );
      FFAppState().currentUser = CurrentUserStruct(
        id: returnedUser?.firstOrNull?.id,
        nome: returnedUser?.firstOrNull?.nome,
        email: returnedUser?.firstOrNull?.email,
        profilePic: returnedUser?.firstOrNull?.profilePic,
        sobre: returnedUser?.firstOrNull?.sobre,
        whatsapp: returnedUser?.firstOrNull?.whatsapp,
        instagram: returnedUser?.firstOrNull?.instagram,
        linkedin: returnedUser?.firstOrNull?.linkedin,
        empresaId: returnedUser?.firstOrNull?.empresa,
        cargo: returnedUser?.firstOrNull?.cargo,
        interesses: returnedUser?.firstOrNull?.interesses,
        perfilCompleto: returnedUser?.firstOrNull?.perfilCompleto,
        premium: returnedUser?.firstOrNull?.premium,
      );
      FFAppState().update(() {});
      return returnedUser?.firstOrNull;
    }),
    Future(() async {
      fcm = await actions.getFCMToken();
      await UsersTable().update(
        data: {
          'fcm_token': fcm,
        },
        matchingRows: (rows) => rows.eqOrNull(
          'uuid',
          currentUserUid,
        ),
      );
    }),
  ]);

  return null;
}

Future sendPush(
  BuildContext context, {
  int? userId,
  String? title,
  String? message,
}) async {
  List<UsersRow>? user;
  ApiCallResponse? apiResultr37;

  user = await UsersTable().queryRows(
    queryFn: (q) => q.eqOrNull(
      'id',
      userId,
    ),
  );
  apiResultr37 = await SendPushCall.call(
    fcmToken: user.firstOrNull?.fcmToken,
    pushTitle: title,
    pushMessage: message,
  );
}

Future appTracking(
  BuildContext context, {
  int? userid,
  String? eventName,
  String? pageName,
  dynamic props,
}) async {
  ApiCallResponse? apiResult5sa;
  ApiCallResponse? apiResultpgc;
  ApiCallResponse? apiResult5saza;

  if (pageName != null && pageName != '') {
    unawaited(
      () async {
        apiResult5sa = await SegmentGroup.trackingCall.call(
          userId: userid,
          eventName: eventName,
          timestamp: getCurrentTimestamp.toString(),
          propsJson: props,
        );
      }(),
    );
    unawaited(
      () async {
        apiResultpgc = await SegmentGroup.pageCall.call(
          userId: userid,
          pageName: pageName,
          timestamp: getCurrentTimestamp.toString(),
        );
      }(),
    );
  } else {
    unawaited(
      () async {
        apiResult5saza = await SegmentGroup.trackingCall.call(
          userId: userid,
          eventName: eventName,
          timestamp: getCurrentTimestamp.toString(),
          propsJson: props,
        );
      }(),
    );
  }
}

Future updateNotifies(
  BuildContext context, {
  int? user,
  String? notifie,
}) async {
  List<NotificationsRow>? notifie;

  notifie = await NotificationsTable().queryRows(
    queryFn: (q) => q.eqOrNull(
      'user',
      user,
    ),
  );
  if (notifie == 'message') {
    await NotificationsTable().update(
      data: {
        'message': true,
      },
      matchingRows: (rows) => rows.eqOrNull(
        'id',
        notifie?.firstOrNull?.id,
      ),
    );
  } else if (notifie == 'connection') {
    await NotificationsTable().update(
      data: {
        'connection': true,
      },
      matchingRows: (rows) => rows.eqOrNull(
        'id',
        notifie?.firstOrNull?.id,
      ),
    );
  }
}
