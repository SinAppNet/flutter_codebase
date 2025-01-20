import '/auth/supabase_auth/auth_util.dart';
import '/backend/schema/structs/index.dart';
import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_util.dart';
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
