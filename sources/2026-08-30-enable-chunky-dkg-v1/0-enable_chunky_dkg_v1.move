// Script hash: a2def68c
// Enable ChunkyDKG (ConfigV1) — full activation, replacing regular DKG.
// Prerequisite: ChunkyDKG framework resources must already be initialized
// (see encrypted_mempool_initialization.move).
script {
    use aptos_framework::aptos_governance;
    use aptos_framework::chunky_dkg_config;
    use aptos_std::fixed_point64;

    fun main(proposal_id: u64) {
        let framework = aptos_governance::resolve_multi_step_proposal(
            proposal_id,
            @0x1,
            vector[98u8,163u8,147u8,181u8,198u8,130u8,177u8,66u8,115u8,135u8,65u8,196u8,221u8,67u8,78u8,113u8,152u8,122u8,55u8,173u8,65u8,230u8,180u8,217u8,76u8,87u8,206u8,104u8,75u8,55u8,177u8,7u8,],
        );

        let config = chunky_dkg_config::new_v1(
            fixed_point64::create_from_rational(1, 2), // secrecy_threshold: 1/2
            fixed_point64::create_from_rational(2, 3), // reconstruction_threshold: 2/3
        );
        chunky_dkg_config::set_for_next_epoch(&framework, config);
        aptos_governance::reconfigure(&framework);
    }
}
