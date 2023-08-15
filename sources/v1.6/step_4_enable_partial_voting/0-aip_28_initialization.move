// Script hash: a7027a84 
// Initialize AIP-28 parital governance voting.
// This script MUST be run before enabling the feature flag, otherwise no new proposal can be passed anymore.
script {
    use aptos_framework::aptos_governance;

    fun main(proposal_id: u64) {
        let framework_signer = aptos_governance::resolve_multi_step_proposal(
            proposal_id,
            @0000000000000000000000000000000000000000000000000000000000000001,
            vector[28u8,90u8,76u8,139u8,158u8,254u8,145u8,206u8,174u8,77u8,133u8,25u8,28u8,234u8,145u8,28u8,175u8,178u8,208u8,185u8,228u8,45u8,156u8,17u8,81u8,32u8,208u8,104u8,29u8,249u8,103u8,60u8,],
        );
        aptos_governance::initialize_partial_voting(&framework_signer);
    }
}
