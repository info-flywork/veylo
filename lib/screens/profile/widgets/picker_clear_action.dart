/// Profil seçici sheet sonucu. `value == null` → kullanıcı değeri temizledi
/// (eski "Seçimi temizle"); sheet kapatıldıysa sonuç hiç gelmez (null).
class PickedValue<T> {
  const PickedValue(this.value);

  final T? value;
}
