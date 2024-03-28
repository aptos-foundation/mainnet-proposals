// Script hash: 54f6f600 
// Initialize AIP-67 parital governance voting.
script {
    use aptos_framework::aptos_governance;
    use aptos_framework::jwks;

    fun main(proposal_id: u64) {
        let framework_signer = aptos_governance::resolve_multi_step_proposal(
            proposal_id,
            @0x1,
            vector[243u8,130u8,86u8,249u8,6u8,20u8,14u8,0u8,157u8,186u8,200u8,128u8,183u8,233u8,94u8,85u8,125u8,138u8,52u8,86u8,112u8,220u8,176u8,19u8,169u8,21u8,17u8,177u8,153u8,92u8,38u8,141u8,],
        );
        jwks::initialize(&framework_signer);
    }
}
