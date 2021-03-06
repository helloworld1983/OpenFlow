#include <omnetpp.h>
#include <openflow/openflow/protocol/OpenFlow.h>
#include "openflow/openflow/switch/buffer/Buffer.h"
#include <algorithm>

using namespace std;
using namespace inet;

namespace ofp{

Buffer::Buffer(){

}

Buffer::Buffer(int cap){
    capacity = cap;
    next_buffer_id = 1;
}

Buffer::~Buffer(){
    for(auto&& pair : pending_msgs) {
      delete pair.second;
    }
    pending_msgs.clear();
}

int Buffer::size(){
    return pending_msgs.size();
}

bool Buffer::isfull(){
    return pending_msgs.size() >= capacity;
}




// store message in buffer and return buffer_id.
uint32_t Buffer::storeMessage(EthernetIIFrame *msg){
    pending_msgs.insert(pair<uint32_t, EthernetIIFrame *> (next_buffer_id, msg));

    // OFP_NO_BUFFER = 0xffffffff;
    if (next_buffer_id != OFP_NO_BUFFER){
        uint32_t result = next_buffer_id;
        next_buffer_id++;
        return result;
    }else{
        next_buffer_id = 0;
        return next_buffer_id;
    }
}
bool Buffer::deleteMessage(EthernetIIFrame *msg){
    bool result = false;
    for (std::map<uint32_t, inet::EthernetIIFrame *>::const_iterator it = pending_msgs.begin(); it != pending_msgs.end(); ++it) {
      if (it->second == msg) {
          pending_msgs.erase(it);
          result = true;
      }
    }

    return result;
}


uint32_t Buffer::getCapacity(){
    return capacity;
}

// return message that is stored at the specified buffer_id
EthernetIIFrame *Buffer::returnMessage(uint32_t buffer_id){
    EthernetIIFrame *frame = (EthernetIIFrame *)pending_msgs[buffer_id];
    pending_msgs.erase(buffer_id);
    return frame;
}

} /*end namespace ofp*/
