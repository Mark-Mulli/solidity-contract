//SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";


contract FundMe {

    mapping(address => uint256) public addressToAmountFunded;
    //accept some type of payment
    function fund() public payable {
        //threshold
        uint256 minimumEth = 50 * 10 ** 18;

        require(getConversion(msg.value) >= minimumEth, "You need to spend more ETH!");

         addressToAmountFunded[msg.sender] += msg.value;
    }

    function getVersion() public view returns(uint256) {
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306);
        return priceFeed.version();
    }

    function getPrice() public view returns(uint256) {
         AggregatorV3Interface priceFeed = AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306);
         (, int256 answer, , , ) = priceFeed.latestRoundData();
         return uint256(answer);
    }

    //eth to USD conversion rate
    function getConversion(uint256 ethAmount) public view returns(uint256) {
        uint256 ethPrice = getPrice();
        uint256 ethAmountInUSD =  (ethPrice * ethAmount) / 1000000000000000000;
        return ethAmountInUSD;
    }
}