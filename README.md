# Olá Mundo

Aplicativo iOS simples em SwiftUI: ao digitar `olá` no campo de texto, a tela exibe **olá mundo**.

## Como executar

1. Abra `OlaMundo/OlaMundo.xcodeproj` no Xcode 15 ou superior.
2. Selecione um simulador de iPhone (iOS 17+).
3. Pressione `Cmd + R` para compilar e rodar.

## Estrutura

- `OlaMundo/OlaMundoApp.swift` — ponto de entrada do app (SwiftUI `@main`).
- `OlaMundo/ContentView.swift` — tela principal com `TextField` e resposta dinâmica.

## Como funciona

O `TextField` está vinculado a um `@State` chamado `texto`. A cada alteração, o
texto é normalizado (sem acentos, minúsculas, sem espaços nas pontas) e
comparado com `"ola"`. Se for igual, a tela exibe **olá mundo**; caso contrário,
o rótulo de resposta fica vazio.
