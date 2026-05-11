import SwiftUI

struct ContentView: View {
    @State private var texto: String = ""
    @State private var resposta: String = ""

    var body: some View {
        VStack(spacing: 24) {
            Text("Digite algo")
                .font(.title2)
                .foregroundColor(.secondary)

            TextField("Escreva aqui...", text: $texto)
                .textFieldStyle(.roundedBorder)
                .padding(.horizontal)
                .autocorrectionDisabled(true)
                .textInputAutocapitalization(.never)
                .onChange(of: texto) { novoValor in
                    atualizarResposta(entrada: novoValor)
                }
                .onSubmit {
                    atualizarResposta(entrada: texto)
                }

            Text(resposta)
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.blue)
                .padding()
                .animation(.easeInOut, value: resposta)

            Spacer()
        }
        .padding(.top, 60)
    }

    private func atualizarResposta(entrada: String) {
        let normalizado = entrada
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .folding(options: .diacriticInsensitive, locale: .current)
            .lowercased()

        if normalizado == "ola" {
            resposta = "olá mundo"
        } else {
            resposta = ""
        }
    }
}

#Preview {
    ContentView()
}
