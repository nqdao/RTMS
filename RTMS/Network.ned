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

package rtms;

import inet.applications.ethernet.EtherAppCli;
import inet.applications.ethernet.EtherAppSrv;
import inet.linklayer.ethernet.EtherLLC;
import inet.linklayer.ieee80211.Ieee80211Nic;
import inet.node.ethernet.EtherHost;
import inet.node.wireless.AccessPoint;


network Network
{
    @display("bgb=569,302");
    submodules:
        etherAppCli: EtherAppCli {
            @display("p=94,93");
        }
        etherAppSrv: EtherAppSrv {
            @display("p=521,93");
        }
        ieee80211Nic: Ieee80211Nic {
            @display("p=195,93");
        }
        ieee80211Nic1: Ieee80211Nic {
            @display("p=400,93");
        }
    connections:
        etherAppCli.out --> ieee80211Nic.upperLayerIn;
        etherAppSrv.out --> ieee80211Nic1.upperLayerIn;
        ieee80211Nic1.upperLayerOut --> etherAppSrv.in;
        ieee80211Nic.upperLayerOut --> etherAppCli.in;
}
