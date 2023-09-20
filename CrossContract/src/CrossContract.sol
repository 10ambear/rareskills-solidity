// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.13;

contract CrossContract {
    /**
     * The function below is to call the price function of PriceOracle1 and PriceOracle2 contracts below and return the lower of the two prices
     */

    function getLowerPrice(
        address _priceOracle1,
        address _priceOracle2
    ) external returns (uint256) {

        // external calls
        (bool okOne, bytes memory resultOne) = _priceOracle1.call(abi.encodeWithSignature("price()"));
        (bool okTwo, bytes memory resultTwo) = _priceOracle2.call(abi.encodeWithSignature("price()"));

        // make sure the calls were successful
        require(okOne && okTwo, "call failed");

        // decode the data
        uint256 oracleOnePrice = abi.decode(resultOne, (uint256));
        uint256 oracleTwoPrice = abi.decode(resultTwo, (uint256)); 

        // return lowest price
        if(oracleOnePrice < oracleTwoPrice){
            return oracleOnePrice;
        }
        return oracleTwoPrice;
    }
}

contract PriceOracle1 {
    uint256 private _price;

    function setPrice(uint256 newPrice) public {
        _price = newPrice;
    }

    function price() external view returns (uint256) {
        return _price;
    }
}

contract PriceOracle2 {
    uint256 private _price;

    function setPrice(uint256 newPrice) public {
        _price = newPrice;
    }

    function price() external view returns (uint256) {
        return _price;
    }
}
