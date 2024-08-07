import 'package:supabase/supabase.dart';

class SupabaseCredentials {
  static const String APIKEY = "votre_clé_api";
  static const String APIURL = "Votre_url";

  static SupabaseClient? _client;

  static SupabaseClient getClient() {
    if (_client == null) {
      _client = SupabaseClient(APIURL, APIKEY);
    }
    return _client!;
  }
}
