#!/usr/local/sbin/click-install -uct24
require(library xia_mq_template.click);

gen_fb2_0(HID2, CID0, CID1, HID4, eth2);
gen_fb2_1(HID3, CID0, CID1, HID5, eth3);
gen_fb2_0(HID4, CID0, CID1, HID2, eth4);
gen_fb2_1(HID5, CID0, CID1, HID3, eth5);
