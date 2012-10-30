// Generated by make-ip-conf.pl
//eth2 10.0.0.1 eth2 
//eth3 10.0.1.1 eth3 
//eth4 10.0.2.1 eth4 
//eth5 10.0.3.1 eth5 

// Shared IP input path and routing table
ip :: Strip(14)
    -> CheckIPHeader(INTERFACES 10.0.0.1/255.255.255.0 10.0.1.1/255.255.255.0 10.0.2.1/255.255.255.0 10.0.3.1/255.255.255.0)
    -> rt :: StaticIPLookup(
	10.0.0.1/32 0,
	10.0.0.255/32 0,
	10.0.0.0/32 0,
	10.0.1.1/32 0,
	10.0.1.255/32 0,
	10.0.1.0/32 0,
	10.0.2.1/32 0,
	10.0.2.255/32 0,
	10.0.2.0/32 0,
	10.0.3.1/32 0,
	10.0.3.255/32 0,
	10.0.3.0/32 0,
	10.0.0.0/255.255.255.0 1,
	10.0.1.0/255.255.255.0 2,
	10.0.2.0/255.255.255.0 3,
	10.0.3.0/255.255.255.0 4,
	255.255.255.255/32 0.0.0.0 0,
	0.0.0.0/32 0,
	131.179.80.139/255.255.255.255 131.179.80.139 4);

// ARP responses are copied to each ARPQuerier and the host.
arpt :: Tee(5);

c0 :: Classifier(12/0806 20/0001, 12/0806 20/0002, 12/0800, -);

pd_eth2_0:: MQPollDevice(eth2, QUEUE 0, BURST 32, PROMISC true) -> c0; 
pd_eth2_1:: MQPollDevice(eth2, QUEUE 1, BURST 32, PROMISC true) -> c0; 
pd_eth2_2:: MQPollDevice(eth2, QUEUE 2, BURST 32, PROMISC true) -> c0; 
pd_eth2_3:: MQPollDevice(eth2, QUEUE 3, BURST 32, PROMISC true) -> c0; 
pd_eth2_4:: MQPollDevice(eth2, QUEUE 4, BURST 32, PROMISC true) -> c0; 
pd_eth2_5:: MQPollDevice(eth2, QUEUE 5, BURST 32, PROMISC true) -> c0; 
out0 :: IsoCPUQueue(200);
out0 -> tod_eth2_0 :: MQToDevice(eth2, QUEUE 0, BURST 32) 
out0 -> tod_eth2_1 :: MQToDevice(eth2, QUEUE 1, BURST 32) 
out0 -> tod_eth2_2 :: MQToDevice(eth2, QUEUE 2, BURST 32) 
out0 -> tod_eth2_3 :: MQToDevice(eth2, QUEUE 3, BURST 32) 
out0 -> tod_eth2_4 :: MQToDevice(eth2, QUEUE 4, BURST 32) 
out0 -> tod_eth2_5 :: MQToDevice(eth2, QUEUE 5, BURST 32) 

c0[0] -> ar0 :: ARPResponder(10.0.0.1 eth2) -> out0;
arpq0 :: ARPQuerier(10.0.0.1, eth2) -> out0;
c0[1] -> arpt;
arpt[0] -> [1]arpq0;
c0[2] -> Paint(1) -> ip;
c0[3] -> Print("eth2 non-IP") -> Discard;



c1 :: Classifier(12/0806 20/0001, 12/0806 20/0002, 12/0800, -);

pd_eth3_0:: MQPollDevice(eth3, QUEUE 0, BURST 32, PROMISC true) -> c1; 
pd_eth3_1:: MQPollDevice(eth3, QUEUE 1, BURST 32, PROMISC true) -> c1; 
pd_eth3_2:: MQPollDevice(eth3, QUEUE 2, BURST 32, PROMISC true) -> c1; 
pd_eth3_3:: MQPollDevice(eth3, QUEUE 3, BURST 32, PROMISC true) -> c1; 
pd_eth3_4:: MQPollDevice(eth3, QUEUE 4, BURST 32, PROMISC true) -> c1; 
pd_eth3_5:: MQPollDevice(eth3, QUEUE 5, BURST 32, PROMISC true) -> c1; 
out1 :: IsoCPUQueue(200);
out1 -> tod_eth3_0 :: MQToDevice(eth3, QUEUE 0, BURST 32) 
out1 -> tod_eth3_1 :: MQToDevice(eth3, QUEUE 1, BURST 32) 
out1 -> tod_eth3_2 :: MQToDevice(eth3, QUEUE 2, BURST 32) 
out1 -> tod_eth3_3 :: MQToDevice(eth3, QUEUE 3, BURST 32) 
out1 -> tod_eth3_4 :: MQToDevice(eth3, QUEUE 4, BURST 32) 
out1 -> tod_eth3_5 :: MQToDevice(eth3, QUEUE 5, BURST 32) 

c1[0] -> ar1 :: ARPResponder(10.0.1.1 eth3) -> out1;
arpq1 :: ARPQuerier(10.0.1.1, eth3) -> out1;
c1[1] -> arpt;
arpt[1] -> [1]arpq1;
c1[2] -> Paint(2) -> ip;
c1[3] -> Print("eth3 non-IP") -> Discard;



c2 :: Classifier(12/0806 20/0001, 12/0806 20/0002, 12/0800, -);

pd_eth4_0:: MQPollDevice(eth4, QUEUE 0, BURST 32, PROMISC true) -> c2; 
pd_eth4_1:: MQPollDevice(eth4, QUEUE 1, BURST 32, PROMISC true) -> c2; 
pd_eth4_2:: MQPollDevice(eth4, QUEUE 2, BURST 32, PROMISC true) -> c2; 
pd_eth4_3:: MQPollDevice(eth4, QUEUE 3, BURST 32, PROMISC true) -> c2; 
pd_eth4_4:: MQPollDevice(eth4, QUEUE 4, BURST 32, PROMISC true) -> c2; 
pd_eth4_5:: MQPollDevice(eth4, QUEUE 5, BURST 32, PROMISC true) -> c2; 
out2 :: IsoCPUQueue(200);
out2 -> tod_eth4_0 :: MQToDevice(eth4, QUEUE 0, BURST 32) 
out2 -> tod_eth4_1 :: MQToDevice(eth4, QUEUE 1, BURST 32) 
out2 -> tod_eth4_2 :: MQToDevice(eth4, QUEUE 2, BURST 32) 
out2 -> tod_eth4_3 :: MQToDevice(eth4, QUEUE 3, BURST 32) 
out2 -> tod_eth4_4 :: MQToDevice(eth4, QUEUE 4, BURST 32) 
out2 -> tod_eth4_5 :: MQToDevice(eth4, QUEUE 5, BURST 32) 

c2[0] -> ar2 :: ARPResponder(10.0.2.1 eth4) -> out2;
arpq2 :: ARPQuerier(10.0.2.1, eth4) -> out2;
c2[1] -> arpt;
arpt[2] -> [1]arpq2;
c2[2] -> Paint(3) -> ip;
c2[3] -> Print("eth4 non-IP") -> Discard;



c3 :: Classifier(12/0806 20/0001, 12/0806 20/0002, 12/0800, -);

pd_eth5_0:: MQPollDevice(eth5, QUEUE 0, BURST 32, PROMISC true) -> c3; 
pd_eth5_1:: MQPollDevice(eth5, QUEUE 1, BURST 32, PROMISC true) -> c3; 
pd_eth5_2:: MQPollDevice(eth5, QUEUE 2, BURST 32, PROMISC true) -> c3; 
pd_eth5_3:: MQPollDevice(eth5, QUEUE 3, BURST 32, PROMISC true) -> c3; 
pd_eth5_4:: MQPollDevice(eth5, QUEUE 4, BURST 32, PROMISC true) -> c3; 
pd_eth5_5:: MQPollDevice(eth5, QUEUE 5, BURST 32, PROMISC true) -> c3; 
out3 :: IsoCPUQueue(200);
out3 -> tod_eth5_0 :: MQToDevice(eth5, QUEUE 0, BURST 32) 
out3 -> tod_eth5_1 :: MQToDevice(eth5, QUEUE 1, BURST 32) 
out3 -> tod_eth5_2 :: MQToDevice(eth5, QUEUE 2, BURST 32) 
out3 -> tod_eth5_3 :: MQToDevice(eth5, QUEUE 3, BURST 32) 
out3 -> tod_eth5_4 :: MQToDevice(eth5, QUEUE 4, BURST 32) 
out3 -> tod_eth5_5 :: MQToDevice(eth5, QUEUE 5, BURST 32) 

c3[0] -> ar3 :: ARPResponder(10.0.3.1 eth5) -> out3;
arpq3 :: ARPQuerier(10.0.3.1, eth5) -> out3;
c3[1] -> arpt;
arpt[3] -> [1]arpq3;
c3[2] -> Paint(4) -> ip;
c3[3] -> Print("eth5 non-IP") -> Discard;


StaticThreadSched(  pd_eth2_0 0, tod_eth2_0 0, pd_eth3_0 0, tod_eth3_0 0, pd_eth4_0 0, tod_eth4_0 0, pd_eth5_0 0, tod_eth5_0 0);
StaticThreadSched(  pd_eth2_1 1, tod_eth2_1 1, pd_eth3_1 1, tod_eth3_1 1, pd_eth4_1 1, tod_eth4_1 1, pd_eth5_1 1, tod_eth5_1 1);
StaticThreadSched(  pd_eth2_2 2, tod_eth2_2 2, pd_eth3_2 2, tod_eth3_2 2, pd_eth4_2 2, tod_eth4_2 2, pd_eth5_2 2, tod_eth5_2 2);
StaticThreadSched(  pd_eth2_3 3, tod_eth2_3 3, pd_eth3_3 3, tod_eth3_3 3, pd_eth4_3 3, tod_eth4_3 3, pd_eth5_3 3, tod_eth5_3 3);
StaticThreadSched(  pd_eth2_4 4, tod_eth2_4 4, pd_eth3_4 4, tod_eth3_4 4, pd_eth4_4 4, tod_eth4_4 4, pd_eth5_4 4, tod_eth5_4 4);
StaticThreadSched(  pd_eth2_5 5, tod_eth2_5 5, pd_eth3_5 5, tod_eth3_5 5, pd_eth4_5 5, tod_eth4_5 5, pd_eth5_5 5, tod_eth5_5 5);

// Local delivery
toh :: ToHost;
arpt[4] -> toh;
rt[0] -> EtherEncap(0x0800, 1:1:1:1:1:1, 2:2:2:2:2:2) -> toh;

// Forwarding path for eth2
rt[1] -> DropBroadcasts
    -> cp0 :: PaintTee(1)
    -> gio0 :: IPGWOptions(10.0.0.1)
    -> FixIPSrc(10.0.0.1)
    -> dt0 :: DecIPTTL
    -> fr0 :: IPFragmenter(1500)
    -> [0]arpq0;
dt0[1] -> ICMPError(10.0.0.1, timeexceeded) -> rt;
fr0[1] -> ICMPError(10.0.0.1, unreachable, needfrag) -> rt;
gio0[1] -> ICMPError(10.0.0.1, parameterproblem) -> rt;
cp0[1] -> ICMPError(10.0.0.1, redirect, host) -> rt;

// Forwarding path for eth3
rt[2] -> DropBroadcasts
    -> cp1 :: PaintTee(2)
    -> gio1 :: IPGWOptions(10.0.1.1)
    -> FixIPSrc(10.0.1.1)
    -> dt1 :: DecIPTTL
    -> fr1 :: IPFragmenter(1500)
    -> [0]arpq1;
dt1[1] -> ICMPError(10.0.1.1, timeexceeded) -> rt;
fr1[1] -> ICMPError(10.0.1.1, unreachable, needfrag) -> rt;
gio1[1] -> ICMPError(10.0.1.1, parameterproblem) -> rt;
cp1[1] -> ICMPError(10.0.1.1, redirect, host) -> rt;

// Forwarding path for eth4
rt[3] -> DropBroadcasts
    -> cp2 :: PaintTee(3)
    -> gio2 :: IPGWOptions(10.0.2.1)
    -> FixIPSrc(10.0.2.1)
    -> dt2 :: DecIPTTL
    -> fr2 :: IPFragmenter(1500)
    -> [0]arpq2;
dt2[1] -> ICMPError(10.0.2.1, timeexceeded) -> rt;
fr2[1] -> ICMPError(10.0.2.1, unreachable, needfrag) -> rt;
gio2[1] -> ICMPError(10.0.2.1, parameterproblem) -> rt;
cp2[1] -> ICMPError(10.0.2.1, redirect, host) -> rt;

// Forwarding path for eth5
rt[4] -> DropBroadcasts
    -> cp3 :: PaintTee(4)
    -> gio3 :: IPGWOptions(10.0.3.1)
    -> FixIPSrc(10.0.3.1)
    -> dt3 :: DecIPTTL
    -> fr3 :: IPFragmenter(1500)
    -> [0]arpq3;
dt3[1] -> ICMPError(10.0.3.1, timeexceeded) -> rt;
fr3[1] -> ICMPError(10.0.3.1, unreachable, needfrag) -> rt;
gio3[1] -> ICMPError(10.0.3.1, parameterproblem) -> rt;
cp3[1] -> ICMPError(10.0.3.1, redirect, host) -> rt;
