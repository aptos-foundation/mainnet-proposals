// Script hash: fe5682eb 
// Empty governance proposal, used for voting only
//
script {
    use aptos_framework::aptos_governance;

    fun main(proposal_id: u64) {
         let _framework_signer = aptos_governance::resolve_multi_step_proposal(
            proposal_id,
            @0000000000000000000000000000000000000000000000000000000000000001,
            vector[],
        );
    }
}
