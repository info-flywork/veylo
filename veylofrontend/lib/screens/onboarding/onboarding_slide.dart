class OnboardingSlide {
  const OnboardingSlide({
    required this.title,
    required this.subtitle,
    required this.imageAsset,
    this.showCta = false,
  });

  final String title;
  final String subtitle;
  final String imageAsset;

  /// Son splash: Get Started + Log In satırı
  final bool showCta;
}
