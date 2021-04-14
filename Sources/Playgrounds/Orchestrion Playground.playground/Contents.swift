import SwiftUI
import PlaygroundSupport
import SongSprout

struct OrchestrionView: View {

    @State var styleGenotypeJSON: String = "<No Style Created>"

    var body: some View {
        VStack {
            Text("Orchestrion Demo").font(.largeTitle)
            Button("New Style") {
                makeStyle()
            }
            Button("Play") {
                Orchestrion.shared.play()
            }
            Button("Stop") {
                Orchestrion.shared.stop()
            }
        }
        .padding()
        .border(Color.black, width: 2)
        .padding(.top)

        VStack {
            Text("Current Style").font(.largeTitle)
            ScrollView {
                Text(styleGenotypeJSON)
                    .multilineTextAlignment(.leading)
            }
            .frame(width: 400, height: 500)
        }
        .padding()
        .border(Color.black, width: 2)
    }

    func makeStyle() {
        let genotype = MusicalGenotype()
        Orchestrion.shared.prepare(genotype)

        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        if let data = try? encoder.encode(genotype) {
            styleGenotypeJSON = String(data: data, encoding: .utf8)!
        }
    }
}

PlaygroundPage.current.setLiveView(OrchestrionView())
