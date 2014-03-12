require(library xia_router_lib.click);
require(library xia_address.click);

controller1 :: XIAController2Port(RE AD1 CHID1, AD1, CHID1, 0.0.0.0, 1500, aa:aa:aa:aa:aa:aa);
router1 :: XIARouter2Port(RE AD1 RHID1, AD1, RHID1, 0.0.0.0, 1600, aa:aa:aa:aa:aa:aa, aa:aa:aa:aa:aa:aa);
beacon1 :: XIASCIONBeaconServerCore(RE AD1 BHID1, AD1, BHID1, 0.0.0.0, 1700, aa:aa:aa:aa:aa:aa,
        AID 11111,
        CONFIG_FILE "./TD1/TDC/AD1/beaconserver/conf/AD1BS.conf",
        TOPOLOGY_FILE "./TD1/TDC/AD1/topology1.xml",
        ROT "./TD1/TDC/AD1/beaconserver/ROT/rot-td1-0.xml");

controller2 :: XIAController2Port(RE AD2 CHID2, AD2, CHID2, 0.0.0.0, 1800, aa:aa:aa:aa:aa:aa);
router2 :: XIARouter4Port(RE AD2 RHID2, AD2, RHID2, 0.0.0.0, 1900,
        aa:aa:aa:aa:aa:aa, aa:aa:aa:aa:aa:aa, aa:aa:aa:aa:aa:aa, aa:aa:aa:aa:aa:aa);
router4 :: XIARouter2Port(RE AD2 RHID4, AD2, RHID4, 0.0.0.0, 2400, aa:aa:aa:aa:aa:aa, aa:aa:aa:aa:aa:aa);
beacon2 :: XIASCIONBeaconServer(RE AD2 BHID2, AD2, BHID2, 0.0.0.0, 2000, aa:aa:aa:aa:aa:aa,
        AID 22222,
        CONFIG_FILE "./TD1/Non-TDC/AD2/beaconserver/conf/AD2BS.conf",
        TOPOLOGY_FILE "./TD1/Non-TDC/AD2/topology2.xml",
        ROT "./TD1/Non-TDC/AD2/beaconserver/ROT/rot-td1-0.xml");

controller3 :: XIAController2Port(RE AD3 CHID3, AD3, CHID3, 0.0.0.0, 2100, aa:aa:aa:aa:aa:aa);
router3 :: XIARouter2Port(RE AD3 RHID3, AD3, RHID3, 0.0.0.0, 2200, aa:aa:aa:aa:aa:aa, aa:aa:aa:aa:aa:aa);
beacon3 :: XIASCIONBeaconServer(RE AD3 BHID3, AD3, BHID3, 0.0.0.0, 2300, aa:aa:aa:aa:aa:aa,
        AID 33333,
        CONFIG_FILE "./TD1/Non-TDC/AD3/beaconserver/conf/AD3BS.conf",
        TOPOLOGY_FILE "./TD1/Non-TDC/AD3/topology3.xml",
        ROT "./TD1/Non-TDC/AD3/beaconserver/ROT/rot-td1-0.xml");

controller1[0] -> LinkUnqueue(0.005, 1 GB/s) -> [0]beacon1;
beacon1[0] -> LinkUnqueue(0.005, 1 GB/s) -> [0]controller1;

controller2[0] -> LinkUnqueue(0.005, 1 GB/s) -> [0]beacon2;
beacon2[0] -> LinkUnqueue(0.005, 1 GB/s) -> [0]controller2;

controller3[0] -> LinkUnqueue(0.005, 1 GB/s) -> [0]beacon3;
beacon3[0] -> LinkUnqueue(0.005, 1 GB/s) -> [0]controller3;


controller1[1] -> LinkUnqueue(0.005, 1 GB/s) -> [1]router1;
router1[1] -> LinkUnqueue(0.005, 1 GB/s) -> [1]controller1;

controller2[1] -> LinkUnqueue(0.005, 1 GB/s) -> [1]router2;
router2[1] -> LinkUnqueue(0.005, 1 GB/s) -> [1]controller2;

controller3[1] -> LinkUnqueue(0.005, 1 GB/s) -> [1]router3;
router3[1] -> LinkUnqueue(0.005, 1 GB/s) -> [1]controller3;


router1[0] -> LinkUnqueue(0.005, 1 GB/s) -> [0]router2;
router2[0] -> LinkUnqueue(0.005, 1 GB/s) -> [0]router1;

router2[2] -> LinkUnqueue(0.005, 1 GB/s) -> [0]router4;
router4[0] -> LinkUnqueue(0.005, 1 GB/s) -> [2]router2;

router4[1] -> LinkUnqueue(0.005, 1 GB/s) -> [0]router3;
router3[0] -> LinkUnqueue(0.005, 1 GB/s) -> [1]router4;

Idle -> [3]router2;
router2[3] -> Idle;

// The following line is required by the xianet script so it can determine the appropriate
// host/router pair to run the nameserver on
// controller0 :: nameserver

ControlSocket(tcp, 7777);
