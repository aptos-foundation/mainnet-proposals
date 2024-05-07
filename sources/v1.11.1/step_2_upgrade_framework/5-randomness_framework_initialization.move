// Script hash: 6bdc1881 
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
            vector[157u8,50u8,36u8,28u8,176u8,183u8,64u8,180u8,227u8,173u8,65u8,142u8,76u8,249u8,84u8,17u8,240u8,63u8,105u8,130u8,1u8,231u8,65u8,1u8,214u8,67u8,11u8,125u8,124u8,205u8,37u8,155u8,],
        );
        config_buffer::initialize(&framework); // on-chain config buffer
        dkg::initialize(&framework); // DKG state holder
        reconfiguration_state::initialize(&framework); // reconfiguration in progress global indicator
        randomness::initialize(&framework); // randomness seed holder

        let config = randomness_config::new_off();
        randomness_config::initialize(&framework, config);
    }
}
