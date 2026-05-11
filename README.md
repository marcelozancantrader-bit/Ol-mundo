# Olá Mundo

App que responde **olá mundo** quando você digita `olá`. Duas versões neste
repositório:

- **`OlaMundo/`** — versão original em **SwiftUI** (apenas iOS).
  Veja [`INSTALL.md`](INSTALL.md) para instalar em um iPhone real.
- **`flutter_app/`** — versão em **Flutter** (iOS + Android no mesmo código).
  Base recomendada para evoluir até um app vendável nas duas lojas.
  Veja [`flutter_app/README.md`](flutter_app/README.md).

## Qual versão usar?

| Cenário | Versão |
|---|---|
| Quero estudar SwiftUI / só preciso de iOS | `OlaMundo/` |
| Quero publicar nas duas lojas (App Store + Play Store) | `flutter_app/` |
| Quero o build script para gerar `.ipa` no Mac | `scripts/build-ipa.sh` |
