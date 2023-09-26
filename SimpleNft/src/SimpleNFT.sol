// SPDX-License-Identifier: GPL-3.0
pragma solidity 0.8.7;

import "@openzeppelin/contracts/utils/Strings.sol";

contract SimpleNFT{
    using Strings for uint256;

    // Events
    event Transfer(address indexed _from, address indexed _to, uint256 indexed _tokenId);
    event ApprovalForAll(address indexed _owner, address indexed _operator, bool _approved);

    // tokenId -> owner
    mapping(uint256 => address) private _owners; 

    // owner -> operator -> true
    mapping(address => mapping (address => bool)) private _operators;

    // owner -> tokens
    mapping(address => uint256) private _balances; 

    string baseURL = "https://example.com/images/";

    function mint(uint256 _tokenId) external {
        require(_owners[_tokenId] == address(0), "already minted");
        require(_tokenId < 100, "tokenId too large");
        _owners[_tokenId] = msg.sender;

        _balances[msg.sender] += 1; 
        emit Transfer(address(0), msg.sender, _tokenId);
    } 

    function ownerOf(uint256 _tokenId) external view returns (address owner){
        require(_owners[_tokenId] != address(0), "no such token");
        return _owners[_tokenId];
    }

    function transferFrom(address _from, address _to, uint256 _tokenId) external payable{
        require(_owners[_tokenId] == address(0), "token doesn't exist");
        require(_owners[_tokenId] == _from, "the from address is not the owner of the token");
        require(msg.sender == _from || _operators[_from][msg.sender], "not the owner");

        _operators[_from][msg.sender] = false; 
        _owners[_tokenId] = _to;
        _balances[_from] -= 1; 
        _balances[_to] += 1; 
        emit Transfer(_from, _to, _tokenId);
    }

    function tokenURI(uint256 _tokenId) external view returns (string memory){
        require(_owners[_tokenId] != address(0), "does not exist");
        return string(abi.encodePacked(baseURL, _tokenId.toString(), ".jpeg"));
    }

    function setApprovalForAll(address _operator, bool _approved) external{
            _operators[msg.sender][_operator] = _approved;
            emit ApprovalForAll(msg.sender, _operator, _approved);
    }

    function isApprovedForAll(address _owner, address _operator) external view returns (bool){
        return _operators[_owner][_operator];
    }

    function balanceOf(address _owner) external view returns (uint256){
        return _balances[_owner];
    }
}