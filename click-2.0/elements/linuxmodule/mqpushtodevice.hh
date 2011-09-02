#ifndef CLICK_MQPUSHTODEVICE_HH
#define CLICK_MQPUSHTODEVICE_HH

/*
=c

MQPushToDevice(DEVNAME, QUEUE [, BURST, I<KEYWORDS>])

=s netdevices

sends packets to network device (Linux kernel)

=d

This manual page describes the Linux kernel module version of the MQPushToDevice
element using multi-queues feature. For the user-level element, read the MQPushToDevice.u manual page.

Pulls packets from its single input and sends them out the Linux network
interface named DEVNAME. DEVNAME may also be an Ethernet address, in which
case MQPushToDevice searches for a device with that address.

Sends up to BURST packets each time it is scheduled. By default, BURST is 16.
For good performance, you should set BURST to be 8 times the number of
elements that could generate packets for this device.

Packets must have a link header. For Ethernet, MQPushToDevice makes sure every
packet is at least 60 bytes long (but see NO_PAD).

Keyword arguments are:

=over 8

=item BURST

Unsigned integer. Same as the BURST argument.

=item QUIET

Boolean.  If true, then suppress device up/down messages.  Default is false.

=item ALLOW_NONEXISTENT

Allow nonexistent devices. If true, and no device named DEVNAME exists when
the router is initialized, then MQPushToDevice will report a warning (rather than an
error). Later, while the router is running, if a device named DEVNAME appears,
MQPushToDevice will seamlessly begin sending packets to it. Default is false.

=item NO_PAD

Boolean. If true, don't force packets to be at least 60 bytes (the
minimum Ethernet packet size).  This is useful because some 802.11
cards can send shorter Ethernet format packets.  Defaults false.

=item UP_CALL

Write handler.  If supplied, this handler is called when the device or link
comes up.

=item DOWN_CALL

Write handler.  If supplied, this handler is called when the device or link
goes down.

=back

=n

The Linux networking code may also send packets out the device. If the device
is in polling mode, Click will try to ensure that Linux eventually sends its
packets. Linux may cause the device to be busy when a MQPushToDevice wants to send a
packet. Click is not clever enough to re-queue such packets, and discards
them.

In Linux 2.2, whether or not the device is running in polling mode, MQPushToDevice
depends on the device driver's send operation for synchronization (e.g. tulip
send operation uses a bit lock). In Linux 2.4, we use the device's "xmit_lock"
to synchronize.

Packets sent via MQPushToDevice will not be received by any packet sniffers on the
machine. Use Tee and ToHostSniffers to send packets to sniffers explicitly.

=h count read-only

Returns the number of packets MQPushToDevice has pulled.

=h calls read-only

Returns a summary of MQPushToDevice statistics.

=h drops read-only

Returns the number of packets MQPushToDevice has dropped.  MQPushToDevice will drop
packets because they are too short for the device, or because the device
explicitly rejected them.

=h reset_counts write-only

Resets counters to zero when written.

=a FromDevice, PollDevice, FromHost, ToHost, MQPushToDevice.u, Tee, ToHostSniffers

*/

#include "elements/linuxmodule/anydevice.hh"
#include <click/notifier.hh>

class MQPushToDevice : public AnyTaskDevice { public:
  
  MQPushToDevice();
  ~MQPushToDevice();

  static void static_initialize();
  static void static_cleanup();
  
  const char *class_name() const	{ return "MQPushToDevice"; }
  const char *port_count() const	{ return PORTS_1_0; }
  const char *processing() const	{ return PUSH; }
  
  int configure_phase() const		{ return CONFIGURE_PHASE_TODEVICE; }
  int configure(Vector<String> &, ErrorHandler *);
  int initialize(ErrorHandler *);
  void cleanup(CleanupStage);
  void add_handlers();
  
  void push(int port, Packet *p);

  void reset_counts();
  inline void tx_wake_queue(net_device *);
  bool tx_intr();
  void change_device(net_device *);

#if CLICK_DEVICE_STATS
  // Statistics.
  uint64_t _time_clean;
  uint64_t _time_freeskb;
  uint64_t _time_queue;
  uint64_t _perfcnt1_pull;
  uint64_t _perfcnt1_clean;
  uint64_t _perfcnt1_freeskb;
  uint64_t _perfcnt1_queue;
  uint64_t _perfcnt2_pull;
  uint64_t _perfcnt2_clean;
  uint64_t _perfcnt2_freeskb;
  uint64_t _perfcnt2_queue;
  uint32_t _activations; 
#endif
  uint32_t _runs;
  uint32_t _pulls;
  uint32_t _npackets;
#if CLICK_DEVICE_THESIS_STATS || CLICK_DEVICE_STATS
  click_cycles_t _pull_cycles;
#endif
  uint32_t _rejected;
  uint32_t _hard_start;
  uint32_t _busy_returns;
  uint32_t _too_short;

#if HAVE_LINUX_MQ_POLLING
  bool polling() const			{ return _dev && _dev->is_polling(_dev, _queue) > 0; }
#else
  bool polling() const			{ return false; }
#endif

  unsigned int _queue; 
 
 private:
  struct _qstruct {
    Packet **q;
    uint32_t head;
    uint32_t tail;
    uint64_t drops;
  } _q; 

  unsigned _capacity;
  unsigned _burst;
  int _dev_idle;
  NotifierSignal _signal;
  bool _no_pad;
 
   
  int queue_packet(Packet *p);
  int size() { int offset= _q.tail-_q.head; if (offset<0) offset = _capacity +1 + offset; return offset; };
  int next_i(int i) const { return (i!=_capacity ? i+1 : 0); }
  Packet * peek();
  Packet * deq();
  bool enq(Packet *p);
  
};

#endif
