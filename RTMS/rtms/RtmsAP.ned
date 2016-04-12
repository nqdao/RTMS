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
import inet.linklayer.ethernet.EtherLLC;
import inet.linklayer.ieee80211.Ieee80211Nic;
import inet.mobility.static.StationaryMobility;
import rtms.rtms.Controller;


//
// TODO documentation
//
module RtmsAP
{
    parameters:
        @networkNode();
        @labels(node);
        @display("i=device/accesspoint;bgb=608,408");
        *.interfaceTableModule = default("");
    gates:
        input radioIn[3] @directIn;
    submodules:
        wlanNic1: Ieee80211Nic {
            parameters:
                @display("p=130,279;q=queue");
                mgmtType = default("Ieee80211MgmtAPSimplified");
                mgmt.encapDecap = "true";
        }
        mobility: StationaryMobility {
            @display("p=31,37;b=5,7");
        }
        cli1: EtherAppCli {
            @display("p=285,91");
        }
        controller: Controller {
            @display("p=285,196");
        }
        wlanNic2: Ieee80211Nic {
            @display("p=285,279;q=queue");
            mgmtType = default("Ieee80211MgmtAPSimplified");
            mgmt.encapDecap = "true";
            
        }
        wlanNic3: Ieee80211Nic {
            @display("p=435,279;q=queue");
            mgmtType = default("Ieee80211MgmtAPSimplified");
            mgmt.encapDecap = "true";
        }
        cli2: EtherAppCli {
            @display("p=130,91");
        }
        cli3: EtherAppCli {
            @display("p=435,91");
        }
    connections allowunconnected:
        radioIn[0] --> { @display("m=s"); } --> wlanNic1.radioIn;
        radioIn[1] --> { @display("m=s"); } --> wlanNic2.radioIn;
        radioIn[2] --> { @display("m=s"); } --> wlanNic3.radioIn;
        cli1.out --> controller.in++;
        controller.out1 --> wlanNic1.upperLayerIn;
        controller.out2 --> wlanNic2.upperLayerIn;
        controller.out3 --> wlanNic3.upperLayerIn;
        cli2.out --> controller.in++;
        cli3.out --> controller.in++;
}

