// Script hash: dd4369fc 
// Initialize AIP-63 coin to fungible asset mapping.
// Create the mapping between coin <> FA and also add APT pairing in the map.

script {
    use aptos_framework::aptos_governance;
    use aptos_framework::coin;

    fun main(proposal_id: u64) {
        let framework_signer = aptos_governance::resolve_multi_step_proposal(
            proposal_id,
            @0x1,
            vector[118u8,101u8,99u8,116u8,111u8,114u8,58u8,58u8,101u8,109u8,112u8,116u8,121u8,60u8,117u8,56u8,62u8,40u8,41u8,],
        );
        coin::create_coin_conversion_map(&framework_signer);
        coin::create_pairing<aptos_framework::aptos_coin::AptosCoin>(&framework_signer);
    }
}
