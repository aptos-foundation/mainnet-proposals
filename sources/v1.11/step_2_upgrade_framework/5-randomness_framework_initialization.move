// Script hash: 148deffd 
// Initialize on-chain randomness resources.
script {
    use aptos_framework::aptos_governance;
    use aptos_framework::config_buffer;
    use aptos_framework::dkg;
    use aptos_framework::randomness;
    use aptos_framework::randomness_config;
    use aptos_framework::reconfiguration_state;

    fun main(proposal_id: u64) {
        let framework = aptos_governance::resolve_multi_step_proposal(
            proposal_id,
            @0x1,
            vector[59u8,244u8,203u8,127u8,87u8,157u8,17u8,114u8,119u8,90u8,159u8,77u8,211u8,135u8,93u8,156u8,4u8,133u8,240u8,123u8,33u8,87u8,200u8,163u8,137u8,78u8,121u8,14u8,67u8,63u8,94u8,113u8,],
        );
        config_buffer::initialize(&framework); // on-chain config buffer
        dkg::initialize(&framework); // DKG state holder
        reconfiguration_state::initialize(&framework); // reconfiguration in progress global indicator
        randomness::initialize(&framework); // randomness seed holder

        let config = randomness_config::new_off();
        randomness_config::initialize(&framework, config);
    }
}
