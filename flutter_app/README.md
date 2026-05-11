# Olá Mundo — versão Flutter (iOS + Android)

Mesmo app, mas escrito uma vez e rodando nas duas plataformas. Base inicial
para um produto vendável nas duas lojas.

## Pré-requisitos

- **Flutter SDK 3.19+** — instale via https://docs.flutter.dev/get-started/install
- Para Android: Android Studio + emulador ou aparelho com USB debugging.
- Para iOS: **macOS com Xcode** (requisito da Apple, não há como contornar).

Confirme que tudo está OK:

```bash
flutter doctor
```

## Primeira vez: gerar as pastas de plataforma

Os arquivos nativos (`android/`, `ios/`, etc.) são gerados automaticamente pelo
Flutter. Eles **não** estão commitados aqui para manter o repo enxuto. Na
primeira vez:

```bash
cd flutter_app
flutter create .
flutter pub get
```

Esse comando cria as pastas `android/`, `ios/`, `linux/`, `macos/`, `web/`,
`windows/` sem sobrescrever `lib/`, `test/`, `pubspec.yaml` nem
`analysis_options.yaml`.

## Rodar em desenvolvimento

```bash
# Android (emulador ou dispositivo conectado)
flutter run -d android

# iOS (simulador ou dispositivo conectado; só em macOS)
flutter run -d ios

# Lista os dispositivos disponíveis
flutter devices
```

## Rodar os testes

```bash
flutter test
```

## Gerar builds de release

### Android — APK / App Bundle

```bash
# APK universal (mais simples para testar fora da Play Store)
flutter build apk --release

# App Bundle (.aab) — formato exigido pela Play Store
flutter build appbundle --release
```

Saída: `build/app/outputs/flutter-apk/app-release.apk` e
`build/app/outputs/bundle/release/app-release.aab`.

Para publicar você precisa **assinar** o build. Veja
https://docs.flutter.dev/deployment/android.

### iOS — IPA

```bash
flutter build ipa --release
```

Saída em `build/ios/ipa/`. Requer perfil de assinatura configurado no Xcode.
Veja https://docs.flutter.dev/deployment/ios.

## Caminho para vender o app

1. **Configure o nome do bundle** (ex.: `com.suaempresa.olamundo`) em:
   - `android/app/build.gradle` → `applicationId`
   - `ios/Runner.xcodeproj` → `PRODUCT_BUNDLE_IDENTIFIER`
2. **Apple:** assine US$ 99/ano em https://developer.apple.com/programs/, gere
   o `.ipa` e suba pelo Transporter ou TestFlight, depois envie para revisão
   na App Store Connect.
3. **Google:** pague US$ 25 (uma vez só) em https://play.google.com/console,
   suba o `.aab` assinado e preencha a ficha da loja.
4. **Monetização:** in-app purchases (pacote
   [`in_app_purchase`](https://pub.dev/packages/in_app_purchase)), assinatura
   (RevenueCat), ou venda direta do app (preço fixo no momento da publicação).

## Como funciona o app

`lib/main.dart` tem um `TextEditingController` ligado a um `TextField`.
A cada mudança, o texto é normalizado (lowercase, sem acentos, sem espaços nas
pontas) e comparado com `"ola"`. Se bater, o widget de resposta renderiza
**olá mundo**; senão, fica vazio.
