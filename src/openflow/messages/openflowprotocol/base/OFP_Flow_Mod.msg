
cplusplus {{
    #include "openflow/openflow/protocol/OpenFlow.h"
    #include "openflow/messages/openflowprotocol/base/OFP_Message_m.h"
}};


struct ofp::oxm_basic_match;
struct ofp::ofp_action_output;
packet ofp::OFP_Message;

namespace ofp;

// Modifications to a flow table by the controller.
packet OFP_Flow_Mod extends OFP_Message
{
    
    
    uint64_t cookie; // Opaque controller-issued identifier.
    uint64_t cookie_mask; // Mask used to restrict the cookie bits
                            //that must match when the command is
                            //OFPFC_MODIFY* or OFPFC_DELETE*. A value
                            //of 0 indicates no restriction. 
    // Flow actions. 
    uint8_t table_id; // ID of the table to put the flow in.
                            //For OFPFC_DELETE_* commands, OFPTT_ALL
                            //can also be used to delete matching
                            //flows from all tables. 
    uint8_t command; // One of OFPFC_*. 
    uint16_t idle_timeout; // Idle time before discarding (seconds).
    uint16_t hard_timeout; // Max time before discarding (seconds).
    uint16_t priority; // Priority level of flow entry. 
    uint32_t buffer_id; // Buffered packet to apply to, or
                            //OFP_NO_BUFFER.
                            //Not meaningful for OFPFC_DELETE*. 
    uint32_t out_port; // For OFPFC_DELETE* commands, require
                            //matching entries to include this as an
                            //output port. A value of OFPP_ANY
                            //indicates no restriction. */
    uint32_t out_group; // For OFPFC_DELETE* commands, require
                            //matching entries to include this as an
                            //output group. A value of OFPG_ANY
                            //indicates no restriction. 
    uint16_t flags; // One of OFPFF_*.
    uint8_t pad[2];
    oxm_basic_match match; // Fields to match. Variable size.
    ofp_action_output actions[];
    //struct ofp_instruction instructions[0]; // Instruction set 

}