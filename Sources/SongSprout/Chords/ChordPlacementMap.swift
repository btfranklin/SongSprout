//  Created by B.T. Franklin on 12/24/19.

import AudioKit

struct ChordPlacementMap {
    
    let chordPlacements: [(position: Duration, duration: Duration)]
    
    init(chordCount: Int, measureCount: Int, measureDuration: Duration) {
        
        var durations = [Double]()
        
        // This is effectively the placement of the first chord, filling the entire duration.
        durations.append(Double(measureCount) * measureDuration.beats)
        
        if chordCount > 1 {
            for _ in 1..<chordCount {
                
                // Find the largest value in the collection of durations
                let longestDuration = durations.max()!
                
                // Find the last occurrence of that longest duration
                // (This means shorter chords will tend to cluster at the end of the progression.)
                let firstLongDurationIndex = durations.lastIndex(of: longestDuration)!
                
                // Replace the longest duration by splitting it in half
                durations.remove(at: firstLongDurationIndex)
                durations.insert(longestDuration / 2, at: firstLongDurationIndex)
                durations.insert(longestDuration / 2, at: firstLongDurationIndex)
            }
        }
        
        var chordPlacements = [(position: Duration, duration: Duration)]()
        let chordAKDurations = durations.map {
            Duration(beats: $0)
        }
        var currentPosition = Duration(beats: 0)
        for duration in chordAKDurations {
            chordPlacements.append((position: currentPosition, duration: duration))
            currentPosition += duration
        }
        
        self.chordPlacements = chordPlacements
    }
}

extension ChordPlacementMap: CustomStringConvertible {
    var description: String {
        var str = ""
        for chordPlacement in chordPlacements {
            str += "{[\(chordPlacement.position.beats)] \(chordPlacement.duration.beats)}"
        }
        return str
    }
}
