script {
    use aptos_framework::aptos_governance;
    use std::vector;

    fun main(proposal_id: u64) {
        let framework_signer = aptos_governance::resolve_multi_step_proposal(proposal_id, @0x1, vector::empty<u8>());
        aptos_governance::update_governance_config(
            &framework_signer,
            aptos_governance::get_min_voting_threshold(),
            100000000000000, // 1M APT
            aptos_governance::get_voting_duration_secs(),
        );
    }
}
