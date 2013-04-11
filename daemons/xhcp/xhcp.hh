#ifndef __XHCP_H__
#define __XHCP_H__

#define XHCP_SERVER_BEACON_INTERVAL 1
#define XHCP_CLIENT_ADEXPIRE_INTERVAL 15
#define XHCP_CLIENT_ADVERTISE_INTERVAL 3

#define XHCP_CLIENT_NAME_REGISTER_WAIT 5

#define XHCP_MAX_PACKET_SIZE 1024
#define XHCP_MAX_DAG_LENGTH 1024

#define XHCP_MAX_PATH 4096

#define HELLO 0
#define LSA 1
#define HOST_REGISTER 2

#define MAX_XID_SIZE 100

#define HID0 "HID:0000000000000000000000000000000000000000"
#define AD0   "AD:1000000000000000000000000000000000000000"
#define HID2 "HID:0000000000000000000000000000000000000002"
#define AD2   "AD:1000000000000000000000000000000000000002"

#define BHID "HID:1111111111111111111111111111111111111111"
#define SID_XHCP "SID:1110000000000000000000000000000000001111"
#define SID_XROUTE "SID:1110000000000000000000000000000000001112"
#define SID_NS "SID:1110000000000000000000000000000000001113"

#define XHCP_TYPE_AD 1
#define XHCP_TYPE_GATEWAY_ROUTER_HID 2
#define XHCP_TYPE_GATEWAY_ROUTER_4ID 3
#define XHCP_TYPE_NAME_SERVER_DAG 4

#define SOURCE_DIR "xia-core"
#define RESOLV_CONF "/etc/resolv.conf"

typedef struct xhcp_pkt_entry {
	short type;
	char data[];
} xhcp_pkt_entry;

typedef struct xhcp_pkt {
	uint32_t seq_num;
	uint16_t num_entries;
	char data[];
} xhcp_pkt;


#endif
