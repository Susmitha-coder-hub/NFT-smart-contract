// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/utils/Strings.sol";

contract NftCollection is ERC721, Ownable {
    using Counters for Counters.Counter;
    using Strings for uint256;

    Counters.Counter private _tokenIdCounter;
    
    uint256 public immutable maxSupply;
    string private _baseTokenURI;
    bool public paused = false;

    event Minted(address indexed to, uint256 indexed tokenId);
    event PausedStateChanged(bool isPaused);

    constructor(
        string memory name, 
        string memory symbol, 
        uint256 _maxSupply,
        string memory initialBaseURI
    ) ERC721(name, symbol) {
        maxSupply = _maxSupply;
        _baseTokenURI = initialBaseURI;
    }

    // Step 3: Access Control
    modifier whenNotPaused() {
        require(!paused, "Minting is paused");
        _;
    }

    // Requirement: Support minting by authorized account
    function safeMint(address to) public onlyOwner whenNotPaused {
        uint256 tokenId = _tokenIdCounter.current();
        
        require(tokenId < maxSupply, "Max supply reached");
        require(to != address(0), "Cannot mint to zero address");

        _tokenIdCounter.increment();
        _safeMint(to, tokenId);
        
        emit Minted(to, tokenId);
    }

    // Requirement: Pause/Unpause minting
    function setPaused(bool _paused) public onlyOwner {
        paused = _paused;
        emit PausedStateChanged(_paused);
    }

    // Step 4: Metadata & Token URI Handling
    function _baseURI() internal view override returns (string memory) {
        return _baseTokenURI;
    }

    function setBaseURI(string memory newBaseURI) public onlyOwner {
        _baseTokenURI = newBaseURI;
    }

    // Requirement: Read-only inspection functions
    function totalSupply() public view returns (uint256) {
        return _tokenIdCounter.current();
    }

    // Requirement: Ensure burning updates state consistently
    function burn(uint256 tokenId) public {
        require(_isApprovedOrOwner(_msgSender(), tokenId), "Not owner nor approved");
        _burn(tokenId);
    }
}