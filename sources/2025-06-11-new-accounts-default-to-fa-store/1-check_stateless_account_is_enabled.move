// Script hash: 22112f3c 
script {
    use aptos_framework::aptos_governance;
    fun main(proposal_id: u64) {
        aptos_governance::resolve_multi_step_proposal(
            proposal_id,
            @0x1,
            vector[],
        );
        assert!(std::features::is_default_account_resource_enabled(), 0);
    }
}
