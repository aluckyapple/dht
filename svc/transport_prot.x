%#include "bigint.h"
%#include "chord_prot.h"

enum rpcstat {
  DORPC_OK = 0,
  DORPC_MARSHALLERR = 1
};

struct dorpc_arg {
  chordID dest_id;
  chordID src_id;
  u_int64_t send_time;
  int32_t src_vnode_num;
  int32_t src_coords<>;
  int32_t progno;
  int32_t procno;
  opaque  args<>;
};

struct dorpc_successres {
  chordID src_id;
  u_int64_t send_time_echo;
  int32_t src_vnode_num;
  int32_t src_coords<>;
  int32_t progno;
  int32_t procno;
  opaque  results<>;
};

union dorpc_res switch (rpcstat status) {
 case DORPC_OK:
   dorpc_successres resok;
 default:
   void;
};

program TRANSPORT_PROGRAM {
  version TRANSPORT_VERSION {
    dorpc_res
    TRANSPORTPROC_DORPC (dorpc_arg) = 1;
  } = 1;
} = 344451;
