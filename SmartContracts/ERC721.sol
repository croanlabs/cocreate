pragma solidity ^0.6.11;

// SPDX-License-Identifier: Apache-2.0
/** 
 * @title Smart Contracts
 * @author Alonso Rodriguez
 * @notice These contracts allows implement the logic of the aplication. Based on ERC721
 * @dev Status: dev
 */
//import "./IERC721Receiver.sol";
import "./ERC165.sol";
//import "./Ownable.sol";

/**
 * @title ERC721 Non-Fungible Token Standard basic implementation
 * @dev see https://eips.ethereum.org/EIPS/eip-721
 */
contract ERC721 is ERC165 {

    event Transfer(address indexed from, address indexed to, bytes32 indexed tokenId);
    event Approval(address indexed owner, address indexed approved, bytes32 indexed tokenId);
    event ApprovalForAll(address indexed owner, address indexed operator, bool approved);

    // Equals to `bytes4(keccak256("onERC721Received(address,address,uint256,bytes)"))`
    // which can be also obtained as `IERC721Receiver(0).onERC721Received.selector`
    bytes4 private constant _ERC721_RECEIVED = 0x150b7a02;

    // Mapping from token ID to owner
    mapping (bytes32 => address[]) private _tokenOwner;

    mapping (bytes32 => bytes32[]) private _parents;
    mapping (bytes32 => string) public _ipfsAddressByTokenId;

    // Mapping from token ID to approved address
    mapping (bytes32 => address) private _tokenApprovals;

    // Mapping from owner to number of owned token
    mapping (address => uint256) private _ownedTokensCount;

    // Mapping from owner to operator approvals
    mapping (address => mapping (address => bool)) private _operatorApprovals;

    mapping (bytes32 => mapping (address => uint)) public _ownershipPercentage;
    mapping (bytes32 => mapping (address => bool)) public _joinApproved;
    mapping (bytes32 => uint) public percentageApproved;


    // Token name
    string private _name;

    // Token symbol
    string private _symbol;

    // Optional mapping for token URIs
    mapping(bytes32 => string) private _tokenURIs;

    // Base URI
    string private _baseURI;

    // Mapping from owner to list of owned token IDs
    mapping(address => bytes32[]) private _ownedTokens;

    // Mapping from token ID to index of the owner tokens list
    mapping(bytes32 => uint256) private _ownedTokensIndex;

    // Array with all token ids, used for enumeration
    bytes32[] private _allTokens;

    // Mapping from token id to position in the allTokens array
    mapping(bytes32 => uint256) private _allTokensIndex;

    /*
     *     bytes4(keccak256('balanceOf(address)')) == 0x70a08231
     *     bytes4(keccak256('ownerOf(uint256)')) == 0x6352211e
     *     bytes4(keccak256('approve(address,uint256)')) == 0x095ea7b3
     *     bytes4(keccak256('getApproved(uint256)')) == 0x081812fc
     *     bytes4(keccak256('setApprovalForAll(address,bool)')) == 0xa22cb465
     *     bytes4(keccak256('isApprovedForAll(address,address)')) == 0xe985e9c5
     *     bytes4(keccak256('transferFrom(address,address,uint256)')) == 0x23b872dd
     *     bytes4(keccak256('safeTransferFrom(address,address,uint256)')) == 0x42842e0e
     *     bytes4(keccak256('safeTransferFrom(address,address,uint256,bytes)')) == 0xb88d4fde
     *
     *     => 0x70a08231 ^ 0x6352211e ^ 0x095ea7b3 ^ 0x081812fc ^
     *        0xa22cb465 ^ 0xe985e9c ^ 0x23b872dd ^ 0x42842e0e ^ 0xb88d4fde == 0x80ac58cd
     */
    bytes4 private constant _INTERFACE_ID_ERC721 = 0x80ac58cd;

    /*
     *     bytes4(keccak256('name()')) == 0x06fdde03
     *     bytes4(keccak256('symbol()')) == 0x95d89b41
     *     bytes4(keccak256('tokenURI(uint256)')) == 0xc87b56dd
     *
     *     => 0x06fdde03 ^ 0x95d89b41 ^ 0xc87b56dd == 0x5b5e139f
     */
    bytes4 private constant _INTERFACE_ID_ERC721_METADATA = 0x5b5e139f;

    /*
     *     bytes4(keccak256('totalSupply()')) == 0x18160ddd
     *     bytes4(keccak256('tokenOfOwnerByIndex(address,uint256)')) == 0x2f745c59
     *     bytes4(keccak256('tokenByIndex(uint256)')) == 0x4f6ccce7
     *
     *     => 0x18160ddd ^ 0x2f745c59 ^ 0x4f6ccce7 == 0x780e9d63
     */
    bytes4 private constant _INTERFACE_ID_ERC721_ENUMERABLE = 0x780e9d63;

    constructor (string memory name, string memory symbol) public {
        _name = name;
        _symbol = symbol;

        // register the supported interfaces to conform to ERC721 via ERC165
        _registerInterface(_INTERFACE_ID_ERC721);
        _registerInterface(_INTERFACE_ID_ERC721_METADATA);
        _registerInterface(_INTERFACE_ID_ERC721_ENUMERABLE);
    }

    /**
     * @dev Gets the balance of the specified address.
     * @param owner address to query the balance of
     * @return uint256 representing the amount owned by the passed address
     */
    function balanceOf(address owner) public view returns (uint256) {
        require(owner != address(0), "ERC721: balance query for the zero address");

        return _ownedTokensCount[owner];
    }

    /**
     * @dev Gets the owner of the specified token ID.
     * @param tokenId uint256 ID of the token to query the owner of
     * @return address currently marked as the owner of the given token ID
     */
    function ownerOf(bytes32 tokenId) public view returns (address[] memory) {
        require(_tokenOwner[tokenId].length > 0, "ERC721: owner query for nonexistent token");

        return _tokenOwner[tokenId];
    }

    /**
     * @dev Gets the token name.
     * @return string representing the token name
     */
    function name() external view returns (string memory) {
        return _name;
    }

    /**
     * @dev Gets the token symbol.
     * @return string representing the token symbol
     */
    function symbol() external view returns (string memory) {
        return _symbol;
    }

    /**
     * @dev Returns the URI for a given token ID. May return an empty string.
     *
     * If the token's URI is non-empty and a base URI was set (via
     * {_setBaseURI}), it will be added to the token ID's URI as a prefix.
     *
     * Reverts if the token ID does not exist.
     */
    function tokenURI(bytes32 tokenId) external view returns (string memory) {
        require(_exists(tokenId), "ERC721Metadata: URI query for nonexistent token");

        string memory _tokenURI = _tokenURIs[tokenId];

        // Even if there is a base URI, it is only appended to non-empty token-specific URIs
        if (bytes(_tokenURI).length == 0) {
            return "";
        } else {
            // abi.encodePacked is being used to concatenate strings
            return string(abi.encodePacked(_baseURI, _tokenURI));
        }
    }

    /**
    * @dev Returns the base URI set via {_setBaseURI}. This will be
    * automatically added as a preffix in {tokenURI} to each token's URI, when
    * they are non-empty.
    */
    function baseURI() external view returns (string memory) {
        return _baseURI;
    }

    /**
     * @dev Gets the token ID at a given index of the tokens list of the requested owner.
     * @param owner address owning the tokens list to be accessed
     * @param index uint256 representing the index to be accessed of the requested tokens list
     * @return uint256 token ID at the given index of the tokens list owned by the requested address
     */
    function tokenOfOwnerByIndex(address owner, uint256 index) public view  returns (bytes32) {
        require(index < balanceOf(owner), "ERC721Enumerable: owner index out of bounds");
        return _ownedTokens[owner][index];
    }

    /**
     * @dev Gets the total amount of tokens stored by the contract.
     * @return uint256 representing the total amount of tokens
     */
    function totalSupply() public view returns (uint256) {
        return _allTokens.length;
    }

    /**
     * @dev Gets the token ID at a given index of all the tokens in this contract
     * Reverts if the index is greater or equal to the total number of tokens.
     * @param index uint256 representing the index to be accessed of the tokens list
     * @return uint256 token ID at the given index of the tokens list
     */
    function tokenByIndex(uint256 index) public view returns (bytes32) {
        require(index < totalSupply(), "ERC721Enumerable: global index out of bounds");
        return _allTokens[index];
    }

    /**
     * @dev Approves another address to transfer the given token ID
     * The zero address indicates there is no approved address.
     * There can only be one approved address per token at a given time.
     * Can only be called by the token owner or an approved operator.
     * @param to address to be approved for the given token ID
     * @param tokenId uint256 ID of the token to be approved
     */
    function approve(address to, bytes32 tokenId) public {
        address[] memory owner = ownerOf(tokenId);
        bool toIsNotTheOwner = true;
        bool isOwnerOrApproved = false;
        for (uint i = 0; i<owner.length; i++) {
            if(owner[i]==to){
                toIsNotTheOwner = false;
            } else if (msg.sender == owner[i] || isApprovedForAll(owner[i], msg.sender)){
                isOwnerOrApproved = true;
            }
        }
        require(toIsNotTheOwner, "ERC721: approval to current owner");

        require(isOwnerOrApproved, "ERC721: approve caller is not owner nor approved for all");

        _approve(to, tokenId);
    }

    /**
     * @dev Gets the approved address for a token ID, or zero if no address set
     * Reverts if the token ID does not exist.
     * @param tokenId uint256 ID of the token to query the approval of
     * @return address currently approved for the given token ID
     */
    function getApproved(bytes32 tokenId) public view returns (address) {
        require(_exists(tokenId), "ERC721: approved query for nonexistent token");

        return _tokenApprovals[tokenId];
    }

    /**
     * @dev Sets or unsets the approval of a given operator
     * An operator is allowed to transfer all tokens of the sender on their behalf.
     * @param operator operator address to set the approval
     * @param approved representing the status of the approval to be set
     */
    function setApprovalForAll(address operator, bool approved) public {
        require(operator != msg.sender, "ERC721: approve to caller");

        _operatorApprovals[msg.sender][operator] = approved;
        emit ApprovalForAll(msg.sender, operator, approved);
    }

    /**
     * @dev Tells whether an operator is approved by a given owner.
     * @param owner owner address which you want to query the approval of
     * @param operator operator address which you want to query the approval of
     * @return bool whether the given operator is approved by the given owner
     */
    function isApprovedForAll(address owner, address operator) public view returns (bool) {
        return _operatorApprovals[owner][operator];
    }

    /**
     * @dev Transfers the ownership of a given token ID to another address.
     * Usage of this method is discouraged, use {safeTransferFrom} whenever possible.
     * Requires the msg.sender to be the owner, approved, or operator.
     * @param from current owner of the token
     * @param to address to receive the ownership of the given token ID
     * @param tokenId uint256 ID of the token to be transferred
     */
    function transferFrom(address from, address to, bytes32 tokenId) public {
        //solhint-disable-next-line max-line-length
        require(_isApprovedOrOwner(msg.sender, tokenId), "ERC721: transfer caller is not owner nor approved");

        _transferFrom(from, to, tokenId);
    }

    /**
     * @dev Safely transfers the ownership of a given token ID to another address
     * If the target address is a contract, it must implement {IERC721Receiver-onERC721Received},
     * which is called upon a safe transfer, and return the magic value
     * `bytes4(keccak256("onERC721Received(address,address,uint256,bytes)"))`; otherwise,
     * the transfer is reverted.
     * Requires the msg.sender to be the owner, approved, or operator
     * @param from current owner of the token
     * @param to address to receive the ownership of the given token ID
     * @param tokenId uint256 ID of the token to be transferred
     */
    function safeTransferFrom(address from, address to, bytes32 tokenId) public {
        require(_isApprovedOrOwner(msg.sender, tokenId), "ERC721: transfer caller is not owner nor approved");
        _safeTransferFrom(from, to, tokenId);
    }

    /**
     * @dev Safely transfers the ownership of a given token ID to another address
     * If the target address is a contract, it must implement `onERC721Received`,
     * which is called upon a safe transfer, and return the magic value
     * `bytes4(keccak256("onERC721Received(address,address,uint256,bytes)"))`; otherwise,
     * the transfer is reverted.
     * Requires the msg.sender to be the owner, approved, or operator
     * @param from current owner of the token
     * @param to address to receive the ownership of the given token ID
     * @param tokenId uint256 ID of the token to be transferred
     */
    function _safeTransferFrom(address from, address to, bytes32 tokenId) internal {
        _transferFrom(from, to, tokenId);
    }

    /**
     * @dev Returns whether the specified token exists.
     * @param tokenId uint256 ID of the token to query the existence of
     * @return bool whether the token exists
     */
    function _exists(bytes32 tokenId) internal view returns (bool) {
        address[] memory owner = _tokenOwner[tokenId];
        return owner.length != 0;
    }

    /**
     * @dev Returns whether the given spender can transfer a given token ID.
     * @param spender address of the spender to query
     * @param tokenId uint256 ID of the token to be transferred
     * @return bool whether the msg.sender is approved for the given token ID,
     * is an operator of the owner, or is the owner of the token
     */
    function _isApprovedOrOwner(address spender, bytes32 tokenId) internal view returns (bool) {
        require(_exists(tokenId), "ERC721: operator query for nonexistent token");
        address[] memory owner = ownerOf(tokenId);
        bool spenderIsOwner = false;
        bool spenderIsApprovedForAll = false;
        for (uint i = 0; i<owner.length; i++) {
            if(spender == owner[i]){
                spenderIsOwner = true;
            } else if (isApprovedForAll(owner[i], spender)){
                spenderIsApprovedForAll = true;
            }
        }
        return (spenderIsOwner || getApproved(tokenId) == spender || spenderIsApprovedForAll);
    }


    /**
     * @dev Internal function to safely mint a new token.
     * Reverts if the given token ID already exists.
     * If the target address is a contract, it must implement `onERC721Received`,
     * which is called upon a safe transfer, and return the magic value
     * `bytes4(keccak256("onERC721Received(address,address,uint256,bytes)"))`; otherwise,
     * the transfer is reverted.
     * @param to The address that will own the minted token
     * @param tokenId uint256 ID of the token to be minted
     */
    function createToken(address to, bytes32 tokenId, string memory ipfsId) public {
        require(keccak256(abi.encodePacked(ipfsId)) == tokenId, "TokenId and ipfsId does not match");
        _ownershipPercentage[tokenId][msg.sender] = 10000;
        _ipfsAddressByTokenId[tokenId] = ipfsId;
        _mint(to, tokenId);
    }

    /**
     * @dev Internal function to mint a new token.
     * Reverts if the given token ID already exists.
     * @param to The address that will own the minted token
     * @param tokenId uint256 ID of the token to be minted
     */
    function _mint(address to, bytes32 tokenId) internal {
        require(to != address(0), "ERC721: mint to the zero address");
        require(!_exists(tokenId), "ERC721: token already minted");

        _beforeTokenTransfer(address(0), to, tokenId);

        _addTokenToOwnerEnumeration(to, tokenId);
        _addTokenToAllTokensEnumeration(tokenId);

        _tokenOwner[tokenId].push(to);
        _ownedTokensCount[to] += 1;

        emit Transfer(address(0), to, tokenId);
    }

    /**
     * @dev Internal function to burn a specific token.
     * Reverts if the token does not exist.
     * @param tokenId uint256 ID of the token being burned
     */
    function _burn(bytes32 tokenId) internal {
        address[] memory owner = ownerOf(tokenId);

        for(uint i = 0; i<owner.length; i++){
            _beforeTokenTransfer(owner[i], address(0), tokenId);
            _removeTokenFromOwnerEnumeration(owner[i], tokenId);
            _ownedTokensCount[owner[i]] -= 1;
            emit Transfer(owner[i], address(0), tokenId);
        }
        // Clear metadata (if any)
        if (bytes(_tokenURIs[tokenId]).length != 0) {
            delete _tokenURIs[tokenId];
        }

        // Since tokenId will be deleted, we can clear its slot in _ownedTokensIndex to trigger a gas refund
        _ownedTokensIndex[tokenId] = 0;

        _removeTokenFromAllTokensEnumeration(tokenId);

        // Clear approvals
        _approve(address(0), tokenId);

        _tokenOwner[tokenId] = [address(0)];
    }

    /**
     * @dev Internal function to transfer ownership of a given token ID to another address.
     * As opposed to {transferFrom}, this imposes no restrictions on msg.sender.
     * @param from current owner of the token
     * @param to address to receive the ownership of the given token ID
     * @param tokenId uint256 ID of the token to be transferred
     */
    function _transferFrom(address from, address to, bytes32 tokenId) internal {
        address[] memory owners = ownerOf(tokenId);
        bool isOwner = false;
        for (uint i = 0; i<owners.length; i++){
            if (owners[i] == from){
                isOwner = true;
            }
        }
        require(isOwner, "ERC721: transfer of token that is not own");
        require(to != address(0), "ERC721: transfer to the zero address");

        _beforeTokenTransfer(from, to, tokenId);

        _removeTokenFromOwnerEnumeration(from, tokenId);
        _addTokenToOwnerEnumeration(to, tokenId);

        // Clear approvals
        _approve(address(0), tokenId);

        _ownedTokensCount[from] -= 1;
        _ownedTokensCount[to] += 1;

        for (uint j = 0;j<_tokenOwner[tokenId].length;j++){
            if (_tokenOwner[tokenId][j] == from){
                _tokenOwner[tokenId][j] = to;
            }
        }
        emit Transfer(from, to, tokenId);
    }

    /**
     * @dev Internal function to set the token URI for a given token.
     *
     * Reverts if the token ID does not exist.
     *
     * TIP: If all token IDs share a prefix (for example, if your URIs look like
     * `https://api.myproject.com/token/<id>`), use {_setBaseURI} to store
     * it and save gas.
     */
    function _setTokenURI(bytes32 tokenId, string memory _tokenURI) internal {
        require(_exists(tokenId), "ERC721Metadata: URI set of nonexistent token");
        _tokenURIs[tokenId] = _tokenURI;
    }

    /**
     * @dev Internal function to set the base URI for all token IDs. It is
     * automatically added as a prefix to the value returned in {tokenURI}.
     */
    function _setBaseURI(string memory baseURI_) internal {
        _baseURI = baseURI_;
    }

    /**
     * @dev Gets the list of token IDs of the requested owner.
     * @param owner address owning the tokens
     * @return uint256[] List of token IDs owned by the requested address
     */
    function _tokensOfOwner(address owner) internal view returns (bytes32[] storage) {
        return _ownedTokens[owner];
    }

    function _approve(address to, bytes32 tokenId) private {
        _tokenApprovals[tokenId] = to;
        emit Approval(msg.sender, to, tokenId);
    }

    /**
     * @dev Private function to add a token to this extension's ownership-tracking data structures.
     * @param to address representing the new owner of the given token ID
     * @param tokenId uint256 ID of the token to be added to the tokens list of the given address
     */
    function _addTokenToOwnerEnumeration(address to, bytes32 tokenId) private {
        _ownedTokensIndex[tokenId] = _ownedTokens[to].length;
        _ownedTokens[to].push(tokenId);
    }

    /**
     * @dev Private function to add a token to this extension's token tracking data structures.
     * @param tokenId uint256 ID of the token to be added to the tokens list
     */
    function _addTokenToAllTokensEnumeration(bytes32 tokenId) private {
        _allTokensIndex[tokenId] = _allTokens.length;
        _allTokens.push(tokenId);
    }

    /**
     * @dev Private function to remove a token from this extension's ownership-tracking data structures. Note that
     * while the token is not assigned a new owner, the `_ownedTokensIndex` mapping is _not_ updated: this allows for
     * gas optimizations e.g. when performing a transfer operation (avoiding double writes).
     * This has O(1) time complexity, but alters the order of the _ownedTokens array.
     * @param from address representing the previous owner of the given token ID
     * @param tokenId uint256 ID of the token to be removed from the tokens list of the given address
     */
    function _removeTokenFromOwnerEnumeration(address from, bytes32 tokenId) private {
        // To prevent a gap in from's tokens array, we store the last token in the index of the token to delete, and
        // then delete the last slot (swap and pop).

        uint256 lastTokenIndex = _ownedTokens[from].length - 1;
        uint256 tokenIndex = _ownedTokensIndex[tokenId];

        // When the token to delete is the last token, the swap operation is unnecessary
        if (tokenIndex != lastTokenIndex) {
            bytes32 lastTokenId = _ownedTokens[from][lastTokenIndex];

            _ownedTokens[from][tokenIndex] = lastTokenId; // Move the last token to the slot of the to-delete token
            _ownedTokensIndex[lastTokenId] = tokenIndex; // Update the moved token's index
        }

        // Deletes the contents at the last position of the array
        _ownedTokens[from].pop();

        // Note that _ownedTokensIndex[tokenId] hasn't been cleared: it still points to the old slot (now occupied by
        // lastTokenId, or just over the end of the array if the token was the last one).
    }

    /**
     * @dev Private function to remove a token from this extension's token tracking data structures.
     * This has O(1) time complexity, but alters the order of the _allTokens array.
     * @param tokenId uint256 ID of the token to be removed from the tokens list
     */
    function _removeTokenFromAllTokensEnumeration(bytes32 tokenId) private {
        // To prevent a gap in the tokens array, we store the last token in the index of the token to delete, and
        // then delete the last slot (swap and pop).

        uint256 lastTokenIndex = _allTokens.length - 1;
        uint256 tokenIndex = _allTokensIndex[tokenId];

        // When the token to delete is the last token, the swap operation is unnecessary. However, since this occurs so
        // rarely (when the last minted token is burnt) that we still do the swap here to avoid the gas cost of adding
        // an 'if' statement (like in _removeTokenFromOwnerEnumeration)
        bytes32 lastTokenId = _allTokens[lastTokenIndex];

        _allTokens[tokenIndex] = lastTokenId; // Move the last token to the slot of the to-delete token
        _allTokensIndex[lastTokenId] = tokenIndex; // Update the moved token's index

        // Delete the contents at the last position of the array
        _allTokens.pop();

        _allTokensIndex[tokenId] = 0;
    }

    /**
     * @dev Hook that is called before any token transfer. This includes minting
     * and burning.
     *
     * Calling conditions:
     *
     * - when `from` and `to` are both non-zero, `from`'s `tokenId` will be
     * transferred to `to`.
     * - when `from` is zero, `tokenId` will be minted for `to`.
     * - when `to` is zero, `from`'s `tokenId` will be burned.
     * - `from` and `to` are never both zero.
     *
     * To learn more about hooks, head to xref:ROOT:using-hooks.adoc[Using Hooks].
     */
    function _beforeTokenTransfer(address from, address to, bytes32 tokenId) internal { }

    /**
     * @dev Returns true if `account` is a contract.
     *
     * [IMPORTANT]
     * ====
     * It is unsafe to assume that an address for which this function returns
     * false is an externally-owned account (EOA) and not a contract.
     *
     * Among others, `isContract` will return false for the following
     * types of addresses:
     *
     *  - an externally-owned account
     *  - a contract in construction
     *  - an address where a contract will be created
     *  - an address where a contract lived, but was destroyed
     * ====
     */
    function isContract(address account) internal view returns (bool) {
        // According to EIP-1052, 0x0 is the value returned for not-yet created accounts
        // and 0xc5d2460186f7233c927e7db2dcc703c0e500b653ca82273b7bfad8045d85a470 is returned
        // for accounts without code, i.e. `keccak256('')`
        bytes32 codehash;
        bytes32 accountHash = 0xc5d2460186f7233c927e7db2dcc703c0e500b653ca82273b7bfad8045d85a470;
        // solhint-disable-next-line no-inline-assembly
        assembly { codehash := extcodehash(account) }
        return (codehash != accountHash && codehash != 0x0);
    }
    function joinTokens (bytes32[] memory _tokens, string memory _newToken) public {
        bool isApprovedOrOwner = false;
        for (uint i = 0; i<_tokens.length; i++) {
            require(_exists(_tokens[i]),"Error: Token doesn't exist");
            if(_isApprovedOrOwner(msg.sender, _tokens[i])){
                isApprovedOrOwner = true;
            }
        }
        require(isApprovedOrOwner, "ERC721: transfer caller is not owner nor approved of token1 or token2");
        bytes32 tokenId = keccak256(abi.encodePacked(_newToken));
        _ipfsAddressByTokenId[tokenId] = _newToken;
        _parents[keccak256(abi.encodePacked(_newToken))] = _tokens;
        //Create the new token and give its property to the owners
        //require(to != address(0), "ERC721: mint to the zero address");
        require(!_exists(tokenId), "ERC721: token already minted");
        for (uint j = 0; j<_tokens.length; j++){
            address[] memory owners = ownerOf(_tokens[j]);
            for (uint i = 0; i<owners.length; i++){
                _beforeTokenTransfer(address(0), owners[i], tokenId);

                _addTokenToOwnerEnumeration(owners[i], tokenId);
                _addTokenToAllTokensEnumeration(tokenId);

                _tokenOwner[tokenId].push(owners[i]);
                _ownedTokensCount[owners[i]] += 1;

                emit Transfer(address(0), owners[i], tokenId);
            }
        }
    }
    function getParents(bytes32 _tokenId) public view returns (bytes32[] memory) {
        require(_exists(_tokenId),"Error: Token doesn't exist");
        return (_parents[_tokenId]);
    }
    function getIpfsId(bytes32 _tokenId) public view returns (string memory) {
        require(_exists(_tokenId),"Error: Token doesn't exist");
        return (_ipfsAddressByTokenId[_tokenId]);
    }
    struct AuxData {
            uint percentage;
            address owner;
            uint numToken;
        }
    mapping(bytes32 => AuxData[]) public data;
    function joinApprove(bytes32[] memory _tokens, uint[] memory _ownerPercentage, string memory _newToken) public {
        bool isApprovedOrOwner = false;
        for (uint i = 0; i<_tokens.length; i++) {
            require(_exists(_tokens[i]),"Error: Token doesn't exist");
            if(_isApprovedOrOwner(msg.sender, _tokens[i])){
                isApprovedOrOwner = true;
            }
        }
        require(isApprovedOrOwner, "ERC721: transfer caller is not owner nor approved of token1 or token2");
        require(_tokens.length == _ownerPercentage.length, "Array different length");
        require(_joinApproved[keccak256(abi.encodePacked(_newToken))][msg.sender] == false, "Vote already applied");
        //Check owners of the parent tokens and percentages
        if(data[keccak256(abi.encodePacked(_newToken))].length == 0){
            for (uint i = 0; i<_tokens.length;i++){
                address[] memory owners = _tokenOwner[_tokens[i]];
                for(uint j = 0; j<owners.length; j++){
                    //porcentajes de propiedad de los owners del token raiz
                    AuxData memory aux;
                    aux.percentage = _ownershipPercentage[_tokens[i]][_tokenOwner[_tokens[i]][j]]* _ownerPercentage[i]/10000; //token3 percentage
                    aux.owner = _tokenOwner[_tokens[i]][j];
                    aux.numToken = i;
                    data[keccak256(abi.encodePacked(_newToken))].push(aux);
                }
            }
        }

        _joinApproved[keccak256(abi.encodePacked(_newToken))][msg.sender] = true;
        for (uint i = 0; i<data[keccak256(abi.encodePacked(_newToken))].length; i++){
            if (msg.sender == data[keccak256(abi.encodePacked(_newToken))][i].owner){
                 percentageApproved[keccak256(abi.encodePacked(_newToken))] += data[keccak256(abi.encodePacked(_newToken))][i].percentage;
            }
        }
        
        // more than 50% must be approved
        //Aprove if most of votes are agree
        if (percentageApproved[keccak256(abi.encodePacked(_newToken))]>5000){
            for (uint i = 0; i<data[keccak256(abi.encodePacked(_newToken))].length; i++){
                _ownershipPercentage[keccak256(abi.encodePacked(_newToken))][data[keccak256(abi.encodePacked(_newToken))][i].owner] += data[keccak256(abi.encodePacked(_newToken))][i].percentage;
            }
            joinTokens (_tokens, _newToken);
        }
    }
    
}
