//SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract ProofOfExistance2 {
    bytes32[] private proofs;

    function storeProof(bytes32 proof) public {
        proofs.push(proof);
    }

    function notarize(string calldata document) external {
        bytes32 proof = proofFor(document);
        storeProof(proof);
    }

    function proofFor(string memory document) pure public returns(bytes32) {
        return keccak256(abi.encodePacked(document));
    }

    function checkDocument(string memory document) public view returns(bool) {
        bytes32 proof = proofFor(document);
        return hasProof(proof);
    }

    function hasProof(bytes32 proof) internal view returns(bool) {
        for(uint i = 0; i < proofs.length; i++) {
            if(proofs[i] == proof) {
                return true;
            }
        }
        return false;
    }
}
