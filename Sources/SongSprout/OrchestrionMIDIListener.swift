//  Created by B.T. Franklin on 3/2/20.

import AudioKit
import CoreMIDI

class OrchestrionMIDIListener: MIDIListener {
    
    func receivedMIDINoteOn(noteNumber: MIDINoteNumber, velocity: MIDIVelocity, channel: MIDIChannel, portID: MIDIUniqueID?, offset: MIDITimeStamp) {
        print("Orchestrion: receivedMIDINoteOn")
    }

    func receivedMIDINoteOff(noteNumber: MIDINoteNumber, velocity: MIDIVelocity, channel: MIDIChannel, portID: MIDIUniqueID?, offset: MIDITimeStamp) {
        print("Orchestrion: receivedMIDINoteOff")
    }

    func receivedMIDIController(_ controller: MIDIByte, value: MIDIByte, channel: MIDIChannel, portID: MIDIUniqueID?, offset: MIDITimeStamp) {
        print("Orchestrion: receivedMIDIController")
    }

    func receivedMIDIAftertouch(noteNumber: MIDINoteNumber, pressure: MIDIByte, channel: MIDIChannel, portID: MIDIUniqueID?, offset: MIDITimeStamp) {
        print("Orchestrion: receivedMIDIAftertouch")
    }

    func receivedMIDIAftertouch(_ pressure: MIDIByte, channel: MIDIChannel, portID: MIDIUniqueID?, offset: MIDITimeStamp) {
        print("Orchestrion: receivedMIDIAftertouch")
    }

    func receivedMIDIPitchWheel(_ pitchWheelValue: MIDIWord, channel: MIDIChannel, portID: MIDIUniqueID?, offset: MIDITimeStamp) {
        print("Orchestrion: receivedMIDIPitchWheel")
    }

    func receivedMIDIProgramChange(_ program: MIDIByte, channel: MIDIChannel, portID: MIDIUniqueID?, offset: MIDITimeStamp) {
        print("Orchestrion: receivedMIDIProgramChange")
    }

    func receivedMIDISetupChange() {
        print("Orchestrion: receivedMIDISetupChange")
    }

    func receivedMIDINotification(notification: MIDINotification) {
    }
    
    func receivedMIDIPropertyChange(propertyChangeInfo: MIDIObjectPropertyChangeNotification) {
    }
    
    func receivedMIDISystemCommand(_ data: [MIDIByte], portID: MIDIUniqueID? = nil, offset: MIDITimeStamp = 0) {
    }
}
