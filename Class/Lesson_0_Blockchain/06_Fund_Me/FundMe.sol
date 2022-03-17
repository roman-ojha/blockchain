// SPDX-License-Identifier: MIT

pragma solidity >=0.6.6 <0.9.0;

// import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

// here we are importing from @chainlink/contract npm package
// https://github.com/smartcontractkit/chainlink

interface AggregatorV3Interface {
    // solidity doesn't natively understand how to interact with another contract we have to tell solidity that functions can be called on another contract this is where interfaces are actually going to come in
    // similar to structs what we can do with interfaces is to define new type
    // we have copy and past code from:
    // https://github.com/smartcontractkit/chainlink/blob/develop/contracts/src/v0.6/interfaces/AggregatorV3Interface.sol
    function decimals() external view returns (uint8);

    function description() external view returns (string memory);

    function version() external view returns (uint256);

    function getRoundData(uint80 _roundId)
        external
        view
        returns (
            uint80 roundId,
            int256 answer,
            uint256 startedAt,
            uint256 updatedAt,
            uint80 answeredInRound
        );

    function latestRoundData()
        external
        view
        returns (
            uint80 roundId,
            int256 answer,
            uint256 startedAt,
            uint256 updatedAt,
            uint80 answeredInRound
        );
}

/*
    *) ABI (Application Binary Interface)
    -> interfaces compile down to an ABI
    -> The ABI Tells solidity and other programming language how it can interact wiht another contract
    -> Anytime you want to interact with an already deployed smart contract you will need and ABI
*/
contract FundMe {
    // we want this contract to be able to accept some type of payment

    mapping(address => uint256) public addressToAmountFunded;

    // so here we will use mapping for address and value

    function fund() public payable {
        // https://youtu.be/M576WGiDBdQ?t=8839
        // if we will define function as payable, this function can be use to pay
        // every single function call have there associated value with it, when we make a transaction we can always append a value, this value is how much wei, gwei, finney, ether we are going to send with our function call or our transaction
        // http://eth-converter.com/
        // now lets track of all the poeple who sent us money or all the address that sent us some value
        addressToAmountFunded[msg.sender] += msg.value;
        // 'msg.sender' & 'msg.value' are every keywords in every contract call and every transaction
        // 'msg.sender' is the sender of the function call
        // 'msg.value' is the value that they sent

        // when we send our funds to a contract this actually means that this contract whenever this is deployed now is the owner of the amount of ether the thye fund

        // if we want to set some minimum value and work with usd then
        // we have to know what the ETH -> USD conversion rate
        // https://data.chain.link/

        // https://youtu.be/M576WGiDBdQ?t=9410
        // API Call: https://docs.chain.link/docs/advanced-tutorial/

        // https://docs.chain.link/docs/get-the-latest-price/
    }

    function getVersion() public view returns (uint256) {
        // https://youtu.be/M576WGiDBdQ?t=9825
        // https://docs.chain.link/docs/ethereum-addresses/
        AggregatorV3Interface priceFeed = AggregatorV3Interface(
            // ETH/USD for Riskeby Testnet :0x8A753747A1Fa494EC906cE90E9f37563A8AF630e
            0x8A753747A1Fa494EC906cE90E9f37563A8AF630e
        );
        // this line is saying that we have a contract that have function defined in the 'AggregatorV3Interface' interface located at this address
        return priceFeed.version();
        // so we made a contract call to another contract from our contract using an interface
        // so interface is powerfull because those are minimulistic view of another contract
    }

    function getPrice() public view returns (uint256) {
        AggregatorV3Interface priceFeed = AggregatorV3Interface(
            0x8A753747A1Fa494EC906cE90E9f37563A8AF630e
        );
        // because this function returns 5 different values
        (
            ,
            //uint80 roundId, -> unUsed variable we be write as blank ,
            // uint80 answeredInRound
            // uint256 startedAt,
            // uint256 updatedAt,
            int256 answer,
            ,
            ,

        ) = priceFeed.latestRoundData();
        return uint256(answer);
        // here we are chainging type of data from 'int256' to 'uint256' and returning it
        // the value for ETH/USD for this date is:
        // 248255877123 -> $ 2,482.55877123
    }
}
