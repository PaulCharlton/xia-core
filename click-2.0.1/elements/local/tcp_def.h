#define TCPOLEN_TSTAMP_APPA	(TCPOLEN_TIMESTAMP+2) 

#define TCPOPT_TSTAMP_HDR	\
        (TCPOPT_NOP<<24|TCPOPT_NOP<<16|TCPOPT_TIMESTAMP<<8|TCPOLEN_TIMESTAMP)

#define TCP_MAX_WINSHIFT	14
#define TCP_REXMT_THRESH 	3
#define TCP_MAXWIN		65535