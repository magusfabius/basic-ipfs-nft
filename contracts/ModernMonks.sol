// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/Ownable.sol";
import "erc721a/contracts/ERC721A.sol";
//import "hardhat/console.sol";

contract ModernMonks is ERC721A, Ownable {
	using Strings for uint;

    string public baseURI;

	uint public constant MAX_SUPPLY = 8888;
	uint public constant MONKS_LIMIT = 20;
	uint public constant PRICE_PER_TOKEN = 0.01 ether;

	bool public isPaused = false;

	constructor(
        string memory _initBaseURI
    ) ERC721A("ModernMonks", "MM") {
        setBaseURI(_initBaseURI);
    }


    // internal
    function _baseURI() internal view virtual override returns (string memory) {
        return baseURI;
    }
    
	function _startTokenId() internal pure override returns (uint) {
		return 1;
	}

    // only owner 
    function setBaseURI(string memory newBaseURI) public onlyOwner {
        baseURI = newBaseURI;
    }

	function setPause(bool value) external onlyOwner {
		isPaused = value;
	}

    function withdrawAll() external onlyOwner {
        require(address(this).balance > 0, "No funds to withdraw");
        payable(owner()).transfer(address(this).balance);
    }

	function airdrop(address to, uint count) external onlyOwner {
		require(
			_totalMinted() + count <= MAX_SUPPLY,
			"ModernMonks: Over limit"
		);
		_safeMint(to, count);
	}

    // public
	function tokenURI(uint tokenId) public view override returns (string memory){
        require(_exists(tokenId), "ERC721Metadata: URI query for nonexistent token");

        return string(abi.encodePacked(_baseURI(), tokenId.toString(), ".json"));
	}

	function mint(uint count) external payable {
		require(!isPaused, "ModernMonks: Sales are off");
        require(count > 0, "ModernMonks: Need to mint at least 1 NFT");
		require(_totalMinted() + count <= MAX_SUPPLY,"ModernMonks: Over limit");

        if (msg.sender != owner()) {
			require(count <= MONKS_LIMIT, "ModernMonks: Over limit");
            require(msg.value >= PRICE_PER_TOKEN * count, "Insufficient funds");
        }

		_safeMint(msg.sender, count);
	}
}