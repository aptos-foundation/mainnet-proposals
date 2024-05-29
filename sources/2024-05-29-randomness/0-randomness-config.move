// Script hash: 7229bc19 
script {
    use aptos_framework::aptos_governance;
    use aptos_framework::randomness_config;
    use aptos_std::fixed_point64;
    use std::vector;

    fun main(proposal_id: u64) {
        let framework_signer = aptos_governance::resolve_multi_step_proposal(proposal_id, @0x1, vector::empty<u8>());

        let v2 = randomness_config::new_v2(
            fixed_point64::create_from_rational(50, 100),
            fixed_point64::create_from_rational(66, 100),
            fixed_point64::create_from_rational(67, 100),
        );
        randomness_config::set_for_next_epoch(&framework_signer, v2);
        aptos_governance::reconfigure(&framework_signer);
    }
}
