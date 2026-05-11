# Instalando o OlaMundo em um iPhone real

> **Importante:** o iOS exige que todo app seja **assinado com um certificado Apple**.
> Não existe "instalador universal" como `.exe` no Windows. Você vai precisar de
> uma das opções abaixo. Em todas elas, a etapa de compilação acontece em **macOS
> com Xcode** (não é possível compilar para iOS a partir de Linux ou Windows).

---

## Opção 1 — Xcode + Apple ID grátis (mais simples)

**Requisitos:** Mac com Xcode 15+, um Apple ID qualquer, cabo USB-C/Lightning.

**Limitações:** o app expira em 7 dias e precisa ser reinstalado. Máximo de 3
apps grátis instalados por vez.

1. Abra `OlaMundo/OlaMundo.xcodeproj` no Xcode.
2. No navegador de projeto, selecione o alvo **OlaMundo** > aba **Signing & Capabilities**.
3. Marque **Automatically manage signing** e selecione seu Apple ID em **Team**
   (se não aparecer, clique em **Add an Account** e entre com seu Apple ID).
4. Mude o **Bundle Identifier** para algo único, por exemplo
   `com.seunome.OlaMundo` (o padrão `com.example.OlaMundo` pode estar em uso).
5. Conecte o iPhone via cabo. No iPhone, vá em **Ajustes > Geral > VPN e gerenciamento
   de dispositivo** e confie no seu certificado de desenvolvedor.
6. No Xcode, escolha o seu iPhone na barra de dispositivos no topo.
7. Pressione `Cmd + R`. O Xcode compila, instala e abre o app no aparelho.

---

## Opção 2 — AltStore / Sideloadly (sem pagar Apple, sem expirar tão rápido)

**Requisitos:** Mac **ou** PC Windows, Apple ID grátis, iPhone, cabo.

1. No **Mac**, gere um `.ipa` não assinado:

   ```bash
   ./scripts/build-ipa.sh unsigned
   ```

   Sai em `build/OlaMundo.ipa`.

2. Instale o **[AltStore](https://altstore.io)** (recomendado) ou o
   **[Sideloadly](https://sideloadly.io)** no seu computador. Ambos têm
   tutorial oficial; o resumo é:
   - AltStore: instale o AltServer no PC/Mac, instale o AltStore no iPhone via
     AltServer, depois arraste o `.ipa` para o AltStore no iPhone.
   - Sideloadly: abra o app, conecte o iPhone, arraste o `.ipa`, informe seu
     Apple ID e clique em **Start**.
3. No iPhone, vá em **Ajustes > Geral > VPN e gerenciamento de dispositivo**
   e confie no certificado.

> AltStore renova o certificado automaticamente a cada 7 dias enquanto o
> AltServer estiver rodando na mesma rede Wi-Fi do iPhone.

---

## Opção 3 — Conta Apple Developer paga (US$ 99/ano)

**Requisitos:** Mac com Xcode, conta paga no [Apple Developer Program](https://developer.apple.com/programs/).

Útil se você quer distribuir para outras pessoas (TestFlight) ou se cansou da
expiração de 7 dias.

### Para o seu próprio dispositivo (development)

```bash
./scripts/build-ipa.sh development
```

Saída: `build/OlaMundo.ipa`. Instale via Apple Configurator, Xcode (Devices &
Simulators), ou TestFlight.

### Para distribuir ad-hoc (até 100 dispositivos cadastrados)

1. Cadastre o UDID dos iPhones-alvo no portal do Apple Developer.
2. Rode:

   ```bash
   ./scripts/build-ipa.sh ad-hoc
   ```

3. Distribua o `build/OlaMundo.ipa` resultante (Diawi, link direto, Apple Configurator etc.).

### Para distribuir via TestFlight

Use `method = app-store` no ExportOptions e suba via `xcrun altool` ou pela
janela Organizer do Xcode. Veja a [documentação da Apple](https://developer.apple.com/testflight/).

---

## Por que não posso só baixar um `.ipa` daqui?

Mesmo que eu te entregasse um `.ipa` pronto:

- Sem assinatura, o iOS **recusa a instalação** (erro "não foi possível instalar").
- Com a minha assinatura (hipotética), o iPhone **não confiaria** no certificado
  e o app não rodaria.
- A Apple impõe que o certificado seja **vinculado à conta Apple do dono do
  dispositivo** (no caso de Apple ID grátis) ou da equipe registrada (no caso
  de conta paga).

Por isso a assinatura precisa acontecer na sua máquina, com a sua conta.
