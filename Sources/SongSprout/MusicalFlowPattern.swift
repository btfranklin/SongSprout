//  Created by B.T. Franklin on 12/17/19.

public struct MusicalFlowPattern: Codable {
    
    private static let sectionalFormConfigOptions: [(designators: [SectionDescriptor.Designation], densities: [SectionDescriptor.Density])] = [
        ([.A,.A,.B,.C],          [.minimal, .minimal, .enhanced, .complete]),
        ([.A,.A,.B,.B],          [.minimal, .minimal, .complete, .complete]),                                   // Binary form
        ([.A,.B],                [.minimal, .complete]),                                                        // Verse/Chorus
        ([.A,.B,.C],             [.minimal, .complete, .enhanced]),                                             // Verse/Chorus/Bridge
        ([.A,.B,.A,.C],          [.minimal, .complete, .minimal, .complete]),
        ([.A,.B,.C,.D],          [.complete, .complete, .complete, .complete]),                                 // Through-composed
        ([.A,.A,.B],             [.enhanced, .enhanced, .complete]),                                            // Twelve-bar blues
        ([.A,.B,.C,.B,.A],       [.minimal, .enhanced, .complete, .enhanced, .minimal]),                        // Arch rondo form
        ([.A,.B,.A,.C,.A,.B,.A], [.minimal, .enhanced, .minimal, .complete, .minimal, .enhanced, .minimal]),    // Symmetrical rondo form
    ]
    
    public let hasIntro: Bool
    public let hasBreakSection: Bool
    public let sectionalForm: [SectionDescriptor.Designation]
    public let sectionalDensities: [SectionDescriptor.Density]
    public let occurrencesOfForm: Int
    
    public init(hasIntro: Bool,
                hasBreakSection: Bool,
                sectionalForm: [SectionDescriptor.Designation],
                sectionalDensities: [SectionDescriptor.Density],
                occurrencesOfForm: Int) {
        self.hasIntro = hasIntro
        self.hasBreakSection = hasBreakSection
        self.sectionalForm = sectionalForm
        self.sectionalDensities = sectionalDensities
        self.occurrencesOfForm = occurrencesOfForm
    }
    
    public init() {
        // TODO restore intros in flow
        //hasIntro = Bool.random(probability: 20)
hasIntro = false
        // TODO restore breaks in flow
        //hasBreakSection = Bool.random(probability: 20)
hasBreakSection = false
        let sectionalFormConfig = MusicalFlowPattern.sectionalFormConfigOptions.randomElement()!
        sectionalForm = sectionalFormConfig.designators
        sectionalDensities = sectionalFormConfig.densities
        
        switch sectionalForm.count {
        case 2:
            occurrencesOfForm = 4
        case 3:
            occurrencesOfForm = 3
        case 4:
            occurrencesOfForm = 2
        default:
            occurrencesOfForm = 1
        }
    }
    
    public func convertedIntoSectionDescriptors() -> [SectionDescriptor] {
        var sectionDescriptors: [SectionDescriptor] = []
        
        if hasIntro {
            let introMeasureCount = Int.random(in: 1...2)
            sectionDescriptors.append(.init(
                designation: .i,
                density: .minimal,
                measuresInPhrase: introMeasureCount,
                phraseCount: 1))
        }
        
        let phrasesPerSection = 2 * Int.random(in: 1...2)
        let overallLength = sectionalForm.count * occurrencesOfForm
        
        for sectionNumber in 0..<overallLength {
            sectionDescriptors.append(.init(
                designation: sectionalForm[sectionNumber % sectionalForm.count],
                density: sectionalDensities[sectionNumber % sectionalForm.count],
                measuresInPhrase: 4,
                phraseCount: phrasesPerSection))
        }
        
        if hasBreakSection {
            let strongestDesignation = sectionalForm.max {
                $0.rawValue < $1.rawValue
            }
            
            let lastStrongestIndex = sectionDescriptors.lastIndex {
                $0.designation == strongestDesignation
            }
            
            sectionDescriptors.insert(.init(
                designation: .b,
                density: .minimal,
                measuresInPhrase: 4,
                phraseCount: 1), at: lastStrongestIndex!)
        }
        
        let finaleMeasureCount = Int.random(in: 1...2)
        sectionDescriptors.append(.init(
            designation: .f,
            density: .minimal,
            measuresInPhrase: finaleMeasureCount,
            phraseCount: 1))
        
        return sectionDescriptors
    }
}
