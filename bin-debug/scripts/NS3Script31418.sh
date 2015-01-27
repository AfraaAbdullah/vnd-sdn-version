//UNDER DEVELOPMENT
//##########################################
//Script created by VND - Visual Network Description (SDN version)
//##########################################
#include "ns3/applications-module.h"
#include "ns3/config-store-module.h"
#include "ns3/core-module.h"
#include "ns3/csma-channel.h"
#include "ns3/csma-helper.h"
#include "ns3/csma-module.h"
#include "ns3/csma-net-device.h"
#include "ns3/internet-module.h"
#include "ns3/internet-stack-helper.h"
#include "ns3/ipv4-address.h"
#include "ns3/mobility-module.h"
#include "ns3/network-module.h"
#include "ns3/point-to-point-module.h"
#include "ns3/wifi-module.h"
#include "ns3/log.h"

#include <iostream>
#include <fstream>
#include <vector>
#include <string>

using namespace ns3;

NS_LOG_COMPONENT_DEFINE ("FirstScriptExample");

bool verbose = false;
bool use_drop = false;
ns3::Time timeout = ns3::Seconds (0);

bool SetVerbose (std::string value){
verbose = true;
return true;}

bool SetDrop (std::string value){
use_drop = true;
return true;}

bool SetTimeout (std::string value){
try {
timeout = ns3::Seconds (atof (value.c_str ()));
return true;}
catch (...) { return false; }
return false;}

int main (int argc, char *argv[]){
Time::SetResolution (Time::NS);
#ifdef NS3_OPENFLOW

  CommandLine cmd;
  cmd.AddValue ("v", "Verbose (turns on logging).", MakeCallback (&SetVerbose));
  cmd.AddValue ("verbose", "Verbose (turns on logging).", MakeCallback (&SetVerbose));
  cmd.AddValue ("d", "Use Drop Controller (Learning if not specified).", MakeCallback (&SetDrop));
  cmd.AddValue ("drop", "Use Drop Controller (Learning if not specified).", MakeCallback (&SetDrop));
  cmd.AddValue ("t", "Learning Controller Timeout (has no effect if drop controller is specified).", MakeCallback ( &SetTimeout));
  cmd.AddValue ("timeout", "Learning Controller Timeout (has no effect if drop controller is specified).", MakeCallback ( &SetTimeout));

  cmd.Parse (argc, argv);

  if (verbose){
  LogComponentEnable ("OpenFlowCsmaSwitchExample", LOG_LEVEL_INFO);
  LogComponentEnable ("OpenFlowInterface", LOG_LEVEL_INFO);
  LogComponentEnable ("OpenFlowSwitchNetDevice", LOG_LEVEL_INFO);
  LogComponentEnable ("UdpEchoClientApplication", LOG_LEVEL_INFO);
  LogComponentEnable ("UdpEchoServerApplication", LOG_LEVEL_INFO);}

  Ptr<Node> computer_1 = CreateObject<Node> ();
  Ptr<Node> switchOpenflow_2 = CreateObject<Node> ();
  Ptr<Node> computer_3 = CreateObject<Node> ();

  NodeContainer c = NodeContainer ()

  NS_LOG_INFO ("Install the IP stack.");
  InternetStackHelper internetStackH;
  internetStackH.Install (c);
  internetStackH.Install (c);@@)

  NS_LOG_INFO ("Install the IP stack.");
  InternetStackHelper internetStackH;
  internetStackH.Install (c);
  internetStackH.Install (c);@@ computer_1,)

  NS_LOG_INFO ("Install the IP stack.");
  InternetStackHelper internetStackH;
  internetStackH.Install (c);
  internetStackH.Install (c);@@ switchOpenflow_2,)

  NS_LOG_INFO ("Install the IP stack.");
  InternetStackHelper internetStackH;
  internetStackH.Install (c);
  internetStackH.Install (c);@@ computer_3,)

  NS_LOG_INFO ("Install the IP stack.");
  InternetStackHelper internetStackH;
  internetStackH.Install (c);

  Ptr<Node> computer_1 = CreateObject<Node> ();
  Ptr<CsmaNetDevice> DeviceswitchOpenflow_2 = CreateObject<CsmaNetDevice> ();
  DeviceswitchOpenflow_2->SetAddress (Mac48Address::Allocate ());
  switchOpenflow_2->AddDevice (deviceA);
  Ptr<Node> computer_3 = CreateObject<Node> ();

  NS_LOG_INFO ("Building links.");


  NS_LOG_INFO ("Building link net device container.");
  NodeContainer all_computer_3_switchOpenflow_2;
  all_computer_3_switchOpenflow_2.Add (computer_3);
  all_computer_3_switchOpenflow_2.Add (switchOpenflow_2);
  NetDeviceContainer ndc_p3p2 = csma_bridge_3_2.Install (all_computer_3_switchOpenflow_2);
  NodeContainer all_computer_1_switchOpenflow_2;
  all_computer_1_switchOpenflow_2.Add (computer_1);
  all_computer_1_switchOpenflow_2.Add (switchOpenflow_2);
  NetDeviceContainer ndc_p1p2 = csma_bridge_1_2.Install (all_computer_1_switchOpenflow_2);

  NS_LOG_INFO ("PCAP CONFIGURATION.");
  csma_bridge_3_2.EnablePcapAll("all_computer_3_switchOpenflow_2");
  csma_bridge_1_2.EnablePcapAll("all_computer_1_switchOpenflow_2");

  //Addressing...
  Ipv4AddressHelper address;
  address.SetBase ("10.0.0.1", "255.0.0.0");
  Ipv4InterfaceContainer iface_computer_3_switchOpenflow_2 = address.Assign (ndc_p3p2);
  address.SetBase ("10.0.0.3", "255.0.0.0");
  Ipv4InterfaceContainer iface_computer_1_switchOpenflow_2 = address.Assign (ndc_p1p2);

  UdpEchoServerHelper echoServer0 (9);

  ApplicationContainer serverApps2 = echoServer0.Install (computer_1.Get (0));
  ApplicationContainer serverApps3 = echoServer0.Install (switchOpenflow_2.Get (0));
  ApplicationContainer serverApps4 = echoServer0.Install (computer_3.Get (0));
  serverApps2.Start (Seconds (1.0));
  serverApps3.Start (Seconds (1.0));
  serverApps4.Start (Seconds (1.0));

  serverApps2.Stop (Seconds (10.0));
  serverApps3.Stop (Seconds (10.0));
  serverApps4.Stop (Seconds (10.0));

  UdpEchoClientHelper echoClient0 (iface_computer_3_switchOpenflow_2.GetAddress (1), 9);
  echoClient0.SetAttribute ("MaxPackets", UintegerValue (1));
  echoClient0.SetAttribute ("Interval", TimeValue (Seconds (1.0)));
  echoClient0.SetAttribute ("PacketSize", UintegerValue (1024));

  UdpEchoClientHelper echoClient1 (iface_computer_1_switchOpenflow_2.GetAddress (1), 9);
  echoClient1.SetAttribute ("MaxPackets", UintegerValue (1));
  echoClient1.SetAttribute ("Interval", TimeValue (Seconds (1.0)));
  echoClient1.SetAttribute ("PacketSize", UintegerValue (1024));


  ApplicationContainer clientApps2 = echoClient0.Install (computer_1.Get (0));
  ApplicationContainer clientApps3 = echoClient0.Install (switchOpenflow_2.Get (0));
  ApplicationContainer clientApps4 = echoClient0.Install (computer_3.Get (0));
  clientApps2.Start (Seconds (2.0));
  clientApps3.Start (Seconds (2.0));
  clientApps4.Start (Seconds (2.0));
  clientApps2.Stop (Seconds (10.0));
  clientApps3.Stop (Seconds (10.0));
  clientApps4.Stop (Seconds (10.0));

  NS_LOG_INFO ("Run Simulation.");
  Simulator::Run ();
  Simulator::Destroy ();
  NS_LOG_INFO ("Done.");
  #else
  NS_LOG_INFO ("NS-3 OpenFlow is not enabled. Cannot run simulation.");
  #endif
}