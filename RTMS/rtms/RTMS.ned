//
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU Lesser General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
// 
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU Lesser General Public License for more details.
// 
// You should have received a copy of the GNU Lesser General Public License
// along with this program.  If not, see http://www.gnu.org/licenses/.
// 

package rtms.rtms;
import inet.applications.ethernet.EtherAppCli;
import inet.applications.ethernet.EtherAppSrv;
import inet.common.queue.Sink;
import inet.linklayer.ieee80211.Ieee80211Nic;
import inet.mobility.static.StationaryMobility;
import inet.physicallayer.ieee80211.packetlevel.Ieee80211ScalarRadioMedium;

module ThroughputClient
{
    parameters:
        @display("i=device/wifilaptop");
        @networkNode();
        *.interfaceTableModule = "";
    gates:
        input radioIn @directIn;

    submodules:
        wlan: Ieee80211Nic {
            parameters:
                @display("p=112,134;q=queue");
                mgmtType = default("Ieee80211MgmtSTASimplified");
        }
        mobility: StationaryMobility {
            parameters:
                @display("p=50,141");
        }
        sink: Sink {
            @display("p=109,68");
        }
    connections allowunconnected:
        wlan.radioIn <-- radioIn;
        wlan.upperLayerOut --> sink.in++;
}

network Network
{
    parameters:
        @display("b=297,203;bgb=741,392");
    submodules:
        PremiumUser: ThroughputClient {
            parameters:
                @display("r=,,#707070;p=370,47");
        }
        ap: RtmsAP {
            parameters:
                @display("p=200,200;r=,,#707070");
        }
        radioMedium: Ieee80211ScalarRadioMedium {
            parameters:
                @display("p=61,46");
        }
        StandardUser: ThroughputClient {
            @display("p=370,181");
        }
        Sensor: ThroughputClient {
            @display("p=370,300");
        }
    connections:
}
