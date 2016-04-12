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

#include "Controller.h"

Define_Module(Controller);

using namespace inet;

namespace controller {
    const char* prem_ip = "20:00:00:00:00:00";
    const char* std_ip = "30:00:00:00:00:00";
    const char* sensor_ip = "40:00:00:00:00:00";
}

using namespace controller;

void Controller::initialize()
{
    // TODO - Generated method body
    Controller::prem_addr = MACAddress(prem_ip);
    Controller::std_addr = MACAddress(std_ip);
    Controller::sensor_addr = MACAddress(sensor_ip);
}

void Controller::handleMessage(cMessage *msg)
{
    // TODO - Generated method body
    if (msg->isPacket()) {
        EtherAppReq *req = check_and_cast<EtherAppReq *>(msg);
        Ieee802Ctrl *ctrl = check_and_cast<Ieee802Ctrl *>(req->getControlInfo());
        MACAddress destAddr = ctrl->getDest();
        if (destAddr.compareTo(Controller::prem_addr)) {
            EV << "Message arrived to prem addr, sending to NIC \n";
            send(msg, "out1");
        } else if (destAddr.compareTo(Controller::std_addr)) {
            EV << "Message arrived to std addr, sending to NIC \n";
            send(msg, "out2");
        } else if (destAddr.compareTo(Controller::sensor_addr)) {
            EV << "Message arrived to sensor addr, sending to NIC \n";
            send(msg, "out3");
        } else {
            EV << "Message is not for any users, deleting \n";
            delete msg;
        }

    }
}
