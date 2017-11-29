//
// Copyright (C) 2017 Benjamin Martin Seregi <seregi@kth.se>
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

package inet.examples.anssdhcp;

import inet.networklayer.configurator.ipv4.IPv4NetworkConfigurator;
import inet.node.ethernet.Eth100M;
import inet.node.inet.Router;
import inet.node.inet.StandardHost;
import inet.node.inet.WirelessHost;
import inet.node.internetcloud.InternetCloud;
import inet.node.wireless.AccessPoint;
import inet.physicallayer.ieee80211.packetlevel.Ieee80211ScalarRadioMedium;
import ned.DatarateChannel;


network ANSSManInTheMiddle
{
    @display("bgb=1135.872,607.104;bgl=2");
    submodules:
        radioMedium: Ieee80211ScalarRadioMedium {
            @display("p=64,34");
        }
        client: WirelessHost {
            @display("p=64,124");
        }
        ap: AccessPoint {
            @display("p=298,232");
        }
        rogueGateway: Router {
            @display("p=510.408,277.848");
        }
        gateway: Router {
            @display("p=511,124");
        }
        remoteServer: StandardHost {
            @display("p=984.096,212.976");
        }
        dhcpServer: StandardHost {
            @display("p=179.928,427.176");
        }
        rogueDHCPServer: StandardHost {
            @display("p=345.168,427.176");
        }
        configurator: IPv4NetworkConfigurator {
            @display("p=180,35");
        }
        Internet: InternetCloud {
            @display("p=752.76,211.752;is=vl");
        }
    connections:
        gateway.pppg++ <--> Eth100M <--> Internet.pppg++;
        gateway.ethg++ <--> Eth100M <--> ap.ethg++;
        rogueGateway.pppg++ <--> Eth100M <--> Internet.pppg++;
        remoteServer.pppg++ <--> Eth100M <--> Internet.pppg++;
        dhcpServer.ethg++ <--> Eth100M <--> ap.ethg++;
        rogueDHCPServer.ethg++ <--> Eth100M <--> ap.ethg++;
        rogueGateway.ethg++ <--> Eth100M <--> ap.ethg++;
}

