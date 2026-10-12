/// Create Profile adımlarında seçilenler; son adımda backend'e tek seferde gönderilir.
class CreateProfileDraft {
  CreateProfileDraft._();

  static final CreateProfileDraft instance = CreateProfileDraft._();

  String fullName = '';
  String username = '';

  /// Seçilen fotoğrafın yerel yolu (yoksa fotoğrafsız devam).
  String? photoPath;

  /// FEMALE | MALE | NON_BINARY | PREFER_NOT_TO_SAY
  String? gender;
  List<String> interests = const [];

  void reset() {
    fullName = '';
    username = '';
    photoPath = null;
    gender = null;
    interests = const [];
  }
}
