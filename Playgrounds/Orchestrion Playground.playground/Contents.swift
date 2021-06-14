import SwiftUI
import PlaygroundSupport
import SongSprout

struct OrchestrionView: View {

    @State var style: MusicalGenotype?
    @State var isSongCreated: Bool = false

    var styleGenotypeJSON: String {
        let result: String

        if let style = self.style {
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted
            if let data = try? encoder.encode(style) {
                result = String(data: data, encoding: .utf8)!
            } else {
                result = "Could not encode style"
            }
        } else {
            result = "<No Style Created>"
        }

        return result
    }

    var body: some View {
        VStack {
            Text("Orchestrion Demo").font(.largeTitle)

            Button("New style") {
                Orchestrion.shared.stop()
                style = MusicalGenotype()
                isSongCreated = false
            }

            Button("New song using style") {
                Orchestrion.shared.stop()
                Orchestrion.shared.prepare(style)
                isSongCreated = true
            }
            .disabled(style == nil)

            Button("Play") {
                Orchestrion.shared.play()
            }
            .disabled(!isSongCreated)

            Button("Stop") {
                Orchestrion.shared.stop()
            }
            .disabled(!isSongCreated)
        }
        .padding()
        .border(.black, width: 2)
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
        .border(.black, width: 2)
    }
}

PlaygroundPage.current.setLiveView(OrchestrionView())
